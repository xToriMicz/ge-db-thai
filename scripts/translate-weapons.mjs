#!/usr/bin/env node
/**
 * Translate weapon names EN→TH using pattern matching
 * Most weapons follow: [Prefix] [WeaponType] pattern
 */
import { execSync } from 'child_process';
import { writeFileSync } from 'fs';

const DB_NAME = 'ge-db-thai';

function d1Query(sql) {
  const escaped = sql.replace(/'/g, "'\\''");
  const cmd = `npx wrangler d1 execute ${DB_NAME} --remote --command '${escaped}' --json 2>/dev/null`;
  try {
    const out = execSync(cmd, { encoding: 'utf8', timeout: 30000 });
    return JSON.parse(out)[0]?.results || [];
  } catch (e) { return []; }
}

// Weapon type translations
const weaponTypes = {
  'Sword': 'ซอร์ด', 'Dagger': 'ดาก้า', 'Rapier': 'เรเปียร์', 'Sabre': 'เซเบอร์',
  'Saber': 'เซเบอร์', 'Shamshir': 'แชมเชียร์',
  'Mace': 'เมซ', 'Axe': 'แอ็กซ์', 'Blunt': 'บลันท์',
  'Slayer': 'สเลเยอร์', 'Polearm': 'โปลอาร์ม',
  'Knuckle': 'นัคเคิล', 'Javelin': 'จาวลิน', 'Tonfa': 'ตันฟา',
  'Crescent': 'เครสเซนต์', 'Main-Gauche': 'เมน-โกช', 'Main-gauche': 'เมน-โกช',
  'Hammer': 'แฮมเมอร์', 'Craft': 'แคร้ฟท์', 'Tool': 'ทูล',
  'Cannon': 'แคนนอน', 'Crossbow': 'โครสโบว์', 'Rifle': 'ไรเฟิล',
  'Pistol': 'ปืนพก', 'Shotgun': 'ช็อตกัน',
  'Rod': 'ไม้เท้า', 'Staff': 'คฑา', 'Lute': 'ลูท',
  'Shield': 'โล่', 'Rosario': 'โรซาริโอ',
  'Fire Bracelet': 'เบรซเล็ตไฟ', 'Ice Bracelet': 'เบรซเล็ตน้ำแข็ง',
  'Lightning Bracelet': 'เบรซเล็ตฟ้าผ่า', 'Special Bracelet': 'เบรซเล็ตพิเศษ',
  'Pendant': 'จี้', 'Cube': 'คิวบ์',
  // Armor types
  'Leather Armor': 'เกราะหนัง', 'Coat': 'โค้ท', 'Robe': 'โรบ', 'Metal Armor': 'เกราะโลหะ',
  'Earring': 'ต่างหู', 'Earrings': 'ต่างหู', 'Necklace': 'สร้อยคอ',
  'Gloves': 'ถุงมือ', 'Glove': 'ถุงมือ', 'Belt': 'เข็มขัด',
  'Shoes': 'รองเท้า', 'Boots': 'รองเท้าบูท',
  'Leg Guard': 'สนับแข้ง', 'Leg Guards': 'สนับแข้ง',
  'Lumin': 'ลูมิน', 'Runestone': 'รูนสโตน',
};

// Prefix translations
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
};

// Special/unique weapon names (not pattern-based)
const specialNames = {
  // Blunt specials
  'Atlas Salvation': 'แอตลาส ซัลเวชั่น',
  'Howling of Callisto': 'เสียงหอนแห่งคาลลิสโต',
  'La Suma Sacherdotisa': 'ลา สุม่า ซาเชอโดติซ่า',
  'Obsidian of Destruction': 'ออบซิเดียนแห่งการทำลายล้าง',
  'Steel Fort': 'ป้อมเหล็ก',
  'The Hammer of Sloth': 'ค้อนแห่งความเกียจคร้าน',
  'Tormento': 'ทอร์เมนโต',
  'Sweet Mace': 'เมซหวาน',
  'Hammer of Judgment': 'ค้อนแห่งการพิพากษา',
  'Battle Mace': 'เมซศึก',
  // Dagger specials
  'Crystalin': 'คริสตาลิน', 'El Colgado': 'เอล คอลกาโด',
  'Stormbringer': 'สตอร์มบริงเกอร์', 'Pandermonia': 'แพนเดอร์โมเนีย',
  'Moonstone of Harmony': 'มูนสโตนแห่งความสามัคคี',
  'Dagger of Higgins': 'ดาก้าแห่งฮิกกินส์', 'Dagger of Lovers': 'ดาก้าแห่งคู่รัก',
  'Black Dagger': 'ดาก้าดำ', 'White Dagger': 'ดาก้าขาว',
  'Assassin Dagger': 'ดาก้านักฆ่า',
  'The Dagger of Greed': 'ดาก้าแห่งความโลภ',
  'Ordens Breath': 'ลมหายใจออร์เดน',
  'Impulse of Algedi': 'แรงกระตุ้นแห่งอัลเกดี',
  // Sword specials
  'Altairs Cunning': 'เล่ห์เหลี่ยมอัลแทร์',
  'Blade of Montgomery': 'ใบมีดมอนต์กอเมอรี่',
  'Stellas Valor': 'ความกล้าหาญสเตลล่า',
  'Sword of Empire': 'ดาบจักรวรรดิ',
  'Sword of the Queen': 'ดาบราชินี',
  'Sword of Exmachina': 'ดาบเอ็กซ์มาชิน่า',
  'La Emperador': 'ลา เอ็มเปราดอร์',
  'Hell Bleed': 'นรกเลือด',
  'Sort of Fool': 'ชะตาคนเขลา',
  'Insincere Blade': 'ใบมีดจอมปลอม',
  'Spirit of Elite Valkyries': 'วิญญาณวัลคีรี่อีลิท',
  'The Grim-wraith': 'กริม-เรธ',
  'Ancient Armonia Sword': 'ดาบอาร์โมเนียโบราณ',
  // Great Sword specials
  'Demon Slayer': 'นักล่าปีศาจ', 'Demon Sword': 'ดาบปีศาจ',
  'Diamond of Perfection': 'เพชรแห่งความสมบูรณ์แบบ',
  'Eye of Veilant': 'ดวงตาเวลแลนท์', 'Fleudelis': 'เฟลอร์ เดอ ลิส',
  'Hacken Spiniel': 'ฮัคเค่น สปินิเอล',
  'Highlander Claymore': 'เคลย์มอร์ไฮแลนเดอร์',
  'Kurenai': 'คุเรไน', 'La Justicia': 'ลา จัสติเซีย',
  'Great Sword of McFaul': 'ดาบใหญ่แม็คฟอล',
  'Sword of Strength': 'ดาบแห่งพลัง', 'Sword of the King': 'ดาบราชา',
  'Soul Zweihander': 'โซลซไวฮันเดอร์',
  'Passion of Regulus': 'ความปรารถนาเรกูลัส',
  'Atlas Weight': 'แอตลาส เวท',
  // Sabre specials
  'Bergelmir': 'แบร์เกลเมียร์', 'Boreas': 'โบเรียส',
  'Golden Damascus': 'ดามัสกัสทอง', 'Masamune': 'มาซามูเนะ',
  'Nightingale': 'ไนติงเกล', 'Vampiric Edge': 'คมดาบแวมไพร์',
  'Charlottes Passion': 'ความปรารถนาชาร์ล็อตต์',
  'El Ermitano': 'เอล เอร์มิตาโน',
  'Will of Acubens': 'เจตจำนงอะคูเบนส์',
  'Sabre of Devil': 'เซเบอร์ปีศาจ', 'Sabre of Trooper': 'เซเบอร์ทหาร',
  'Peridot of Defiant': 'เพอริดอทแห่งการท้าทาย',
  // Rapier specials
  'Fleuret of Shirley': 'ฟลูเรท์แห่งเชอร์ลี่',
  'Glacial Eglanche': 'อีกลังช์น้ำแข็ง',
  'Grim-wight': 'กริม-ไวท์', 'Hell Spit': 'ถุยนรก',
  'Jasper of Aggression': 'แจสเปอร์แห่งความก้าวร้าว',
  'La Torre': 'ลา ทอร์เร',
  'Rapier of Highpriestess': 'เรเปียร์มหาปุโรหิต',
  'Stellas Purity': 'ความบริสุทธิ์สเตลล่า',
  'Sword of Knight': 'ดาบอัศวิน', 'The Wasp': 'ตัวต่อ',
  'The Rapier of Imitator': 'เรเปียร์นักเลียนแบบ',
  'Purity of Aldebaran': 'ความบริสุทธิ์อัลเดบาราน',
  // Crescent specials
  'Noche Triste': 'โนเช่ ทริสเต้',
  'Atlas Dignity': 'แอตลาส ดิกนิตี้',
  'The Crescent of Avenger': 'เครสเซนต์ผู้แก้แค้น',
  'Crescent of Reilly': 'เครสเซนต์แห่งไรลี่',
  'War Crescent': 'เครสเซนต์สงคราม',
  'Hestia': 'เฮสเทีย',
  // Knuckle specials
  'Carbon Knuckle': 'นัคเคิลคาร์บอน',
  'Feast of Emperor': 'งานเลี้ยงจักรพรรดิ',
  'Garnet of Nature': 'การ์เนตแห่งธรรมชาติ',
  'Golden Fist': 'หมัดทอง', 'La Luna': 'ลา ลูน่า',
  'Knuckle of the Yeti': 'นัคเคิลเยติ',
  'Knuckle of Raionu': 'นัคเคิลไรโอนู',
  'Knuckle of Srutoss': 'นัคเคิลสรูทอส',
  'Atlas Ferocity': 'แอตลาส เฟโรซิตี้',
  'Wits of Gemini': 'ปัญญาเจมิไน',
  'The Knuckle of Temptation': 'นัคเคิลแห่งสิ่งล่อลวง',
  'Rays Anchor Knuckle': 'นัคเคิลสมอเรย์',
  // Javelin specials
  'El Juicio': 'เอล ฮุยซิโอ',
  'Charlottes Sharpness': 'ความคมชาร์ล็อตต์',
  'Aclys of Graham': 'อะคลิสแห่งเกรแฮม',
  'Insight of Antares': 'วิจารณญาณอันทาเรส',
  'Jade of Patience': 'หยกแห่งความอดทน',
  'Javelin of Tower': 'จาวลินแห่งหอคอย',
  // Tonfa specials
  'Noche Frigid': 'โนเช่ ฟริจิด',
  'Ordens Oblivion': 'หลงลืมออร์เดน',
  'War Prominence': 'เปลวสงคราม',
  'The Tonfa of Wrath': 'ตันฟาแห่งความพิโรธ',
  'Naiads': 'นาอิแอดส์',
  // Polearm specials
  'Death of Wraith': 'ความตายวิญญาณ',
  'Dullahan Halberd': 'ดัลลาฮัน ฮาลเบิร์ด',
  'Gigantic Poleaxe': 'ขวานด้ามยาวยักษ์',
  'Hell Slayer': 'นักล่านรก',
  'La Muerte': 'ลา มูเอร์เต้',
  'Malachite of Sublimity': 'มาลาไคท์แห่งความสูงส่ง',
  'Leadership of Hamal': 'ภาวะผู้นำฮามาล',
  'Ordens Hatred': 'ความเกลียดชังออร์เดน',
  'The Axe of Lie': 'ขวานแห่งมายา',
  'Marcia Pole Axe': 'ขวานด้ามยาวมาร์เซีย',
  // Main-Gauche specials
  'Charlottes Raid': 'การจู่โจมชาร์ล็อตต์',
  'Dagger Symmetric': 'ดาก้าสมมาตร',
  'Delusion of Karas': 'ภาพลวงแห่งคาราส',
  'La Rueda De La Fortuna': 'ลา รูเอดา เดอ ลา ฟอร์ทูน่า',
  'Main-Gauche of Yeager': 'เมน-โกชเยเกอร์',
  'Sword Breaker': 'ซอร์ดเบรคเกอร์',
  // Hammer specials
  'Craft of Nash': 'แคร้ฟท์แนช',
  'Hammer of Barsene': 'ค้อนบาร์เซ่น',
  'Hammer of Tollero': 'ค้อนทอลเลโร',
  'Heavenly Craft': 'แคร้ฟท์สวรรค์',
  'Ordens Lament': 'ความเศร้าออร์เดน',
  'Woodwork Hammer': 'ค้อนงานไม้',
  'Construction Hammer: Attack': 'ค้อนก่อสร้าง: โจมตี',
  'Construction Hammer: Defense': 'ค้อนก่อสร้าง: ป้องกัน',
  'High Quality Construction Hammer': 'ค้อนก่อสร้างคุณภาพสูง',
  // Rifle specials
  'Dullahan Rifle': 'ไรเฟิลดัลลาฮัน',
  'Heyran Machine Gun': 'ปืนกลเฮย์รัน',
  'Le Soleil': 'เลอ โซเลย',
  'Snipe Bayonet': 'สไนป์เบย์โอเน็ต',
  'The Rifle of Anger': 'ไรเฟิลแห่งความโกรธ',
  // Pistol specials
  'Angel Twin Pistol': 'ปืนพกคู่แองเจิล',
  'Dullahan Pistol': 'ปืนพกดัลลาฮัน',
  'Golden Revolver': 'ปืนลูกโม่ทอง',
  'Jewel of Fortune': 'อัญมณีแห่งโชคลาภ',
  'Jewel of Fortune (Event)': 'อัญมณีแห่งโชคลาภ (อีเวนต์)',
  'Le Etoile': 'เลอ เอตวาล',
  'Ogre Boomstick': 'บูมสติ๊กอ็อกร์',
  'The Pistol of Greed': 'ปืนพกแห่งความโลภ',
  'Twin Revolver': 'ปืนลูกโม่คู่',
  // Shotgun specials
  'Improved Shotgun (7 days)': 'ช็อตกันปรับปรุง (7 วัน)',
  'Koenig Shotgun': 'ช็อตกันโคนิก',
  'Ogre Blaster': 'บลาสเตอร์อ็อกร์',
  'Soul Shotgun': 'ช็อตกันวิญญาณ',
  'The Shotgun of Wrath': 'ช็อตกันแห่งความพิโรธ',
  // Crossbow specials
  'Angel Crossbow': 'โครสโบว์แองเจิล',
  'Highlander Crossbow': 'โครสโบว์ไฮแลนเดอร์',
  'The Crossbow of Hubris': 'โครสโบว์แห่งความหยิ่ง',
  // Cannon specials
  'Angel Cannon': 'แคนนอนแองเจิล',
  'Dullahan Cannon': 'แคนนอนดัลลาฮัน',
  'Einschiever Cannon': 'แคนนอนไอน์ชีเวอร์',
  'Ogre Cannon': 'แคนนอนอ็อกร์',
  'The Cannon of Vice': 'แคนนอนแห่งความชั่วร้าย',
  // Rod specials
  'Angel Rod': 'ไม้เท้าแองเจิล',
  'Aura of Death': 'ออร่าแห่งความตาย',
  'Dullahan Wand': 'ไม้กายสิทธิ์ดัลลาฮัน',
  'Elite Moonstone Rod': 'อีลิทมูนสโตนไม้เท้า',
  'Ogre Rod': 'ไม้เท้าอ็อกร์',
  'Pearl of Brightness': 'ไข่มุกแห่งความสว่าง',
  'Rod of Lenia': 'ไม้เท้าเลเนีย',
  'Starlight Rod': 'ไม้เท้าแสงดาว',
  'The Rod of Jealousy': 'ไม้เท้าแห่งความอิจฉา',
  // Staff specials
  'Angel Staff': 'คฑาแองเจิล',
  'El Sacerdote': 'เอล ซาเซอร์โดเต้',
  'Highlander Staff': 'คฑาไฮแลนเดอร์',
  'Serpent Staff': 'คฑาเซอร์เพนท์',
  'Skull Staff': 'คฑากะโหลก',
  'Soul Staff': 'คฑาวิญญาณ',
  'Staff of Wiseman': 'คฑานักปราชญ์',
  'The Staff of Pride': 'คฑาแห่งความทะนง',
  // Lute specials
  'Angel Lute': 'ลูทแองเจิล',
  'Ballad of Merciless': 'บัลลาดไร้ปรานี',
  'Elgoom Lyre': 'ไลร์เอลกูม',
  'Guitar of Fire': 'กีตาร์แห่งไฟ',
  'Kobolt Lute': 'ลูทโคบอลท์',
  'The Lute of Sloth': 'ลูทแห่งความเกียจคร้าน',
  'Melody of Procyon': 'ทำนองโพรซิออน',
  // Shield specials
  'Angel Shield': 'โล่แองเจิล',
  'Dullahan Shield': 'โล่ดัลลาฮัน',
  'Highlander Shield': 'โล่ไฮแลนเดอร์',
  'Iron Wall': 'กำแพงเหล็ก',
  'Serpent Shield': 'โล่เซอร์เพนท์',
  'Soul Shield': 'โล่วิญญาณ',
  'Werebear Shield': 'โล่แวร์แบร์',
  'The Shield of Gluttony': 'โล่แห่งความตะกละ',
  // Rosario specials
  'Angel Rosario': 'โรซาริโอแองเจิล',
  'Highlander Rosario': 'โรซาริโอไฮแลนเดอร์',
  'Serpent Rosario': 'โรซาริโอเซอร์เพนท์',
  'Soul Rosario': 'โรซาริโอวิญญาณ',
  'The Rosario of Greed': 'โรซาริโอแห่งความโลภ',
  // Bracelet specials
  'Amethyst of Tranquility': 'อเมทิสต์แห่งความสงบ',
  'Topaz of Fury': 'โทแพซแห่งความดุร้าย',
  'Aquamarine of Soul': 'อะความารีนแห่งวิญญาณ',
  'Turquoise of Mind': 'เทอร์ควอยซ์แห่งจิต',
  // Controller specials
  'Angel Puppet': 'หุ่นเชิดแองเจิล',
  'Dullahan Doll': 'ตุ๊กตาดัลลาฮัน',
  'Highlander Puppet': 'หุ่นเชิดไฮแลนเดอร์',
  'Kobolt Puppet': 'หุ่นเชิดโคบอลท์',
  'Thread of Control': 'สายใยควบคุม',
};

// Get all weapons without Thai names
const categories = ['leather','coat','robe','metal','earring','necklace','glove','belt','shoes','leg_guards','magic_scroll','runestone','lumin'];
const allItems = d1Query(`SELECT name, slug, category FROM items WHERE name_th IS NULL AND category IN (${categories.map(c=>`'${c}'`).join(',')}) ORDER BY category, name`);
console.log(`Total melee weapons to translate: ${allItems.length}`);

const sqlLines = ['-- Migration 051: Thai names for melee weapons', `-- Generated: ${new Date().toISOString()}`, ''];
let translated = 0, skipped = 0;

for (const item of allItems) {
  let name = item.name;
  let thaiName = null;

  // Strip (Event), (7 Days) suffixes for matching, add back later
  let suffix = '';
  const eventMatch = name.match(/\s*\(Event\)\s*$/);
  const daysMatch = name.match(/\s*\((\d+)\s*[Dd]ays?\)\s*$/);
  const contractMatch = name.match(/^(.+) of Contract \(7 Days\)$/);
  const eventPrefix = name.match(/^\[Event\]\s+(.+)$/);
  const improvedMatch = name.match(/^Improved (.+) \((\d+) days?\)$/);

  if (eventMatch) { suffix = ' (อีเวนต์)'; name = name.replace(eventMatch[0], ''); }
  else if (daysMatch) { suffix = ` (${daysMatch[1]} วัน)`; name = name.replace(daysMatch[0], ''); }

  // Check special names first
  if (specialNames[name]) {
    thaiName = specialNames[name] + suffix;
  }
  // Contract weapons
  else if (contractMatch) {
    const wType = contractMatch[1];
    const thType = weaponTypes[wType];
    if (thType) thaiName = `${thType}สัญญา (7 วัน)`;
  }
  // [Event] prefix
  else if (eventPrefix) {
    const inner = eventPrefix[1];
    if (specialNames[inner]) thaiName = `[อีเวนต์] ${specialNames[inner]}`;
    else {
      // Try pattern match on inner
      for (const [pre, thPre] of Object.entries(prefixes)) {
        for (const [wt, thWt] of Object.entries(weaponTypes)) {
          if (inner === `${pre} ${wt}`) {
            thaiName = `[อีเวนต์] ${thPre} ${thWt}`;
            break;
          }
        }
        if (thaiName) break;
      }
    }
  }
  // Improved weapons
  else if (improvedMatch) {
    thaiName = null; // skip for now
  }
  else {
    // Try prefix + weapon type pattern
    for (const [pre, thPre] of Object.entries(prefixes).sort((a,b) => b[0].length - a[0].length)) {
      if (name.startsWith(pre + ' ')) {
        const rest = name.substring(pre.length + 1);
        const thRest = weaponTypes[rest];
        if (thRest) {
          thaiName = `${thPre} ${thRest}${suffix}`;
        }
        break;
      }
    }
    // Try Elite + special weapon
    if (!thaiName && name.startsWith('Elite ')) {
      const inner = name.substring(6);
      if (specialNames[inner]) thaiName = `อีลิท ${specialNames[inner]}${suffix}`;
      // Try Elite + prefix pattern
      if (!thaiName) {
        for (const [wt, thWt] of Object.entries(weaponTypes)) {
          if (inner.endsWith(' ' + wt)) {
            const pre = inner.substring(0, inner.length - wt.length - 1);
            thaiName = `อีลิท ${pre} ${thWt}${suffix}`;
            break;
          }
        }
      }
    }
    // Try Incomplete + special
    if (!thaiName && name.startsWith('Incomplete ')) {
      const inner = name.substring(11);
      if (specialNames[inner]) thaiName = `${specialNames[inner]}ไม่สมบูรณ์${suffix}`;
    }
    // Direct special name
    if (!thaiName && specialNames[name]) {
      thaiName = specialNames[name] + suffix;
    }
    // Add suffix if not yet added
    if (thaiName && suffix && !thaiName.endsWith(suffix)) {
      thaiName += suffix;
    }
  }

  if (thaiName) {
    const th = thaiName.replace(/'/g, "''");
    const slug = item.slug.replace(/'/g, "''");
    sqlLines.push(`UPDATE items SET name_th = '${th}' WHERE slug = '${slug}' AND name_th IS NULL;`);
    translated++;
  } else {
    skipped++;
    sqlLines.push(`-- SKIP: ${item.name} | ${item.category} (${item.slug})`);
  }
}

const sql = sqlLines.join('\n');
writeFileSync('sql/migrations/053_thai-names-armor-acc.sql', sql);
console.log(`Translated: ${translated}, Skipped: ${skipped}`);
console.log('Saved to sql/migrations/051_thai-names-melee-weapons.sql');
