// Import scraped character data into D1-compatible SQL
// Usage: npx tsx scripts/import-to-d1.ts > sql/seed.sql
// Then: wrangler d1 execute ge-db-thai --file=sql/seed.sql
import { readFileSync } from "fs";

const DATA = "/Users/angkana/Jingjing-oracle/ψ/lab/ge-db/data/characters-detail.json";
const characters = JSON.parse(readFileSync(DATA, "utf-8"));

function esc(s: string): string {
  return s.replace(/'/g, "''");
}

console.log("-- GE Database Thai — Seed Data");
console.log(`-- Generated: ${new Date().toISOString()}`);
console.log(`-- Characters: ${characters.length}\n`);

// Insert characters
for (const c of characters) {
  const stats = c.stats || {};
  console.log(`INSERT OR REPLACE INTO characters (slug, name, display_name, type, armor_types, weapons, portrait_x, portrait_y, portrait_class, str, agi, hp, dex, int_stat, sen, starting_level, bio, starting_armor, starting_weapon, buff, buff_level, is_new) VALUES ('${esc(c.slug)}', '${esc(c.name)}', '${esc(c.displayName)}', '${esc(c.type)}', '${esc(JSON.stringify(c.armorTypes || []))}', '${esc(JSON.stringify(c.weapons || []))}', ${c.portraitX || 0}, ${c.portraitY || 0}, '${esc(c.portraitClass || "portrait")}', ${stats.str || 0}, ${stats.agi || 0}, ${stats.hp || 0}, ${stats.dex || 0}, ${stats.int || 0}, ${stats.sen || 0}, ${c.startingLevel || 1}, '${esc(c.bio || "")}', '${esc(c.startingArmor || "")}', '${esc(c.startingWeapon || "")}', '${esc(c.buff || "")}', ${c.buffLevel || 0}, ${c.isNew ? 1 : 0});`);
}

console.log("");

// Insert stances
for (const c of characters) {
  if (!c.stances?.length) continue;
  for (const stance of c.stances) {
    console.log(`INSERT OR REPLACE INTO stances (character_id, name) VALUES ((SELECT id FROM characters WHERE slug = '${esc(c.slug)}'), '${esc(stance)}');`);
  }
}

console.log(`\n-- Done: ${characters.length} characters imported`);
