#!/usr/bin/env node
// Generate SQL to update old fields (target, levels, buff) from re-scraped data
// This fixes the 512 diffs found by verify-characters-v3.mjs
// Usage: node scripts/import-rescrape-fields.mjs

import { readFileSync, writeFileSync, readdirSync } from "node:fs";
import { resolve, dirname } from "node:path";
import { fileURLToPath } from "node:url";

const __dirname = dirname(fileURLToPath(import.meta.url));
const DATA_DIR = resolve(__dirname, "../data/full");
const OUT_FILE = resolve(__dirname, "import-rescrape-fields.sql");

const files = readdirSync(DATA_DIR).filter(f => f.endsWith(".json") && f !== "_summary.json");

function esc(s) {
  if (!s) return "NULL";
  return "'" + String(s).replace(/'/g, "''") + "'";
}

const lines = [
  "-- Auto-generated: update old fields from re-scraped data",
  `-- Generated: ${new Date().toISOString()}`,
  `-- Fixes 512 diffs in: target, levels, buff details`,
  "",
];

let skillUpdates = 0;
let buffUpdates = 0;

for (const file of files) {
  const data = JSON.parse(readFileSync(resolve(DATA_DIR, file), "utf8"));
  const slug = data.slug;

  for (const stance of (data.stances || [])) {
    for (const skill of (stance.skills || [])) {
      const updates = [];

      // Update target (re-scrape has more detailed format)
      if (skill.target) {
        updates.push(`target = ${esc(skill.target)}`);
      }

      // Update description
      if (skill.description) {
        updates.push(`description = ${esc(skill.description)}`);
      }

      // Update casting_time, cooldown, duration
      if (skill.casting_time) updates.push(`casting_time = ${esc(skill.casting_time)}`);
      if (skill.cooldown) updates.push(`cooldown = ${esc(skill.cooldown)}`);
      if (skill.duration) updates.push(`duration = ${esc(skill.duration)}`);

      // Update levels with full effects (always overwrite — re-scrape is source of truth)
      if (skill.levels && skill.levels.length > 0) {
        const levelsJson = JSON.stringify(skill.levels).replace(/'/g, "''");
        updates.push(`levels = '${levelsJson}'`);
      }

      if (updates.length > 0) {
        lines.push(
          `UPDATE skill_details SET ${updates.join(", ")} ` +
          `WHERE LOWER(character_slug) = LOWER(${esc(slug)}) AND skill_name = ${esc(skill.name)} AND stance_name = ${esc(stance.name)};`
        );
        skillUpdates++;
      }
    }
  }

  // Update character buff
  if (data.character_buff) {
    const b = data.character_buff;
    const updates = [];
    if (b.description) updates.push(`description = ${esc(b.description)}`);
    if (b.cooldown) updates.push(`cooldown = ${esc(b.cooldown)}`);
    if (b.casting_time) updates.push(`casting_time = ${esc(b.casting_time)}`);
    if (b.duration) updates.push(`duration = ${esc(b.duration)}`);
    if (b.sp_cost) updates.push(`sp_cost = ${esc(b.sp_cost)}`);
    if (b.consume_item) updates.push(`consume_item = ${esc(b.consume_item)}`);
    if (b.levels && b.levels.length > 0) {
      const levelsJson = JSON.stringify(b.levels).replace(/'/g, "''");
      updates.push(`levels = '${levelsJson}'`);
    }

    if (updates.length > 0) {
      lines.push(
        `UPDATE character_buffs SET ${updates.join(", ")} ` +
        `WHERE LOWER(character_slug) = LOWER(${esc(slug)});`
      );
      buffUpdates++;
    }
  }
}

lines.push("");
lines.push(`-- Summary: ${skillUpdates} skill updates, ${buffUpdates} buff updates`);

writeFileSync(OUT_FILE, lines.join("\n"), "utf8");
console.log(`✅ Generated ${OUT_FILE}`);
console.log(`   Skill updates: ${skillUpdates}`);
console.log(`   Buff updates: ${buffUpdates}`);
console.log(`   Total SQL lines: ${lines.length}`);
