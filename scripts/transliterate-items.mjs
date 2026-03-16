#!/usr/bin/env node
// Transliterate GE item names from English to Thai phonetic
// Batch process using common GE terminology + phonetic rules

import { readFileSync, writeFileSync } from 'fs';

const items = JSON.parse(readFileSync('data/items.json', 'utf8'));

// ── Common GE word mappings (English → Thai) ──
const WORD_MAP = {
  // Prefixes
  'Elite': 'อีลีท', 'Great': 'เกรท', 'Old': 'โอลด์', 'Ancient': 'แอนเชียนท์',
  'Supreme': 'สุพรีม', 'Unique': 'ยูนิค', 'Rare': 'แรร์', 'Holy': 'โฮลี่',
  'Dark': 'ดาร์ค', 'Black': 'แบล็ค', 'White': 'ไวท์', 'Red': 'เรด',
  'Blue': 'บลู', 'Green': 'กรีน', 'Golden': 'โกลเด้น', 'Gold': 'โกลด์',
  'Silver': 'ซิลเวอร์', 'Crystal': 'คริสตัล', 'Shadow': 'ชาโดว์',
  'Dragon': 'ดราก้อน', 'Phoenix': 'ฟินิกซ์', 'Chaos': 'เคออส',
  'Royal': 'รอยัล', 'Imperial': 'อิมพีเรียล', 'Divine': 'ดิไวน์',
  'Sacred': 'เซเครด', 'Blessed': 'เบลสเซ็ด', 'Cursed': 'เคิร์สเซ็ด',
  'Enchanted': 'เอนแชนเท็ด', 'Magic': 'เมจิค', 'Magical': 'เมจิคัล',
  'Mystic': 'มิสติค', 'Mythic': 'มิธิค',
  'Fire': 'ไฟร์', 'Ice': 'ไอซ์', 'Lightning': 'ไลท์นิ่ง',
  'Thunder': 'ธันเดอร์', 'Wind': 'วินด์', 'Earth': 'เอิร์ธ',
  'Water': 'วอเตอร์', 'Light': 'ไลท์', 'Darkness': 'ดาร์คเนส',
  'Storm': 'สตอร์ม', 'Frost': 'ฟรอสต์', 'Flame': 'เฟลม',
  'Spirit': 'สปิริท', 'Soul': 'โซล', 'Ghost': 'โกสท์',
  'Demon': 'ดีมอน', 'Angel': 'แองเจิ้ล', 'Devil': 'เดวิล',
  'King': 'คิง', 'Queen': 'ควีน', 'Knight': 'ไนท์', 'Lord': 'ลอร์ด',
  'Master': 'มาสเตอร์', 'Grand': 'แกรนด์', 'Noble': 'โนเบิล',
  'Hero': 'ฮีโร่', 'Veteran': 'เวเทอแรน', 'Expert': 'เอ็กซ์เพิร์ท',
  'Battle': 'แบทเทิล', 'War': 'วอร์', 'Warrior': 'วอร์ริเออร์',
  'Guardian': 'การ์เดียน', 'Defender': 'ดีเฟนเดอร์', 'Protector': 'โพรเทคเตอร์',
  'Hunter': 'ฮันเตอร์', 'Slayer': 'สเลเยอร์', 'Destroyer': 'ดีสทรอยเออร์',

  // Weapon types
  'Sword': 'ซอร์ด', 'Dagger': 'แด็กเกอร์', 'Rapier': 'เรเพียร์',
  'Sabre': 'เซเบอร์', 'Blade': 'เบลด', 'Claymore': 'เคลย์มอร์',
  'Katana': 'คาทาน่า', 'Scimitar': 'ซิมิทาร์',
  'Staff': 'สตาฟ', 'Rod': 'ร็อด', 'Wand': 'วานด์',
  'Pistol': 'พิสทอล', 'Rifle': 'ไรเฟิล', 'Cannon': 'แคนนอน',
  'Crossbow': 'ครอสโบว์', 'Shotgun': 'ช็อตกัน', 'Musket': 'มัสเก็ต',
  'Revolver': 'รีวอลเวอร์', 'Handgun': 'แฮนด์กัน',
  'Shield': 'ชิลด์', 'Buckler': 'บัคเลอร์',
  'Knuckle': 'นัคเคิล', 'Gauntlet': 'กันเล็ท', 'Fist': 'ฟิสท์',
  'Spear': 'สเปียร์', 'Lance': 'แลนซ์', 'Halberd': 'ฮาลเบิร์ด',
  'Javelin': 'จาเวลิน', 'Polearm': 'โพลอาร์ม',
  'Hammer': 'แฮมเมอร์', 'Mace': 'เมซ', 'Axe': 'แอ็กซ์',
  'Bow': 'โบว์', 'Arrow': 'แอร์โรว์',
  'Bracelet': 'เบรสเลท', 'Rosario': 'โรซาริโอ',
  'Cube': 'คิวบ์', 'Scroll': 'สกรอล์', 'Lute': 'ลูท',
  'Book': 'บุ๊ค', 'Pendant': 'เพนดันท์', 'Controller': 'คอนโทรลเลอร์',

  // Armor types
  'Coat': 'โค้ท', 'Leather': 'เลเธอร์', 'Metal': 'เมทัล', 'Robe': 'โรบ',
  'Armor': 'อาร์เมอร์', 'Plate': 'เพลท', 'Chainmail': 'เชนเมล',
  'Vest': 'เวสท์', 'Cloak': 'โคลค', 'Cape': 'เคป',

  // Accessories
  'Ring': 'แหวน', 'Necklace': 'สร้อยคอ', 'Earring': 'ต่างหู',
  'Belt': 'เข็มขัด', 'Glove': 'ถุงมือ', 'Shoes': 'รองเท้า',
  'Hat': 'หมวก', 'Medal': 'เหรียญ', 'Badge': 'ตรา',
  'Artifact': 'อาร์ทิแฟค', 'Amulet': 'อมูเล็ท', 'Charm': 'ชาร์ม',
  'Gem': 'เจม', 'Jewel': 'จิวเวล', 'Stone': 'สโตน',
  'Runestone': 'รูนสโตน', 'Spinel': 'สปิเนล',

  // Materials & crafting
  'Cabosse': 'คาบอส', 'Recipe': 'สูตร', 'Powder': 'ผง',
  'Potion': 'ยา', 'Elixir': 'อีลิกเซอร์', 'Essence': 'เอสเซนส์',
  'Chip': 'ชิป', 'Core': 'คอร์', 'Fragment': 'ชิ้นส่วน',
  'Piece': 'ชิ้น', 'Shard': 'เศษ', 'Dust': 'ฝุ่น',
  'Ore': 'แร่', 'Ingot': 'แท่ง', 'Thread': 'ด้าย',
  'Cloth': 'ผ้า', 'Silk': 'ผ้าไหม', 'Cotton': 'ฝ้าย',
  'Wood': 'ไม้', 'Iron': 'เหล็ก', 'Steel': 'เหล็กกล้า',
  'Copper': 'ทองแดง', 'Bronze': 'ทองสัมฤทธิ์',
  'Pearl': 'ไข่มุก', 'Ruby': 'ทับทิม', 'Sapphire': 'ไพลิน',
  'Emerald': 'มรกต', 'Diamond': 'เพชร', 'Amethyst': 'อเมทิสต์',
  'Topaz': 'โทแพซ', 'Garnet': 'โกเมน', 'Opal': 'โอปอล',

  // GE-specific
  'Crescemento': 'เครสเซเมนโต้', 'Constellation': 'คอนสเตลเลชัน',
  'Armonia': 'อาร์โมเนีย', 'Bristia': 'บริสเทีย', 'Castilla': 'คาสทิลล่า',
  'Viron': 'ไวรอน', 'Bahamar': 'บาฮามาร์', 'Montoro': 'มอนโตโร',
  'Torsche': 'ทอร์เช่', 'Vespanola': 'เวสปาโนล่า',
  'Joaquin': 'โจอาควิน', 'Ustiur': 'อัสทิเออร์',
  'Rafflesia': 'ราฟเฟลเซีย', 'Diablo': 'ดิอาโบล',
  'Trump': 'ทรัมป์', 'Card': 'การ์ด',
  'Griffon': 'กริฟฟอน', 'Pegasus': 'เพกาซัส',
  'Uraeus': 'อุเรอุส', 'Chimera': 'ไคเมร่า',
  'Valkyrie': 'วัลคิรี', 'Halidom': 'ฮาลิดอม',

  // Common adjectives
  'Experimental': 'ทดลอง', 'Enhanced': 'เสริม', 'Upgraded': 'อัพเกรด',
  'Improved': 'ปรับปรุง', 'Advanced': 'ขั้นสูง', 'Superior': 'ซูพีเรียร์',
  'Reinforced': 'เสริมเกราะ', 'Hardened': 'แข็ง',
  'Sharp': 'คม', 'Heavy': 'หนัก', 'Swift': 'เร็ว',
  'Strong': 'แข็งแกร่ง', 'Mighty': 'ทรงพลัง',
  'Cunning': 'เฉลียว', 'Agility': 'ว่องไว',
  'Accuracy': 'แม่นยำ', 'Evasion': 'หลบหลีก',
  'Penetration': 'เจาะเกราะ', 'Assault': 'จู่โจม',
  'Protection': 'ป้องกัน', 'Resistance': 'ต้านทาน',

  // Misc words
  'Costume': 'คอสตูม', 'Weapon': 'อาวุธ', 'Back': 'หลัง',
  'Face': 'หน้า', 'Body': 'ตัว', 'Head': 'หัว',
  'Wing': 'ปีก', 'Wings': 'ปีก', 'Tail': 'หาง',
  'Crown': 'มงกุฎ', 'Tiara': 'เทียร่า', 'Helm': 'หมวก',
  'Mask': 'หน้ากาก', 'Glasses': 'แว่นตา', 'Goggles': 'กอกเกิล',

  // Connectors (keep short)
  'of': 'แห่ง', 'the': 'เดอะ', 'and': 'แอนด์',

  // Days
  'Days': 'วัน', 'days': 'วัน', 'Day': 'วัน',

  // Numbers as words
  'One': 'วัน', 'Two': 'ทู', 'Three': 'ทรี',

  // Special items
  'Cook': 'คุ้ก', 'Smith': 'สมิธ', 'Boost': 'บูสท์',
  'Auto': 'ออโต้', 'Manual': 'แมนนวล',
  'Wolf': 'หมาป่า', 'Bear': 'หมี', 'Tiger': 'เสือ',
  'Hawk': 'เหยี่ยว', 'Eagle': 'นกอินทรี', 'Serpent': 'งู',
  'Spider': 'แมงมุม', 'Scorpion': 'แมงป่อง',
  'Beast': 'สัตว์ร้าย', 'Monster': 'มอนสเตอร์',
  'Contract': 'สัญญา', 'Summon': 'ซัมมอน',
  'Lumin': 'ลูมิน', 'Alchemy': 'เล่นแร่แปรธาตุ',
  'Cooking': 'ทำอาหาร', 'Quest': 'เควสท์',
  'Event': 'อีเวนท์', 'Anniversary': 'ครบรอบ',
  'Special': 'พิเศษ', 'Limited': 'จำกัด',
  'Premium': 'พรีเมียม', 'Normal': 'ธรรมดา',
  'No Use': 'ใช้ไม่ได้',
};

// ── Phonetic transliteration for unknown words ──
const PHONETIC = {
  // Consonant clusters
  'sch': 'ช', 'tch': 'ทช', 'th': 'ธ', 'sh': 'ช', 'ch': 'ช',
  'ph': 'ฟ', 'wh': 'ว', 'ck': 'ค', 'qu': 'คว',
  'str': 'สตร', 'spr': 'สปร', 'scr': 'สคร',
  'st': 'สท', 'sp': 'สป', 'sc': 'สค', 'sk': 'สค',
  'sl': 'สล', 'sm': 'สม', 'sn': 'สน', 'sw': 'สว',
  'bl': 'บล', 'br': 'บร', 'cl': 'คล', 'cr': 'คร',
  'dr': 'ดร', 'fl': 'ฟล', 'fr': 'ฟร', 'gl': 'กล', 'gr': 'กร',
  'pl': 'พล', 'pr': 'พร', 'tr': 'ทร', 'tw': 'ทว',
  'wr': 'ร', 'kn': 'น',
  // Vowel patterns
  'tion': 'ชัน', 'sion': 'ชัน', 'ous': 'อัส', 'ious': 'เอียส',
  'ment': 'เมนท์', 'ness': 'เนส', 'less': 'เลส', 'ful': 'ฟูล',
  'ight': 'ไอท์', 'ough': 'อัฟ', 'ight': 'ไอท์',
  'ould': 'อูด', 'tion': 'ชัน',
  'ea': 'เอ', 'ee': 'อี', 'oo': 'อู', 'ou': 'เอา',
  'ai': 'เอ', 'ei': 'เอ', 'ie': 'อี',
  'oa': 'โอ', 'oe': 'โอ',
  // Single consonants
  'b': 'บ', 'c': 'ค', 'd': 'ด', 'f': 'ฟ', 'g': 'ก',
  'h': 'ฮ', 'j': 'จ', 'k': 'ค', 'l': 'ล', 'm': 'ม',
  'n': 'น', 'p': 'พ', 'r': 'ร', 's': 'ส', 't': 'ท',
  'v': 'ว', 'w': 'ว', 'x': 'กซ', 'y': 'ย', 'z': 'ซ',
  // Vowels
  'a': 'า', 'e': 'เ', 'i': 'อิ', 'o': 'โอ', 'u': 'อู',
};

function transliterateWord(word) {
  // Check exact match first
  if (WORD_MAP[word]) return WORD_MAP[word];

  // Check case-insensitive
  const lower = word.toLowerCase();
  for (const [eng, thai] of Object.entries(WORD_MAP)) {
    if (eng.toLowerCase() === lower) return thai;
  }

  // Skip numbers, keep as-is
  if (/^\d+$/.test(word)) return word;

  // Skip very short words
  if (word.length <= 1) return word;

  // Skip parenthetical content markers
  if (word.startsWith('(') || word.endsWith(')')) {
    const inner = word.replace(/[()]/g, '');
    const trans = transliterateWord(inner);
    return word.startsWith('(') ? `(${trans}` : `${trans})`;
  }

  // For unknown words, return original (better than bad transliteration)
  return word;
}

function transliterateName(name) {
  // Handle special patterns
  if (/^<\$>/.test(name)) return null; // Skip placeholder items
  if (/^\[/.test(name)) return null; // Skip bracket items

  // Split into words
  const words = name.split(/\s+/);
  const result = words.map(w => {
    // Handle hyphenated words
    if (w.includes('-') && !WORD_MAP[w]) {
      return w.split('-').map(transliterateWord).join('-');
    }
    // Handle apostrophe (possessive)
    if (w.includes("'")) {
      const parts = w.split("'");
      return parts.map(transliterateWord).join("'");
    }
    return transliterateWord(w);
  });

  // If ALL words are untranslated (same as original), return null
  const translated = result.join(' ');
  if (translated === name) return null;

  return translated;
}

// Process all items
console.log('Processing items...');
const results = [];
let translated = 0;
let skipped = 0;

for (const item of items) {
  const thai = transliterateName(item.name);
  if (thai) {
    results.push({ slug: item.slug, name: item.name, name_th: thai });
    translated++;
  } else {
    skipped++;
  }
}

console.log(`Translated: ${translated}`);
console.log(`Skipped (no translation possible): ${skipped}`);
console.log(`Total: ${items.length}`);

// Save results
writeFileSync('data/item-names-th.json', JSON.stringify(results, null, 2));
console.log('Saved to data/item-names-th.json');

// Show samples per group
const byGroup = {};
for (const item of items) {
  const g = item.group;
  if (!byGroup[g]) byGroup[g] = { total: 0, translated: 0 };
  byGroup[g].total++;
  if (results.find(r => r.slug === item.slug)) byGroup[g].translated++;
}
console.log('\n=== By Group ===');
for (const [g, counts] of Object.entries(byGroup).sort((a, b) => b[1].total - a[1].total)) {
  console.log(`  ${g}: ${counts.translated}/${counts.total} (${Math.round(counts.translated / counts.total * 100)}%)`);
}

// Show 20 random samples
console.log('\n=== Samples ===');
const shuffled = results.sort(() => Math.random() - 0.5).slice(0, 20);
for (const s of shuffled) {
  console.log(`  ${s.name} → ${s.name_th}`);
}
