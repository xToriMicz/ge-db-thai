#!/usr/bin/env node
// Automated 1:1 character verification v2
// Compares per-stance skill count + lv25 bonus count between local scraped data and source
// Reports any mismatch at the stance level

import { readFileSync, readdirSync, writeFileSync } from "node:fs";
import { resolve, dirname } from "node:path";
import { fileURLToPath } from "node:url";

const __dirname = dirname(fileURLToPath(import.meta.url));
const FULL_DIR = resolve(__dirname, "../data/full");
const BASE = "https://ge-db.site/andromida";

function extractTextLines(html) {
  return html.split(/<[^>]*>/)
    .map(s => s.replace(/&nbsp;/g, " ").trim())
    .filter(t => t.length > 0);
}

function stripTags(html) {
  return html.replace(/<[^>]+>/g, " ").replace(/&nbsp;/g, " ").replace(/\s+/g, " ").trim();
}

// Parse source page fully — returns { stanceOverview, stanceDetails }
function parseSourcePage(html) {
  // Overview stances
  const stanceNames = [];
  const tableStart = html.indexOf('class="stances full');
  if (tableStart !== -1) {
    const tableEnd = html.indexOf("</table>", tableStart);
    const table = html.substring(tableStart, tableEnd + 8);
    const rows = [...table.matchAll(/<tr[^>]*>(.*?)<\/tr>/gs)];
    for (const row of rows.slice(1)) {
      const cells = [...row[1].matchAll(/<td[^>]*>(.*?)<\/td>/gs)];
      if (cells.length >= 3) {
        const names = stripTags(cells[2][1]).split(",").map(s => s.trim()).filter(Boolean);
        stanceNames.push(...names);
      }
    }
  }

  // Stance details (h3 sections)
  const stanceHeaders = [...html.matchAll(/<h3\s+id="([^"]+)">([^<]+)<\/h3>/gi)];
  const stanceDetails = [];

  for (let i = 0; i < stanceHeaders.length; i++) {
    const stanceName = stanceHeaders[i][2].trim();
    const startIdx = stanceHeaders[i].index;
    const endIdx = i + 1 < stanceHeaders.length ? stanceHeaders[i + 1].index : startIdx + 20000;
    const section = html.substring(startIdx, Math.min(endIdx, startIdx + 20000));

    // Count skills (exclude "None")
    const skills = [...section.matchAll(/class="skills_als"[^>]*alt="([^"]+)"/g)]
      .map(s => s[1].trim())
      .filter(n => n !== "None");

    // Count lv25 bonus
    let lv25Count = 0;
    const tableMatch = section.match(/<table[^>]*class="dark2"[^>]*>([\s\S]*?)<\/table>/);
    if (tableMatch) {
      const rows = [...tableMatch[1].matchAll(/<tr[^>]*>([\s\S]*?)<\/tr>/g)];
      if (rows.length >= 2) {
        const cells = [...rows[rows.length - 1][1].matchAll(/<td[^>]*>([\s\S]*?)<\/td>/g)];
        if (cells[2]) {
          const lines = extractTextLines(cells[2][1]);
          // Count meaningful lv25 lines (not "None", not empty)
          lv25Count = lines.filter(l => l.length > 2 && l !== "None").length;
        }
      }
    }

    stanceDetails.push({ name: stanceName, skillCount: skills.length, skillNames: skills, lv25Count });
  }

  return { stanceNames, stanceDetails };
}

async function main() {
  const files = readdirSync(FULL_DIR).filter(f => f.endsWith(".json") && f[0] !== "_");
  console.log(`\n🔍 Verification v2: ${files.length} characters (per-stance detail check)\n`);

  const issues = [];
  let checked = 0, perfect = 0;
  let totalStancesChecked = 0, totalSkillsChecked = 0;

  for (let i = 0; i < files.length; i++) {
    const slug = files[i].replace(".json", "");
    const local = JSON.parse(readFileSync(resolve(FULL_DIR, files[i]), "utf8"));

    let html;
    try {
      const res = await fetch(`${BASE}/${encodeURIComponent(slug)}.php`);
      if (!res.ok) { issues.push({ slug, errors: [`HTTP ${res.status}`] }); checked++; continue; }
      html = await res.text();
    } catch (err) {
      issues.push({ slug, errors: [`FETCH: ${err.message}`] }); checked++; continue;
    }

    const source = parseSourcePage(html);
    const charIssues = [];

    // 1. Stance overview count
    const localOverview = local.stance_overview?.length || 0;
    if (source.stanceNames.length !== localOverview) {
      charIssues.push(`overview: source=${source.stanceNames.length} local=${localOverview}`);
    }

    // 2. Stance detail count
    const localDetails = local.stances?.length || 0;
    if (source.stanceDetails.length !== localDetails) {
      charIssues.push(`details: source=${source.stanceDetails.length} local=${localDetails}`);
    }

    // 3. Per-stance comparison
    for (const srcStance of source.stanceDetails) {
      totalStancesChecked++;
      const localStance = local.stances?.find(s => s.name === srcStance.name);

      if (!localStance) {
        charIssues.push(`missing_stance: "${srcStance.name}" (${srcStance.skillCount} skills)`);
        continue;
      }

      const localSkillCount = localStance.skills?.length || 0;
      totalSkillsChecked += srcStance.skillCount;

      if (srcStance.skillCount !== localSkillCount) {
        charIssues.push(`skill_count: "${srcStance.name}" source=${srcStance.skillCount} local=${localSkillCount} [src: ${srcStance.skillNames.join(", ")}]`);
      }

      // Lv25 bonus count
      const localLv25 = Object.keys(localStance.lv25_bonus || {}).length +
        (localStance.lv25_bonus_extra?.length || 0);
      if (srcStance.lv25Count !== localLv25 && srcStance.lv25Count > 0) {
        charIssues.push(`lv25: "${srcStance.name}" source=${srcStance.lv25Count} local=${localLv25}`);
      }
    }

    if (charIssues.length > 0) {
      issues.push({ slug, errors: charIssues });
    } else {
      perfect++;
    }

    checked++;
    const pct = ((checked / files.length) * 100).toFixed(1);
    process.stdout.write(`\r  ${checked}/${files.length} (${pct}%) — ${perfect} perfect, ${issues.length} issues`);

    if (i < files.length - 1) await new Promise(r => setTimeout(r, 300));
  }

  console.log(`\n\n📊 Verification v2 Results:`);
  console.log(`  Characters checked: ${checked}`);
  console.log(`  Perfect match: ${perfect} (${(perfect/checked*100).toFixed(1)}%)`);
  console.log(`  With issues: ${issues.length}`);
  console.log(`  Stances checked: ${totalStancesChecked}`);
  console.log(`  Skills checked: ${totalSkillsChecked}`);

  if (issues.length > 0) {
    // Categorize
    const cats = { overview: 0, details: 0, missing_stance: 0, skill_count: 0, lv25: 0, http: 0 };
    for (const issue of issues) {
      for (const e of issue.errors) {
        if (e.startsWith("overview")) cats.overview++;
        else if (e.startsWith("details")) cats.details++;
        else if (e.startsWith("missing_stance")) cats.missing_stance++;
        else if (e.startsWith("skill_count")) cats.skill_count++;
        else if (e.startsWith("lv25")) cats.lv25++;
        else cats.http++;
      }
    }
    console.log(`\n  Issue breakdown:`);
    Object.entries(cats).filter(([,v]) => v > 0).forEach(([k,v]) => console.log(`    ${k}: ${v}`));

    console.log(`\n❌ Details:\n`);
    for (const issue of issues) {
      console.log(`  ${issue.slug}:`);
      issue.errors.forEach(e => console.log(`    - ${e}`));
    }
  }

  const report = {
    timestamp: new Date().toISOString(),
    total: checked, perfect, issues: issues.length,
    stancesChecked: totalStancesChecked,
    skillsChecked: totalSkillsChecked,
    details: issues,
  };
  writeFileSync(resolve(FULL_DIR, "_verification-v2.json"), JSON.stringify(report, null, 2));
  console.log(`\n✅ Report saved to data/full/_verification-v2.json`);
}

main().catch(err => { console.error(err); process.exit(1); });
