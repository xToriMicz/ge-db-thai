-- Migration: Thai names from ge.exe.in.th (quests, guides, patch notes)
-- Generated: 2026-03-16T02:49:09.655Z

-- Items: 53 matches
UPDATE items SET name_th = 'ตัวทำละลาย' WHERE slug = 'solvent' AND name_th IS NULL;
UPDATE items SET name_th = 'เมก้าทัลท์' WHERE slug = 'mega-talt' AND name_th IS NULL;
UPDATE items SET name_th = 'เมก้าควอสท์' WHERE slug = 'mega-quartz' AND name_th IS NULL;
UPDATE items SET name_th = 'ทองแท่ง' WHERE slug = 'pure-gold-bar' AND name_th IS NULL;
UPDATE items SET name_th = 'โรโดไลท์' WHERE slug = 'rhodolite-crystal' AND name_th IS NULL;
UPDATE items SET name_th = 'ชิ้นส่วนโรโดไลท์' WHERE slug = 'rhodolite-fragment' AND name_th IS NULL;
UPDATE items SET name_th = 'ไชนี่ คริสตัล' WHERE slug = 'shiny-crystal' AND name_th IS NULL;
UPDATE items SET name_th = 'มูน สโตน' WHERE slug = 'moon-stone' AND name_th IS NULL;
-- SKIP: แร่อาร์โมเนียม → red-armonium-ore (generic "Armonium Ore" vs "Red Armonium Ore")
UPDATE items SET name_th = 'เนื้อหมาป่า' WHERE slug = 'wolf-meat' AND name_th IS NULL;
UPDATE items SET name_th = 'กะหล่ำ' WHERE slug = 'cabbage' AND name_th IS NULL;
UPDATE items SET name_th = 'หินเวทมนตร์' WHERE slug = 'black-magic-stone' AND name_th IS NULL;
UPDATE items SET name_th = 'เคลียร์ รัม' WHERE slug = 'clear-rum' AND name_th IS NULL;
-- SKIP: ดอกกุหลาบ → black-rose (generic "rose" vs specific "Black Rose")
UPDATE items SET name_th = 'เศษชิ้นส่วนโอไทต์' WHERE slug = 'otite-fragment' AND name_th IS NULL;
UPDATE items SET name_th = 'เศษชิ้นส่วนคอราซอน' WHERE slug = 'corazon-fragment' AND name_th IS NULL;
UPDATE items SET name_th = 'เอลิเมนเทียม' WHERE slug = 'elementium' AND name_th IS NULL;
UPDATE items SET name_th = 'เมก้าไอโอเนียม' WHERE slug = 'mega-ionium' AND name_th IS NULL;
UPDATE items SET name_th = 'น้ำมนต์ศักดิ์สิทธิ์' WHERE slug = 'holy-water-crystal' AND name_th IS NULL;
UPDATE items SET name_th = 'หอกแห่งออร์เดน' WHERE slug = 'spear-of-orden' AND name_th IS NULL;
UPDATE items SET name_th = 'วาร์ปสครอล' WHERE slug = 'warp-scroll' AND name_th IS NULL;
UPDATE items SET name_th = 'โรส วิง' WHERE slug = 'rose-wing' AND name_th IS NULL;
UPDATE items SET name_th = 'อิโรลิน่าแฮท' WHERE slug = 'irolina-hat' AND name_th IS NULL;
-- SKIP: เทมเพสท์ → tempest-robe (generic "Tempest" vs specific "Tempest Robe")
-- SKIP: ครอสโบว์ → elite-crossbow (generic "crossbow" vs specific "Elite Crossbow")
UPDATE items SET name_th = 'ปีกปีศาจ' WHERE slug = 'devil-wings' AND name_th IS NULL;
UPDATE items SET name_th = 'ไม้กวาด' WHERE slug = 'broom-of-maid' AND name_th IS NULL;
-- SKIP: ฟินิกส์ วิง → golden-phoenix-wings (Phoenix Wing vs Golden Phoenix Wings)
UPDATE items SET name_th = 'อาร์โมเนีย แคนนอน' WHERE slug = 'armonia-cannon' AND name_th IS NULL;
UPDATE items SET name_th = 'อาร์โมเนีย โครสโบว์' WHERE slug = 'armonia-crossbow' AND name_th IS NULL;
UPDATE items SET name_th = 'อาร์โมเนีย เครสเซนต์' WHERE slug = 'armonia-crescent' AND name_th IS NULL;
UPDATE items SET name_th = 'อาร์โมเนีย ดาก้า' WHERE slug = 'armonia-dagger' AND name_th IS NULL;
UPDATE items SET name_th = 'อาร์โมเนีย ไฟ เบรซเล็ต' WHERE slug = 'armonia-fire-bracelet' AND name_th IS NULL;
UPDATE items SET name_th = 'อาร์โมเนีย น้ำแข็ง เบรซเล็ต' WHERE slug = 'armonia-ice-bracelet' AND name_th IS NULL;
UPDATE items SET name_th = 'อาร์โมเนีย จาวลิน' WHERE slug = 'armonia-javelin' AND name_th IS NULL;
UPDATE items SET name_th = 'อาร์โมเนีย นัคเคิล' WHERE slug = 'armonia-knuckle' AND name_th IS NULL;
UPDATE items SET name_th = 'อาร์โมเนีย ฟ้าผ่า เบรซเล็ต' WHERE slug = 'armonia-lightning-bracelet' AND name_th IS NULL;
UPDATE items SET name_th = 'อาร์โมเนีย ลูท' WHERE slug = 'armonia-lute' AND name_th IS NULL;
UPDATE items SET name_th = 'อาร์โมเนีย เมซ' WHERE slug = 'armonia-mace' AND name_th IS NULL;
UPDATE items SET name_th = 'อาร์โมเนีย เมน-โกช' WHERE slug = 'armonia-main-gauche' AND name_th IS NULL;
UPDATE items SET name_th = 'อาร์โมเนีย ปืนพก' WHERE slug = 'armonia-pistol' AND name_th IS NULL;
UPDATE items SET name_th = 'อาร์โมเนีย โปลอาร์ม' WHERE slug = 'armonia-polearm' AND name_th IS NULL;
UPDATE items SET name_th = 'อาร์โมเนีย เร เปียร์' WHERE slug = 'armonia-rapier' AND name_th IS NULL;
UPDATE items SET name_th = 'อาร์โมเนีย ไรเฟิล' WHERE slug = 'armonia-rifle' AND name_th IS NULL;
UPDATE items SET name_th = 'อาร์โมเนีย ไม้' WHERE slug = 'armonia-rod' AND name_th IS NULL;
UPDATE items SET name_th = 'อาร์โมเนีย เซเบอร์' WHERE slug = 'armonia-sabre' AND name_th IS NULL;
UPDATE items SET name_th = 'อาร์โมเนีย โล่' WHERE slug = 'armonia-shield' AND name_th IS NULL;
UPDATE items SET name_th = 'อาร์โมเนีย ช็อตกัน' WHERE slug = 'armonia-shotgun' AND name_th IS NULL;
UPDATE items SET name_th = 'อาร์โมเนีย สเลเยอร์' WHERE slug = 'armonia-slayer' AND name_th IS NULL;
UPDATE items SET name_th = 'อาร์โมเนีย สเปเชียล เบรซเล็ต' WHERE slug = 'armonia-special-bracelet' AND name_th IS NULL;
UPDATE items SET name_th = 'อาร์โมเนีย คฑา' WHERE slug = 'armonia-staff' AND name_th IS NULL;
UPDATE items SET name_th = 'อาร์โมเนีย ซอร์ด' WHERE slug = 'armonia-sword' AND name_th IS NULL;
UPDATE items SET name_th = 'อาร์โมเนีย ตันฟา' WHERE slug = 'armonia-tonfa' AND name_th IS NULL;
