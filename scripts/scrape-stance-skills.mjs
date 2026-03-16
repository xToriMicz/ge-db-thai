#!/usr/bin/env node
// Scrape stance skills from character pages on ge-db.site
// Each character page has stances with skills listed
import { writeFileSync, readFileSync } from "node:fs";
import { resolve, dirname } from "node:path";
import { fileURLToPath } from "node:url";

const __dirname = dirname(fileURLToPath(import.meta.url));
const OUT_PATH = resolve(__dirname, "../data/stance-skills.json");
const BASE = "https://ge-db.site/andromida";

// Get character slugs from existing data
const chars = JSON.parse(readFileSync(resolve(__dirname, "../data/characters-list.json"), "utf8"));
const slugs = chars.map(c => c.slug || c.name);

function parseStanceSkills(html, charSlug) {
  const results = [];

  // Find all stance sections: <h3 id="StanceId">Stance Name</h3>
  const stanceRegex = /<h3\s+id="([^"]+)">([^<]+)<\/h3>/gi;
  const stances = [...html.matchAll(stanceRegex)];

  for (let i = 0; i < stances.length; i++) {
    const stanceName = stances[i][2].trim();
    const startIdx = stances[i].index;
    const endIdx = i + 1 < stances.length ? stances[i + 1].index : startIdx + 10000;
    const section = html.substring(startIdx, Math.min(endIdx, startIdx + 10000));

    // Find skills: <img ... class="skills_als" ... alt="Skill Name">
    const skillRegex = /class="skills_als"[^>]*alt="([^"]+)"/gi;
    const skills = [...section.matchAll(skillRegex)];

    // Also find skill images for icon reference
    const skillImgRegex = /src="\.\/images\/Skills\/([^"]+)"/gi;
    const skillImgs = [...section.matchAll(skillImgRegex)];

    for (let j = 0; j < skills.length; j++) {
      const skillName = skills[j][1].trim();
      if (skillName && skillName !== "None" && skillName.length > 1) {
        results.push({
          character_slug: charSlug,
          stance_name: stanceName,
          skill_name: skillName,
          skill_image: skillImgs[j] ? skillImgs[j][1] : null,
        });
      }
    }
  }

  return results;
}

async function scrapeChar(slug, retries = 2) {
  const url = `${BASE}/${slug}.php`;
  for (let attempt = 0; attempt <= retries; attempt++) {
    try {
      const res = await fetch(url);
      if (!res.ok) return [];
      const html = await res.text();
      return parseStanceSkills(html, slug);
    } catch {
      if (attempt < retries) await new Promise(r => setTimeout(r, 1000));
      else return [];
    }
  }
  return [];
}

async function main() {
  console.log(`🎯 Scraping stance skills for ${slugs.length} characters\n`);

  const allSkills = [];
  const batchSize = 5;

  for (let i = 0; i < slugs.length; i += batchSize) {
    const batch = slugs.slice(i, i + batchSize);
    const results = await Promise.all(batch.map(s => scrapeChar(s)));
    for (const skills of results) allSkills.push(...skills);

    process.stdout.write(`  ${Math.min(i + batchSize, slugs.length)}/${slugs.length} characters (${allSkills.length} skills)\r`);
    if (i + batchSize < slugs.length) await new Promise(r => setTimeout(r, 300));
  }

  console.log(`\n\n📊 Total: ${allSkills.length} skills across ${new Set(allSkills.map(s => s.stance_name)).size} stances`);

  writeFileSync(OUT_PATH, JSON.stringify(allSkills, null, 2));
  console.log(`✅ Saved to data/stance-skills.json`);
}

main().catch(err => { console.error(err); process.exit(1); });
