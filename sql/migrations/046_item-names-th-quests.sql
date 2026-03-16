-- Migration: Thai item names from ge.exe.in.th quest pages
-- Source: 56 quest/guide pages scraped 2026-03-16
-- Total: 18 items

UPDATE items SET name_th = 'ตัวทำละลาย' WHERE slug = 'solvent';
UPDATE items SET name_th = 'เมก้าทัลท์' WHERE slug = 'mega-talt';
UPDATE items SET name_th = 'เมก้าควอสท์' WHERE slug = 'mega-quartz';
UPDATE items SET name_th = 'ชิ้นส่วนโรโดไลท์' WHERE slug = 'rhodolite-fragment';
UPDATE items SET name_th = 'ไชนี่ คริสตัล' WHERE slug = 'shiny-crystal';
UPDATE items SET name_th = 'มูน สโตน' WHERE slug = 'moon-stone';
UPDATE items SET name_th = 'เนื้อหมาป่า' WHERE slug = 'wolf-meat';
UPDATE items SET name_th = 'กะหล่ำ' WHERE slug = 'cabbage';
UPDATE items SET name_th = 'เคลียร์ รัม' WHERE slug = 'clear-rum';
UPDATE items SET name_th = 'เศษชิ้นส่วนโอไทต์' WHERE slug = 'otite-fragment';
UPDATE items SET name_th = 'เศษชิ้นส่วนคอราซอน' WHERE slug = 'corazon-fragment';
UPDATE items SET name_th = 'เอลิเมนเทียม' WHERE slug = 'elementium';
UPDATE items SET name_th = 'เมก้าไอโอเนียม' WHERE slug = 'mega-ionium';
UPDATE items SET name_th = 'หอกแห่งออร์เดน' WHERE slug = 'spear-of-orden';
UPDATE items SET name_th = 'วาร์ปสครอล' WHERE slug = 'warp-scroll';
UPDATE items SET name_th = 'โรส วิง' WHERE slug = 'rose-wing';
UPDATE items SET name_th = 'อิโรลิน่าแฮท' WHERE slug = 'irolina-hat';
UPDATE items SET name_th = 'ปีกปีศาจ' WHERE slug = 'devil-wings';
