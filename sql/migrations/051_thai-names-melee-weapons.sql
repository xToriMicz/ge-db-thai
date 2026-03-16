-- Migration 051: Thai names for melee weapons
-- Generated: 2026-03-16T03:29:36.674Z

UPDATE items SET name_th = 'อะบิส อาร์ม่า เมซ' WHERE slug = 'abyss-arma-mace' AND name_th IS NULL;
UPDATE items SET name_th = 'อะบิส อาร์ม่า เมซ (อีเวนต์)' WHERE slug = 'abyss-arma-mace-event' AND name_th IS NULL;
UPDATE items SET name_th = 'แองเจิล เมซ' WHERE slug = 'angel-mace' AND name_th IS NULL;
UPDATE items SET name_th = 'อาร์โมเนีย เมซ (อีเวนต์)' WHERE slug = 'armonia-mace-event' AND name_th IS NULL;
UPDATE items SET name_th = 'แอตลาส ซัลเวชั่น' WHERE slug = 'atlas-salvation' AND name_th IS NULL;
UPDATE items SET name_th = 'แอตลาส ซัลเวชั่น (อีเวนต์)' WHERE slug = 'atlas-salvation-event' AND name_th IS NULL;
UPDATE items SET name_th = 'เมซศึก' WHERE slug = 'battle-mace' AND name_th IS NULL;
UPDATE items SET name_th = 'บลันท์สัญญา (7 วัน)' WHERE slug = 'blunt-of-contract-7-days' AND name_th IS NULL;
UPDATE items SET name_th = 'บริสเทีย เมซ' WHERE slug = 'bristia-mace' AND name_th IS NULL;
UPDATE items SET name_th = 'เดอุส มาชิน่า เมซ' WHERE slug = 'deus-machina-mace' AND name_th IS NULL;
UPDATE items SET name_th = 'เดอุส มาชิน่า เมซ (อีเวนต์)' WHERE slug = 'deus-machina-mace-event' AND name_th IS NULL;
UPDATE items SET name_th = 'ดิไวน์ เมซ' WHERE slug = 'divine-mace' AND name_th IS NULL;
-- SKIP: Elite Axe di Gavi (elite-axe-di-gavi)
UPDATE items SET name_th = 'อีลิท บริสเทีย เมซ' WHERE slug = 'elite-bristia-mace' AND name_th IS NULL;
UPDATE items SET name_th = 'อีลิท บริสเทีย เมซ (อีเวนต์)' WHERE slug = 'elite-bristia-mace-event' AND name_th IS NULL;
-- SKIP: Elite Craighammer (elite-craighammer)
UPDATE items SET name_th = 'อีลิท Crescent แอ็กซ์' WHERE slug = 'elite-crescent-axe' AND name_th IS NULL;
-- SKIP: Elite Dragomahawk (elite-dragomahawk)
UPDATE items SET name_th = 'อีลิท ทดลอง แอ็กซ์' WHERE slug = 'elite-experimental-axe' AND name_th IS NULL;
UPDATE items SET name_th = 'อีลิท ทดลอง เมซ' WHERE slug = 'elite-experimental-mace' AND name_th IS NULL;
UPDATE items SET name_th = 'อีลิท เสียงหอนแห่งคาลลิสโต' WHERE slug = 'elite-howling-of-callisto' AND name_th IS NULL;
UPDATE items SET name_th = 'อีลิท เสียงหอนแห่งคาลลิสโต (อีเวนต์)' WHERE slug = 'elite-howling-of-callisto-event' AND name_th IS NULL;
UPDATE items SET name_th = 'อีลิท Iron แอ็กซ์' WHERE slug = 'elite-iron-axe' AND name_th IS NULL;
UPDATE items SET name_th = 'อีลิท ลา สุม่า ซาเชอโดติซ่า' WHERE slug = 'elite-la-suma-sacherdotisa' AND name_th IS NULL;
-- SKIP: Elite Morgenstern (elite-morgenstern)
UPDATE items SET name_th = 'อีลิท มูเอร์ทัวร์ส บลันท์' WHERE slug = 'elite-muertuors-blunt' AND name_th IS NULL;
UPDATE items SET name_th = 'อีลิท Paladin เมซ' WHERE slug = 'elite-paladin-mace' AND name_th IS NULL;
UPDATE items SET name_th = 'อีลิท Shaft แฮมเมอร์' WHERE slug = 'elite-shaft-hammer' AND name_th IS NULL;
UPDATE items SET name_th = 'เอเน็กซ์ อีเธอเรียล เมซ' WHERE slug = 'enex-ethereal-mace' AND name_th IS NULL;
UPDATE items SET name_th = 'อีเวนต์ อีลิท มูเอร์ทัวร์ส บลันท์' WHERE slug = 'event-elite-muertuors-blunt' AND name_th IS NULL;
UPDATE items SET name_th = 'อีเวนต์ มูเอร์ทัวร์ส บลันท์' WHERE slug = 'event-muertuors-blunt' AND name_th IS NULL;
UPDATE items SET name_th = 'อีวิล เมซ' WHERE slug = 'evil-mace' AND name_th IS NULL;
UPDATE items SET name_th = 'ทดลอง แอ็กซ์' WHERE slug = 'experimental-axe' AND name_th IS NULL;
UPDATE items SET name_th = 'ทดลอง เมซ' WHERE slug = 'experimental-mace' AND name_th IS NULL;
UPDATE items SET name_th = 'ค้อนแห่งการพิพากษา' WHERE slug = 'hammer-of-judgment' AND name_th IS NULL;
UPDATE items SET name_th = 'เสียงหอนแห่งคาลลิสโต' WHERE slug = 'howling-of-callisto' AND name_th IS NULL;
UPDATE items SET name_th = 'เสียงหอนแห่งคาลลิสโต (อีเวนต์)' WHERE slug = 'howling-of-callisto-event' AND name_th IS NULL;
UPDATE items SET name_th = 'แอตลาส ซัลเวชั่นไม่สมบูรณ์' WHERE slug = 'incomplete-atlas-salvation' AND name_th IS NULL;
UPDATE items SET name_th = 'โคบอลท์ แอ็กซ์' WHERE slug = 'kobolt-axe' AND name_th IS NULL;
-- SKIP: Kobolt Torch (kobolt-torch)
UPDATE items SET name_th = 'ลา สุม่า ซาเชอโดติซ่า' WHERE slug = 'la-suma-sacherdotisa' AND name_th IS NULL;
UPDATE items SET name_th = 'ลีเจียน เมซ' WHERE slug = 'legion-mace' AND name_th IS NULL;
UPDATE items SET name_th = 'มูเอร์ทัวร์ส บลันท์' WHERE slug = 'muertuors-blunt' AND name_th IS NULL;
UPDATE items SET name_th = 'ออบซิเดียนแห่งการทำลายล้าง' WHERE slug = 'obsidian-of-destruction' AND name_th IS NULL;
UPDATE items SET name_th = 'เวสปาโนลาขัดเงา เมซ' WHERE slug = 'refined-vespanola-mace' AND name_th IS NULL;
UPDATE items SET name_th = 'ป้อมเหล็ก' WHERE slug = 'steel-fort' AND name_th IS NULL;
UPDATE items SET name_th = 'สตราต้า เดวิล บลันท์' WHERE slug = 'strata-devil-blunt' AND name_th IS NULL;
UPDATE items SET name_th = 'สตราต้า เดวิล บลันท์ (อีเวนต์)' WHERE slug = 'strata-devil-blunt-event' AND name_th IS NULL;
UPDATE items SET name_th = 'เมซหวาน' WHERE slug = 'sweet-mace' AND name_th IS NULL;
UPDATE items SET name_th = 'ค้อนแห่งความเกียจคร้าน' WHERE slug = 'the-hammer-of-sloth' AND name_th IS NULL;
UPDATE items SET name_th = 'ทอร์เมนโต' WHERE slug = 'tormento' AND name_th IS NULL;
UPDATE items SET name_th = 'คำสั่งทรราช เมซ' WHERE slug = 'tyrants-order-mace' AND name_th IS NULL;
UPDATE items SET name_th = 'คำสั่งทรราช เมซ (อีเวนต์)' WHERE slug = 'tyrants-order-mace-event' AND name_th IS NULL;
UPDATE items SET name_th = 'วาเลรอน เมซ' WHERE slug = 'valeron-mace' AND name_th IS NULL;
UPDATE items SET name_th = 'วาเลรอน เมซ (อีเวนต์)' WHERE slug = 'valeron-mace-event' AND name_th IS NULL;
UPDATE items SET name_th = 'สนับสนุนผู้บุกเบิกเวสปาโนลา เมซ' WHERE slug = 'vespanola-pioneer-support-mace' AND name_th IS NULL;
UPDATE items SET name_th = 'แวร์แบร์ เมซ' WHERE slug = 'werebear-mace' AND name_th IS NULL;
UPDATE items SET name_th = 'แวร์วูล์ฟ แอ็กซ์' WHERE slug = 'werewolf-axe' AND name_th IS NULL;
UPDATE items SET name_th = '[อีเวนต์] เอเน็กซ์ อีเธอเรียล เมซ' WHERE slug = 'event-enex-ethereal-mace' AND name_th IS NULL;
UPDATE items SET name_th = 'อะบิส อาร์ม่า เครสเซนต์' WHERE slug = 'abyss-arma-crescent' AND name_th IS NULL;
UPDATE items SET name_th = 'อะบิส อาร์ม่า เครสเซนต์ (อีเวนต์)' WHERE slug = 'abyss-arma-crescent-event' AND name_th IS NULL;
UPDATE items SET name_th = 'อาร์โมเนีย เครสเซนต์ (อีเวนต์)' WHERE slug = 'armonia-crescent-event' AND name_th IS NULL;
UPDATE items SET name_th = 'แอตลาส ดิกนิตี้' WHERE slug = 'atlas-dignity' AND name_th IS NULL;
UPDATE items SET name_th = 'แอตลาส ดิกนิตี้ (อีเวนต์)' WHERE slug = 'atlas-dignity-event' AND name_th IS NULL;
UPDATE items SET name_th = 'บริสเทีย เครสเซนต์' WHERE slug = 'bristia-crescent' AND name_th IS NULL;
UPDATE items SET name_th = 'เครสเซนต์สัญญา (7 วัน)' WHERE slug = 'crescent-of-contract-7-days' AND name_th IS NULL;
UPDATE items SET name_th = 'เครสเซนต์แห่งไรลี่' WHERE slug = 'crescent-of-reilly' AND name_th IS NULL;
UPDATE items SET name_th = 'เดอุส มาชิน่า เครสเซนต์' WHERE slug = 'deus-machina-crescent' AND name_th IS NULL;
UPDATE items SET name_th = 'เดอุส มาชิน่า เครสเซนต์ (อีเวนต์)' WHERE slug = 'deus-machina-crescent-event' AND name_th IS NULL;
UPDATE items SET name_th = 'ดิไวน์ เครสเซนต์' WHERE slug = 'divine-crescent' AND name_th IS NULL;
UPDATE items SET name_th = 'อีลิท บริสเทีย เครสเซนต์' WHERE slug = 'elite-bristia-crescent' AND name_th IS NULL;
UPDATE items SET name_th = 'อีลิท บริสเทีย เครสเซนต์ (อีเวนต์)' WHERE slug = 'elite-bristia-crescent-event' AND name_th IS NULL;
UPDATE items SET name_th = 'อีลิท ทดลอง เครสเซนต์' WHERE slug = 'elite-experimental-crescent' AND name_th IS NULL;
UPDATE items SET name_th = 'อีลิท เฮสเทีย' WHERE slug = 'elite-hestia' AND name_th IS NULL;
UPDATE items SET name_th = 'อีลิท เฮสเทีย (อีเวนต์)' WHERE slug = 'elite-hestia-event' AND name_th IS NULL;
UPDATE items SET name_th = 'อีลิท มูเอร์ทัวร์ส เครสเซนต์' WHERE slug = 'elite-muertuors-crescent' AND name_th IS NULL;
UPDATE items SET name_th = 'เอเน็กซ์ อีเธอเรียล เครสเซนต์' WHERE slug = 'enex-ethereal-crescent' AND name_th IS NULL;
UPDATE items SET name_th = 'อีเวนต์ อีลิท มูเอร์ทัวร์ส เครสเซนต์' WHERE slug = 'event-elite-muertuors-crescent' AND name_th IS NULL;
UPDATE items SET name_th = 'อีเวนต์ มูเอร์ทัวร์ส เครสเซนต์' WHERE slug = 'event-muertuors-crescent' AND name_th IS NULL;
UPDATE items SET name_th = 'อีวิล เครสเซนต์' WHERE slug = 'evil-crescent' AND name_th IS NULL;
UPDATE items SET name_th = 'ทดลอง เครสเซนต์' WHERE slug = 'experimental-crescent' AND name_th IS NULL;
UPDATE items SET name_th = 'เฮสเทีย' WHERE slug = 'hestia' AND name_th IS NULL;
UPDATE items SET name_th = 'เฮสเทีย (อีเวนต์)' WHERE slug = 'hestia-event' AND name_th IS NULL;
UPDATE items SET name_th = 'แอตลาส ดิกนิตี้ไม่สมบูรณ์' WHERE slug = 'incomplete-atlas-dignity' AND name_th IS NULL;
UPDATE items SET name_th = 'ลีเจียน เครสเซนต์' WHERE slug = 'legion-crescent' AND name_th IS NULL;
UPDATE items SET name_th = 'มูเอร์ทัวร์ส เครสเซนต์' WHERE slug = 'muertuors-crescent' AND name_th IS NULL;
UPDATE items SET name_th = 'โนเช่ ทริสเต้' WHERE slug = 'noche-triste' AND name_th IS NULL;
UPDATE items SET name_th = 'พรอสเป เครสเซนต์' WHERE slug = 'prospe-crescent' AND name_th IS NULL;
UPDATE items SET name_th = 'เวสปาโนลาขัดเงา เครสเซนต์' WHERE slug = 'refined-vespanola-crescent' AND name_th IS NULL;
UPDATE items SET name_th = 'สตราต้า เดวิล เครสเซนต์' WHERE slug = 'strata-devil-crescent' AND name_th IS NULL;
UPDATE items SET name_th = 'สตราต้า เดวิล เครสเซนต์ (อีเวนต์)' WHERE slug = 'strata-devil-crescent-event' AND name_th IS NULL;
UPDATE items SET name_th = 'เครสเซนต์ผู้แก้แค้น' WHERE slug = 'the-crescent-of-avenger' AND name_th IS NULL;
UPDATE items SET name_th = 'คำสั่งทรราช เครสเซนต์' WHERE slug = 'tyrants-order-crescent' AND name_th IS NULL;
UPDATE items SET name_th = 'คำสั่งทรราช เครสเซนต์ (อีเวนต์)' WHERE slug = 'tyrants-order-crescent-event' AND name_th IS NULL;
UPDATE items SET name_th = 'วาเลรอน เครสเซนต์' WHERE slug = 'valeron-crescent' AND name_th IS NULL;
UPDATE items SET name_th = 'วาเลรอน เครสเซนต์ (อีเวนต์)' WHERE slug = 'valeron-crescent-event' AND name_th IS NULL;
UPDATE items SET name_th = 'สนับสนุนผู้บุกเบิกเวสปาโนลา เครสเซนต์' WHERE slug = 'vespanola-pioneer-support-crescent' AND name_th IS NULL;
UPDATE items SET name_th = 'เครสเซนต์สงคราม' WHERE slug = 'war-crescent' AND name_th IS NULL;
UPDATE items SET name_th = '[อีเวนต์] เอเน็กซ์ อีเธอเรียล เครสเซนต์' WHERE slug = 'event-enex-ethereal-crescent' AND name_th IS NULL;
UPDATE items SET name_th = 'อะบิส อาร์ม่า ดาก้า' WHERE slug = 'abyss-arma-dagger' AND name_th IS NULL;
UPDATE items SET name_th = 'อะบิส อาร์ม่า ดาก้า (อีเวนต์)' WHERE slug = 'abyss-arma-dagger-event' AND name_th IS NULL;
UPDATE items SET name_th = 'แองเจิล ดาก้า' WHERE slug = 'angel-dagger' AND name_th IS NULL;
UPDATE items SET name_th = 'อาร์โมเนีย ดาก้า (อีเวนต์)' WHERE slug = 'armonia-dagger-event' AND name_th IS NULL;
UPDATE items SET name_th = 'ดาก้านักฆ่า' WHERE slug = 'assassin-dagger' AND name_th IS NULL;
UPDATE items SET name_th = 'ดาก้าดำ' WHERE slug = 'black-dagger' AND name_th IS NULL;
UPDATE items SET name_th = 'บริสเทีย ดาก้า' WHERE slug = 'bristia-dagger' AND name_th IS NULL;
UPDATE items SET name_th = 'คริสตาลิน' WHERE slug = 'crystalin' AND name_th IS NULL;
UPDATE items SET name_th = 'ดาก้าสัญญา (7 วัน)' WHERE slug = 'dagger-of-contract-7-days' AND name_th IS NULL;
UPDATE items SET name_th = 'ดาก้าแห่งฮิกกินส์' WHERE slug = 'dagger-of-higgins' AND name_th IS NULL;
UPDATE items SET name_th = 'ดาก้าแห่งคู่รัก' WHERE slug = 'dagger-of-lovers' AND name_th IS NULL;
UPDATE items SET name_th = 'เดอุส มาชิน่า ดาก้า' WHERE slug = 'deus-machina-dagger' AND name_th IS NULL;
UPDATE items SET name_th = 'เดอุส มาชิน่า ดาก้า (อีเวนต์)' WHERE slug = 'deus-machina-dagger-event' AND name_th IS NULL;
UPDATE items SET name_th = 'ดิไวน์ ดาก้า' WHERE slug = 'divine-dagger' AND name_th IS NULL;
-- SKIP: Duel Structure Dagger (duel-structure-dagger)
UPDATE items SET name_th = 'เอล คอลกาโด' WHERE slug = 'el-colgado' AND name_th IS NULL;
-- SKIP: Elite Baselard (elite-baselard)
UPDATE items SET name_th = 'อีลิท บริสเทีย ดาก้า' WHERE slug = 'elite-bristia-dagger' AND name_th IS NULL;
UPDATE items SET name_th = 'อีลิท บริสเทีย ดาก้า (อีเวนต์)' WHERE slug = 'elite-bristia-dagger-event' AND name_th IS NULL;
-- SKIP: Elite Cuspid of Steel (elite-cuspid-of-steel)
UPDATE items SET name_th = 'อีลิท Eared ดาก้า' WHERE slug = 'elite-eared-dagger' AND name_th IS NULL;
UPDATE items SET name_th = 'อีลิท เอล คอลกาโด' WHERE slug = 'elite-el-colgado' AND name_th IS NULL;
UPDATE items SET name_th = 'อีลิท ทดลอง ดาก้า' WHERE slug = 'elite-experimental-dagger' AND name_th IS NULL;
UPDATE items SET name_th = 'อีลิท แรงกระตุ้นแห่งอัลเกดี' WHERE slug = 'elite-impulse-of-algedi' AND name_th IS NULL;
UPDATE items SET name_th = 'อีลิท แรงกระตุ้นแห่งอัลเกดี (อีเวนต์)' WHERE slug = 'elite-impulse-of-algedi-event' AND name_th IS NULL;
UPDATE items SET name_th = 'อีลิท มูเอร์ทัวร์ส ดาก้า' WHERE slug = 'elite-muertuors-dagger' AND name_th IS NULL;
-- SKIP: Elite Mystic Knife (elite-mystic-knife)
-- SKIP: Elite Pugio (elite-pugio)
-- SKIP: Elite Small Knife (elite-small-knife)
-- SKIP: Elite Xiphos (elite-xiphos)
UPDATE items SET name_th = 'เอเน็กซ์ อีเธอเรียล ดาก้า' WHERE slug = 'enex-ethereal-dagger' AND name_th IS NULL;
UPDATE items SET name_th = 'อีเวนต์ อีลิท มูเอร์ทัวร์ส ดาก้า' WHERE slug = 'event-elite-muertuors-dagger' AND name_th IS NULL;
UPDATE items SET name_th = 'อีเวนต์ มูเอร์ทัวร์ส ดาก้า' WHERE slug = 'event-muertuors-dagger' AND name_th IS NULL;
UPDATE items SET name_th = 'อีวิล ดาก้า' WHERE slug = 'evil-dagger' AND name_th IS NULL;
UPDATE items SET name_th = 'ทดลอง ดาก้า' WHERE slug = 'experimental-dagger' AND name_th IS NULL;
UPDATE items SET name_th = 'แรงกระตุ้นแห่งอัลเกดี' WHERE slug = 'impulse-of-algedi' AND name_th IS NULL;
UPDATE items SET name_th = 'แรงกระตุ้นแห่งอัลเกดี (อีเวนต์)' WHERE slug = 'impulse-of-algedi-event' AND name_th IS NULL;
UPDATE items SET name_th = 'ลมหายใจออร์เดนไม่สมบูรณ์' WHERE slug = 'incomplete-ordens-breath' AND name_th IS NULL;
UPDATE items SET name_th = 'โคบอลท์ ดาก้า' WHERE slug = 'kobolt-dagger' AND name_th IS NULL;
UPDATE items SET name_th = 'ลีเจียน ดาก้า' WHERE slug = 'legion-dagger' AND name_th IS NULL;
UPDATE items SET name_th = 'มูนสโตนแห่งความสามัคคี' WHERE slug = 'moonstone-of-harmony' AND name_th IS NULL;
UPDATE items SET name_th = 'มูเอร์ทัวร์ส ดาก้า' WHERE slug = 'muertuors-dagger' AND name_th IS NULL;
UPDATE items SET name_th = 'ลมหายใจออร์เดน' WHERE slug = 'ordens-breath' AND name_th IS NULL;
UPDATE items SET name_th = 'ลมหายใจออร์เดน (อีเวนต์)' WHERE slug = 'ordens-breath-event' AND name_th IS NULL;
UPDATE items SET name_th = 'แพนเดอร์โมเนีย' WHERE slug = 'pandermonia' AND name_th IS NULL;
-- SKIP: Peorthlight Dagger (peorthlight-dagger)
UPDATE items SET name_th = 'พรอสเป ดาก้า' WHERE slug = 'prospe-dagger' AND name_th IS NULL;
UPDATE items SET name_th = 'เวสปาโนลาขัดเงา ดาก้า' WHERE slug = 'refined-vespanola-dagger' AND name_th IS NULL;
UPDATE items SET name_th = 'สตอร์มบริงเกอร์' WHERE slug = 'stormbringer' AND name_th IS NULL;
UPDATE items SET name_th = 'สตราต้า เดวิล ดาก้า' WHERE slug = 'strata-devil-dagger' AND name_th IS NULL;
UPDATE items SET name_th = 'สตราต้า เดวิล ดาก้า (อีเวนต์)' WHERE slug = 'strata-devil-dagger-event' AND name_th IS NULL;
UPDATE items SET name_th = 'ดาก้าแห่งความโลภ' WHERE slug = 'the-dagger-of-greed' AND name_th IS NULL;
UPDATE items SET name_th = 'คำสั่งทรราช ดาก้า' WHERE slug = 'tyrants-order-dagger' AND name_th IS NULL;
UPDATE items SET name_th = 'คำสั่งทรราช ดาก้า (อีเวนต์)' WHERE slug = 'tyrants-order-dagger-event' AND name_th IS NULL;
UPDATE items SET name_th = 'วาเลรอน ดาก้า' WHERE slug = 'valeron-dagger' AND name_th IS NULL;
UPDATE items SET name_th = 'วาเลรอน ดาก้า (อีเวนต์)' WHERE slug = 'valeron-dagger-event' AND name_th IS NULL;
UPDATE items SET name_th = 'สนับสนุนผู้บุกเบิกเวสปาโนลา ดาก้า' WHERE slug = 'vespanola-pioneer-support-dagger' AND name_th IS NULL;
UPDATE items SET name_th = 'แวร์วูล์ฟ ดาก้า' WHERE slug = 'werewolf-dagger' AND name_th IS NULL;
UPDATE items SET name_th = 'ดาก้าขาว' WHERE slug = 'white-dagger' AND name_th IS NULL;
UPDATE items SET name_th = '[อีเวนต์] เอเน็กซ์ อีเธอเรียล ดาก้า' WHERE slug = 'event-enex-ethereal-dagger' AND name_th IS NULL;
UPDATE items SET name_th = 'อะบิส อาร์ม่า สเลเยอร์' WHERE slug = 'abyss-arma-slayer' AND name_th IS NULL;
UPDATE items SET name_th = 'อะบิส อาร์ม่า สเลเยอร์ (อีเวนต์)' WHERE slug = 'abyss-arma-slayer-event' AND name_th IS NULL;
-- SKIP: Angel Zweihander (angel-zweihander)
UPDATE items SET name_th = 'อาร์โมเนีย สเลเยอร์ (อีเวนต์)' WHERE slug = 'armonia-slayer-event' AND name_th IS NULL;
UPDATE items SET name_th = 'แอตลาส เวท' WHERE slug = 'atlas-weight' AND name_th IS NULL;
UPDATE items SET name_th = 'แอตลาส เวท (อีเวนต์)' WHERE slug = 'atlas-weight-event' AND name_th IS NULL;
UPDATE items SET name_th = 'บริสเทีย สเลเยอร์' WHERE slug = 'bristia-slayer' AND name_th IS NULL;
UPDATE items SET name_th = 'นักล่าปีศาจ' WHERE slug = 'demon-slayer' AND name_th IS NULL;
UPDATE items SET name_th = 'ดาบปีศาจ' WHERE slug = 'demon-sword' AND name_th IS NULL;
UPDATE items SET name_th = 'เดอุส มาชิน่า สเลเยอร์' WHERE slug = 'deus-machina-slayer' AND name_th IS NULL;
UPDATE items SET name_th = 'เดอุส มาชิน่า สเลเยอร์ (อีเวนต์)' WHERE slug = 'deus-machina-slayer-event' AND name_th IS NULL;
UPDATE items SET name_th = 'เพชรแห่งความสมบูรณ์แบบ' WHERE slug = 'diamond-of-perfection' AND name_th IS NULL;
UPDATE items SET name_th = 'ดิไวน์ สเลเยอร์' WHERE slug = 'divine-slayer' AND name_th IS NULL;
-- SKIP: Einschiever Sword (einschiever-sword)
UPDATE items SET name_th = 'อีลิท Bastard ซอร์ด' WHERE slug = 'elite-bastard-sword' AND name_th IS NULL;
UPDATE items SET name_th = 'อีลิท บริสเทีย สเลเยอร์' WHERE slug = 'elite-bristia-slayer' AND name_th IS NULL;
UPDATE items SET name_th = 'อีลิท บริสเทีย สเลเยอร์ (อีเวนต์)' WHERE slug = 'elite-bristia-slayer-event' AND name_th IS NULL;
UPDATE items SET name_th = 'อีลิท Castor ซอร์ด' WHERE slug = 'elite-castor-sword' AND name_th IS NULL;
UPDATE items SET name_th = 'อีลิท นักล่าปีศาจ' WHERE slug = 'elite-demon-slayer' AND name_th IS NULL;
-- SKIP: Elite Destruction of Steel (elite-destruction-of-steel)
-- SKIP: Elite Earthcracker (elite-earthcracker)
UPDATE items SET name_th = 'อีลิท Executioner ซอร์ด' WHERE slug = 'elite-executioner-sword' AND name_th IS NULL;
UPDATE items SET name_th = 'อีลิท ทดลอง สเลเยอร์' WHERE slug = 'elite-experimental-slayer' AND name_th IS NULL;
-- SKIP: Elite Kaladbolg (elite-kaladbolg)
UPDATE items SET name_th = 'อีลิท ลา จัสติเซีย' WHERE slug = 'elite-la-justicia' AND name_th IS NULL;
-- SKIP: Elite Merveilleuse (elite-merveilleuse)
UPDATE items SET name_th = 'อีลิท มูเอร์ทัวร์ส สเลเยอร์' WHERE slug = 'elite-muertuors-slayer' AND name_th IS NULL;
-- SKIP: Elite Muses Gigantespada (elite-muses-gigantespada)
UPDATE items SET name_th = 'อีลิท ความปรารถนาเรกูลัส' WHERE slug = 'elite-passion-of-regulus' AND name_th IS NULL;
UPDATE items SET name_th = 'อีลิท ความปรารถนาเรกูลัส (อีเวนต์)' WHERE slug = 'elite-passion-of-regulus-event' AND name_th IS NULL;
UPDATE items SET name_th = 'อีลิท Pollux ซอร์ด' WHERE slug = 'elite-pollux-sword' AND name_th IS NULL;
UPDATE items SET name_th = 'อีลิท Schvarlier สเลเยอร์' WHERE slug = 'elite-schvarlier-slayer' AND name_th IS NULL;
-- SKIP: Elite Slayer (elite-slayer)
-- SKIP: Elite Vident Hander (elite-vident-hander)
UPDATE items SET name_th = 'อีลิท Weird ซอร์ด' WHERE slug = 'elite-weird-sword' AND name_th IS NULL;
UPDATE items SET name_th = 'เอเน็กซ์ อีเธอเรียล สเลเยอร์' WHERE slug = 'enex-ethereal-slayer' AND name_th IS NULL;
UPDATE items SET name_th = 'อีเวนต์ อีลิท มูเอร์ทัวร์ส สเลเยอร์' WHERE slug = 'event-elite-muertuors-slayer' AND name_th IS NULL;
UPDATE items SET name_th = 'อีเวนต์ มูเอร์ทัวร์ส สเลเยอร์' WHERE slug = 'event-muertuors-slayer' AND name_th IS NULL;
-- SKIP: Evil Killer (evil-killer)
UPDATE items SET name_th = 'ทดลอง สเลเยอร์' WHERE slug = 'experimental-slayer' AND name_th IS NULL;
UPDATE items SET name_th = 'ดวงตาเวลแลนท์' WHERE slug = 'eye-of-veilant' AND name_th IS NULL;
UPDATE items SET name_th = 'เฟลอร์ เดอ ลิส' WHERE slug = 'fleudelis' AND name_th IS NULL;
UPDATE items SET name_th = 'ดาบใหญ่แม็คฟอล' WHERE slug = 'great-sword-of-mcfaul' AND name_th IS NULL;
-- SKIP: Greatsword of Contract (7 Days) (greatsword-of-contract-7-days)
UPDATE items SET name_th = 'ฮัคเค่น สปินิเอล' WHERE slug = 'hacken-spiniel' AND name_th IS NULL;
UPDATE items SET name_th = 'เคลย์มอร์ไฮแลนเดอร์' WHERE slug = 'highlander-claymore' AND name_th IS NULL;
-- SKIP: Improved Great Sword of Yeganeh (7 days) (improved-great-sword-of-yeganeh-7-days)
UPDATE items SET name_th = 'แอตลาส เวทไม่สมบูรณ์' WHERE slug = 'incomplete-atlas-weight' AND name_th IS NULL;
UPDATE items SET name_th = 'คุเรไน' WHERE slug = 'kurenai' AND name_th IS NULL;
UPDATE items SET name_th = 'คุเรไน (อีเวนต์)' WHERE slug = 'kurenai-event' AND name_th IS NULL;
UPDATE items SET name_th = 'ลา จัสติเซีย' WHERE slug = 'la-justicia' AND name_th IS NULL;
UPDATE items SET name_th = 'ลีเจียน สเลเยอร์' WHERE slug = 'legion-slayer' AND name_th IS NULL;
UPDATE items SET name_th = 'มูเอร์ทัวร์ส สเลเยอร์' WHERE slug = 'muertuors-slayer' AND name_th IS NULL;
-- SKIP: Ogre Long Sword (ogre-long-sword)
UPDATE items SET name_th = 'ความปรารถนาเรกูลัส' WHERE slug = 'passion-of-regulus' AND name_th IS NULL;
UPDATE items SET name_th = 'ความปรารถนาเรกูลัส (อีเวนต์)' WHERE slug = 'passion-of-regulus-event' AND name_th IS NULL;
UPDATE items SET name_th = 'พรอสเป สเลเยอร์' WHERE slug = 'prospe-slayer' AND name_th IS NULL;
UPDATE items SET name_th = 'เวสปาโนลาขัดเงา สเลเยอร์' WHERE slug = 'refined-vespanola-slayer' AND name_th IS NULL;
UPDATE items SET name_th = 'โซลซไวฮันเดอร์' WHERE slug = 'soul-zweihander' AND name_th IS NULL;
UPDATE items SET name_th = 'สตราต้า เดวิล สเลเยอร์' WHERE slug = 'strata-devil-slayer' AND name_th IS NULL;
UPDATE items SET name_th = 'สตราต้า เดวิล สเลเยอร์ (อีเวนต์)' WHERE slug = 'strata-devil-slayer-event' AND name_th IS NULL;
UPDATE items SET name_th = 'ดาบแห่งพลัง' WHERE slug = 'sword-of-strength' AND name_th IS NULL;
UPDATE items SET name_th = 'ดาบราชา' WHERE slug = 'sword-of-the-king' AND name_th IS NULL;
-- SKIP: Thornlight Slayer (thornlight-slayer)
UPDATE items SET name_th = 'คำสั่งทรราช สเลเยอร์' WHERE slug = 'tyrants-order-slayer' AND name_th IS NULL;
UPDATE items SET name_th = 'คำสั่งทรราช สเลเยอร์ (อีเวนต์)' WHERE slug = 'tyrants-order-slayer-event' AND name_th IS NULL;
UPDATE items SET name_th = 'วาเลรอน สเลเยอร์' WHERE slug = 'valeron-slayer' AND name_th IS NULL;
UPDATE items SET name_th = 'วาเลรอน สเลเยอร์ (อีเวนต์)' WHERE slug = 'valeron-slayer-event' AND name_th IS NULL;
UPDATE items SET name_th = 'สนับสนุนผู้บุกเบิกเวสปาโนลา สเลเยอร์' WHERE slug = 'vespanola-pioneer-support-slayer' AND name_th IS NULL;
UPDATE items SET name_th = '[อีเวนต์] เอเน็กซ์ อีเธอเรียล สเลเยอร์' WHERE slug = 'event-enex-ethereal-slayer' AND name_th IS NULL;
UPDATE items SET name_th = 'อะบิส อาร์ม่า แฮมเมอร์' WHERE slug = 'abyss-arma-hammer' AND name_th IS NULL;
UPDATE items SET name_th = 'อะบิส อาร์ม่า แฮมเมอร์ (อีเวนต์)' WHERE slug = 'abyss-arma-hammer-event' AND name_th IS NULL;
UPDATE items SET name_th = 'ค้อนก่อสร้าง: โจมตี' WHERE slug = 'construction-hammer-attack' AND name_th IS NULL;
UPDATE items SET name_th = 'ค้อนก่อสร้าง: ป้องกัน' WHERE slug = 'construction-hammer-defense' AND name_th IS NULL;
UPDATE items SET name_th = 'แคร้ฟท์แนช' WHERE slug = 'craft-of-nash' AND name_th IS NULL;
UPDATE items SET name_th = 'เดอุส มาชิน่า แฮมเมอร์' WHERE slug = 'deus-machina-hammer' AND name_th IS NULL;
UPDATE items SET name_th = 'เดอุส มาชิน่า แฮมเมอร์ (อีเวนต์)' WHERE slug = 'deus-machina-hammer-event' AND name_th IS NULL;
UPDATE items SET name_th = 'อีลิท ทดลอง แคร้ฟท์' WHERE slug = 'elite-experimental-craft' AND name_th IS NULL;
UPDATE items SET name_th = 'อีลิท มูเอร์ทัวร์ส ทูล' WHERE slug = 'elite-muertuors-tool' AND name_th IS NULL;
UPDATE items SET name_th = 'เอเน็กซ์ อีเธอเรียล แฮมเมอร์' WHERE slug = 'enex-ethereal-hammer' AND name_th IS NULL;
UPDATE items SET name_th = 'อีเวนต์ อีลิท มูเอร์ทัวร์ส ทูล' WHERE slug = 'event-elite-muertuors-tool' AND name_th IS NULL;
UPDATE items SET name_th = 'อีเวนต์ มูเอร์ทัวร์ส ทูล' WHERE slug = 'event-muertuors-tool' AND name_th IS NULL;
UPDATE items SET name_th = 'ทดลอง แคร้ฟท์' WHERE slug = 'experimental-craft' AND name_th IS NULL;
UPDATE items SET name_th = 'ค้อนบาร์เซ่น' WHERE slug = 'hammer-of-barsene' AND name_th IS NULL;
UPDATE items SET name_th = 'แฮมเมอร์สัญญา (7 วัน)' WHERE slug = 'hammer-of-contract-7-days' AND name_th IS NULL;
UPDATE items SET name_th = 'ค้อนทอลเลโร' WHERE slug = 'hammer-of-tollero' AND name_th IS NULL;
UPDATE items SET name_th = 'แคร้ฟท์สวรรค์' WHERE slug = 'heavenly-craft' AND name_th IS NULL;
UPDATE items SET name_th = 'แคร้ฟท์สวรรค์ (อีเวนต์)' WHERE slug = 'heavenly-craft-event' AND name_th IS NULL;
UPDATE items SET name_th = 'ค้อนก่อสร้างคุณภาพสูง' WHERE slug = 'high-quality-construction-hammer' AND name_th IS NULL;
UPDATE items SET name_th = 'ความเศร้าออร์เดนไม่สมบูรณ์' WHERE slug = 'incomplete-ordens-lament' AND name_th IS NULL;
UPDATE items SET name_th = 'ลีเจียน แคร้ฟท์' WHERE slug = 'legion-craft' AND name_th IS NULL;
UPDATE items SET name_th = 'มูเอร์ทัวร์ส ทูล' WHERE slug = 'muertuors-tool' AND name_th IS NULL;
UPDATE items SET name_th = 'ความเศร้าออร์เดน' WHERE slug = 'ordens-lament' AND name_th IS NULL;
UPDATE items SET name_th = 'ความเศร้าออร์เดน (อีเวนต์)' WHERE slug = 'ordens-lament-event' AND name_th IS NULL;
UPDATE items SET name_th = 'พรอสเป แคร้ฟท์' WHERE slug = 'prospe-craft' AND name_th IS NULL;
UPDATE items SET name_th = 'เวสปาโนลาขัดเงา แฮมเมอร์' WHERE slug = 'refined-vespanola-hammer' AND name_th IS NULL;
UPDATE items SET name_th = 'สตราต้า เดวิล แฮมเมอร์' WHERE slug = 'strata-devil-hammer' AND name_th IS NULL;
UPDATE items SET name_th = 'สตราต้า เดวิล แฮมเมอร์ (อีเวนต์)' WHERE slug = 'strata-devil-hammer-event' AND name_th IS NULL;
UPDATE items SET name_th = 'คำสั่งทรราช แฮมเมอร์' WHERE slug = 'tyrants-order-hammer' AND name_th IS NULL;
UPDATE items SET name_th = 'คำสั่งทรราช แฮมเมอร์ (อีเวนต์)' WHERE slug = 'tyrants-order-hammer-event' AND name_th IS NULL;
UPDATE items SET name_th = 'วาเลรอน แฮมเมอร์' WHERE slug = 'valeron-hammer' AND name_th IS NULL;
UPDATE items SET name_th = 'วาเลรอน แฮมเมอร์ (อีเวนต์)' WHERE slug = 'valeron-hammer-event' AND name_th IS NULL;
UPDATE items SET name_th = 'สนับสนุนผู้บุกเบิกเวสปาโนลา แฮมเมอร์' WHERE slug = 'vespanola-pioneer-support-hammer' AND name_th IS NULL;
UPDATE items SET name_th = 'ค้อนงานไม้' WHERE slug = 'woodwork-hammer' AND name_th IS NULL;
UPDATE items SET name_th = '[อีเวนต์] เอเน็กซ์ อีเธอเรียล แฮมเมอร์' WHERE slug = 'event-enex-ethereal-hammer' AND name_th IS NULL;
UPDATE items SET name_th = 'อะบิส อาร์ม่า จาวลิน' WHERE slug = 'abyss-arma-javelin' AND name_th IS NULL;
UPDATE items SET name_th = 'อะบิส อาร์ม่า จาวลิน (อีเวนต์)' WHERE slug = 'abyss-arma-javelin-event' AND name_th IS NULL;
UPDATE items SET name_th = 'อะคลิสแห่งเกรแฮม' WHERE slug = 'aclys-of-graham' AND name_th IS NULL;
UPDATE items SET name_th = 'แองเจิล จาวลิน' WHERE slug = 'angel-javelin' AND name_th IS NULL;
UPDATE items SET name_th = 'อาร์โมเนีย จาวลิน (อีเวนต์)' WHERE slug = 'armonia-javelin-event' AND name_th IS NULL;
UPDATE items SET name_th = 'บริสเทีย จาวลิน' WHERE slug = 'bristia-javelin' AND name_th IS NULL;
UPDATE items SET name_th = 'ความคมชาร์ล็อตต์' WHERE slug = 'charlottes-sharpness' AND name_th IS NULL;
UPDATE items SET name_th = 'ความคมชาร์ล็อตต์ (อีเวนต์)' WHERE slug = 'charlottes-sharpness-event' AND name_th IS NULL;
UPDATE items SET name_th = 'เดอุส มาชิน่า จาวลิน' WHERE slug = 'deus-machina-javelin' AND name_th IS NULL;
UPDATE items SET name_th = 'เดอุส มาชิน่า จาวลิน (อีเวนต์)' WHERE slug = 'deus-machina-javelin-event' AND name_th IS NULL;
UPDATE items SET name_th = 'ดิไวน์ จาวลิน' WHERE slug = 'divine-javelin' AND name_th IS NULL;
UPDATE items SET name_th = 'เอล ฮุยซิโอ' WHERE slug = 'el-juicio' AND name_th IS NULL;
UPDATE items SET name_th = 'อีลิท บริสเทีย จาวลิน' WHERE slug = 'elite-bristia-javelin' AND name_th IS NULL;
UPDATE items SET name_th = 'อีลิท บริสเทีย จาวลิน (อีเวนต์)' WHERE slug = 'elite-bristia-javelin-event' AND name_th IS NULL;
-- SKIP: Elite Cortes (elite-cortes)
UPDATE items SET name_th = 'อีลิท เอล ฮุยซิโอ' WHERE slug = 'elite-el-juicio' AND name_th IS NULL;
UPDATE items SET name_th = 'อีลิท ทดลอง จาวลิน' WHERE slug = 'elite-experimental-javelin' AND name_th IS NULL;
UPDATE items SET name_th = 'อีลิท วิจารณญาณอันทาเรส' WHERE slug = 'elite-insight-of-antares' AND name_th IS NULL;
UPDATE items SET name_th = 'อีลิท วิจารณญาณอันทาเรส (อีเวนต์)' WHERE slug = 'elite-insight-of-antares-event' AND name_th IS NULL;
UPDATE items SET name_th = 'อีลิท มูเอร์ทัวร์ส จาวลิน' WHERE slug = 'elite-muertuors-javelin' AND name_th IS NULL;
-- SKIP: Elite Pizarro (elite-pizarro)
UPDATE items SET name_th = 'อีลิท Silver จาวลิน' WHERE slug = 'elite-silver-javelin' AND name_th IS NULL;
UPDATE items SET name_th = 'เอเน็กซ์ อีเธอเรียล จาวลิน' WHERE slug = 'enex-ethereal-javelin' AND name_th IS NULL;
UPDATE items SET name_th = 'อีเวนต์ อีลิท มูเอร์ทัวร์ส จาวลิน' WHERE slug = 'event-elite-muertuors-javelin' AND name_th IS NULL;
UPDATE items SET name_th = 'อีเวนต์ มูเอร์ทัวร์ส จาวลิน' WHERE slug = 'event-muertuors-javelin' AND name_th IS NULL;
UPDATE items SET name_th = 'อีวิล จาวลิน' WHERE slug = 'evil-javelin' AND name_th IS NULL;
UPDATE items SET name_th = 'ทดลอง จาวลิน' WHERE slug = 'experimental-javelin' AND name_th IS NULL;
UPDATE items SET name_th = 'ความคมชาร์ล็อตต์ไม่สมบูรณ์' WHERE slug = 'incomplete-charlottes-sharpness' AND name_th IS NULL;
UPDATE items SET name_th = 'วิจารณญาณอันทาเรส' WHERE slug = 'insight-of-antares' AND name_th IS NULL;
UPDATE items SET name_th = 'วิจารณญาณอันทาเรส (อีเวนต์)' WHERE slug = 'insight-of-antares-event' AND name_th IS NULL;
UPDATE items SET name_th = 'หยกแห่งความอดทน' WHERE slug = 'jade-of-patience' AND name_th IS NULL;
UPDATE items SET name_th = 'จาวลินสัญญา (7 วัน)' WHERE slug = 'javelin-of-contract-7-days' AND name_th IS NULL;
UPDATE items SET name_th = 'จาวลินแห่งหอคอย' WHERE slug = 'javelin-of-tower' AND name_th IS NULL;
UPDATE items SET name_th = 'ลีเจียน จาวลิน' WHERE slug = 'legion-javelin' AND name_th IS NULL;
UPDATE items SET name_th = 'มูเอร์ทัวร์ส จาวลิน' WHERE slug = 'muertuors-javelin' AND name_th IS NULL;
UPDATE items SET name_th = 'พรอสเป จาวลิน' WHERE slug = 'prospe-javelin' AND name_th IS NULL;
-- SKIP: Redlight Javeline (redlight-javeline)
-- SKIP: Refined Vespanola Javeline (refined-vespanola-javeline)
UPDATE items SET name_th = 'เซอร์เพนท์ จาวลิน' WHERE slug = 'serpent-javelin' AND name_th IS NULL;
UPDATE items SET name_th = 'สตราต้า เดวิล จาวลิน' WHERE slug = 'strata-devil-javelin' AND name_th IS NULL;
UPDATE items SET name_th = 'สตราต้า เดวิล จาวลิน (อีเวนต์)' WHERE slug = 'strata-devil-javelin-event' AND name_th IS NULL;
UPDATE items SET name_th = 'คำสั่งทรราช จาวลิน' WHERE slug = 'tyrants-order-javelin' AND name_th IS NULL;
UPDATE items SET name_th = 'คำสั่งทรราช จาวลิน (อีเวนต์)' WHERE slug = 'tyrants-order-javelin-event' AND name_th IS NULL;
UPDATE items SET name_th = 'วาเลรอน จาวลิน' WHERE slug = 'valeron-javelin' AND name_th IS NULL;
UPDATE items SET name_th = 'วาเลรอน จาวลิน (อีเวนต์)' WHERE slug = 'valeron-javelin-event' AND name_th IS NULL;
UPDATE items SET name_th = 'สนับสนุนผู้บุกเบิกเวสปาโนลา จาวลิน' WHERE slug = 'vespanola-pioneer-support-javelin' AND name_th IS NULL;
UPDATE items SET name_th = '[อีเวนต์] เอเน็กซ์ อีเธอเรียล จาวลิน' WHERE slug = 'event-enex-ethereal-javelin' AND name_th IS NULL;
UPDATE items SET name_th = 'อะบิส อาร์ม่า นัคเคิล' WHERE slug = 'abyss-arma-knuckle' AND name_th IS NULL;
UPDATE items SET name_th = 'อะบิส อาร์ม่า นัคเคิล (อีเวนต์)' WHERE slug = 'abyss-arma-knuckle-event' AND name_th IS NULL;
UPDATE items SET name_th = 'แองเจิล นัคเคิล' WHERE slug = 'angel-knuckle' AND name_th IS NULL;
UPDATE items SET name_th = 'อาร์โมเนีย นัคเคิล (อีเวนต์)' WHERE slug = 'armonia-knuckle-event' AND name_th IS NULL;
UPDATE items SET name_th = 'แอตลาส เฟโรซิตี้' WHERE slug = 'atlas-ferocity' AND name_th IS NULL;
UPDATE items SET name_th = 'แอตลาส เฟโรซิตี้ (อีเวนต์)' WHERE slug = 'atlas-ferocity-event' AND name_th IS NULL;
UPDATE items SET name_th = 'บริสเทีย นัคเคิล' WHERE slug = 'bristia-knuckle' AND name_th IS NULL;
UPDATE items SET name_th = 'นัคเคิลคาร์บอน' WHERE slug = 'carbon-knuckle' AND name_th IS NULL;
UPDATE items SET name_th = 'เดอุส มาชิน่า นัคเคิล' WHERE slug = 'deus-machina-knuckle' AND name_th IS NULL;
UPDATE items SET name_th = 'เดอุส มาชิน่า นัคเคิล (อีเวนต์)' WHERE slug = 'deus-machina-knuckle-event' AND name_th IS NULL;
UPDATE items SET name_th = 'ดิไวน์ นัคเคิล' WHERE slug = 'divine-knuckle' AND name_th IS NULL;
UPDATE items SET name_th = 'อีลิท บริสเทีย นัคเคิล' WHERE slug = 'elite-bristia-knuckle' AND name_th IS NULL;
UPDATE items SET name_th = 'อีลิท บริสเทีย นัคเคิล (อีเวนต์)' WHERE slug = 'elite-bristia-knuckle-event' AND name_th IS NULL;
UPDATE items SET name_th = 'อีลิท Earth นัคเคิล' WHERE slug = 'elite-earth-knuckle' AND name_th IS NULL;
UPDATE items SET name_th = 'อีลิท ทดลอง นัคเคิล' WHERE slug = 'elite-experimental-knuckle' AND name_th IS NULL;
-- SKIP: Elite Knuckle (elite-knuckle)
UPDATE items SET name_th = 'อีลิท ลา ลูน่า' WHERE slug = 'elite-la-luna' AND name_th IS NULL;
UPDATE items SET name_th = 'อีลิท มูเอร์ทัวร์ส นัคเคิล' WHERE slug = 'elite-muertuors-knuckle' AND name_th IS NULL;
UPDATE items SET name_th = 'อีลิท Phobitan นัคเคิล' WHERE slug = 'elite-phobitan-knuckle' AND name_th IS NULL;
-- SKIP: Elite Steel of Destruction (elite-steel-of-destruction)
UPDATE items SET name_th = 'อีลิท ปัญญาเจมิไน' WHERE slug = 'elite-wits-of-gemini' AND name_th IS NULL;
UPDATE items SET name_th = 'อีลิท ปัญญาเจมิไน (อีเวนต์)' WHERE slug = 'elite-wits-of-gemini-event' AND name_th IS NULL;
UPDATE items SET name_th = 'เอเน็กซ์ อีเธอเรียล นัคเคิล' WHERE slug = 'enex-ethereal-knuckle' AND name_th IS NULL;
UPDATE items SET name_th = 'อีเวนต์ อีลิท มูเอร์ทัวร์ส นัคเคิล' WHERE slug = 'event-elite-muertuors-knuckle' AND name_th IS NULL;
UPDATE items SET name_th = 'อีเวนต์ มูเอร์ทัวร์ส นัคเคิล' WHERE slug = 'event-muertuors-knuckle' AND name_th IS NULL;
UPDATE items SET name_th = 'อีวิล นัคเคิล' WHERE slug = 'evil-knuckle' AND name_th IS NULL;
UPDATE items SET name_th = 'ทดลอง นัคเคิล' WHERE slug = 'experimental-knuckle' AND name_th IS NULL;
UPDATE items SET name_th = 'งานเลี้ยงจักรพรรดิ' WHERE slug = 'feast-of-emperor' AND name_th IS NULL;
UPDATE items SET name_th = 'การ์เนตแห่งธรรมชาติ' WHERE slug = 'garnet-of-nature' AND name_th IS NULL;
UPDATE items SET name_th = 'หมัดทอง' WHERE slug = 'golden-fist' AND name_th IS NULL;
UPDATE items SET name_th = 'แอตลาส เฟโรซิตี้ไม่สมบูรณ์' WHERE slug = 'incomplete-atlas-ferocity' AND name_th IS NULL;
UPDATE items SET name_th = 'นัคเคิลสัญญา (7 วัน)' WHERE slug = 'knuckle-of-contract-7-days' AND name_th IS NULL;
UPDATE items SET name_th = 'นัคเคิลไรโอนู' WHERE slug = 'knuckle-of-raionu' AND name_th IS NULL;
UPDATE items SET name_th = 'นัคเคิลสรูทอส' WHERE slug = 'knuckle-of-srutoss' AND name_th IS NULL;
UPDATE items SET name_th = 'นัคเคิลเยติ' WHERE slug = 'knuckle-of-the-yeti' AND name_th IS NULL;
UPDATE items SET name_th = 'ลา ลูน่า' WHERE slug = 'la-luna' AND name_th IS NULL;
UPDATE items SET name_th = 'ลีเจียน นัคเคิล' WHERE slug = 'legion-knuckle' AND name_th IS NULL;
-- SKIP: Manaslight Knuckle (manaslight-knuckle)
UPDATE items SET name_th = 'มูเอร์ทัวร์ส นัคเคิล' WHERE slug = 'muertuors-knuckle' AND name_th IS NULL;
UPDATE items SET name_th = 'พรอสเป นัคเคิล' WHERE slug = 'prospe-knuckle' AND name_th IS NULL;
UPDATE items SET name_th = 'นัคเคิลสมอเรย์' WHERE slug = 'rays-anchor-knuckle' AND name_th IS NULL;
UPDATE items SET name_th = 'เวสปาโนลาขัดเงา นัคเคิล' WHERE slug = 'refined-vespanola-knuckle' AND name_th IS NULL;
UPDATE items SET name_th = 'สตราต้า เดวิล นัคเคิล' WHERE slug = 'strata-devil-knuckle' AND name_th IS NULL;
UPDATE items SET name_th = 'สตราต้า เดวิล นัคเคิล (อีเวนต์)' WHERE slug = 'strata-devil-knuckle-event' AND name_th IS NULL;
UPDATE items SET name_th = 'นัคเคิลแห่งสิ่งล่อลวง' WHERE slug = 'the-knuckle-of-temptation' AND name_th IS NULL;
UPDATE items SET name_th = 'คำสั่งทรราช นัคเคิล' WHERE slug = 'tyrants-order-knuckle' AND name_th IS NULL;
UPDATE items SET name_th = 'คำสั่งทรราช นัคเคิล (อีเวนต์)' WHERE slug = 'tyrants-order-knuckle-event' AND name_th IS NULL;
UPDATE items SET name_th = 'วาเลรอน นัคเคิล' WHERE slug = 'valeron-knuckle' AND name_th IS NULL;
UPDATE items SET name_th = 'วาเลรอน นัคเคิล (อีเวนต์)' WHERE slug = 'valeron-knuckle-event' AND name_th IS NULL;
UPDATE items SET name_th = 'สนับสนุนผู้บุกเบิกเวสปาโนลา นัคเคิล' WHERE slug = 'vespanola-pioneer-support-knuckle' AND name_th IS NULL;
UPDATE items SET name_th = 'ปัญญาเจมิไน' WHERE slug = 'wits-of-gemini' AND name_th IS NULL;
UPDATE items SET name_th = 'ปัญญาเจมิไน (อีเวนต์)' WHERE slug = 'wits-of-gemini-event' AND name_th IS NULL;
UPDATE items SET name_th = '[อีเวนต์] เอเน็กซ์ อีเธอเรียล นัคเคิล' WHERE slug = 'event-enex-ethereal-knuckle' AND name_th IS NULL;
UPDATE items SET name_th = 'อะบิส อาร์ม่า เมน-โกช' WHERE slug = 'abyss-arma-main-gauche' AND name_th IS NULL;
UPDATE items SET name_th = 'อะบิส อาร์ม่า เมน-โกช (อีเวนต์)' WHERE slug = 'abyss-arma-main-gauche-event' AND name_th IS NULL;
UPDATE items SET name_th = 'อาร์โมเนีย เมน-โกช (อีเวนต์)' WHERE slug = 'armonia-main-gauche-event' AND name_th IS NULL;
UPDATE items SET name_th = 'บริสเทีย เมน-โกช' WHERE slug = 'bristia-main-gauche' AND name_th IS NULL;
UPDATE items SET name_th = 'การจู่โจมชาร์ล็อตต์' WHERE slug = 'charlottes-raid' AND name_th IS NULL;
UPDATE items SET name_th = 'การจู่โจมชาร์ล็อตต์ (อีเวนต์)' WHERE slug = 'charlottes-raid-event' AND name_th IS NULL;
UPDATE items SET name_th = 'ดาก้าสมมาตร' WHERE slug = 'dagger-symmetric' AND name_th IS NULL;
UPDATE items SET name_th = 'ภาพลวงแห่งคาราส' WHERE slug = 'delusion-of-karas' AND name_th IS NULL;
UPDATE items SET name_th = 'ภาพลวงแห่งคาราส (อีเวนต์)' WHERE slug = 'delusion-of-karas-event' AND name_th IS NULL;
UPDATE items SET name_th = 'เดอุส มาชิน่า เมน-โกช' WHERE slug = 'deus-machina-main-gauche' AND name_th IS NULL;
UPDATE items SET name_th = 'เดอุส มาชิน่า เมน-โกช (อีเวนต์)' WHERE slug = 'deus-machina-main-gauche-event' AND name_th IS NULL;
UPDATE items SET name_th = 'ดิไวน์ เมน-โกช' WHERE slug = 'divine-main-gauche' AND name_th IS NULL;
UPDATE items SET name_th = 'อีลิท บริสเทีย เมน-โกช' WHERE slug = 'elite-bristia-main-gauche' AND name_th IS NULL;
UPDATE items SET name_th = 'อีลิท บริสเทีย เมน-โกช (อีเวนต์)' WHERE slug = 'elite-bristia-main-gauche-event' AND name_th IS NULL;
UPDATE items SET name_th = 'อีลิท ภาพลวงแห่งคาราส' WHERE slug = 'elite-delusion-of-karas' AND name_th IS NULL;
UPDATE items SET name_th = 'อีลิท ภาพลวงแห่งคาราส (อีเวนต์)' WHERE slug = 'elite-delusion-of-karas-event' AND name_th IS NULL;
UPDATE items SET name_th = 'อีลิท ทดลอง เมน-โกช' WHERE slug = 'elite-experimental-main-gauche' AND name_th IS NULL;
UPDATE items SET name_th = 'อีลิท ลา รูเอดา เดอ ลา ฟอร์ทูน่า' WHERE slug = 'elite-la-rueda-de-la-fortuna' AND name_th IS NULL;
-- SKIP: Elite Main-Gauche (elite-main-gauche)
-- SKIP: Elite Poignard (elite-poignard)
UPDATE items SET name_th = 'อีลิท Split ดาก้า' WHERE slug = 'elite-split-dagger' AND name_th IS NULL;
UPDATE items SET name_th = 'อีวิล เมน-โกช' WHERE slug = 'evil-main-gauche' AND name_th IS NULL;
UPDATE items SET name_th = 'ทดลอง เมน-โกช' WHERE slug = 'experimental-main-gauche' AND name_th IS NULL;
UPDATE items SET name_th = 'การจู่โจมชาร์ล็อตต์ไม่สมบูรณ์' WHERE slug = 'incomplete-charlottes-raid' AND name_th IS NULL;
UPDATE items SET name_th = 'ลา รูเอดา เดอ ลา ฟอร์ทูน่า' WHERE slug = 'la-rueda-de-la-fortuna' AND name_th IS NULL;
UPDATE items SET name_th = 'ลีเจียน เมน-โกช' WHERE slug = 'legion-main-gauche' AND name_th IS NULL;
UPDATE items SET name_th = 'เมน-โกชเยเกอร์' WHERE slug = 'main-gauche-of-yeager' AND name_th IS NULL;
UPDATE items SET name_th = 'เมน-โกชสัญญา (7 วัน)' WHERE slug = 'main-gauche-of-contract-7-days' AND name_th IS NULL;
UPDATE items SET name_th = 'พรอสเป เมน-โกช' WHERE slug = 'prospe-main-gauche' AND name_th IS NULL;
UPDATE items SET name_th = 'เวสปาโนลาขัดเงา เมน-โกช' WHERE slug = 'refined-vespanola-main-gauche' AND name_th IS NULL;
UPDATE items SET name_th = 'เซอร์เพนท์ เมน-โกช' WHERE slug = 'serpent-main-gauche' AND name_th IS NULL;
UPDATE items SET name_th = 'สตราต้า เดวิล เมน-โกช' WHERE slug = 'strata-devil-main-gauche' AND name_th IS NULL;
UPDATE items SET name_th = 'สตราต้า เดวิล เมน-โกช (อีเวนต์)' WHERE slug = 'strata-devil-main-gauche-event' AND name_th IS NULL;
UPDATE items SET name_th = 'ซอร์ดเบรคเกอร์' WHERE slug = 'sword-breaker' AND name_th IS NULL;
UPDATE items SET name_th = 'คำสั่งทรราช เมน-โกช' WHERE slug = 'tyrants-order-main-gauche' AND name_th IS NULL;
UPDATE items SET name_th = 'คำสั่งทรราช เมน-โกช (อีเวนต์)' WHERE slug = 'tyrants-order-main-gauche-event' AND name_th IS NULL;
UPDATE items SET name_th = 'วาเลรอน เมน-โกช' WHERE slug = 'valeron-main-gauche' AND name_th IS NULL;
UPDATE items SET name_th = 'วาเลรอน เมน-โกช (อีเวนต์)' WHERE slug = 'valeron-main-gauche-event' AND name_th IS NULL;
UPDATE items SET name_th = 'สนับสนุนผู้บุกเบิกเวสปาโนลา เมน-โกช' WHERE slug = 'vespanola-pioneer-support-main-gauche' AND name_th IS NULL;
UPDATE items SET name_th = 'อะบิส อาร์ม่า โปลอาร์ม' WHERE slug = 'abyss-arma-polearm' AND name_th IS NULL;
UPDATE items SET name_th = 'อะบิส อาร์ม่า โปลอาร์ม (อีเวนต์)' WHERE slug = 'abyss-arma-polearm-event' AND name_th IS NULL;
-- SKIP: Angel Hell Bird (angel-hell-bird)
UPDATE items SET name_th = 'อาร์โมเนีย โปลอาร์ม (อีเวนต์)' WHERE slug = 'armonia-polearm-event' AND name_th IS NULL;
-- SKIP: Beolight Polearm (beolight-polearm)
UPDATE items SET name_th = 'บริสเทีย โปลอาร์ม' WHERE slug = 'bristia-polearm' AND name_th IS NULL;
UPDATE items SET name_th = 'ความตายวิญญาณ' WHERE slug = 'death-of-wraith' AND name_th IS NULL;
UPDATE items SET name_th = 'เดอุส มาชิน่า โปลอาร์ม' WHERE slug = 'deus-machina-polearm' AND name_th IS NULL;
UPDATE items SET name_th = 'เดอุส มาชิน่า โปลอาร์ม (อีเวนต์)' WHERE slug = 'deus-machina-polearm-event' AND name_th IS NULL;
UPDATE items SET name_th = 'ดิไวน์ โปลอาร์ม' WHERE slug = 'divine-polearm' AND name_th IS NULL;
UPDATE items SET name_th = 'ดัลลาฮัน ฮาลเบิร์ด' WHERE slug = 'dullahan-halberd' AND name_th IS NULL;
-- SKIP: Einschiever War Hammer (einschiever-war-hammer)
-- SKIP: Elgoom Spear (elgoom-spear)
-- SKIP: Elite Beat of Steel (elite-beat-of-steel)
UPDATE items SET name_th = 'อีลิท บริสเทีย โปลอาร์ม' WHERE slug = 'elite-bristia-polearm' AND name_th IS NULL;
UPDATE items SET name_th = 'อีลิท บริสเทีย โปลอาร์ม (อีเวนต์)' WHERE slug = 'elite-bristia-polearm-event' AND name_th IS NULL;
-- SKIP: Elite Broinac (elite-broinac)
UPDATE items SET name_th = 'อีลิท ทดลอง โปลอาร์ม' WHERE slug = 'elite-experimental-polearm' AND name_th IS NULL;
-- SKIP: Elite Great Maul (elite-great-maul)
-- SKIP: Elite Guisarme (elite-guisarme)
-- SKIP: Elite Gungnir (elite-gungnir)
-- SKIP: Elite Harpoon (elite-harpoon)
UPDATE items SET name_th = 'อีลิท ลา มูเอร์เต้' WHERE slug = 'elite-la-muerte' AND name_th IS NULL;
UPDATE items SET name_th = 'อีลิท ภาวะผู้นำฮามาล' WHERE slug = 'elite-leadership-of-hamal' AND name_th IS NULL;
UPDATE items SET name_th = 'อีลิท ภาวะผู้นำฮามาล (อีเวนต์)' WHERE slug = 'elite-leadership-of-hamal-event' AND name_th IS NULL;
-- SKIP: Elite Muerte Balada (elite-muerte-balada)
UPDATE items SET name_th = 'อีลิท มูเอร์ทัวร์ส โปลอาร์ม' WHERE slug = 'elite-muertuors-polearm' AND name_th IS NULL;
-- SKIP: Elite Muses Gigantestar (elite-muses-gigantestar)
-- SKIP: Elite Muspellheim (elite-muspellheim)
-- SKIP: Elite Scythe (elite-scythe)
-- SKIP: Elite Spetum (elite-spetum)
UPDATE items SET name_th = 'เอเน็กซ์ อีเธอเรียล โปลอาร์ม' WHERE slug = 'enex-ethereal-polearm' AND name_th IS NULL;
UPDATE items SET name_th = 'อีเวนต์ อีลิท มูเอร์ทัวร์ส โปลอาร์ม' WHERE slug = 'event-elite-muertuors-polearm' AND name_th IS NULL;
UPDATE items SET name_th = 'อีเวนต์ มูเอร์ทัวร์ส โปลอาร์ม' WHERE slug = 'event-muertuors-polearm' AND name_th IS NULL;
UPDATE items SET name_th = 'อีวิล โปลอาร์ม' WHERE slug = 'evil-polearm' AND name_th IS NULL;
UPDATE items SET name_th = 'ทดลอง โปลอาร์ม' WHERE slug = 'experimental-polearm' AND name_th IS NULL;
UPDATE items SET name_th = 'ขวานด้ามยาวยักษ์' WHERE slug = 'gigantic-poleaxe' AND name_th IS NULL;
UPDATE items SET name_th = 'นักล่านรก' WHERE slug = 'hell-slayer' AND name_th IS NULL;
-- SKIP: Improved Brandistock (7 days) (improved-brandistock-7-days)
UPDATE items SET name_th = 'ความเกลียดชังออร์เดนไม่สมบูรณ์' WHERE slug = 'incomplete-ordens-hatred' AND name_th IS NULL;
UPDATE items SET name_th = 'ลา มูเอร์เต้' WHERE slug = 'la-muerte' AND name_th IS NULL;
UPDATE items SET name_th = 'ภาวะผู้นำฮามาล' WHERE slug = 'leadership-of-hamal' AND name_th IS NULL;
UPDATE items SET name_th = 'ภาวะผู้นำฮามาล (อีเวนต์)' WHERE slug = 'leadership-of-hamal-event' AND name_th IS NULL;
UPDATE items SET name_th = 'ลีเจียน โปลอาร์ม' WHERE slug = 'legion-polearm' AND name_th IS NULL;
UPDATE items SET name_th = 'มาลาไคท์แห่งความสูงส่ง' WHERE slug = 'malachite-of-sublimity' AND name_th IS NULL;
UPDATE items SET name_th = 'ขวานด้ามยาวมาร์เซีย' WHERE slug = 'marcia-pole-axe' AND name_th IS NULL;
UPDATE items SET name_th = 'มูเอร์ทัวร์ส โปลอาร์ม' WHERE slug = 'muertuors-polearm' AND name_th IS NULL;
-- SKIP: Ogre Pole-axe (ogre-pole-axe)
UPDATE items SET name_th = 'ความเกลียดชังออร์เดน' WHERE slug = 'ordens-hatred' AND name_th IS NULL;
UPDATE items SET name_th = 'ความเกลียดชังออร์เดน (อีเวนต์)' WHERE slug = 'ordens-hatred-event' AND name_th IS NULL;
UPDATE items SET name_th = 'โปลอาร์มสัญญา (7 วัน)' WHERE slug = 'polearm-of-contract-7-days' AND name_th IS NULL;
UPDATE items SET name_th = 'พรอสเป โปลอาร์ม' WHERE slug = 'prospe-polearm' AND name_th IS NULL;
UPDATE items SET name_th = 'เวสปาโนลาขัดเงา โปลอาร์ม' WHERE slug = 'refined-vespanola-polearm' AND name_th IS NULL;
-- SKIP: Serpent Spear (serpent-spear)
UPDATE items SET name_th = 'สตราต้า เดวิล โปลอาร์ม' WHERE slug = 'strata-devil-polearm' AND name_th IS NULL;
UPDATE items SET name_th = 'สตราต้า เดวิล โปลอาร์ม (อีเวนต์)' WHERE slug = 'strata-devil-polearm-event' AND name_th IS NULL;
UPDATE items SET name_th = 'ขวานแห่งมายา' WHERE slug = 'the-axe-of-lie' AND name_th IS NULL;
UPDATE items SET name_th = 'คำสั่งทรราช โปลอาร์ม' WHERE slug = 'tyrants-order-polearm' AND name_th IS NULL;
UPDATE items SET name_th = 'คำสั่งทรราช โปลอาร์ม (อีเวนต์)' WHERE slug = 'tyrants-order-polearm-event' AND name_th IS NULL;
UPDATE items SET name_th = 'วาเลรอน โปลอาร์ม' WHERE slug = 'valeron-polearm' AND name_th IS NULL;
UPDATE items SET name_th = 'วาเลรอน โปลอาร์ม (อีเวนต์)' WHERE slug = 'valeron-polearm-event' AND name_th IS NULL;
UPDATE items SET name_th = 'สนับสนุนผู้บุกเบิกเวสปาโนลา โปลอาร์ม' WHERE slug = 'vespanola-pioneer-support-polearm' AND name_th IS NULL;
-- SKIP: Werebear Morning Star (werebear-morning-star)
-- SKIP: Werebear Poleaxe (werebear-poleaxe)
UPDATE items SET name_th = '[อีเวนต์] เอเน็กซ์ อีเธอเรียล โปลอาร์ม' WHERE slug = 'event-enex-ethereal-polearm' AND name_th IS NULL;
UPDATE items SET name_th = 'อะบิส อาร์ม่า เรเปียร์' WHERE slug = 'abyss-arma-rapier' AND name_th IS NULL;
UPDATE items SET name_th = 'อะบิส อาร์ม่า เรเปียร์ (อีเวนต์)' WHERE slug = 'abyss-arma-rapier-event' AND name_th IS NULL;
UPDATE items SET name_th = 'แองเจิล เรเปียร์' WHERE slug = 'angel-rapier' AND name_th IS NULL;
UPDATE items SET name_th = 'อาร์โมเนีย เรเปียร์ (อีเวนต์)' WHERE slug = 'armonia-rapier-event' AND name_th IS NULL;
UPDATE items SET name_th = 'บริสเทีย เรเปียร์' WHERE slug = 'bristia-rapier' AND name_th IS NULL;
UPDATE items SET name_th = 'เดอุส มาชิน่า เรเปียร์' WHERE slug = 'deus-machina-rapier' AND name_th IS NULL;
UPDATE items SET name_th = 'เดอุส มาชิน่า เรเปียร์ (อีเวนต์)' WHERE slug = 'deus-machina-rapier-event' AND name_th IS NULL;
UPDATE items SET name_th = 'ดิไวน์ เรเปียร์' WHERE slug = 'divine-rapier' AND name_th IS NULL;
UPDATE items SET name_th = 'อีลิท บริสเทีย เรเปียร์' WHERE slug = 'elite-bristia-rapier' AND name_th IS NULL;
UPDATE items SET name_th = 'อีลิท บริสเทีย เรเปียร์ (อีเวนต์)' WHERE slug = 'elite-bristia-rapier-event' AND name_th IS NULL;
-- SKIP: Elite Calabrone (elite-calabrone)
-- SKIP: Elite Candlestick (elite-candlestick)
-- SKIP: Elite Epee (elite-epee)
UPDATE items SET name_th = 'อีลิท ทดลอง เรเปียร์' WHERE slug = 'elite-experimental-rapier' AND name_th IS NULL;
UPDATE items SET name_th = 'อีลิท ลา ทอร์เร' WHERE slug = 'elite-la-torre' AND name_th IS NULL;
UPDATE items SET name_th = 'อีลิท มูเอร์ทัวร์ส เรเปียร์' WHERE slug = 'elite-muertuors-rapier' AND name_th IS NULL;
-- SKIP: Elite Purity of Aldebara (Event) (elite-purity-of-aldebara-event)
UPDATE items SET name_th = 'อีลิท ความบริสุทธิ์อัลเดบาราน' WHERE slug = 'elite-purity-of-aldebaran' AND name_th IS NULL;
-- SKIP: Elite Rapier (elite-rapier)
UPDATE items SET name_th = 'เอเน็กซ์ อีเธอเรียล เรเปียร์' WHERE slug = 'enex-ethereal-rapier' AND name_th IS NULL;
UPDATE items SET name_th = 'อีเวนต์ อีลิท มูเอร์ทัวร์ส เรเปียร์' WHERE slug = 'event-elite-muertuors-rapier' AND name_th IS NULL;
UPDATE items SET name_th = 'อีเวนต์ มูเอร์ทัวร์ส เรเปียร์' WHERE slug = 'event-muertuors-rapier' AND name_th IS NULL;
UPDATE items SET name_th = 'อีวิล เรเปียร์' WHERE slug = 'evil-rapier' AND name_th IS NULL;
UPDATE items SET name_th = 'ทดลอง เรเปียร์' WHERE slug = 'experimental-rapier' AND name_th IS NULL;
UPDATE items SET name_th = 'ฟลูเรท์แห่งเชอร์ลี่' WHERE slug = 'fleuret-of-shirley' AND name_th IS NULL;
UPDATE items SET name_th = 'อีกลังช์น้ำแข็ง' WHERE slug = 'glacial-eglanche' AND name_th IS NULL;
UPDATE items SET name_th = 'กริม-ไวท์' WHERE slug = 'grim-wight' AND name_th IS NULL;
UPDATE items SET name_th = 'ถุยนรก' WHERE slug = 'hell-spit' AND name_th IS NULL;
UPDATE items SET name_th = 'ความบริสุทธิ์สเตลล่าไม่สมบูรณ์' WHERE slug = 'incomplete-stellas-purity' AND name_th IS NULL;
-- SKIP: Inglight Rapier (inglight-rapier)
UPDATE items SET name_th = 'แจสเปอร์แห่งความก้าวร้าว' WHERE slug = 'jasper-of-aggression' AND name_th IS NULL;
UPDATE items SET name_th = 'ลา ทอร์เร' WHERE slug = 'la-torre' AND name_th IS NULL;
UPDATE items SET name_th = 'ลีเจียน เรเปียร์' WHERE slug = 'legion-rapier' AND name_th IS NULL;
UPDATE items SET name_th = 'มูเอร์ทัวร์ส เรเปียร์' WHERE slug = 'muertuors-rapier' AND name_th IS NULL;
UPDATE items SET name_th = 'พรอสเป เรเปียร์' WHERE slug = 'prospe-rapier' AND name_th IS NULL;
UPDATE items SET name_th = 'ความบริสุทธิ์อัลเดบาราน' WHERE slug = 'purity-of-aldebaran' AND name_th IS NULL;
UPDATE items SET name_th = 'ความบริสุทธิ์อัลเดบาราน (อีเวนต์)' WHERE slug = 'purity-of-aldebaran-event' AND name_th IS NULL;
UPDATE items SET name_th = 'เรเปียร์สัญญา (7 วัน)' WHERE slug = 'rapier-of-contract-7-days' AND name_th IS NULL;
UPDATE items SET name_th = 'เรเปียร์มหาปุโรหิต' WHERE slug = 'rapier-of-highpriestess' AND name_th IS NULL;
UPDATE items SET name_th = 'เวสปาโนลาขัดเงา เรเปียร์' WHERE slug = 'refined-vespanola-rapier' AND name_th IS NULL;
UPDATE items SET name_th = 'ความบริสุทธิ์สเตลล่า' WHERE slug = 'stellas-purity' AND name_th IS NULL;
UPDATE items SET name_th = 'ความบริสุทธิ์สเตลล่า (อีเวนต์)' WHERE slug = 'stellas-purity-event' AND name_th IS NULL;
UPDATE items SET name_th = 'สตราต้า เดวิล เรเปียร์' WHERE slug = 'strata-devil-rapier' AND name_th IS NULL;
UPDATE items SET name_th = 'สตราต้า เดวิล เรเปียร์ (อีเวนต์)' WHERE slug = 'strata-devil-rapier-event' AND name_th IS NULL;
UPDATE items SET name_th = 'ดาบอัศวิน' WHERE slug = 'sword-of-knight' AND name_th IS NULL;
-- SKIP: The Elite Sabre of Rafael (the-elite-sabre-of-rafael)
UPDATE items SET name_th = 'เรเปียร์นักเลียนแบบ' WHERE slug = 'the-rapier-of-imitator' AND name_th IS NULL;
UPDATE items SET name_th = 'ตัวต่อ' WHERE slug = 'the-wasp' AND name_th IS NULL;
UPDATE items SET name_th = 'คำสั่งทรราช เรเปียร์' WHERE slug = 'tyrants-order-rapier' AND name_th IS NULL;
UPDATE items SET name_th = 'คำสั่งทรราช เรเปียร์ (อีเวนต์)' WHERE slug = 'tyrants-order-rapier-event' AND name_th IS NULL;
UPDATE items SET name_th = 'วาเลรอน เรเปียร์' WHERE slug = 'valeron-rapier' AND name_th IS NULL;
UPDATE items SET name_th = 'วาเลรอน เรเปียร์ (อีเวนต์)' WHERE slug = 'valeron-rapier-event' AND name_th IS NULL;
UPDATE items SET name_th = 'สนับสนุนผู้บุกเบิกเวสปาโนลา เรเปียร์' WHERE slug = 'vespanola-pioneer-support-rapier' AND name_th IS NULL;
UPDATE items SET name_th = '[อีเวนต์] เอเน็กซ์ อีเธอเรียล เรเปียร์' WHERE slug = 'event-enex-ethereal-rapier' AND name_th IS NULL;
UPDATE items SET name_th = 'อะบิส อาร์ม่า เซเบอร์ (อีเวนต์)' WHERE slug = 'abyss-arma-saber-event' AND name_th IS NULL;
UPDATE items SET name_th = 'อะบิส อาร์ม่า เซเบอร์' WHERE slug = 'abyss-arma-sabre' AND name_th IS NULL;
UPDATE items SET name_th = 'แองเจิล เซเบอร์' WHERE slug = 'angel-sabre' AND name_th IS NULL;
UPDATE items SET name_th = 'อาร์โมเนีย เซเบอร์ (อีเวนต์)' WHERE slug = 'armonia-sabre-event' AND name_th IS NULL;
UPDATE items SET name_th = 'แบร์เกลเมียร์' WHERE slug = 'bergelmir' AND name_th IS NULL;
UPDATE items SET name_th = 'โบเรียส' WHERE slug = 'boreas' AND name_th IS NULL;
UPDATE items SET name_th = 'บริสเทีย เซเบอร์' WHERE slug = 'bristia-sabre' AND name_th IS NULL;
UPDATE items SET name_th = 'ความปรารถนาชาร์ล็อตต์' WHERE slug = 'charlottes-passion' AND name_th IS NULL;
UPDATE items SET name_th = 'ความปรารถนาชาร์ล็อตต์ (อีเวนต์)' WHERE slug = 'charlottes-passion-event' AND name_th IS NULL;
UPDATE items SET name_th = 'เดอุส มาชิน่า เซเบอร์' WHERE slug = 'deus-machina-sabre' AND name_th IS NULL;
UPDATE items SET name_th = 'เดอุส มาชิน่า เซเบอร์ (อีเวนต์)' WHERE slug = 'deus-machina-sabre-event' AND name_th IS NULL;
UPDATE items SET name_th = 'ดิไวน์ เซเบอร์' WHERE slug = 'divine-sabre' AND name_th IS NULL;
UPDATE items SET name_th = 'เอล เอร์มิตาโน' WHERE slug = 'el-ermitano' AND name_th IS NULL;
-- SKIP: Elite Blade (elite-blade)
UPDATE items SET name_th = 'อีลิท บริสเทีย เซเบอร์ (อีเวนต์)' WHERE slug = 'elite-bristia-saber-event' AND name_th IS NULL;
UPDATE items SET name_th = 'อีลิท บริสเทีย เซเบอร์' WHERE slug = 'elite-bristia-sabre' AND name_th IS NULL;
-- SKIP: Elite Cutlass (elite-cutlass)
-- SKIP: Elite Dance of Steel (elite-dance-of-steel)
UPDATE items SET name_th = 'อีลิท เอล เอร์มิตาโน' WHERE slug = 'elite-el-ermitano' AND name_th IS NULL;
UPDATE items SET name_th = 'อีลิท ทดลอง แชมเชียร์' WHERE slug = 'elite-experimental-shamshir' AND name_th IS NULL;
UPDATE items SET name_th = 'อีลิท มูเอร์ทัวร์ส เซเบอร์' WHERE slug = 'elite-muertuors-sabre' AND name_th IS NULL;
-- SKIP: Elite Sabre (elite-sabre)
-- SKIP: Elite Sabre di Gavi (elite-sabre-di-gavi)
-- SKIP: Elite Shamshir (elite-shamshir)
-- SKIP: Elite Slicer (elite-slicer)
UPDATE items SET name_th = 'อีลิท เจตจำนงอะคูเบนส์' WHERE slug = 'elite-will-of-acubens' AND name_th IS NULL;
UPDATE items SET name_th = 'อีลิท เจตจำนงอะคูเบนส์ (อีเวนต์)' WHERE slug = 'elite-will-of-acubens-event' AND name_th IS NULL;
UPDATE items SET name_th = 'เอเน็กซ์ อีเธอเรียล เซเบอร์' WHERE slug = 'enex-ethereal-saber' AND name_th IS NULL;
-- SKIP: Eolhlight Sabre (eolhlight-sabre)
UPDATE items SET name_th = 'อีเวนต์ อีลิท มูเอร์ทัวร์ส เซเบอร์' WHERE slug = 'event-elite-muertuors-sabre' AND name_th IS NULL;
UPDATE items SET name_th = 'อีเวนต์ มูเอร์ทัวร์ส เซเบอร์' WHERE slug = 'event-muertuors-sabre' AND name_th IS NULL;
UPDATE items SET name_th = 'อีวิล เซเบอร์' WHERE slug = 'evil-sabre' AND name_th IS NULL;
UPDATE items SET name_th = 'ทดลอง แชมเชียร์' WHERE slug = 'experimental-shamshir' AND name_th IS NULL;
UPDATE items SET name_th = 'ดามัสกัสทอง' WHERE slug = 'golden-damascus' AND name_th IS NULL;
-- SKIP: Grear Gimmick of Scimitar (grear-gimmick-of-scimitar)
UPDATE items SET name_th = 'ความปรารถนาชาร์ล็อตต์ไม่สมบูรณ์' WHERE slug = 'incomplete-charlottes-passion' AND name_th IS NULL;
-- SKIP: Kobolt Bone Sabre (kobolt-bone-sabre)
UPDATE items SET name_th = 'ลีเจียน เซเบอร์' WHERE slug = 'legion-sabre' AND name_th IS NULL;
UPDATE items SET name_th = 'มาซามูเนะ' WHERE slug = 'masamune' AND name_th IS NULL;
UPDATE items SET name_th = 'มูเอร์ทัวร์ส เซเบอร์' WHERE slug = 'muertuors-sabre' AND name_th IS NULL;
UPDATE items SET name_th = 'ไนติงเกล' WHERE slug = 'nightingale' AND name_th IS NULL;
UPDATE items SET name_th = 'เพอริดอทแห่งการท้าทาย' WHERE slug = 'peridot-of-defiant' AND name_th IS NULL;
UPDATE items SET name_th = 'พรอสเป แชมเชียร์' WHERE slug = 'prospe-shamshir' AND name_th IS NULL;
UPDATE items SET name_th = 'เวสปาโนลาขัดเงา เซเบอร์' WHERE slug = 'refined-vespanola-sabre' AND name_th IS NULL;
UPDATE items SET name_th = 'เซเบอร์สัญญา (7 วัน)' WHERE slug = 'sabre-of-contract-7-days' AND name_th IS NULL;
UPDATE items SET name_th = 'เซเบอร์ปีศาจ' WHERE slug = 'sabre-of-devil' AND name_th IS NULL;
UPDATE items SET name_th = 'เซเบอร์ทหาร' WHERE slug = 'sabre-of-trooper' AND name_th IS NULL;
-- SKIP: Shamshir of Norris (shamshir-of-norris)
UPDATE items SET name_th = 'สตราต้า เดวิล เซเบอร์' WHERE slug = 'strata-devil-sabre' AND name_th IS NULL;
UPDATE items SET name_th = 'สตราต้า เดวิล เซเบอร์ (อีเวนต์)' WHERE slug = 'strata-devil-sabre-event' AND name_th IS NULL;
UPDATE items SET name_th = 'คำสั่งทรราช เซเบอร์' WHERE slug = 'tyrants-order-sabre' AND name_th IS NULL;
UPDATE items SET name_th = 'คำสั่งทรราช เซเบอร์ (อีเวนต์)' WHERE slug = 'tyrants-order-sabre-event' AND name_th IS NULL;
UPDATE items SET name_th = 'วาเลรอน เซเบอร์' WHERE slug = 'valeron-saber' AND name_th IS NULL;
UPDATE items SET name_th = 'วาเลรอน เซเบอร์ (อีเวนต์)' WHERE slug = 'valeron-saber-event' AND name_th IS NULL;
UPDATE items SET name_th = 'คมดาบแวมไพร์' WHERE slug = 'vampiric-edge' AND name_th IS NULL;
UPDATE items SET name_th = 'สนับสนุนผู้บุกเบิกเวสปาโนลา เซเบอร์' WHERE slug = 'vespanola-pioneer-support-sabre' AND name_th IS NULL;
UPDATE items SET name_th = 'เจตจำนงอะคูเบนส์' WHERE slug = 'will-of-acubens' AND name_th IS NULL;
UPDATE items SET name_th = 'เจตจำนงอะคูเบนส์ (อีเวนต์)' WHERE slug = 'will-of-acubens-event' AND name_th IS NULL;
UPDATE items SET name_th = '[อีเวนต์] เอเน็กซ์ อีเธอเรียล เซเบอร์' WHERE slug = 'event-enex-ethereal-saber' AND name_th IS NULL;
UPDATE items SET name_th = 'อะบิส อาร์ม่า ซอร์ด' WHERE slug = 'abyss-arma-sword' AND name_th IS NULL;
UPDATE items SET name_th = 'อะบิส อาร์ม่า ซอร์ด (อีเวนต์)' WHERE slug = 'abyss-arma-sword-event' AND name_th IS NULL;
UPDATE items SET name_th = 'เล่ห์เหลี่ยมอัลแทร์' WHERE slug = 'altairs-cunning' AND name_th IS NULL;
UPDATE items SET name_th = 'เล่ห์เหลี่ยมอัลแทร์ (อีเวนต์)' WHERE slug = 'altairs-cunning-event' AND name_th IS NULL;
UPDATE items SET name_th = 'ดาบอาร์โมเนียโบราณ' WHERE slug = 'ancient-armonia-sword' AND name_th IS NULL;
-- SKIP: Angel Blade (angel-blade)
UPDATE items SET name_th = 'อาร์โมเนีย ซอร์ด (อีเวนต์)' WHERE slug = 'armonia-sword-event' AND name_th IS NULL;
UPDATE items SET name_th = 'ใบมีดมอนต์กอเมอรี่' WHERE slug = 'blade-of-montgomery' AND name_th IS NULL;
UPDATE items SET name_th = 'บริสเทีย ซอร์ด' WHERE slug = 'bristia-sword' AND name_th IS NULL;
UPDATE items SET name_th = 'เดอุส มาชิน่า ซอร์ด' WHERE slug = 'deus-machina-sword' AND name_th IS NULL;
UPDATE items SET name_th = 'เดอุส มาชิน่า ซอร์ด (อีเวนต์)' WHERE slug = 'deus-machina-sword-event' AND name_th IS NULL;
UPDATE items SET name_th = 'ดิไวน์ ซอร์ด' WHERE slug = 'divine-sword' AND name_th IS NULL;
-- SKIP: Dullahan Claymore (dullahan-claymore)
-- SKIP: Dullahan Sword (dullahan-sword)
-- SKIP: Einaptor Sword (einaptor-sword)
-- SKIP: Elbrid Sword (elbrid-sword)
UPDATE items SET name_th = 'อีลิท เล่ห์เหลี่ยมอัลแทร์' WHERE slug = 'elite-altairs-cunning' AND name_th IS NULL;
UPDATE items SET name_th = 'อีลิท เล่ห์เหลี่ยมอัลแทร์ (อีเวนต์)' WHERE slug = 'elite-altairs-cunning-event' AND name_th IS NULL;
-- SKIP: Elite Arondight (elite-arondight)
UPDATE items SET name_th = 'อีลิท บริสเทีย ซอร์ด' WHERE slug = 'elite-bristia-sword' AND name_th IS NULL;
UPDATE items SET name_th = 'อีลิท บริสเทีย ซอร์ด (อีเวนต์)' WHERE slug = 'elite-bristia-sword-event' AND name_th IS NULL;
-- SKIP: Elite Durandal (elite-durandal)
UPDATE items SET name_th = 'อีลิท ทดลอง ซอร์ด' WHERE slug = 'elite-experimental-sword' AND name_th IS NULL;
-- SKIP: Elite Grim-Wraith (elite-grim-wraith)
-- SKIP: Elite Katzbalger (elite-katzbalger)
UPDATE items SET name_th = 'อีลิท ลา เอ็มเปราดอร์' WHERE slug = 'elite-la-emperador' AND name_th IS NULL;
UPDATE items SET name_th = 'อีลิท Long ซอร์ด' WHERE slug = 'elite-long-sword' AND name_th IS NULL;
UPDATE items SET name_th = 'อีลิท มูเอร์ทัวร์ส ซอร์ด' WHERE slug = 'elite-muertuors-sword' AND name_th IS NULL;
-- SKIP: Elite Penetrator (elite-penetrator)
UPDATE items SET name_th = 'อีลิท Schvarlier ซอร์ด' WHERE slug = 'elite-schvarlier-sword' AND name_th IS NULL;
-- SKIP: Elite Soul of Steel (elite-soul-of-steel)
UPDATE items SET name_th = 'เอเน็กซ์ อีเธอเรียล ซอร์ด' WHERE slug = 'enex-ethereal-sword' AND name_th IS NULL;
UPDATE items SET name_th = 'อีเวนต์ อีลิท มูเอร์ทัวร์ส ซอร์ด' WHERE slug = 'event-elite-muertuors-sword' AND name_th IS NULL;
UPDATE items SET name_th = 'อีเวนต์ มูเอร์ทัวร์ส ซอร์ด' WHERE slug = 'event-muertuors-sword' AND name_th IS NULL;
UPDATE items SET name_th = 'อีวิล ซอร์ด' WHERE slug = 'evil-sword' AND name_th IS NULL;
UPDATE items SET name_th = 'ทดลอง ซอร์ด' WHERE slug = 'experimental-sword' AND name_th IS NULL;
-- SKIP: Geobolight Blade (geobolight-blade)
UPDATE items SET name_th = 'นรกเลือด' WHERE slug = 'hell-bleed' AND name_th IS NULL;
UPDATE items SET name_th = 'ความกล้าหาญสเตลล่าไม่สมบูรณ์' WHERE slug = 'incomplete-stellas-valor' AND name_th IS NULL;
UPDATE items SET name_th = 'ใบมีดจอมปลอม' WHERE slug = 'insincere-blade' AND name_th IS NULL;
UPDATE items SET name_th = 'โคบอลท์ ซอร์ด' WHERE slug = 'kobolt-sword' AND name_th IS NULL;
UPDATE items SET name_th = 'ลา เอ็มเปราดอร์' WHERE slug = 'la-emperador' AND name_th IS NULL;
UPDATE items SET name_th = 'ลีเจียน ซอร์ด' WHERE slug = 'legion-sword' AND name_th IS NULL;
UPDATE items SET name_th = 'มูเอร์ทัวร์ส ซอร์ด' WHERE slug = 'muertuors-sword' AND name_th IS NULL;
-- SKIP: Ogre Blade (ogre-blade)
UPDATE items SET name_th = 'อ็อกร์ ซอร์ด' WHERE slug = 'ogre-sword' AND name_th IS NULL;
UPDATE items SET name_th = 'พรอสเป ซอร์ด' WHERE slug = 'prospe-sword' AND name_th IS NULL;
UPDATE items SET name_th = 'เวสปาโนลาขัดเงา ซอร์ด' WHERE slug = 'refined-vespanola-sword' AND name_th IS NULL;
UPDATE items SET name_th = 'ชะตาคนเขลา' WHERE slug = 'sort-of-fool' AND name_th IS NULL;
-- SKIP: Spinel of Sharpness (spinel-of-sharpness)
UPDATE items SET name_th = 'วิญญาณวัลคีรี่อีลิท' WHERE slug = 'spirit-of-elite-valkyries' AND name_th IS NULL;
UPDATE items SET name_th = 'ความกล้าหาญสเตลล่า' WHERE slug = 'stellas-valor' AND name_th IS NULL;
UPDATE items SET name_th = 'ความกล้าหาญสเตลล่า (อีเวนต์)' WHERE slug = 'stellas-valor-event' AND name_th IS NULL;
UPDATE items SET name_th = 'สตราต้า เดวิล ซอร์ด' WHERE slug = 'strata-devil-sword' AND name_th IS NULL;
UPDATE items SET name_th = 'สตราต้า เดวิล ซอร์ด (อีเวนต์)' WHERE slug = 'strata-devil-sword-event' AND name_th IS NULL;
UPDATE items SET name_th = 'ซอร์ดสัญญา (7 วัน)' WHERE slug = 'sword-of-contract-7-days' AND name_th IS NULL;
UPDATE items SET name_th = 'ดาบจักรวรรดิ' WHERE slug = 'sword-of-empire' AND name_th IS NULL;
UPDATE items SET name_th = 'ดาบเอ็กซ์มาชิน่า' WHERE slug = 'sword-of-exmachina' AND name_th IS NULL;
UPDATE items SET name_th = 'ดาบราชินี' WHERE slug = 'sword-of-the-queen' AND name_th IS NULL;
UPDATE items SET name_th = 'กริม-เรธ' WHERE slug = 'the-grim-wraith' AND name_th IS NULL;
UPDATE items SET name_th = 'คำสั่งทรราช ซอร์ด' WHERE slug = 'tyrants-order-sword' AND name_th IS NULL;
UPDATE items SET name_th = 'คำสั่งทรราช ซอร์ด (อีเวนต์)' WHERE slug = 'tyrants-order-sword-event' AND name_th IS NULL;
UPDATE items SET name_th = 'วาเลรอน ซอร์ด' WHERE slug = 'valeron-sword' AND name_th IS NULL;
UPDATE items SET name_th = 'วาเลรอน ซอร์ด (อีเวนต์)' WHERE slug = 'valeron-sword-event' AND name_th IS NULL;
UPDATE items SET name_th = 'สนับสนุนผู้บุกเบิกเวสปาโนลา ซอร์ด' WHERE slug = 'vespanola-pioneer-support-sword' AND name_th IS NULL;
UPDATE items SET name_th = 'แวร์วูล์ฟ ซอร์ด' WHERE slug = 'werewolf-sword' AND name_th IS NULL;
UPDATE items SET name_th = '[อีเวนต์] เอเน็กซ์ อีเธอเรียล ซอร์ด' WHERE slug = 'event-enex-ethereal-sword' AND name_th IS NULL;
UPDATE items SET name_th = 'อะบิส อาร์ม่า ตันฟา' WHERE slug = 'abyss-arma-tonfa' AND name_th IS NULL;
UPDATE items SET name_th = 'อะบิส อาร์ม่า ตันฟา (อีเวนต์)' WHERE slug = 'abyss-arma-tonfa-event' AND name_th IS NULL;
UPDATE items SET name_th = 'อาร์โมเนีย ตันฟา (อีเวนต์)' WHERE slug = 'armonia-tonfa-event' AND name_th IS NULL;
UPDATE items SET name_th = 'บริสเทีย ตันฟา' WHERE slug = 'bristia-tonfa' AND name_th IS NULL;
UPDATE items SET name_th = 'เดอุส มาชิน่า ตันฟา' WHERE slug = 'deus-machina-tonfa' AND name_th IS NULL;
UPDATE items SET name_th = 'เดอุส มาชิน่า ตันฟา (อีเวนต์)' WHERE slug = 'deus-machina-tonfa-event' AND name_th IS NULL;
UPDATE items SET name_th = 'ดิไวน์ ตันฟา' WHERE slug = 'divine-tonfa' AND name_th IS NULL;
UPDATE items SET name_th = 'อีลิท บริสเทีย ตันฟา' WHERE slug = 'elite-bristia-tonfa' AND name_th IS NULL;
UPDATE items SET name_th = 'อีลิท บริสเทีย ตันฟา (อีเวนต์)' WHERE slug = 'elite-bristia-tonfa-event' AND name_th IS NULL;
UPDATE items SET name_th = 'อีลิท ทดลอง ตันฟา' WHERE slug = 'elite-experimental-tonfa' AND name_th IS NULL;
UPDATE items SET name_th = 'อีลิท มูเอร์ทัวร์ส ตันฟา' WHERE slug = 'elite-muertuors-tonfa' AND name_th IS NULL;
UPDATE items SET name_th = 'อีลิท นาอิแอดส์' WHERE slug = 'elite-naiads' AND name_th IS NULL;
UPDATE items SET name_th = 'อีลิท นาอิแอดส์ (อีเวนต์)' WHERE slug = 'elite-naiads-event' AND name_th IS NULL;
UPDATE items SET name_th = 'เอเน็กซ์ อีเธอเรียล ตันฟา' WHERE slug = 'enex-ethereal-tonfa' AND name_th IS NULL;
UPDATE items SET name_th = 'อีเวนต์ อีลิท มูเอร์ทัวร์ส ตันฟา' WHERE slug = 'event-elite-muertuors-tonfa' AND name_th IS NULL;
UPDATE items SET name_th = 'อีเวนต์ มูเอร์ทัวร์ส ตันฟา' WHERE slug = 'event-muertuors-tonfa' AND name_th IS NULL;
UPDATE items SET name_th = 'อีวิล ตันฟา' WHERE slug = 'evil-tonfa' AND name_th IS NULL;
UPDATE items SET name_th = 'ทดลอง ตันฟา' WHERE slug = 'experimental-tonfa' AND name_th IS NULL;
UPDATE items SET name_th = 'หลงลืมออร์เดนไม่สมบูรณ์' WHERE slug = 'incomplete-ordens-oblivion' AND name_th IS NULL;
UPDATE items SET name_th = 'ลีเจียน ตันฟา' WHERE slug = 'legion-tonfa' AND name_th IS NULL;
UPDATE items SET name_th = 'มูเอร์ทัวร์ส ตันฟา' WHERE slug = 'muertuors-tonfa' AND name_th IS NULL;
UPDATE items SET name_th = 'นาอิแอดส์' WHERE slug = 'naiads' AND name_th IS NULL;
UPDATE items SET name_th = 'นาอิแอดส์ (อีเวนต์)' WHERE slug = 'naiads-event' AND name_th IS NULL;
UPDATE items SET name_th = 'โนเช่ ฟริจิด' WHERE slug = 'noche-frigid' AND name_th IS NULL;
UPDATE items SET name_th = 'หลงลืมออร์เดน' WHERE slug = 'ordens-oblivion' AND name_th IS NULL;
UPDATE items SET name_th = 'หลงลืมออร์เดน (อีเวนต์)' WHERE slug = 'ordens-oblivion-event' AND name_th IS NULL;
UPDATE items SET name_th = 'พรอสเป ตันฟา' WHERE slug = 'prospe-tonfa' AND name_th IS NULL;
UPDATE items SET name_th = 'เวสปาโนลาขัดเงา ตันฟา' WHERE slug = 'refined-vespanola-tonfa' AND name_th IS NULL;
UPDATE items SET name_th = 'สตราต้า เดวิล ตันฟา' WHERE slug = 'strata-devil-tonfa' AND name_th IS NULL;
UPDATE items SET name_th = 'สตราต้า เดวิล ตันฟา (อีเวนต์)' WHERE slug = 'strata-devil-tonfa-event' AND name_th IS NULL;
UPDATE items SET name_th = 'ตันฟาแห่งความพิโรธ' WHERE slug = 'the-tonfa-of-wrath' AND name_th IS NULL;
UPDATE items SET name_th = 'ตันฟาสัญญา (7 วัน)' WHERE slug = 'tonfa-of-contract-7-days' AND name_th IS NULL;
UPDATE items SET name_th = 'คำสั่งทรราช ตันฟา' WHERE slug = 'tyrants-order-tonfa' AND name_th IS NULL;
UPDATE items SET name_th = 'คำสั่งทรราช ตันฟา (อีเวนต์)' WHERE slug = 'tyrants-order-tonfa-event' AND name_th IS NULL;
-- SKIP: Urlight tonfa (urlight-tonfa)
UPDATE items SET name_th = 'วาเลรอน ตันฟา' WHERE slug = 'valeron-tonfa' AND name_th IS NULL;
UPDATE items SET name_th = 'วาเลรอน ตันฟา (อีเวนต์)' WHERE slug = 'valeron-tonfa-event' AND name_th IS NULL;
UPDATE items SET name_th = 'สนับสนุนผู้บุกเบิกเวสปาโนลา ตันฟา' WHERE slug = 'vespanola-pioneer-support-tonfa' AND name_th IS NULL;
UPDATE items SET name_th = 'เปลวสงคราม' WHERE slug = 'war-prominence' AND name_th IS NULL;
UPDATE items SET name_th = '[อีเวนต์] เอเน็กซ์ อีเธอเรียล ตันฟา' WHERE slug = 'event-enex-ethereal-tonfa' AND name_th IS NULL;