#!/usr/bin/env node
/**
 * Translate ALL remaining items to Thai
 * Strategy: Pattern-based for systematic names, AI knowledge for unique names
 */
import { execSync } from 'child_process';
import { writeFileSync } from 'fs';

const DB_NAME = 'ge-db-thai';

function d1Query(sql) {
  const escaped = sql.replace(/'/g, "'\\''");
  const cmd = `npx wrangler d1 execute ${DB_NAME} --remote --command '${escaped}' --json 2>/dev/null`;
  try {
    return JSON.parse(execSync(cmd, { encoding: 'utf8', timeout: 60000, maxBuffer: 50 * 1024 * 1024 }))[0]?.results || [];
  } catch (e) { console.error('D1 query error:', e.message?.slice(0, 200)); return []; }
}

// Common suffix translations
function translateSuffix(name) {
  let suffix = '';
  let clean = name;

  // Handle multiple suffix patterns
  const patterns = [
    [/\s*\(Event\)\s*$/, ' (อีเวนต์)'],
    [/\s*\((\d+)\s*[Dd]ays?\)\s*$/, (m) => ` (${m[1]} วัน)`],
    [/\s*\((\d+)\s*[Dd]ay\)\s*$/, (m) => ` (${m[1]} วัน)`],
    [/\s*\(Illusion\)\s*$/, ' (ภาพลวง)'],
    [/\s*\(30 days\)\s*$/, ' (30 วัน)'],
    [/\s*\(7 days\)\s*$/, ' (7 วัน)'],
    [/\s*\(1 day\)\s*$/, ' (1 วัน)'],
  ];

  for (const [pat, rep] of patterns) {
    const m = clean.match(pat);
    if (m) {
      suffix = typeof rep === 'function' ? rep(m) : rep;
      clean = clean.replace(pat, '');
      break;
    }
  }

  // Handle [Event] prefix
  let prefix = '';
  const evtPre = clean.match(/^\[Event\]\s+/i);
  if (evtPre) {
    prefix = '[อีเวนต์] ';
    clean = clean.replace(evtPre[0], '');
  }
  const dreamPre = clean.match(/^\[Dreaming\]\s+/);
  if (dreamPre) {
    prefix = '[ความฝัน] ';
    clean = clean.replace(dreamPre[0], '');
  }
  const tierI = clean.match(/^\[Tier I\]\s+/);
  if (tierI) {
    prefix = '[เทียร์ I] ';
    clean = clean.replace(tierI[0], '');
  }
  const tierII = clean.match(/^\[Tier II\]\s+/);
  if (tierII) {
    prefix = '[เทียร์ II] ';
    clean = clean.replace(tierII[0], '');
  }

  return { clean, prefix, suffix };
}

// ===== RING TRANSLATION =====
// Skill names that have Thai translations
const ringTranslations = {
  'Acceleration': 'เร่งความเร็ว', 'Accuracy Shot': 'ยิงแม่น',
  'Additional Magic': 'เวทเพิ่มเติม', 'Additional Training': 'ฝึกฝนเพิ่มเติม',
  'Absolute Zero': 'ศูนย์สัมบูรณ์', 'Alter Ego': 'อัลเตอร์ อีโก้',
};

function translateRing(name) {
  const { clean, prefix, suffix } = translateSuffix(name);

  // "[X] Ring" pattern
  const ringMatch = clean.match(/^(.+?)\s+Ring$/);
  if (ringMatch) {
    const skillName = ringMatch[1];
    // Check if we have a specific translation
    const thSkill = ringTranslations[skillName];
    if (thSkill) return `${prefix}แหวน${thSkill}${suffix}`;
    // Otherwise keep skill name + แหวน
    return `${prefix}แหวน${skillName}${suffix}`;
  }
  return null;
}

// ===== COSTUME TRANSLATION =====
function translateCostume(name, category) {
  const { clean, prefix, suffix } = translateSuffix(name);

  const typeWord = category === 'weapon_costume' ? 'สกินอาวุธ' : 'ชุด';

  // "[X] Costume" pattern
  const costumeMatch = clean.match(/^(.+?)\s+Costume$/);
  if (costumeMatch) {
    return `${prefix}${typeWord}${costumeMatch[1]}${suffix}`;
  }

  // Weapon costume patterns: "[X] Skin", "[X] Weapon Skin"
  const skinMatch = clean.match(/^(.+?)\s+(?:Weapon\s+)?Skin$/);
  if (skinMatch) {
    return `${prefix}สกินอาวุธ${skinMatch[1]}${suffix}`;
  }

  return null;
}

// ===== ARTIFACT TRANSLATION =====
const artifactWords = {
  'Ring': 'แหวน', 'Necklace': 'สร้อยคอ', 'Earring': 'ต่างหู', 'Earrings': 'ต่างหู',
  'Locket': 'จี้', 'Brooch': 'เข็มกลัด', 'Cape': 'ผ้าคลุม', 'Cloak': 'เสื้อคลุม',
  'Shield': 'โล่', 'Amulet': 'เครื่องราง', 'Cross': 'ไม้กางเขน',
  'Eye': 'ตา', 'Eagle Eye': 'ตาอินทรี', 'Piercing': 'เจาะ',
  'Talisman': 'ยันต์', 'Mask': 'หน้ากาก', 'Crown': 'มงกุฎ',
  'Diary': 'สมุดบันทึก', 'Map': 'แผนที่', 'Crystal Ball': 'ลูกแก้ว',
  'Bandage': 'ผ้าพันแผล', 'Ribbon': 'ริบบิ้น',
  'Belt': 'เข็มขัด', 'Gloves': 'ถุงมือ', 'Boots': 'รองเท้าบูท',
};

const artifactSpecials = {
  'Black Rose': 'กุหลาบดำ', 'Bloody Rose': 'กุหลาบเลือด',
  'Body Oil': 'น้ำมันทาตัว', 'Baby Cap': 'หมวกเด็ก',
  'Blindford': 'ผ้าปิดตา', 'Celestial Map': 'แผนที่ดวงดาว',
  'Cooking Equipment': 'อุปกรณ์ทำอาหาร', 'Colorful Necktie': 'เนคไทหลากสี',
  'Candy Shell': 'เปลือกลูกอม', 'Castle Roll Book': 'สมุดม้วนปราสาท',
  'Custodia': 'คัสโทเดีย', 'Dimension Stone': 'หินมิติ',
  'Dio Elpides': 'ดิโอ เอลปิเดส', 'Dom Perignon': 'ดอม เปริญง',
  'Dragon Coalescence': 'การรวมตัวมังกร',
  'Chocolate of Reminiscence': 'ช็อกโกแลตแห่งความทรงจำ',
  'Body of Wiseman': 'ร่างนักปราชญ์',
  'Alchemists Bottle': 'ขวดนักเล่นแร่แปรธาตุ',
  'Alchemists Pliers': 'คีมนักเล่นแร่แปรธาตุ',
  'Amulet of Prince': 'เครื่องรางเจ้าชาย',
  'Agility of Griffon': 'ความคล่องแคล่วกริฟฟอน',
  'A Hat with Unknown Power': 'หมวกพลังลึกลับ',
  'Archbishops Ring': 'แหวนอาร์คบิชอป',
  'Armonia Halidom': 'วัตถุศักดิ์สิทธิ์อาร์โมเนีย',
  'Armonias Will': 'เจตจำนงอาร์โมเนีย',
  'Assault of Uraeus': 'การโจมตีอุเรอุส',
  'Auto Barons Shield': 'โล่ออโต้ บารอน',
  'Auxiliary Hammer for Repairing': 'ค้อนซ่อมเสริม',
  'Bearskin Protector': 'เกราะหนังหมี',
  'Bolt of Repairman': 'สลักช่างซ่อม',
  'Brisingamen': 'บริซิงกาเม็น',
  'Butterfly Brooch': 'เข็มกลัดผีเสื้อ',
  'Chain of Vindictive Spirit': 'โซ่วิญญาณพยาบาท',
  'Chipped Medal': 'เหรียญบิ่น',
  'Cold Auracite': 'ออราไซต์เย็น',
  'Contract with Gehenna': 'สัญญากับเกเฮนน่า',
  'Creature Talisman': 'ยันต์สัตว์ประหลาด',
  'Dagger of the Killer': 'กริชนักฆ่า',
  'Demon Talisman': 'ยันต์ปีศาจ',
  'Barrels Keg': 'ถังเบียร์',
  'Brandines Letter': 'จดหมายแบรนดีน',
  'Bristias Decision': 'การตัดสินใจบริสเทีย',
  'Broken Hanbok Norigae': 'โนริแกฮันบกแตก',
  'Brooch of Darkness': 'เข็มกลัดแห่งความมืด',
  'Brutality of Vergo the Cursed': 'ความโหดร้ายเวอร์โก ผู้ถูกสาป',
  'Cape of the Family': 'ผ้าคลุมครอบครัว',
  'Crest of Vernier': 'ตราเวอร์เนียร์',
  'Crude Ordens Arrogance': 'ความเย่อหยิ่งออร์เดนดิบ',
  'Crude Ordens Fury': 'ความดุร้ายออร์เดนดิบ',
  'Crude Ordens Greed': 'ความโลภออร์เดนดิบ',
  'Crude Ordens Jealousy': 'ความอิจฉาออร์เดนดิบ',
  'Crude Ordens Sloth': 'ความเกียจคร้านออร์เดนดิบ',
  'Crystal Ball of Dazzlement': 'ลูกแก้วแห่งความตระการตา',
  'Dancers Mask': 'หน้ากากนักเต้น',
  'Diary of Idge': 'บันทึกอิดจ์',
  'Diary of Lorenzo': 'บันทึกลอเรนโซ',
  'Do-rag of the Dead': 'ผ้าโพกหัวคนตาย',
  '2015 King anniversary': 'ครบรอบราชา 2015',
};

function translateArtifact(name) {
  const { clean, prefix, suffix } = translateSuffix(name);

  // Check specials first
  if (artifactSpecials[clean]) return `${prefix}${artifactSpecials[clean]}${suffix}`;

  // Pattern: "[Name]'s [Type]"
  // Pattern: "[Adj] [Type]" where Type is a known artifact type
  // Pattern: "[X] of [Y]"

  // For artifacts with known type words at the end
  for (const [en, th] of Object.entries(artifactWords)) {
    if (clean.endsWith(` ${en}`)) {
      const namepart = clean.substring(0, clean.length - en.length - 1);
      return `${prefix}${th}${namepart}${suffix}`;
    }
  }

  // "Arcard [type]" pattern
  if (clean.startsWith('Arcard ')) {
    const rest = clean.substring(7);
    const thRest = artifactWords[rest] || rest;
    return `${prefix}อาร์การ์ด ${thRest}${suffix}`;
  }

  // "Black [X] [Type]" pattern
  if (clean.startsWith('Black ')) {
    const rest = clean.substring(6);
    for (const [en, th] of Object.entries(artifactWords)) {
      if (rest.endsWith(` ${en}`)) {
        const mid = rest.substring(0, rest.length - en.length - 1);
        return `${prefix}${th}${mid}ดำ${suffix}`;
      }
    }
  }

  // "Blood [X] [Type]"
  if (clean.startsWith('Blood ')) {
    const rest = clean.substring(6);
    for (const [en, th] of Object.entries(artifactWords)) {
      if (rest.endsWith(` ${en}`)) {
        const mid = rest.substring(0, rest.length - en.length - 1);
        return `${prefix}${th}${mid}เลือด${suffix}`;
      }
    }
  }

  // "Bloody [X]"
  if (clean.startsWith('Bloody ')) {
    const rest = clean.substring(7);
    if (artifactWords[rest]) return `${prefix}${artifactWords[rest]}เลือด${suffix}`;
  }

  return null;
}

// ===== HAT/BACK/FACE/MEDAL TRANSLATION =====
const categoryNames = {
  'hat': 'หมวก', 'back': 'หลัง', 'face': 'หน้า',
  'medal': 'เหรียญ', 'summon': 'ซัมมอน', 'pet_spirit': 'สปิริทสัตว์เลี้ยง',
};

function translateCosmetic(name, category) {
  const { clean, prefix, suffix } = translateSuffix(name);

  // Hat patterns
  if (category === 'hat') {
    const hatMatch = clean.match(/^(.+?)\s+Hat$/);
    if (hatMatch) return `${prefix}หมวก${hatMatch[1]}${suffix}`;
    const helmMatch = clean.match(/^(.+?)\s+Helm(?:et)?$/);
    if (helmMatch) return `${prefix}หมวก${helmMatch[1]}${suffix}`;
    const crownMatch = clean.match(/^(.+?)\s+Crown$/);
    if (crownMatch) return `${prefix}มงกุฎ${crownMatch[1]}${suffix}`;
    const headMatch = clean.match(/^(.+?)\s+Headband$/);
    if (headMatch) return `${prefix}ผ้าคาดผม${headMatch[1]}${suffix}`;
    const wigMatch = clean.match(/^(.+?)\s+Wig$/);
    if (wigMatch) return `${prefix}วิก${wigMatch[1]}${suffix}`;
    const hairMatch = clean.match(/^(.+?)\s+Hair$/);
    if (hairMatch) return `${prefix}ผม${hairMatch[1]}${suffix}`;
    const capMatch = clean.match(/^(.+?)\s+Cap$/);
    if (capMatch) return `${prefix}หมวกแก๊ป${capMatch[1]}${suffix}`;
    const hoodMatch = clean.match(/^(.+?)\s+Hood$/);
    if (hoodMatch) return `${prefix}ฮูด${hoodMatch[1]}${suffix}`;
    const maskMatch = clean.match(/^(.+?)\s+Mask$/);
    if (maskMatch) return `${prefix}หน้ากาก${maskMatch[1]}${suffix}`;
    const tiaraMatch = clean.match(/^(.+?)\s+Tiara$/);
    if (tiaraMatch) return `${prefix}มงกุฎเล็ก${tiaraMatch[1]}${suffix}`;
    const ribbonMatch = clean.match(/^(.+?)\s+Ribbon$/);
    if (ribbonMatch) return `${prefix}ริบบิ้น${ribbonMatch[1]}${suffix}`;
    const earMatch = clean.match(/^(.+?)\s+Ear(?:s)?$/);
    if (earMatch) return `${prefix}หู${earMatch[1]}${suffix}`;
    const hornMatch = clean.match(/^(.+?)\s+Horn(?:s)?$/);
    if (hornMatch) return `${prefix}เขา${hornMatch[1]}${suffix}`;
    const haloMatch = clean.match(/^(.+?)\s+Halo$/);
    if (haloMatch) return `${prefix}รัศมี${haloMatch[1]}${suffix}`;
  }

  // Back patterns (wings, capes)
  if (category === 'back') {
    const wingMatch = clean.match(/^(.+?)\s+Wing(?:s)?$/);
    if (wingMatch) return `${prefix}ปีก${wingMatch[1]}${suffix}`;
    const capeMatch = clean.match(/^(.+?)\s+Cape$/);
    if (capeMatch) return `${prefix}ผ้าคลุม${capeMatch[1]}${suffix}`;
    const cloakMatch = clean.match(/^(.+?)\s+Cloak$/);
    if (cloakMatch) return `${prefix}เสื้อคลุม${cloakMatch[1]}${suffix}`;
    const backpackMatch = clean.match(/^(.+?)\s+Backpack$/);
    if (backpackMatch) return `${prefix}กระเป๋าเป้${backpackMatch[1]}${suffix}`;
    const bagMatch = clean.match(/^(.+?)\s+Bag$/);
    if (bagMatch) return `${prefix}กระเป๋า${bagMatch[1]}${suffix}`;
    const mantle = clean.match(/^(.+?)\s+Mantle$/);
    if (mantle) return `${prefix}เสื้อคลุม${mantle[1]}${suffix}`;
  }

  // Face patterns
  if (category === 'face') {
    const glassMatch = clean.match(/^(.+?)\s+(?:Glasses|Sunglasses)$/);
    if (glassMatch) return `${prefix}แว่นตา${glassMatch[1]}${suffix}`;
    const eyeMatch = clean.match(/^(.+?)\s+Eye(?:patch)?$/);
    if (eyeMatch) return `${prefix}ผ้าปิดตา${eyeMatch[1]}${suffix}`;
    const maskMatch = clean.match(/^(.+?)\s+Mask$/);
    if (maskMatch) return `${prefix}หน้ากาก${maskMatch[1]}${suffix}`;
    const monocle = clean.match(/^(.+?)\s+Monocle$/);
    if (monocle) return `${prefix}แว่นตาเดียว${monocle[1]}${suffix}`;
  }

  // Medal patterns
  if (category === 'medal') {
    const medalMatch = clean.match(/^(.+?)\s+Medal$/);
    if (medalMatch) return `${prefix}เหรียญ${medalMatch[1]}${suffix}`;
    const badgeMatch = clean.match(/^(.+?)\s+Badge$/);
    if (badgeMatch) return `${prefix}ตรา${badgeMatch[1]}${suffix}`;
    const emblemMatch = clean.match(/^(.+?)\s+Emblem$/);
    if (emblemMatch) return `${prefix}สัญลักษณ์${emblemMatch[1]}${suffix}`;
    const insigniaMatch = clean.match(/^(.+?)\s+Insignia$/);
    if (insigniaMatch) return `${prefix}เครื่องหมาย${insigniaMatch[1]}${suffix}`;
    const markMatch = clean.match(/^(.+?)\s+Mark$/);
    if (markMatch) return `${prefix}ตรา${markMatch[1]}${suffix}`;
  }

  return null;
}

// ===== MAIN =====
const allItems = d1Query("SELECT name, slug, category FROM items WHERE name_th IS NULL ORDER BY category, name");
console.log(`Total items to translate: ${allItems.length}`);

const sqlLines = ['-- Migration 054+: Thai names for ALL remaining items', `-- Generated: ${new Date().toISOString()}`, ''];
let translated = 0, skipped = 0;
const catStats = {};

for (const item of allItems) {
  let thaiName = null;
  const cat = item.category;

  if (!catStats[cat]) catStats[cat] = { ok: 0, skip: 0 };

  // Route to appropriate translator
  if (['skill_ring', 'upgraded_ring', 'veteran_ring', 'stat_ring'].includes(cat)) {
    thaiName = translateRing(item.name);
  } else if (['body_costume', 'weapon_costume'].includes(cat)) {
    thaiName = translateCostume(item.name, cat);
  } else if (cat === 'artifact') {
    thaiName = translateArtifact(item.name);
  } else if (['hat', 'back', 'face', 'medal'].includes(cat)) {
    thaiName = translateCosmetic(item.name, cat);
  } else if (['summon', 'pet_spirit'].includes(cat)) {
    // Summon/pet: keep name, add category prefix
    const { clean, prefix, suffix } = translateSuffix(item.name);
    if (cat === 'summon') {
      const summonMatch = clean.match(/^(.+?)(?:\s+Summoning)?$/);
      if (summonMatch) thaiName = `${prefix}ซัมมอน${summonMatch[1]}${suffix}`;
    } else {
      thaiName = `${prefix}${clean}${suffix}`;
    }
  } else if (cat === 'arm_shield') {
    const { clean, prefix, suffix } = translateSuffix(item.name);
    const match = clean.match(/^(.+?)\s+(?:Arm\s*[Ss]hield|Armshield)$/);
    if (match) thaiName = `${prefix}อาร์มชิลด์${match[1]}${suffix}`;
  } else if (cat === 'magic_scroll') {
    const { clean, prefix, suffix } = translateSuffix(item.name);
    thaiName = `${prefix}ม้วนเวท${clean.replace(/\s*Magic Scroll$/, '')}${suffix}`;
  } else if (cat === 'runestone') {
    const { clean, prefix, suffix } = translateSuffix(item.name);
    const match = clean.match(/^(.+?)\s+Runestone$/);
    if (match) thaiName = `${prefix}รูนสโตน${match[1]}${suffix}`;
  } else if (cat === 'lumin') {
    const { clean, prefix, suffix } = translateSuffix(item.name);
    const match = clean.match(/^(.+?)\s+Lumin$/);
    if (match) thaiName = `${prefix}ลูมิน${match[1]}${suffix}`;
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
  }
}

// Split into multiple migration files (D1 has command size limits)
const updates = sqlLines.filter(l => l.startsWith('UPDATE'));
const BATCH_SIZE = 500;
const batches = [];
for (let i = 0; i < updates.length; i += BATCH_SIZE) {
  batches.push(updates.slice(i, i + BATCH_SIZE));
}

for (let i = 0; i < batches.length; i++) {
  const migNum = 54 + i;
  const header = `-- Migration 0${migNum}: Thai names batch ${i + 1}/${batches.length}\n-- Generated: ${new Date().toISOString()}\n\n`;
  writeFileSync(`sql/migrations/0${migNum}_thai-names-remaining-${i + 1}.sql`, header + batches[i].join('\n'));
}

console.log(`\nTranslated: ${translated}, Skipped: ${skipped}`);
console.log(`Batches: ${batches.length} files`);
console.log('\nBy category:');
for (const [cat, stats] of Object.entries(catStats).sort((a, b) => b[1].ok - a[1].ok)) {
  const total = stats.ok + stats.skip;
  const pct = Math.round(stats.ok * 100 / total);
  console.log(`  ${cat.padEnd(20)} ${stats.ok}/${total} (${pct}%)`);
}
