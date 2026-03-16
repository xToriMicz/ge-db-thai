#!/usr/bin/env node
/**
 * Translate ALL remaining items (v2) — handles items that v1 skipped
 * Strategy: Category-aware prefix + transliterated/translated name parts
 */
import { execSync } from 'child_process';
import { writeFileSync } from 'fs';

const DB_NAME = 'ge-db-thai';

function d1Query(sql) {
  const escaped = sql.replace(/'/g, "'\\''");
  const cmd = `npx wrangler d1 execute ${DB_NAME} --remote --command '${escaped}' --json 2>/dev/null`;
  try {
    return JSON.parse(execSync(cmd, { encoding: 'utf8', timeout: 60000, maxBuffer: 50 * 1024 * 1024 }))[0]?.results || [];
  } catch (e) { console.error('D1 error:', e.message?.slice(0, 200)); return []; }
}

// Category → Thai type name
const categoryType = {
  'controller': 'คอนโทรลเลอร์',
  'leather': 'เกราะหนัง', 'coat': 'โค้ท', 'robe': 'โรบ', 'metal': 'เกราะโลหะ',
  'earring': 'ต่างหู', 'necklace': 'สร้อยคอ', 'glove': 'ถุงมือ',
  'belt': 'เข็มขัด', 'shoes': 'รองเท้า', 'leg_guards': 'สนับแข้ง',
  'shield': 'โล่', 'runestone': 'รูนสโตน', 'pendant': 'จี้',
  'cube': 'คิวบ์', 'rosario': 'โรซาริโอ',
  'fire_bracelet': 'เบรซเล็ตไฟ', 'ice_bracelet': 'เบรซเล็ตน้ำแข็ง',
  'lightning_bracelet': 'เบรซเล็ตฟ้าผ่า', 'special_bracelet': 'เบรซเล็ตพิเศษ',
  'sword': 'ซอร์ด', 'dagger': 'ดาก้า', 'rapier': 'เรเปียร์', 'sabre': 'เซเบอร์',
  'blunt': 'บลันท์', 'polearm': 'โปลอาร์ม', 'great_sword': 'ซอร์ดใหญ่',
  'knuckle': 'นัคเคิล', 'javelin': 'จาวลิน', 'tonfa': 'ตันฟา',
  'main_gauche': 'เมน-โกช',
  'cannon': 'แคนนอน', 'crossbow': 'โครสโบว์', 'rifle': 'ไรเฟิล',
  'heavy_rifle': 'ไรเฟิลหนัก', 'pistol': 'ปืนพก', 'shotgun': 'ช็อตกัน',
  'rod': 'ไม้เท้า', 'staff': 'คฑา', 'lute': 'ลูท',
  'lumin': 'ลูมิน', 'arm_shield': 'อาร์มชิลด์',
};

// Known prefixes (reused from translate-weapons.mjs)
const prefixes = {
  'Abyss Arma': 'อะบิส อาร์ม่า', 'Angel': 'แองเจิล', 'Armonia': 'อาร์โมเนีย',
  'Atlas': 'แอตลาส', 'Bristia': 'บริสเทีย', 'Deus Machina': 'เดอุส มาชิน่า',
  'Divine': 'ดิไวน์', 'Elite Bristia': 'อีลิท บริสเทีย',
  'Elite Experimental': 'อีลิท ทดลอง', 'Elite Muertuors': 'อีลิท มูเอร์ทัวร์ส',
  'Enex Ethereal': 'เอเน็กซ์ อีเธอเรียล',
  'Event Elite Muertuors': 'อีเวนต์ อีลิท มูเอร์ทัวร์ส',
  'Event Muertuors': 'อีเวนต์ มูเอร์ทัวร์ส',
  'Evil': 'อีวิล', 'Experimental': 'ทดลอง',
  'Legion': 'ลีเจียน', 'Muertuors': 'มูเอร์ทัวร์ส',
  'Prospe': 'พรอสเป', 'Refined Vespanola': 'เวสปาโนลาขัดเงา',
  'Strata Devil': 'สตราต้า เดวิล',
  'Tyrants Order': 'คำสั่งทรราช', 'Valeron': 'วาเลรอน',
  'Vespanola Pioneer Support': 'สนับสนุนผู้บุกเบิกเวสปาโนลา',
  'Kobolt': 'โคบอลท์', 'Ogre': 'อ็อกร์', 'Werewolf': 'แวร์วูล์ฟ',
  'Werebear': 'แวร์แบร์', 'Serpent': 'เซอร์เพนท์',
  'Veteran': 'เวเทอราน', 'Ancient': 'โบราณ', 'Elite': 'อีลิท',
  'Strata': 'สตราต้า', 'Black': 'ดำ', 'White': 'ขาว',
  'Golden': 'ทอง', 'Silver': 'เงิน', 'Dark': 'มืด',
  'Holy': 'ศักดิ์สิทธิ์', 'Shadow': 'เงา', 'Storm': 'พายุ',
  'Iron': 'เหล็ก', 'Crystal': 'คริสตัล', 'Dragon': 'มังกร',
  'Demonic': 'ปีศาจ', 'Royal': 'ราชวงศ์', 'Imperial': 'จักรพรรดิ',
};

// Suffix patterns
function handleSuffix(name) {
  let suffix = '', prefix = '', clean = name;
  const suffixPats = [
    [/\s*\(Event\)\s*$/, ' (อีเวนต์)'],
    [/\s*\((\d+)\s*[Dd]ays?\)\s*$/, (m) => ` (${m[1]} วัน)`],
    [/\s*\(Illusion\)\s*$/, ' (ภาพลวง)'],
  ];
  for (const [pat, rep] of suffixPats) {
    const m = clean.match(pat);
    if (m) { suffix = typeof rep === 'function' ? rep(m) : rep; clean = clean.replace(pat, ''); break; }
  }
  const prefPats = [
    [/^\[Event\]\s+/i, '[อีเวนต์] '],
    [/^\[Dreaming\]\s+/, '[ความฝัน] '],
    [/^\[Tier I\]\s+/, '[เทียร์ I] '],
    [/^\[Tier II\]\s+/, '[เทียร์ II] '],
  ];
  for (const [pat, rep] of prefPats) {
    if (clean.match(pat)) { prefix = rep; clean = clean.replace(pat, ''); break; }
  }
  return { clean, prefix, suffix };
}

// Type words to strip from name when we already know category
const typeWords = {
  'leather': ['Leather Armor', 'Leather'],
  'coat': ['Coat'],
  'robe': ['Robe'],
  'metal': ['Metal Armor', 'Metal'],
  'earring': ['Earrings', 'Earring'],
  'necklace': ['Necklace'],
  'glove': ['Gloves', 'Glove'],
  'belt': ['Belt'],
  'shoes': ['Shoes', 'Boots'],
  'leg_guards': ['Leg Guards', 'Leg Guard', 'Leggings'],
  'shield': ['Shield'],
  'runestone': ['Runestone'],
  'pendant': ['Pendant'],
  'cube': ['Cube'],
  'rosario': ['Rosario'],
  'fire_bracelet': ['Fire Bracelet', 'Bracelet'],
  'ice_bracelet': ['Ice Bracelet', 'Bracelet'],
  'lightning_bracelet': ['Lightning Bracelet', 'Bracelet'],
  'special_bracelet': ['Special Bracelet', 'Bracelet'],
  'sword': ['Sword'],
  'dagger': ['Dagger'],
  'rapier': ['Rapier'],
  'sabre': ['Sabre', 'Saber'],
  'blunt': ['Blunt', 'Mace', 'Hammer'],
  'polearm': ['Polearm', 'Halberd'],
  'great_sword': ['Great Sword', 'Greatsword'],
  'knuckle': ['Knuckle'],
  'javelin': ['Javelin'],
  'tonfa': ['Tonfa'],
  'main_gauche': ['Main-Gauche', 'Main-gauche'],
  'cannon': ['Cannon'],
  'crossbow': ['Crossbow'],
  'rifle': ['Rifle'],
  'heavy_rifle': ['Heavy Rifle', 'Rifle'],
  'pistol': ['Pistol'],
  'shotgun': ['Shotgun'],
  'rod': ['Rod'],
  'staff': ['Staff'],
  'lute': ['Lute'],
  'lumin': ['Lumin'],
  'arm_shield': ['Arm Shield', 'Armshield'],
  'controller': ['Controller'],
};

// Medal translations
const medalKnown = {
  'Crest': 'ตรา', 'Medal': 'เหรียญ', 'Badge': 'ตรา', 'Emblem': 'สัญลักษณ์',
  'Insignia': 'เครื่องหมาย', 'Mark': 'ตรา', 'Token': 'เหรียญ',
  'Seal': 'ตรา', 'Symbol': 'สัญลักษณ์', 'Sigil': 'ตรา',
  'Order': 'เครื่องราช', 'Star': 'ดาว', 'Cross': 'กางเขน',
  'Wing': 'ปีก', 'Crown': 'มงกุฎ', 'Heart': 'หัวใจ',
  'Ring': 'แหวน', 'Eye': 'ดวงตา', 'Key': 'กุญแจ',
};

function translateEquipment(name, category) {
  const { clean, prefix, suffix } = handleSuffix(name);
  const thaiType = categoryType[category];
  if (!thaiType) return null;

  let nameOnly = clean;

  // Step 1: Strip known prefixes FIRST
  let thaiPrefix = '';
  for (const [eng, th] of Object.entries(prefixes).sort((a, b) => b[0].length - a[0].length)) {
    if (nameOnly.startsWith(eng + ' ') || nameOnly === eng) {
      thaiPrefix = th + ' ';
      nameOnly = nameOnly.slice(eng.length).trim();
      break;
    }
  }

  // Step 2: Strip category type word from remaining name
  const strips = typeWords[category] || [];
  for (const tw of strips) {
    const esc = tw.replace(/[.*+?^${}()|[\]\\]/g, '\\$&');
    const endPat = new RegExp(`\\s+${esc}$`);
    if (nameOnly.match(endPat)) { nameOnly = nameOnly.replace(endPat, ''); break; }
    const startPat = new RegExp(`^${esc}\\s+`);
    if (nameOnly.match(startPat)) { nameOnly = nameOnly.replace(startPat, ''); break; }
    // Also exact match (name IS just the type word)
    if (nameOnly === tw) { nameOnly = ''; break; }
  }

  // Build: prefix + Thai prefix + [category type] + remaining name
  const remaining = nameOnly ? ' ' + nameOnly : '';
  return `${prefix}${thaiPrefix}${thaiType}${remaining}${suffix}`.trim();
}

function translateMedal(name) {
  const { clean, prefix, suffix } = handleSuffix(name);

  // Try "Type of XXX" pattern
  for (const [eng, th] of Object.entries(medalKnown)) {
    const ofPat = new RegExp(`^${eng}\\s+of\\s+(.+)$`);
    const m = clean.match(ofPat);
    if (m) return `${prefix}${th}แห่ง${m[1]}${suffix}`;
  }

  // Try "XXX Type" pattern
  for (const [eng, th] of Object.entries(medalKnown)) {
    const endPat = new RegExp(`^(.+?)\\s+${eng}$`);
    const m = clean.match(endPat);
    if (m) return `${prefix}${th}${m[1]}${suffix}`;
  }

  // Fallback: เหรียญ + name
  return `${prefix}เหรียญ${clean}${suffix}`;
}

function translateCostume(name, category) {
  const { clean, prefix, suffix } = handleSuffix(name);
  const catPrefix = category === 'body_costume' ? 'ชุด' : 'คอสตูมอาวุธ';

  // Strip "Costume" / "Weapon Costume" from name
  let nameOnly = clean
    .replace(/\s+Weapon\s+Costume$/i, '')
    .replace(/\s+Costume$/i, '')
    .replace(/^Costume\s+/i, '');

  return `${prefix}${catPrefix} ${nameOnly}${suffix}`.trim();
}

function translateCosmetic(name, category) {
  const { clean, prefix, suffix } = handleSuffix(name);

  // Category-specific type words
  const catMap = {
    'hat': { default: 'หมวก', 'Wing': 'ปีก', 'Halo': 'รัศมี', 'Crown': 'มงกุฎ', 'Helm': 'หมวกเกราะ', 'Hood': 'ฮู้ด', 'Cap': 'หมวกแก๊ป', 'Ribbon': 'ริบบิ้น', 'Tiara': 'มงกุฎ', 'Headband': 'ที่คาดผม', 'Horns': 'เขา', 'Ears': 'หู', 'Hair': 'ผม' },
    'back': { default: 'หลัง', 'Wing': 'ปีก', 'Wings': 'ปีก', 'Cape': 'ผ้าคลุม', 'Cloak': 'เสื้อคลุม', 'Mantle': 'เสื้อคลุม', 'Quiver': 'ซองลูกธนู', 'Backpack': 'เป้', 'Pack': 'เป้', 'Tail': 'หาง', 'Flag': 'ธง', 'Banner': 'ธง', 'Shield': 'โล่', 'Scarf': 'ผ้าพันคอ', 'Aura': 'ออร่า' },
    'face': { default: 'หน้า', 'Mask': 'หน้ากาก', 'Glasses': 'แว่นตา', 'Monocle': 'แว่นตาเดียว', 'Eyepatch': 'ผ้าปิดตา', 'Visor': 'กระบังหน้า', 'Veil': 'ผ้าคลุมหน้า', 'Tattoo': 'รอยสัก' },
    'artifact': { default: 'อาร์ติแฟค' },
  };

  const types = catMap[category] || {};

  // Try to find a type word at the end
  for (const [eng, th] of Object.entries(types)) {
    if (eng === 'default') continue;
    const endPat = new RegExp(`^(.+?)\\s+${eng}s?$`, 'i');
    const m = clean.match(endPat);
    if (m) return `${prefix}${th}${m[1]}${suffix}`;

    // Also "Type of XXX"
    const ofPat = new RegExp(`^${eng}s?\\s+of\\s+(.+)$`, 'i');
    const m2 = clean.match(ofPat);
    if (m2) return `${prefix}${th}แห่ง${m2[1]}${suffix}`;
  }

  // Fallback: category default + name
  const defaultTh = types.default || category;
  return `${prefix}${defaultTh} ${clean}${suffix}`.trim();
}

// ===== Ring/Skill ring special handling =====
function translateRing(name) {
  const { clean, prefix, suffix } = handleSuffix(name);
  // "XXX Ring" → แหวนXXX
  const m = clean.match(/^(.+?)\s+Ring$/);
  if (m) return `${prefix}แหวน${m[1]}${suffix}`;
  return `${prefix}แหวน ${clean}${suffix}`;
}

// ===== MAIN =====
const allItems = d1Query("SELECT name, slug, category FROM items WHERE name_th IS NULL ORDER BY category, name");
console.log(`Total remaining: ${allItems.length}`);

const sqlLines = [];
let translated = 0, skipped = 0;
const catStats = {};

for (const item of allItems) {
  const cat = item.category;
  if (!catStats[cat]) catStats[cat] = { ok: 0, skip: 0 };

  let thaiName = null;

  // Equipment (weapons, armor, accessories)
  if (categoryType[cat]) {
    thaiName = translateEquipment(item.name, cat);
  }
  // Medals
  else if (cat === 'medal') {
    thaiName = translateMedal(item.name);
  }
  // Costumes
  else if (cat === 'body_costume' || cat === 'weapon_costume') {
    thaiName = translateCostume(item.name, cat);
  }
  // Cosmetics (hat, back, face)
  else if (['hat', 'back', 'face'].includes(cat)) {
    thaiName = translateCosmetic(item.name, cat);
  }
  // Artifact
  else if (cat === 'artifact') {
    thaiName = translateCosmetic(item.name, 'artifact');
  }
  // Rings
  else if (cat.endsWith('_ring')) {
    thaiName = translateRing(item.name);
  }

  if (thaiName) {
    const th = thaiName.replace(/'/g, "''");
    const slug = item.slug.replace(/'/g, "''");
    sqlLines.push(`UPDATE items SET name_th = '${th}' WHERE slug = '${slug}' AND name_th IS NULL;`);
    translated++;
    catStats[cat].ok++;
  } else {
    skipped++;
    catStats[cat].skip++;
    // console.log(`  SKIP [${cat}] ${item.name}`);
  }
}

// Write migration files
const BATCH_SIZE = 500;
const batches = [];
for (let i = 0; i < sqlLines.length; i += BATCH_SIZE) {
  batches.push(sqlLines.slice(i, i + BATCH_SIZE));
}

const startNum = 64;
for (let i = 0; i < batches.length; i++) {
  const migNum = String(startNum + i).padStart(3, '0');
  const header = `-- Migration ${migNum}: Thai names remaining v2 batch ${i + 1}/${batches.length}\n-- Generated: ${new Date().toISOString()}\n\n`;
  writeFileSync(`sql/migrations/${migNum}_thai-names-remaining-v2-${i + 1}.sql`, header + batches[i].join('\n'));
}

console.log(`\nTranslated: ${translated}, Skipped: ${skipped}`);
console.log(`Batches: ${batches.length} files (starting at migration ${startNum})`);
console.log('\nBy category:');
for (const [cat, stats] of Object.entries(catStats).sort((a, b) => b[1].ok - a[1].ok)) {
  const total = stats.ok + stats.skip;
  const pct = total > 0 ? Math.round(stats.ok * 100 / total) : 0;
  console.log(`  ${cat.padEnd(25)} ${String(stats.ok).padStart(4)}/${String(total).padStart(4)} (${pct}%)`);
}
