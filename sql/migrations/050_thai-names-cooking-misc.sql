-- Migration 050: Thai names for cooking, alchemy, quest, craftable items
-- Generated: 2026-03-16

-- Alchemy (3 remaining)
UPDATE items SET name_th = 'ตับกระต่าย' WHERE slug = 'liver-of-rabbit' AND name_th IS NULL;
UPDATE items SET name_th = 'แร่อาร์โมเนียมแดง' WHERE slug = 'red-armonium-ore' AND name_th IS NULL;
UPDATE items SET name_th = 'เศษแห่งป่า' WHERE slug = 'the-fragment-of-forest' AND name_th IS NULL;

-- Cooking - Raw ingredients
UPDATE items SET name_th = 'ผลไม้ไข่ทองขนาดใหญ่' WHERE slug = 'big-golden-egg-fruit' AND name_th IS NULL;
UPDATE items SET name_th = 'เนื้อโคโมโด' WHERE slug = 'comodo-meat' AND name_th IS NULL;
UPDATE items SET name_th = 'ไข่ค็อกคาทริซ' WHERE slug = 'egg-of-cockatrice' AND name_th IS NULL;
UPDATE items SET name_th = 'เนื้อปลา' WHERE slug = 'fish-flesh' AND name_th IS NULL;
UPDATE items SET name_th = 'ไข่ค็อกคาขนาดยักษ์' WHERE slug = 'giant-cocka-egg' AND name_th IS NULL;
UPDATE items SET name_th = 'กะหล่ำชั้นดี' WHERE slug = 'great-cabbage' AND name_th IS NULL;
UPDATE items SET name_th = 'คาบอสชั้นดี' WHERE slug = 'great-cabosse' AND name_th IS NULL;
UPDATE items SET name_th = 'เนื้อปลาชั้นดี' WHERE slug = 'great-fish-flesh' AND name_th IS NULL;
UPDATE items SET name_th = 'แอปเปิ้ลทองชั้นดี' WHERE slug = 'great-golden-apple' AND name_th IS NULL;
UPDATE items SET name_th = 'ขาปลาหมึกชั้นดี' WHERE slug = 'great-octopus-leg' AND name_th IS NULL;
UPDATE items SET name_th = 'แป้งสาลีชั้นดี' WHERE slug = 'great-wheat-flour' AND name_th IS NULL;
UPDATE items SET name_th = 'น้ำผึ้ง' WHERE slug = 'honey' AND name_th IS NULL;
UPDATE items SET name_th = 'เคลียร์รัมบ่ม' WHERE slug = 'mature-clear-rum' AND name_th IS NULL;
UPDATE items SET name_th = 'ขาปลาหมึก' WHERE slug = 'octopus-arm' AND name_th IS NULL;
UPDATE items SET name_th = 'เนื้อแมงมุม' WHERE slug = 'spider-meat' AND name_th IS NULL;
UPDATE items SET name_th = 'ผงน้ำตาล' WHERE slug = 'sugar-powder' AND name_th IS NULL;
UPDATE items SET name_th = 'ผงหวาน' WHERE slug = 'sweet-powder' AND name_th IS NULL;
UPDATE items SET name_th = 'เนื้อโคโมโดหนา' WHERE slug = 'thick-comodo-meat' AND name_th IS NULL;
UPDATE items SET name_th = 'เนื้อแมงมุมหนา' WHERE slug = 'thick-spider-meat' AND name_th IS NULL;
UPDATE items SET name_th = 'เนื้อหมูป่าหนา' WHERE slug = 'thick-wild-boar-meat' AND name_th IS NULL;
UPDATE items SET name_th = 'เนื้อหมาป่าหนา' WHERE slug = 'thick-wolf-meat' AND name_th IS NULL;
UPDATE items SET name_th = 'เนื้อหมูป่า' WHERE slug = 'wild-boar-meat' AND name_th IS NULL;

-- Cooking - Tier I Feasts
UPDATE items SET name_th = '[เทียร์ I] งานเลี้ยงสเต็กหมูป่า' WHERE slug = 'tier-i-feast-of-boar-steak' AND name_th IS NULL;
UPDATE items SET name_th = '[เทียร์ I] งานเลี้ยงคาโบรัม' WHERE slug = 'tier-i-feast-of-caborum' AND name_th IS NULL;
UPDATE items SET name_th = '[เทียร์ I] งานเลี้ยงปลาคาปี้' WHERE slug = 'tier-i-feast-of-capy-fish' AND name_th IS NULL;
UPDATE items SET name_th = '[เทียร์ I] งานเลี้ยงเนื้อโคโมโด' WHERE slug = 'tier-i-feast-of-comodo-meat' AND name_th IS NULL;
UPDATE items SET name_th = '[เทียร์ I] งานเลี้ยงสตูว์ไข่' WHERE slug = 'tier-i-feast-of-egg-stew' AND name_th IS NULL;
UPDATE items SET name_th = '[เทียร์ I] งานเลี้ยงไส้กรอกปลา' WHERE slug = 'tier-i-feast-of-fish-sausage' AND name_th IS NULL;
UPDATE items SET name_th = '[เทียร์ I] งานเลี้ยงพายแอปเปิ้ลทอง' WHERE slug = 'tier-i-feast-of-golden-apple-pie' AND name_th IS NULL;
UPDATE items SET name_th = '[เทียร์ I] งานเลี้ยงสตูว์เนื้อ' WHERE slug = 'tier-i-feast-of-meat-stew' AND name_th IS NULL;
UPDATE items SET name_th = '[เทียร์ I] งานเลี้ยงสลัดพิเศษ' WHERE slug = 'tier-i-feast-of-special-salad' AND name_th IS NULL;
UPDATE items SET name_th = '[เทียร์ I] งานเลี้ยงเนื้อแมงมุม' WHERE slug = 'tier-i-feast-of-spider-meat' AND name_th IS NULL;
UPDATE items SET name_th = '[เทียร์ I] งานเลี้ยงข้าวโพดผัด' WHERE slug = 'tier-i-feast-of-stirfried-corn' AND name_th IS NULL;
UPDATE items SET name_th = '[เทียร์ I] งานเลี้ยงปลาหมึกผัด' WHERE slug = 'tier-i-feast-of-stirfried-octo' AND name_th IS NULL;
UPDATE items SET name_th = '[เทียร์ I] งานเลี้ยงเนื้อหมาป่า' WHERE slug = 'tier-i-feast-of-wolf-meat' AND name_th IS NULL;

-- Cooking - Tier II Feasts
UPDATE items SET name_th = '[เทียร์ II] งานเลี้ยงคาโบรัม' WHERE slug = 'tier-ii-feast-of-caborum' AND name_th IS NULL;
UPDATE items SET name_th = '[เทียร์ II] งานเลี้ยงปลาคาปี้' WHERE slug = 'tier-ii-feast-of-capy-fish' AND name_th IS NULL;
UPDATE items SET name_th = '[เทียร์ II] งานเลี้ยงเนื้อโคโมโด' WHERE slug = 'tier-ii-feast-of-comodo-meat' AND name_th IS NULL;
UPDATE items SET name_th = '[เทียร์ II] งานเลี้ยงสตูว์ไข่' WHERE slug = 'tier-ii-feast-of-egg-stew' AND name_th IS NULL;
UPDATE items SET name_th = '[เทียร์ II] งานเลี้ยงไส้กรอกปลา' WHERE slug = 'tier-ii-feast-of-fish-sausage' AND name_th IS NULL;
UPDATE items SET name_th = '[เทียร์ II] งานเลี้ยงพายแอปเปิ้ลทอง' WHERE slug = 'tier-ii-feast-of-golden-apple-pie' AND name_th IS NULL;
UPDATE items SET name_th = '[เทียร์ II] งานเลี้ยงสตูว์เนื้อ' WHERE slug = 'tier-ii-feast-of-meat-stew' AND name_th IS NULL;
UPDATE items SET name_th = '[เทียร์ II] งานเลี้ยงสลัดพิเศษ' WHERE slug = 'tier-ii-feast-of-special-salad' AND name_th IS NULL;
UPDATE items SET name_th = '[เทียร์ II] งานเลี้ยงเนื้อแมงมุม' WHERE slug = 'tier-ii-feast-of-spider-meat' AND name_th IS NULL;
UPDATE items SET name_th = '[เทียร์ II] งานเลี้ยงไข่ผัด' WHERE slug = 'tier-ii-feast-of-stirfried-egg' AND name_th IS NULL;
UPDATE items SET name_th = '[เทียร์ II] งานเลี้ยงปลาหมึกผัด' WHERE slug = 'tier-ii-feast-of-stirfried-octo' AND name_th IS NULL;
UPDATE items SET name_th = '[เทียร์ II] งานเลี้ยงเนื้อหมาป่า' WHERE slug = 'tier-ii-feast-of-wolf-meat' AND name_th IS NULL;

-- Craftable
UPDATE items SET name_th = 'สลักอาวุธกองทัพเรือเลือด' WHERE slug = 'blood-navy-weapon-dowel' AND name_th IS NULL;
UPDATE items SET name_th = 'ตั๋วคณะละครสัตว์อาร์เซ็น (น้ำเงิน)' WHERE slug = 'blue-arsene-circus-ticket' AND name_th IS NULL;
UPDATE items SET name_th = 'คริสตัลคอราซอนเจิดจ้า' WHERE slug = 'dazzling-corazon-crystal' AND name_th IS NULL;
UPDATE items SET name_th = 'คริสตัลน้ำมนต์ศักดิ์สิทธิ์เจิดจ้า' WHERE slug = 'dazzling-holy-water-crystal' AND name_th IS NULL;
UPDATE items SET name_th = 'คริสตัลโอไทต์เจิดจ้า' WHERE slug = 'dazzling-otite-crystal' AND name_th IS NULL;
UPDATE items SET name_th = 'คริสตัลแก๊สกลายหินเจิดจ้า' WHERE slug = 'dazzling-petrified-gas-crystal' AND name_th IS NULL;
UPDATE items SET name_th = 'คริสตัลโรโดไลท์เจิดจ้า' WHERE slug = 'dazzling-rhodolite-crystal' AND name_th IS NULL;
UPDATE items SET name_th = 'แก่นแห่งดวงดาว' WHERE slug = 'essence-of-star' AND name_th IS NULL;
UPDATE items SET name_th = 'เศษโอไทต์บริสุทธิ์' WHERE slug = 'pure-otite-fragment' AND name_th IS NULL;
UPDATE items SET name_th = 'หอคอยลับ - ม้วนเวทมนตร์' WHERE slug = 'secret-tower-magic-scroll' AND name_th IS NULL;
UPDATE items SET name_th = 'เศษน้ำมนต์ศักดิ์สิทธิ์เปล่งประกาย' WHERE slug = 'shiny-holy-water-fragment' AND name_th IS NULL;
UPDATE items SET name_th = 'สัญลักษณ์ยอร์มุนกานด์' WHERE slug = 'symbol-of-jormongand' AND name_th IS NULL;

-- Quest items
UPDATE items SET name_th = 'ต่างหูซีเฟอุส' WHERE slug = 'earring-of-cepheus' AND name_th IS NULL;
UPDATE items SET name_th = 'รูปร่างแห่งความโลภ' WHERE slug = 'greeds-shape' AND name_th IS NULL;
UPDATE items SET name_th = 'รูปร่างแห่งความอิจฉา' WHERE slug = 'jealousys-shape' AND name_th IS NULL;
UPDATE items SET name_th = 'รูปร่างแห่งความทะนง' WHERE slug = 'prides-shape' AND name_th IS NULL;
UPDATE items SET name_th = 'รูปร่างแห่งความเกรี้ยวกราด' WHERE slug = 'rages-shape' AND name_th IS NULL;
UPDATE items SET name_th = 'ใบปลิวโฆษณาชิฟฟ์' WHERE slug = 'schiff-advertisement-flyer' AND name_th IS NULL;
UPDATE items SET name_th = 'รูปร่างแห่งความเกียจคร้าน' WHERE slug = 'sloths-shape' AND name_th IS NULL;
UPDATE items SET name_th = 'ต่างหูนักรบ' WHERE slug = 'warriors-earrings' AND name_th IS NULL;
