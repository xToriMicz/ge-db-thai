#!/usr/bin/env node
/**
 * Match Thai names from scraped data against D1 database
 * Outputs SQL migration for all matched names
 */
import { execSync } from 'child_process';
import { readFileSync, writeFileSync } from 'fs';

const DB_NAME = 'ge-db-thai';

function d1Query(sql) {
  const escaped = sql.replace(/'/g, "'\\''");
  const cmd = `npx wrangler d1 execute ${DB_NAME} --remote --command '${escaped}' --json 2>/dev/null`;
  try {
    const out = execSync(cmd, { encoding: 'utf8', timeout: 30000 });
    const parsed = JSON.parse(out);
    return parsed[0]?.results || [];
  } catch (e) {
    console.error('D1 query failed:', sql.substring(0, 80));
    return [];
  }
}

// Load scraped data
const data = JSON.parse(readFileSync('data/thai-names-from-quests.json', 'utf8'));

// Also add today's new data from WebFetch
const extraItems = [
  // From Armonia Weapon guide (already in file? check)
  // From Reboldoeux quest
  { thai: "วาร์ปสครอล", english: "Warp Scroll", category: "consumables" },
  { thai: "เทเลพอร์ทสครอล", english: "Teleport Scroll", category: "consumables" },
  { thai: "เอลิเมนทัล ออร์บ", english: "Elemental Orb", category: "materials" },
  { thai: "เมจิคัล ออร์บ", english: "Magical Orb", category: "materials" },
  { thai: "ไชนี่ คริสตัล", english: "Shiny Crystal", category: "materials" },
  { thai: "ไมทริดาร์ท", english: "Mitridart", category: "consumables" },
  { thai: "ปีกลูซิเฟอร์", english: "Lucifer Wings", category: "equipment" },
  { thai: "ปีกปีศาจ", english: "Demon Wings", category: "equipment" },
  { thai: "ไทรอัมพ์ฟีลเลอร์", english: "Triumph Filler", category: "consumables" },
  // From Coimbra quest
  { thai: "เต้าหู้", english: "Soft Tofu", category: "materials" },
  { thai: "ช็อกโกแลต", english: "Chocolate", category: "materials" },
  { thai: "ฮิลลิ่งโพชั่น", english: "Healing Potion", category: "consumables" },
  { thai: "ฟินิกส์ วิง", english: "Phoenix Wing", category: "equipment" },
  { thai: "สเตียรอยด์ โพชั่น", english: "Stearoid Potion", category: "consumables" },
  // From Auch quest
  { thai: "รีเซอเรคทีฟ โพชั่น", english: "Resurrectiv Potion", category: "consumables" },
  { thai: "พรินซิเพิล แอมพัล", english: "Principal Ampoule", category: "consumables" },
  { thai: "โรส วิง", english: "Rose Wing", category: "equipment" },
  { thai: "โซล คริสตัล", english: "Sol Crystal", category: "materials" },
  // From Armonia weapon guide
  { thai: "อาร์โมเนีย แคนนอน", english: "Armonia Cannon", category: "equipment" },
  { thai: "อาร์โมเนีย โครสโบว์", english: "Armonia Crossbow", category: "equipment" },
  { thai: "อาร์โมเนีย เครสเซนต์", english: "Armonia Crescent", category: "equipment" },
  { thai: "อาร์โมเนีย ดาก้า", english: "Armonia Dagger", category: "equipment" },
  { thai: "อาร์โมเนีย ไฟ เบรซเล็ต", english: "Armonia Fire Bracelet", category: "equipment" },
  { thai: "อาร์โมเนีย น้ำแข็ง เบรซเล็ต", english: "Armonia Ice Bracelet", category: "equipment" },
  { thai: "อาร์โมเนีย จาวลิน", english: "Armonia Javelin", category: "equipment" },
  { thai: "อาร์โมเนีย นัคเคิล", english: "Armonia Knuckle", category: "equipment" },
  { thai: "อาร์โมเนีย ฟ้าผ่า เบรซเล็ต", english: "Armonia Lightning Bracelet", category: "equipment" },
  { thai: "อาร์โมเนีย ลูท", english: "Armonia Lute", category: "equipment" },
  { thai: "อาร์โมเนีย เมซ", english: "Armonia Mace", category: "equipment" },
  { thai: "อาร์โมเนีย หนังสือวิเศษ", english: "Armonia Magic Book", category: "equipment" },
  { thai: "อาร์โมเนีย เมน-โกช", english: "Armonia Main-gauche", category: "equipment" },
  { thai: "อาร์โมเนีย ปืนพก", english: "Armonia Pistol", category: "equipment" },
  { thai: "อาร์โมเนีย โปลอาร์ม", english: "Armonia Polearm", category: "equipment" },
  { thai: "อาร์โมเนีย เร เปียร์", english: "Armonia Rapier", category: "equipment" },
  { thai: "อาร์โมเนีย ไรเฟิล", english: "Armonia Rifle", category: "equipment" },
  { thai: "อาร์โมเนีย ไม้", english: "Armonia Rod", category: "equipment" },
  { thai: "อาร์โมเนีย เซเบอร์", english: "Armonia Sabre", category: "equipment" },
  { thai: "อาร์โมเนีย โล่", english: "Armonia Shield", category: "equipment" },
  { thai: "อาร์โมเนีย ช็อตกัน", english: "Armonia Shotgun", category: "equipment" },
  { thai: "อาร์โมเนีย สเลเยอร์", english: "Armonia Slayer", category: "equipment" },
  { thai: "อาร์โมเนีย สเปเชียล เบรซเล็ต", english: "Armonia Special Bracelet", category: "equipment" },
  { thai: "อาร์โมเนีย คฑา", english: "Armonia Staff", category: "equipment" },
  { thai: "อาร์โมเนีย ซอร์ด", english: "Armonia Sword", category: "equipment" },
  { thai: "อาร์โมเนีย ตันฟา", english: "Armonia Tonfa", category: "equipment" },
  // Armonia materials
  { thai: "ชิ้นความมืด", english: "Pieces of Darkness", category: "materials" },
  { thai: "น้ำบริสุทธิ์อาร์โมเนีย", english: "Armonia Holy Water", category: "materials" },
  // Patch note items
  { thai: "เศษกระดาษปริศนา", english: "Puzzle Paper Fragment", category: "materials" },
];

async function main() {
  // Collect all item-matchable pairs
  const itemPairs = [];
  for (const cat of ['materials', 'consumables', 'equipment', 'items_misc']) {
    if (data.categories[cat]) {
      for (const p of data.categories[cat]) {
        itemPairs.push({ thai: p.thai, english: p.english, source: p.source || cat });
      }
    }
  }
  for (const p of extraItems) {
    itemPairs.push({ thai: p.thai, english: p.english, source: 'webfetch-today' });
  }

  // Deduplicate by english name
  const seen = new Set();
  const uniqueItems = [];
  for (const p of itemPairs) {
    const key = p.english.toLowerCase();
    if (!seen.has(key)) {
      seen.add(key);
      uniqueItems.push(p);
    }
  }

  console.log(`Total unique item pairs to match: ${uniqueItems.length}`);

  // Get all items from DB for matching
  console.log('Fetching items from D1...');
  const allItems = d1Query("SELECT name, slug FROM items LIMIT 11000");
  console.log(`Items in DB: ${allItems.length}`);

  // Build lookup maps
  const exactMap = new Map(); // lowercase name -> item
  const wordMap = new Map(); // first significant word -> items
  for (const item of allItems) {
    exactMap.set(item.name.toLowerCase(), item);
    // Also store without common prefixes
    const simplified = item.name.toLowerCase()
      .replace(/^(old |broken |damaged |refined |pure |mega |mini |great |small |large |giant |tiny )/, '');
    if (simplified !== item.name.toLowerCase()) {
      // store both
    }
  }

  // Match items
  const matched = [];
  const unmatched = [];

  for (const pair of uniqueItems) {
    const en = pair.english;
    const enLower = en.toLowerCase();

    // Exact match
    let item = exactMap.get(enLower);

    // Try variations if no exact match
    if (!item) {
      // Try with/without 's at end
      item = exactMap.get(enLower.replace(/'s$/, ''));
    }
    if (!item) {
      // Try adding/removing "Recipe"
      item = exactMap.get(enLower + ' recipe');
    }
    if (!item) {
      // Try partial - check if DB has an item containing this name
      for (const [name, it] of exactMap) {
        if (name.includes(enLower) && name.length - enLower.length < 10) {
          item = it;
          break;
        }
      }
    }

    if (item) {
      matched.push({ ...pair, dbName: item.name, dbSlug: item.slug });
    } else {
      unmatched.push(pair);
    }
  }

  console.log(`\nMatched: ${matched.length}`);
  console.log(`Unmatched: ${unmatched.length}`);

  // Also match characters
  const charPairs = data.categories.characters || [];
  const allChars = d1Query("SELECT name, display_name, slug, name_th FROM characters LIMIT 500");
  console.log(`\nCharacters in DB: ${allChars.length}`);

  const charMatched = [];
  for (const pair of charPairs) {
    const en = pair.english.toLowerCase();
    const char = allChars.find(c =>
      c.name?.toLowerCase() === en ||
      c.display_name?.toLowerCase() === en ||
      c.slug?.toLowerCase() === en.replace(/\s+/g, '-')
    );
    if (char && !char.name_th) {
      charMatched.push({ ...pair, dbName: char.display_name || char.name, dbSlug: char.slug });
    }
  }
  console.log(`Characters matched (without existing name_th): ${charMatched.length}`);

  // Match maps
  const mapPairs = data.categories.maps || [];
  const allMaps = d1Query("SELECT name, slug, name_th FROM maps LIMIT 500");
  console.log(`\nMaps in DB: ${allMaps.length}`);

  const mapMatched = [];
  for (const pair of mapPairs) {
    const en = pair.english.toLowerCase();
    const map = allMaps.find(m =>
      m.name?.toLowerCase() === en ||
      m.slug?.toLowerCase() === en.replace(/\s+/g, '-')
    );
    if (map && !map.name_th) {
      mapMatched.push({ ...pair, dbName: map.name, dbSlug: map.slug });
    }
  }
  console.log(`Maps matched (without existing name_th): ${mapMatched.length}`);

  // Match monsters
  const monPairs = data.categories.monsters || [];
  const allMons = d1Query("SELECT name, name_th FROM monsters GROUP BY name LIMIT 1000");
  console.log(`\nUnique monsters in DB: ${allMons.length}`);

  const monMatched = [];
  for (const pair of monPairs) {
    const en = pair.english.toLowerCase();
    const mon = allMons.find(m => m.name?.toLowerCase() === en);
    if (mon && !mon.name_th) {
      monMatched.push({ ...pair, dbName: mon.name });
    }
  }
  console.log(`Monsters matched (without existing name_th): ${monMatched.length}`);

  // Generate SQL migration
  const sqlLines = ['-- Migration: Thai names from ge.exe.in.th (quests, guides, patch notes)',
                    `-- Generated: ${new Date().toISOString()}`, ''];

  // Items
  if (matched.length > 0) {
    sqlLines.push(`-- Items: ${matched.length} matches`);
    for (const m of matched) {
      const th = m.thai.replace(/'/g, "''");
      const slug = m.dbSlug.replace(/'/g, "''");
      sqlLines.push(`UPDATE items SET name_th = '${th}' WHERE slug = '${slug}' AND name_th IS NULL;`);
    }
    sqlLines.push('');
  }

  // Characters
  if (charMatched.length > 0) {
    sqlLines.push(`-- Characters: ${charMatched.length} matches`);
    for (const m of charMatched) {
      const th = m.thai.replace(/'/g, "''");
      const slug = m.dbSlug.replace(/'/g, "''");
      sqlLines.push(`UPDATE characters SET name_th = '${th}' WHERE slug = '${slug}' AND name_th IS NULL;`);
    }
    sqlLines.push('');
  }

  // Maps
  if (mapMatched.length > 0) {
    sqlLines.push(`-- Maps: ${mapMatched.length} matches`);
    for (const m of mapMatched) {
      const th = m.thai.replace(/'/g, "''");
      const slug = m.dbSlug.replace(/'/g, "''");
      sqlLines.push(`UPDATE maps SET name_th = '${th}' WHERE slug = '${slug}' AND name_th IS NULL;`);
    }
    sqlLines.push('');
  }

  // Monsters
  if (monMatched.length > 0) {
    sqlLines.push(`-- Monsters: ${monMatched.length} matches`);
    for (const m of monMatched) {
      const th = m.thai.replace(/'/g, "''");
      const name = m.dbName.replace(/'/g, "''");
      sqlLines.push(`UPDATE monsters SET name_th = '${th}' WHERE name = '${name}' AND name_th IS NULL;`);
    }
    sqlLines.push('');
  }

  const sql = sqlLines.join('\n');
  writeFileSync('sql/migrations/047_thai-names-batch.sql', sql);
  console.log(`\nMigration saved to sql/migrations/047_thai-names-batch.sql`);

  // Summary
  console.log('\n=== SUMMARY ===');
  console.log(`Items: ${matched.length} matched`);
  console.log(`Characters: ${charMatched.length} matched`);
  console.log(`Maps: ${mapMatched.length} matched`);
  console.log(`Monsters: ${monMatched.length} matched`);
  console.log(`Total updates: ${matched.length + charMatched.length + mapMatched.length + monMatched.length}`);

  // Show unmatched items for debugging
  if (unmatched.length > 0) {
    console.log(`\n--- Unmatched items (${unmatched.length}) ---`);
    for (const u of unmatched.slice(0, 30)) {
      console.log(`  ${u.english} → ${u.thai}`);
    }
    if (unmatched.length > 30) console.log(`  ... and ${unmatched.length - 30} more`);
  }
}

main().catch(console.error);
