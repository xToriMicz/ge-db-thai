#!/usr/bin/env node
// Generate SQL to import 5 new columns from data/full/*.json into D1
// Outputs: scripts/import-new-columns.sql
// Usage: node scripts/import-new-columns.mjs

import { readFileSync, writeFileSync, readdirSync } from "node:fs";
import { resolve, dirname } from "node:path";
import { fileURLToPath } from "node:url";

const __dirname = dirname(fileURLToPath(import.meta.url));
const DATA_DIR = resolve(__dirname, "../data/full");
const OUT_FILE = resolve(__dirname, "import-new-columns.sql");

const files = readdirSync(DATA_DIR).filter(f => f.endsWith(".json") && f !== "_summary.json");

function esc(s) {
  if (!s) return "NULL";
  return "'" + String(s).replace(/'/g, "''") + "'";
}

function escJson(arr) {
  if (!arr || arr.length === 0) return "'[]'";
  return "'" + JSON.stringify(arr).replace(/'/g, "''") + "'";
}

const lines = [
  "-- Auto-generated: import 5 new columns from data/full/*.json",
  `-- Generated: ${new Date().toISOString()}`,
  `-- Characters: ${files.length}`,
  "",
];

let stanceUpdates = 0;
let skillUpdates = 0;
let levelUpdates = 0;

for (const file of files) {
  const data = JSON.parse(readFileSync(resolve(DATA_DIR, file), "utf8"));
  const slug = data.slug;

  for (const stance of (data.stances || [])) {
    // Stance consume
    if (stance.consume) {
      lines.push(`UPDATE stance_details SET consume = ${esc(stance.consume)} WHERE stance_name = ${esc(stance.name)};`);
      stanceUpdates++;
    }

    for (const skill of (stance.skills || [])) {
      const updates = [];

      if (skill.consume_item) updates.push(`consume_item = ${esc(skill.consume_item)}`);
      if (skill.soft_armor_atk) updates.push(`soft_armor_atk = ${esc(skill.soft_armor_atk)}`);
      if (skill.heavy_armor_atk) updates.push(`heavy_armor_atk = ${esc(skill.heavy_armor_atk)}`);
      if (skill.light_armor_atk) updates.push(`light_armor_atk = ${esc(skill.light_armor_atk)}`);

      // Update levels with full effects
      if (skill.levels && skill.levels.length > 0) {
        const hasEffects = skill.levels.some(l => l.effects && l.effects.length > 0);
        if (hasEffects) {
          updates.push(`levels = ${escJson(skill.levels)}`);
          levelUpdates++;
        }
      }

      if (updates.length > 0) {
        // Use LOWER() for case-insensitive matching since DB has mixed case slugs
        lines.push(
          `UPDATE skill_details SET ${updates.join(", ")} ` +
          `WHERE LOWER(character_slug) = LOWER(${esc(slug)}) AND skill_name = ${esc(skill.name)} AND stance_name = ${esc(stance.name)};`
        );
        skillUpdates++;
      }
    }
  }
}

lines.push("");
lines.push(`-- Summary: ${stanceUpdates} stance updates, ${skillUpdates} skill updates, ${levelUpdates} level updates`);

writeFileSync(OUT_FILE, lines.join("\n"), "utf8");
console.log(`✅ Generated ${OUT_FILE}`);
console.log(`   Stance consume updates: ${stanceUpdates}`);
console.log(`   Skill updates (consume/armor/levels): ${skillUpdates}`);
console.log(`   Level effect updates: ${levelUpdates}`);
console.log(`   Total SQL lines: ${lines.length}`);
