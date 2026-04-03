#!/usr/bin/env node
// Verify all characters: compare data/full/{slug}.json with live API
// Usage: node scripts/verify-characters-v3.mjs [--sample N]

import { readFileSync, readdirSync, existsSync } from "node:fs";
import { resolve, dirname } from "node:path";
import { fileURLToPath } from "node:url";

const __dirname = dirname(fileURLToPath(import.meta.url));
const DATA_DIR = resolve(__dirname, "../data/full");
const API_BASE = "https://ge.makeloops.xyz/api/characters";

const args = process.argv.slice(2);
const sampleSize = args.includes("--sample") ? parseInt(args[args.indexOf("--sample") + 1]) : 0;

// Load character list
const chars = JSON.parse(readFileSync(resolve(__dirname, "../data/characters-list.json"), "utf8"));
const slugs = chars.map(c => c.slug || c.name);

// Select subset if --sample
let targets = slugs;
if (sampleSize > 0) {
  // Random sample
  const shuffled = [...slugs].sort(() => Math.random() - 0.5);
  targets = shuffled.slice(0, sampleSize);
  console.log(`\n🎲 Random sample: ${sampleSize} of ${slugs.length} characters\n`);
} else {
  console.log(`\n🔍 Verifying all ${slugs.length} characters\n`);
}

let passed = 0;
let failed = 0;
let skipped = 0;
const failures = [];

async function fetchAPI(slug) {
  // Try original case first, then lowercase (DB stores some as lowercase)
  for (const s of [slug, slug.toLowerCase()]) {
    try {
      const res = await fetch(`${API_BASE}/${encodeURIComponent(s)}`, {
        headers: {
          "User-Agent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) ge-db-verify/1.0",
          "Accept": "application/json",
        },
      });
      if (res.ok) return await res.json();
    } catch {}
  }
  return null;
}

function compareField(section, field, expected, actual) {
  const expStr = String(expected ?? "").trim();
  const actStr = String(actual ?? "").trim();
  if (expStr === actStr) return null;
  // Allow empty vs missing
  if (!expStr && !actStr) return null;
  return { section, field, expected: expStr, actual: actStr };
}

async function verifyCharacter(slug) {
  const jsonPath = resolve(DATA_DIR, `${slug}.json`);
  if (!existsSync(jsonPath)) {
    return { slug, status: "skip", reason: "no JSON file" };
  }

  const local = JSON.parse(readFileSync(jsonPath, "utf8"));
  const api = await fetchAPI(slug);
  if (!api) {
    return { slug, status: "skip", reason: "API returned null/error" };
  }

  const diffs = [];

  // Stances count
  const localStances = local.stances || [];
  const apiStances = api.stances || [];
  const d1 = compareField("stances", "count", localStances.length, apiStances.length);
  if (d1) diffs.push(d1);

  // Stance names
  const localStanceNames = localStances.map(s => s.name).sort();
  const apiStanceNames = apiStances.map(s => s.name).sort();
  const d2 = compareField("stances", "names", localStanceNames.join(","), apiStanceNames.join(","));
  if (d2) diffs.push(d2);

  // For each stance with skills
  for (const localStance of localStances) {
    const apiStance = apiStances.find(s => s.name === localStance.name);
    if (!apiStance) {
      diffs.push({ section: `stance:${localStance.name}`, field: "exists", expected: "yes", actual: "missing" });
      continue;
    }

    // Stance consume
    if (localStance.consume) {
      const d = compareField(`stance:${localStance.name}`, "consume", localStance.consume, apiStance.consume || "");
      if (d) diffs.push(d);
    }

    // Skills
    const localSkills = localStance.skills || [];
    const apiSkills = apiStance.skills || [];

    for (const ls of localSkills) {
      const as = apiSkills.find(s => s.skill_name === ls.name);
      if (!as) {
        diffs.push({ section: `skill:${ls.name}`, field: "exists", expected: "yes", actual: "missing" });
        continue;
      }

      // Core fields
      const skillFields = [
        ["image", ls.image, as.skill_image],
        ["description", ls.description, as.description],
        ["target", ls.target, as.target],
        ["casting_time", ls.casting_time, as.casting_time],
        ["cooldown", ls.cooldown, as.cooldown],
        ["duration", ls.duration, as.duration],
        ["sp_cost", ls.sp_cost, as.sp_cost],
        ["aggro", ls.aggro, as.aggro],
        ["skill_type", ls.skill_type, as.skill_type],
        ["hits_flying", ls.hits_flying, as.hits_flying],
        ["knock_down", ls.knock_down, as.knock_down],
      ];

      for (const [fname, exp, act] of skillFields) {
        const d = compareField(`skill:${ls.name}`, fname, exp, act);
        if (d) diffs.push(d);
      }

      // New fields (only check if local has them)
      if (ls.consume_item) {
        const d = compareField(`skill:${ls.name}`, "consume_item", ls.consume_item, as.consume_item || "");
        if (d) diffs.push(d);
      }
      if (ls.soft_armor_atk) {
        const d = compareField(`skill:${ls.name}`, "soft_armor_atk", ls.soft_armor_atk, as.soft_armor_atk || "");
        if (d) diffs.push(d);
      }
      if (ls.heavy_armor_atk) {
        const d = compareField(`skill:${ls.name}`, "heavy_armor_atk", ls.heavy_armor_atk, as.heavy_armor_atk || "");
        if (d) diffs.push(d);
      }
      if (ls.light_armor_atk) {
        const d = compareField(`skill:${ls.name}`, "light_armor_atk", ls.light_armor_atk, as.light_armor_atk || "");
        if (d) diffs.push(d);
      }

      // Levels count
      const localLevels = ls.levels || [];
      const apiLevels = as.levels || [];
      const ld = compareField(`skill:${ls.name}`, "levels_count", localLevels.length, apiLevels.length);
      if (ld) diffs.push(ld);
    }
  }

  // Character buff
  if (local.character_buff) {
    const lb = local.character_buff;
    const ab = api.character_buff || {};
    const buffFields = [
      ["name", lb.name, ab.name],
      ["image", lb.image, ab.image],
      ["description", lb.description, ab.description],
      ["cooldown", lb.cooldown, ab.cooldown],
      ["sp_cost", lb.sp_cost, ab.sp_cost],
    ];
    for (const [fname, exp, act] of buffFields) {
      const d = compareField("buff", fname, exp, act);
      if (d) diffs.push(d);
    }
  }

  return { slug, status: diffs.length === 0 ? "pass" : "fail", diffs };
}

// Main
async function main() {
  for (let i = 0; i < targets.length; i++) {
    const slug = targets[i];
    const result = await verifyCharacter(slug);

    if (result.status === "pass") {
      passed++;
      if (targets.length <= 20) console.log(`  ✅ ${slug}`);
    } else if (result.status === "skip") {
      skipped++;
      console.log(`  ⏭️  ${slug}: ${result.reason}`);
    } else {
      failed++;
      failures.push(result);
      console.log(`  ❌ ${slug}: ${result.diffs.length} mismatches`);
      for (const d of result.diffs.slice(0, 5)) {
        console.log(`      ${d.section}.${d.field}: local='${d.expected}' vs api='${d.actual}'`);
      }
      if (result.diffs.length > 5) {
        console.log(`      ... +${result.diffs.length - 5} more`);
      }
    }

    // Progress every 50
    if (targets.length > 20 && (i + 1) % 50 === 0) {
      console.log(`  Progress: ${i + 1}/${targets.length} (${passed} pass, ${failed} fail, ${skipped} skip)`);
    }

    // Rate limit: small delay between API calls
    await new Promise(r => setTimeout(r, 100));
  }

  console.log(`\n${"=".repeat(60)}`);
  console.log(`📊 Results: ${targets.length} characters`);
  console.log(`  ✅ Passed: ${passed}`);
  console.log(`  ❌ Failed: ${failed}`);
  console.log(`  ⏭️  Skipped: ${skipped}`);

  if (failures.length > 0) {
    console.log(`\n❌ Failed characters:`);
    for (const f of failures) {
      console.log(`\n  ${f.slug} (${f.diffs.length} diffs):`);
      for (const d of f.diffs) {
        console.log(`    ${d.section}.${d.field}: local='${d.expected}' vs api='${d.actual}'`);
      }
    }
  }

  console.log(`\n${"=".repeat(60)}`);
  process.exit(failed > 0 ? 1 : 0);
}

main();
