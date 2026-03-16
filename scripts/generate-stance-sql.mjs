#!/usr/bin/env node
// Generate SQL migration from scraped full character data
// Reads data/full/*.json → outputs stance_details + skill_details INSERT statements

import { readFileSync, readdirSync, writeFileSync } from "node:fs";
import { resolve, dirname } from "node:path";
import { fileURLToPath } from "node:url";

const __dirname = dirname(fileURLToPath(import.meta.url));
const FULL_DIR = resolve(__dirname, "../data/full");
const OUT_STANCE = resolve(__dirname, "../sql/migrations/026_stance-details-data.sql");
const OUT_SKILL = resolve(__dirname, "../sql/migrations/031_skill-details-per-char-data.sql");

function esc(s) {
  if (s === null || s === undefined) return "NULL";
  return "'" + String(s).replace(/'/g, "''") + "'";
}

function main() {
  const files = readdirSync(FULL_DIR).filter(f => f.endsWith(".json") && !f.startsWith("_"));
  console.log(`Processing ${files.length} character files...\n`);

  const stanceMap = new Map(); // stance_name → details (first occurrence wins)
  const skillMap = new Map();  // skill_name+stance_name → details

  for (const file of files) {
    const data = JSON.parse(readFileSync(resolve(FULL_DIR, file), "utf8"));
    if (!data.stances) continue;

    for (const stance of data.stances) {
      // Only store first occurrence of each stance name
      if (!stanceMap.has(stance.name)) {
        stanceMap.set(stance.name, {
          stance_name: stance.name,
          equipped_items: stance.equipped_items || "None",
          icon_x: stance.icon_position?.x ?? null,
          icon_y: stance.icon_position?.y ?? null,
          targets: stance.info?.Targets || null,
          attack_range: stance.info?.Range || null,
          splash: stance.info?.Splash || null,
          hits_per_attack: stance.info?.["Hits per attack"] || null,
          hits_flying: stance.info?.["Hits flying"] || "No",
          flying: stance.info?.Flying || "No",
          regenerate_sp: stance.info?.["Regenerate SP"] || null,
          physical_dmg_mod: stance.info?.["Physical DMG"] || null,
          shooting_dmg_mod: stance.info?.["Shooting DMG"] || null,
          magical_dmg_mod: stance.info?.["Magical DMG"] || null,
          aspd: stance.stats?.ASPD || null,
          bonus_atk: stance.stats?.["Bonus ATK"] || null,
          mspd: stance.stats?.MSPD || null,
          mspd_limit: stance.stats?.["MSPD Limit"] || null,
          acc: stance.stats?.ACC || null,
          eva: stance.stats?.EVA || null,
          blk: stance.stats?.BLK || null,
          fire_res: stance.stats?.["Fire RES"] || "0",
          ice_res: stance.stats?.["Ice RES"] || "0",
          lightning_res: stance.stats?.["Lightning RES"] || "0",
          abnormal_res: stance.stats?.["Abnormal RES"] || "0",
          lv25_bonus: JSON.stringify(stance.lv25_bonus || {}),
          lv25_bonus_extra: stance.lv25_bonus_extra ? JSON.stringify(stance.lv25_bonus_extra) : null,
        });
      }

      // Skills — keyed by skill_name + stance_name + character_slug
      for (const skill of stance.skills || []) {
        const key = `${skill.name}|||${stance.name}|||${data.slug}`;
        if (!skillMap.has(key)) {
          skillMap.set(key, {
            character_slug: data.slug,
            skill_name: skill.name,
            stance_name: stance.name,
            skill_image: skill.image || null,
            description: skill.description || null,
            target: skill.target || null,
            casting_time: skill.casting_time || null,
            cooldown: skill.cooldown || null,
            duration: skill.duration || null,
            hits_flying: skill.hits_flying || null,
            knock_down: skill.knock_down || null,
            sp_cost: skill.sp_cost || null,
            aggro: skill.aggro || null,
            skill_type: skill.skill_type || null,
            levels: JSON.stringify(skill.levels || []),
            special: JSON.stringify(skill.special || []),
          });
        }
      }
    }
  }

  console.log(`Unique stances: ${stanceMap.size}`);
  console.log(`Unique skills: ${skillMap.size}`);

  // Generate stance SQL
  let stanceSql = `-- 026: Stance details data\n-- ${stanceMap.size} unique stances with full stats\n\n`;
  for (const [, s] of stanceMap) {
    stanceSql += `INSERT OR IGNORE INTO stance_details (stance_name, equipped_items, icon_x, icon_y, targets, attack_range, splash, hits_per_attack, hits_flying, flying, regenerate_sp, physical_dmg_mod, shooting_dmg_mod, magical_dmg_mod, aspd, bonus_atk, mspd, mspd_limit, acc, eva, blk, fire_res, ice_res, lightning_res, abnormal_res, lv25_bonus, lv25_bonus_extra) VALUES (${esc(s.stance_name)}, ${esc(s.equipped_items)}, ${s.icon_x ?? "NULL"}, ${s.icon_y ?? "NULL"}, ${esc(s.targets)}, ${esc(s.attack_range)}, ${esc(s.splash)}, ${esc(s.hits_per_attack)}, ${esc(s.hits_flying)}, ${esc(s.flying)}, ${esc(s.regenerate_sp)}, ${esc(s.physical_dmg_mod)}, ${esc(s.shooting_dmg_mod)}, ${esc(s.magical_dmg_mod)}, ${esc(s.aspd)}, ${esc(s.bonus_atk)}, ${esc(s.mspd)}, ${esc(s.mspd_limit)}, ${esc(s.acc)}, ${esc(s.eva)}, ${esc(s.blk)}, ${esc(s.fire_res)}, ${esc(s.ice_res)}, ${esc(s.lightning_res)}, ${esc(s.abnormal_res)}, ${esc(s.lv25_bonus)}, ${esc(s.lv25_bonus_extra)});\n`;
  }

  // Generate skill SQL (per-character, not deduped)
  let skillSql = `-- 031: Skill details data (per-character)\n-- ${skillMap.size} skills across all characters\n\n`;
  for (const [, s] of skillMap) {
    skillSql += `INSERT OR IGNORE INTO skill_details (character_slug, skill_name, stance_name, skill_image, description, target, casting_time, cooldown, duration, hits_flying, knock_down, sp_cost, aggro, skill_type, levels, special) VALUES (${esc(s.character_slug)}, ${esc(s.skill_name)}, ${esc(s.stance_name)}, ${esc(s.skill_image)}, ${esc(s.description)}, ${esc(s.target)}, ${esc(s.casting_time)}, ${esc(s.cooldown)}, ${esc(s.duration)}, ${esc(s.hits_flying)}, ${esc(s.knock_down)}, ${esc(s.sp_cost)}, ${esc(s.aggro)}, ${esc(s.skill_type)}, ${esc(s.levels)}, ${esc(s.special)});\n`;
  }

  writeFileSync(OUT_STANCE, stanceSql);
  writeFileSync(OUT_SKILL, skillSql);

  console.log(`\n✅ Generated:`);
  console.log(`  ${OUT_STANCE} (${stanceMap.size} stances)`);
  console.log(`  ${OUT_SKILL} (${skillMap.size} skills)`);
}

main().catch(err => { console.error(err); process.exit(1); });
