-- Migration 051: Thai names for melee weapons
-- Generated: 2026-03-16T03:31:56.837Z

UPDATE items SET name_th = 'อะบิส อาร์ม่า แคนนอน' WHERE slug = 'abyss-arma-cannon' AND name_th IS NULL;
UPDATE items SET name_th = 'อะบิส อาร์ม่า แคนนอน (อีเวนต์)' WHERE slug = 'abyss-arma-cannon-event' AND name_th IS NULL;
-- SKIP: Agate of Blast | cannon (agate-of-blast)
UPDATE items SET name_th = 'แคนนอนแองเจิล' WHERE slug = 'angel-cannon' AND name_th IS NULL;
UPDATE items SET name_th = 'อาร์โมเนีย แคนนอน (อีเวนต์)' WHERE slug = 'armonia-cannon-event' AND name_th IS NULL;
UPDATE items SET name_th = 'บริสเทีย แคนนอน' WHERE slug = 'bristia-cannon' AND name_th IS NULL;
-- SKIP: Cannon of Chariot | cannon (cannon-of-chariot)
UPDATE items SET name_th = 'แคนนอนสัญญา (7 วัน)' WHERE slug = 'cannon-of-contract-7-days' AND name_th IS NULL;
-- SKIP: Conqueror Cannon | cannon (conqueror-cannon)
-- SKIP: Crowood Recker | cannon (crowood-recker)
UPDATE items SET name_th = 'เดอุส มาชิน่า แคนนอน' WHERE slug = 'deus-machina-cannon' AND name_th IS NULL;
UPDATE items SET name_th = 'เดอุส มาชิน่า แคนนอน (อีเวนต์)' WHERE slug = 'deus-machina-cannon-event' AND name_th IS NULL;
UPDATE items SET name_th = 'ดิไวน์ แคนนอน' WHERE slug = 'divine-cannon' AND name_th IS NULL;
-- SKIP: El Carro | cannon (el-carro)
UPDATE items SET name_th = 'อีลิท Automatic แคนนอน' WHERE slug = 'elite-automatic-cannon' AND name_th IS NULL;
UPDATE items SET name_th = 'อีลิท บริสเทีย แคนนอน' WHERE slug = 'elite-bristia-cannon' AND name_th IS NULL;
UPDATE items SET name_th = 'อีลิท บริสเทีย แคนนอน (อีเวนต์)' WHERE slug = 'elite-bristia-cannon-event' AND name_th IS NULL;
-- SKIP: Elite El Carro | cannon (elite-el-carro)
UPDATE items SET name_th = 'อีลิท ทดลอง แคนนอน' WHERE slug = 'elite-experimental-cannon' AND name_th IS NULL;
UPDATE items SET name_th = 'อีลิท มูเอร์ทัวร์ส แคนนอน' WHERE slug = 'elite-muertuors-cannon' AND name_th IS NULL;
-- SKIP: Elite Peacemaker | cannon (elite-peacemaker)
UPDATE items SET name_th = 'อีลิท Recoilless แคนนอน' WHERE slug = 'elite-recoilless-cannon' AND name_th IS NULL;
-- SKIP: Elite Relief of Deneb | cannon (elite-relief-of-deneb)
-- SKIP: Elite Relief of Deneb (Event) | cannon (elite-relief-of-deneb-event)
UPDATE items SET name_th = 'เอเน็กซ์ อีเธอเรียล แคนนอน' WHERE slug = 'enex-ethereal-cannon' AND name_th IS NULL;
UPDATE items SET name_th = 'อีเวนต์ อีลิท มูเอร์ทัวร์ส แคนนอน' WHERE slug = 'event-elite-muertuors-cannon' AND name_th IS NULL;
UPDATE items SET name_th = 'อีเวนต์ มูเอร์ทัวร์ส แคนนอน' WHERE slug = 'event-muertuors-cannon' AND name_th IS NULL;
UPDATE items SET name_th = 'อีวิล แคนนอน' WHERE slug = 'evil-cannon' AND name_th IS NULL;
UPDATE items SET name_th = 'ทดลอง แคนนอน' WHERE slug = 'experimental-cannon' AND name_th IS NULL;
-- SKIP: Florence en Lamina | cannon (florence-en-lamina)
-- SKIP: Incomplete Stellas Enthusiasm | cannon (incomplete-stellas-enthusiasm)
UPDATE items SET name_th = 'ลีเจียน แคนนอน' WHERE slug = 'legion-cannon' AND name_th IS NULL;
UPDATE items SET name_th = 'มูเอร์ทัวร์ส แคนนอน' WHERE slug = 'muertuors-cannon' AND name_th IS NULL;
UPDATE items SET name_th = 'พรอสเป แคนนอน' WHERE slug = 'prospe-cannon' AND name_th IS NULL;
UPDATE items SET name_th = 'เวสปาโนลาขัดเงา แคนนอน' WHERE slug = 'refined-vespanola-cannon' AND name_th IS NULL;
-- SKIP: Relief of Deneb | cannon (relief-of-deneb)
-- SKIP: Relief of Deneb (Event) | cannon (relief-of-deneb-event)
UPDATE items SET name_th = 'เซอร์เพนท์ แคนนอน' WHERE slug = 'serpent-cannon' AND name_th IS NULL;
-- SKIP: Stellas Enthusiasm | cannon (stellas-enthusiasm)
-- SKIP: Stellas Enthusiasm (Event) | cannon (stellas-enthusiasm-event)
UPDATE items SET name_th = 'สตราต้า เดวิล แคนนอน' WHERE slug = 'strata-devil-cannon' AND name_th IS NULL;
UPDATE items SET name_th = 'สตราต้า เดวิล แคนนอน (อีเวนต์)' WHERE slug = 'strata-devil-cannon-event' AND name_th IS NULL;
-- SKIP: The Canon of Detractor | cannon (the-canon-of-detractor)
UPDATE items SET name_th = 'คำสั่งทรราช แคนนอน' WHERE slug = 'tyrants-order-cannon' AND name_th IS NULL;
UPDATE items SET name_th = 'คำสั่งทรราช แคนนอน (อีเวนต์)' WHERE slug = 'tyrants-order-cannon-event' AND name_th IS NULL;
UPDATE items SET name_th = 'วาเลรอน แคนนอน' WHERE slug = 'valeron-cannon' AND name_th IS NULL;
UPDATE items SET name_th = 'วาเลรอน แคนนอน (อีเวนต์)' WHERE slug = 'valeron-cannon-event' AND name_th IS NULL;
UPDATE items SET name_th = 'สนับสนุนผู้บุกเบิกเวสปาโนลา แคนนอน' WHERE slug = 'vespanola-pioneer-support-cannon' AND name_th IS NULL;
UPDATE items SET name_th = 'แวร์แบร์ แคนนอน' WHERE slug = 'werebear-cannon' AND name_th IS NULL;
UPDATE items SET name_th = '[อีเวนต์] เอเน็กซ์ อีเธอเรียล แคนนอน' WHERE slug = 'event-enex-ethereal-cannon' AND name_th IS NULL;
-- SKIP: Abyss Arma Controller | controller (abyss-arma-controller)
-- SKIP: Abyss Arma Controller (Event) | controller (abyss-arma-controller-event)
-- SKIP: Controller of Contract (7 Days) | controller (controller-of-contract-7-days)
-- SKIP: Deus Machina Controller | controller (deus-machina-controller)
-- SKIP: Deus Machina Controller (Event) | controller (deus-machina-controller-event)
-- SKIP: Elegant Controller | controller (elegant-controller)
-- SKIP: Elite Experimental Controller | controller (elite-experimental-controller)
-- SKIP: Enex Ethereal Controller | controller (enex-ethereal-controller)
-- SKIP: Experimental Controller | controller (experimental-controller)
-- SKIP: Heavenly Marionette | controller (heavenly-marionette)
-- SKIP: Heavenly Marionette (Event) | controller (heavenly-marionette-event)
-- SKIP: High Quality Silver Controller | controller (high-quality-silver-controller)
-- SKIP: Incomplete Stellas Nobility | controller (incomplete-stellas-nobility)
-- SKIP: Legion Controller | controller (legion-controller)
-- SKIP: Platinum Controller | controller (platinum-controller)
-- SKIP: Prospe Controller | controller (prospe-controller)
-- SKIP: Refined Vespanola Controller | controller (refined-vespanola-controller)
-- SKIP: Silver Controller: Attack | controller (silver-controller-attack)
-- SKIP: Silver Controller: Defense | controller (silver-controller-defense)
-- SKIP: Silver Light Controller | controller (silver-light-controller)
-- SKIP: Stellas Nobility | controller (stellas-nobility)
-- SKIP: Stellas Nobility (Event) | controller (stellas-nobility-event)
-- SKIP: Strata Devil Controller | controller (strata-devil-controller)
-- SKIP: Strata Devil Controller (Event) | controller (strata-devil-controller-event)
-- SKIP: Tyrants Order Controller | controller (tyrants-order-controller)
-- SKIP: Tyrants Order Controller (Event) | controller (tyrants-order-controller-event)
-- SKIP: Valeron Controller | controller (valeron-controller)
-- SKIP: Valeron Controller (Event) | controller (valeron-controller-event)
-- SKIP: Vespanola Pioneer Support Controller | controller (vespanola-pioneer-support-controller)
-- SKIP: Wooden Controller | controller (wooden-controller)
-- SKIP: [Event] Enex Ethereal Controller | controller (event-enex-ethereal-controller)
UPDATE items SET name_th = 'อะบิส อาร์ม่า โครสโบว์' WHERE slug = 'abyss-arma-crossbow' AND name_th IS NULL;
UPDATE items SET name_th = 'อะบิส อาร์ม่า โครสโบว์ (อีเวนต์)' WHERE slug = 'abyss-arma-crossbow-event' AND name_th IS NULL;
-- SKIP: Accuracy of Pegasus | crossbow (accuracy-of-pegasus)
-- SKIP: Accuracy of Pegasus (Event) | crossbow (accuracy-of-pegasus-event)
UPDATE items SET name_th = 'โครสโบว์แองเจิล' WHERE slug = 'angel-crossbow' AND name_th IS NULL;
UPDATE items SET name_th = 'อาร์โมเนีย โครสโบว์ (อีเวนต์)' WHERE slug = 'armonia-crossbow-event' AND name_th IS NULL;
UPDATE items SET name_th = 'บริสเทีย โครสโบว์' WHERE slug = 'bristia-crossbow' AND name_th IS NULL;
-- SKIP: Crossbow of Ashley | crossbow (crossbow-of-ashley)
UPDATE items SET name_th = 'โครสโบว์สัญญา (7 วัน)' WHERE slug = 'crossbow-of-contract-7-days' AND name_th IS NULL;
-- SKIP: Crossbow of Temperance | crossbow (crossbow-of-temperance)
UPDATE items SET name_th = 'เดอุส มาชิน่า โครสโบว์' WHERE slug = 'deus-machina-crossbow' AND name_th IS NULL;
UPDATE items SET name_th = 'เดอุส มาชิน่า โครสโบว์ (อีเวนต์)' WHERE slug = 'deus-machina-crossbow-event' AND name_th IS NULL;
UPDATE items SET name_th = 'ดิไวน์ โครสโบว์' WHERE slug = 'divine-crossbow' AND name_th IS NULL;
-- SKIP: El Loco | crossbow (el-loco)
-- SKIP: Elite Accuracy of Pegasus | crossbow (elite-accuracy-of-pegasus)
-- SKIP: Elite Accuracy of Pegasus (Event) | crossbow (elite-accuracy-of-pegasus-event)
UPDATE items SET name_th = 'อีลิท Battle โครสโบว์' WHERE slug = 'elite-battle-crossbow' AND name_th IS NULL;
UPDATE items SET name_th = 'อีลิท บริสเทีย โครสโบว์' WHERE slug = 'elite-bristia-crossbow' AND name_th IS NULL;
UPDATE items SET name_th = 'อีลิท บริสเทีย โครสโบว์ (อีเวนต์)' WHERE slug = 'elite-bristia-crossbow-event' AND name_th IS NULL;
-- SKIP: Elite Crossbow | crossbow (elite-crossbow)
-- SKIP: Elite El Loco | crossbow (elite-el-loco)
UPDATE items SET name_th = 'อีลิท ทดลอง โครสโบว์' WHERE slug = 'elite-experimental-crossbow' AND name_th IS NULL;
-- SKIP: Elite Muertuors CrossBow | crossbow (elite-muertuors-crossbow)
UPDATE items SET name_th = 'อีลิท Silver โครสโบว์' WHERE slug = 'elite-silver-crossbow' AND name_th IS NULL;
UPDATE items SET name_th = 'เอเน็กซ์ อีเธอเรียล โครสโบว์' WHERE slug = 'enex-ethereal-crossbow' AND name_th IS NULL;
-- SKIP: Event Elite Muertuors CrossBow | crossbow (event-elite-muertuors-crossbow)
-- SKIP: Event Muertuors CrossBow | crossbow (event-muertuors-crossbow)
UPDATE items SET name_th = 'อีวิล โครสโบว์' WHERE slug = 'evil-crossbow' AND name_th IS NULL;
UPDATE items SET name_th = 'ทดลอง โครสโบว์' WHERE slug = 'experimental-crossbow' AND name_th IS NULL;
-- SKIP: Incomplete Ordens Dedication | crossbow (incomplete-ordens-dedication)
UPDATE items SET name_th = 'ลีเจียน โครสโบว์' WHERE slug = 'legion-crossbow' AND name_th IS NULL;
-- SKIP: Muertuors CrossBow | crossbow (muertuors-crossbow)
-- SKIP: Opal of Precision | crossbow (opal-of-precision)
-- SKIP: Ordens Dedication | crossbow (ordens-dedication)
-- SKIP: Ordens Dedication (Event) | crossbow (ordens-dedication-event)
UPDATE items SET name_th = 'พรอสเป โครสโบว์' WHERE slug = 'prospe-crossbow' AND name_th IS NULL;
UPDATE items SET name_th = 'เวสปาโนลาขัดเงา โครสโบว์' WHERE slug = 'refined-vespanola-crossbow' AND name_th IS NULL;
-- SKIP: Screw Bolt Crossbow | crossbow (screw-bolt-crossbow)
UPDATE items SET name_th = 'สตราต้า เดวิล โครสโบว์' WHERE slug = 'strata-devil-crossbow' AND name_th IS NULL;
UPDATE items SET name_th = 'สตราต้า เดวิล โครสโบว์ (อีเวนต์)' WHERE slug = 'strata-devil-crossbow-event' AND name_th IS NULL;
-- SKIP: The Crossbow of Apostate | crossbow (the-crossbow-of-apostate)
UPDATE items SET name_th = 'คำสั่งทรราช โครสโบว์' WHERE slug = 'tyrants-order-crossbow' AND name_th IS NULL;
UPDATE items SET name_th = 'คำสั่งทรราช โครสโบว์ (อีเวนต์)' WHERE slug = 'tyrants-order-crossbow-event' AND name_th IS NULL;
UPDATE items SET name_th = 'วาเลรอน โครสโบว์' WHERE slug = 'valeron-crossbow' AND name_th IS NULL;
UPDATE items SET name_th = 'วาเลรอน โครสโบว์ (อีเวนต์)' WHERE slug = 'valeron-crossbow-event' AND name_th IS NULL;
UPDATE items SET name_th = 'สนับสนุนผู้บุกเบิกเวสปาโนลา โครสโบว์' WHERE slug = 'vespanola-pioneer-support-crossbow' AND name_th IS NULL;
-- SKIP: Yrlight Crossbow | crossbow (yrlight-crossbow)
UPDATE items SET name_th = '[อีเวนต์] เอเน็กซ์ อีเธอเรียล โครสโบว์' WHERE slug = 'event-enex-ethereal-crossbow' AND name_th IS NULL;
UPDATE items SET name_th = 'อะบิส อาร์ม่า คิวบ์' WHERE slug = 'abyss-arma-cube' AND name_th IS NULL;
UPDATE items SET name_th = 'อะบิส อาร์ม่า คิวบ์ (อีเวนต์)' WHERE slug = 'abyss-arma-cube-event' AND name_th IS NULL;
-- SKIP: Chloes Riddle | cube (chloes-riddle)
-- SKIP: Chloes Riddle (Event) | cube (chloes-riddle-event)
-- SKIP: Cube | cube (cube)
-- SKIP: Cube (Event) | cube (cube-event)
UPDATE items SET name_th = 'คิวบ์สัญญา (7 วัน)' WHERE slug = 'cube-of-contract-7-days' AND name_th IS NULL;
-- SKIP: Cube of Gridley | cube (cube-of-gridley)
UPDATE items SET name_th = 'เดอุส มาชิน่า คิวบ์' WHERE slug = 'deus-machina-cube' AND name_th IS NULL;
UPDATE items SET name_th = 'เดอุส มาชิน่า คิวบ์ (อีเวนต์)' WHERE slug = 'deus-machina-cube-event' AND name_th IS NULL;
UPDATE items SET name_th = 'ดิไวน์ คิวบ์' WHERE slug = 'divine-cube' AND name_th IS NULL;
UPDATE items SET name_th = 'อีลิท ทดลอง คิวบ์' WHERE slug = 'elite-experimental-cube' AND name_th IS NULL;
UPDATE items SET name_th = 'อีลิท มูเอร์ทัวร์ส คิวบ์' WHERE slug = 'elite-muertuors-cube' AND name_th IS NULL;
UPDATE items SET name_th = 'เอเน็กซ์ อีเธอเรียล คิวบ์' WHERE slug = 'enex-ethereal-cube' AND name_th IS NULL;
UPDATE items SET name_th = 'อีเวนต์ อีลิท มูเอร์ทัวร์ส คิวบ์' WHERE slug = 'event-elite-muertuors-cube' AND name_th IS NULL;
UPDATE items SET name_th = 'อีเวนต์ มูเอร์ทัวร์ส คิวบ์' WHERE slug = 'event-muertuors-cube' AND name_th IS NULL;
UPDATE items SET name_th = 'ทดลอง คิวบ์' WHERE slug = 'experimental-cube' AND name_th IS NULL;
-- SKIP: ILE-525 Cube | cube (ile-525-cube)
-- SKIP: ILE-525 Cube (Event) | cube (ile-525-cube-event)
-- SKIP: Incomplete Chloes Riddle | cube (incomplete-chloes-riddle)
UPDATE items SET name_th = 'ลีเจียน คิวบ์' WHERE slug = 'legion-cube' AND name_th IS NULL;
-- SKIP: Masterpiece Cube | cube (masterpiece-cube)
-- SKIP: Masterpiece Cube (Event) | cube (masterpiece-cube-event)
UPDATE items SET name_th = 'มูเอร์ทัวร์ส คิวบ์' WHERE slug = 'muertuors-cube' AND name_th IS NULL;
UPDATE items SET name_th = 'พรอสเป คิวบ์' WHERE slug = 'prospe-cube' AND name_th IS NULL;
UPDATE items SET name_th = 'คำสั่งทรราช คิวบ์' WHERE slug = 'tyrants-order-cube' AND name_th IS NULL;
UPDATE items SET name_th = 'คำสั่งทรราช คิวบ์ (อีเวนต์)' WHERE slug = 'tyrants-order-cube-event' AND name_th IS NULL;
UPDATE items SET name_th = 'สนับสนุนผู้บุกเบิกเวสปาโนลา คิวบ์' WHERE slug = 'vespanola-pioneer-support-cube' AND name_th IS NULL;
UPDATE items SET name_th = '[อีเวนต์] เอเน็กซ์ อีเธอเรียล คิวบ์' WHERE slug = 'event-enex-ethereal-cube' AND name_th IS NULL;
UPDATE items SET name_th = 'อะบิส อาร์ม่า เบรซเล็ตไฟ' WHERE slug = 'abyss-arma-fire-bracelet' AND name_th IS NULL;
UPDATE items SET name_th = 'อะบิส อาร์ม่า เบรซเล็ตไฟ (อีเวนต์)' WHERE slug = 'abyss-arma-fire-bracelet-event' AND name_th IS NULL;
-- SKIP: Ancient Armonia Bracelet | fire_bracelet (ancient-armonia-bracelet)
UPDATE items SET name_th = 'อาร์โมเนีย เบรซเล็ตไฟ (อีเวนต์)' WHERE slug = 'armonia-fire-bracelet-event' AND name_th IS NULL;
-- SKIP: Bracelet of Behemoth | fire_bracelet (bracelet-of-behemoth)
-- SKIP: Bracelet of Empire | fire_bracelet (bracelet-of-empire)
UPDATE items SET name_th = 'บริสเทีย เบรซเล็ตไฟ' WHERE slug = 'bristia-fire-bracelet' AND name_th IS NULL;
-- SKIP: Charlottes Smile | fire_bracelet (charlottes-smile)
-- SKIP: Charlottes Smile (Event) | fire_bracelet (charlottes-smile-event)
-- SKIP: Deus Machina Flame Bracelet | fire_bracelet (deus-machina-flame-bracelet)
-- SKIP: Deus Machina Flame Bracelet (Event) | fire_bracelet (deus-machina-flame-bracelet-event)
UPDATE items SET name_th = 'ดิไวน์ เบรซเล็ตไฟ' WHERE slug = 'divine-fire-bracelet' AND name_th IS NULL;
-- SKIP: Elite Bracelet of Behemoth | fire_bracelet (elite-bracelet-of-behemoth)
-- SKIP: Elite Bracelet of Fire | fire_bracelet (elite-bracelet-of-fire)
-- SKIP: Elite Bracelet of Muspell | fire_bracelet (elite-bracelet-of-muspell)
-- SKIP: Elite Bracelet of Pluto | fire_bracelet (elite-bracelet-of-pluto)
-- SKIP: Elite Bracelet of hellfire | fire_bracelet (elite-bracelet-of-hellfire)
-- SKIP: Elite Bracelet of the Salamander | fire_bracelet (elite-bracelet-of-the-salamander)
UPDATE items SET name_th = 'อีลิท บริสเทีย เบรซเล็ตไฟ' WHERE slug = 'elite-bristia-fire-bracelet' AND name_th IS NULL;
UPDATE items SET name_th = 'อีลิท บริสเทีย เบรซเล็ตไฟ (อีเวนต์)' WHERE slug = 'elite-bristia-fire-bracelet-event' AND name_th IS NULL;
-- SKIP: Elite Experimental Flame Bangle | fire_bracelet (elite-experimental-flame-bangle)
-- SKIP: Elite Fire of Palermo | fire_bracelet (elite-fire-of-palermo)
-- SKIP: Elite Fire of Palermo (Event) | fire_bracelet (elite-fire-of-palermo-event)
UPDATE items SET name_th = 'อีลิท มูเอร์ทัวร์ส เบรซเล็ตไฟ' WHERE slug = 'elite-muertuors-fire-bracelet' AND name_th IS NULL;
-- SKIP: Enex Ethereal Flame Bracelet | fire_bracelet (enex-ethereal-flame-bracelet)
UPDATE items SET name_th = 'อีเวนต์ อีลิท มูเอร์ทัวร์ส เบรซเล็ตไฟ' WHERE slug = 'event-elite-muertuors-fire-bracelet' AND name_th IS NULL;
UPDATE items SET name_th = 'อีเวนต์ มูเอร์ทัวร์ส เบรซเล็ตไฟ' WHERE slug = 'event-muertuors-fire-bracelet' AND name_th IS NULL;
UPDATE items SET name_th = 'อีวิล เบรซเล็ตไฟ' WHERE slug = 'evil-fire-bracelet' AND name_th IS NULL;
-- SKIP: Experimental Flame Bangle | fire_bracelet (experimental-flame-bangle)
-- SKIP: Fire of Palermo | fire_bracelet (fire-of-palermo)
-- SKIP: Fire of Palermo (Event) | fire_bracelet (fire-of-palermo-event)
-- SKIP: Flame Bangle of Howard | fire_bracelet (flame-bangle-of-howard)
-- SKIP: Flame Bracelet of Contract (7 Days) | fire_bracelet (flame-bracelet-of-contract-7-days)
-- SKIP: Incomplete Charlottes Smile | fire_bracelet (incomplete-charlottes-smile)
-- SKIP: Kenlight Bracelet | fire_bracelet (kenlight-bracelet)
-- SKIP: Legion Flame Bracelet | fire_bracelet (legion-flame-bracelet)
UPDATE items SET name_th = 'มูเอร์ทัวร์ส เบรซเล็ตไฟ' WHERE slug = 'muertuors-fire-bracelet' AND name_th IS NULL;
-- SKIP: Prospe Flame Bangle | fire_bracelet (prospe-flame-bangle)
-- SKIP: Pyrite Bangle | fire_bracelet (pyrite-bangle)
-- SKIP: Refined Vespanola Flame Bangle | fire_bracelet (refined-vespanola-flame-bangle)
-- SKIP: Ruby of Passion | fire_bracelet (ruby-of-passion)
-- SKIP: Strata Devil Bracelet of Fire | fire_bracelet (strata-devil-bracelet-of-fire)
-- SKIP: Strata Devil Bracelet of Fire (Event) | fire_bracelet (strata-devil-bracelet-of-fire-event)
-- SKIP: Tyrants Order Flame Bracelet | fire_bracelet (tyrants-order-flame-bracelet)
-- SKIP: Tyrants Order Flame Bracelet (Event) | fire_bracelet (tyrants-order-flame-bracelet-event)
UPDATE items SET name_th = 'วาเลรอน เบรซเล็ตไฟ' WHERE slug = 'valeron-fire-bracelet' AND name_th IS NULL;
UPDATE items SET name_th = 'วาเลรอน เบรซเล็ตไฟ (อีเวนต์)' WHERE slug = 'valeron-fire-bracelet-event' AND name_th IS NULL;
-- SKIP: Vespanola Pioneer Support Fire Bangle | fire_bracelet (vespanola-pioneer-support-fire-bangle)
-- SKIP: [Event] Enex Ethereal Flame Bracelet | fire_bracelet (event-enex-ethereal-flame-bracelet)
-- SKIP: Abyss Arma Large Caliber Rifle | heavy_rifle (abyss-arma-large-caliber-rifle)
-- SKIP: Abyss Arma Large Caliber Rifle (Event) | heavy_rifle (abyss-arma-large-caliber-rifle-event)
-- SKIP: Atlas Gaze | heavy_rifle (atlas-gaze)
-- SKIP: Atlas Gaze (Event) | heavy_rifle (atlas-gaze-event)
-- SKIP: Deus Machina Large Caliber Rifle | heavy_rifle (deus-machina-large-caliber-rifle)
-- SKIP: Deus Machina Large Caliber Rifle (Event) | heavy_rifle (deus-machina-large-caliber-rifle-event)
UPDATE items SET name_th = 'อีลิท Experimental Large Caliber ไรเฟิล' WHERE slug = 'elite-experimental-large-caliber-rifle' AND name_th IS NULL;
UPDATE items SET name_th = 'อีลิท Muertuors Heavy ไรเฟิล' WHERE slug = 'elite-muertuors-heavy-rifle' AND name_th IS NULL;
-- SKIP: Enex Ethereal Large-Caliber Rifle | heavy_rifle (enex-ethereal-large-caliber-rifle)
-- SKIP: Event Elite Muertuors Heavy Rifle | heavy_rifle (event-elite-muertuors-heavy-rifle)
-- SKIP: Event Muertuors Heavy Rifle | heavy_rifle (event-muertuors-heavy-rifle)
-- SKIP: Experimental Large Caliber Rifle | heavy_rifle (experimental-large-caliber-rifle)
-- SKIP: IAR-323 Large Caliber Rifle | heavy_rifle (iar-323-large-caliber-rifle)
-- SKIP: IBR-620 Large Caliber Rifle | heavy_rifle (ibr-620-large-caliber-rifle)
-- SKIP: IBR-620 Large Caliber Rifle (Event) | heavy_rifle (ibr-620-large-caliber-rifle-event)
-- SKIP: ILE-525 Large Caliber Rifle | heavy_rifle (ile-525-large-caliber-rifle)
-- SKIP: ILE-525 Large Caliber Rifle (Event) | heavy_rifle (ile-525-large-caliber-rifle-event)
-- SKIP: Incomplete Atlas Gaze | heavy_rifle (incomplete-atlas-gaze)
-- SKIP: Large Caliber Rifle of Contract (7 Days) | heavy_rifle (large-caliber-rifle-of-contract-7-days)
-- SKIP: Legion Large Caliber Rifle | heavy_rifle (legion-large-caliber-rifle)
-- SKIP: Muertuors Heavy Rifle | heavy_rifle (muertuors-heavy-rifle)
-- SKIP: Tyrants Order Large Caliber Rifle | heavy_rifle (tyrants-order-large-caliber-rifle)
-- SKIP: Tyrants Order Large Caliber Rifle (Event) | heavy_rifle (tyrants-order-large-caliber-rifle-event)
-- SKIP: Vespanola Pioneer Support Large Caliber Rifle | heavy_rifle (vespanola-pioneer-support-large-caliber-rifle)
-- SKIP: [Event] Enex Ethereal Large-Caliber Rifle | heavy_rifle (event-enex-ethereal-large-caliber-rifle)
UPDATE items SET name_th = 'อะบิส อาร์ม่า เบรซเล็ตน้ำแข็ง' WHERE slug = 'abyss-arma-ice-bracelet' AND name_th IS NULL;
UPDATE items SET name_th = 'อะบิส อาร์ม่า เบรซเล็ตน้ำแข็ง (อีเวนต์)' WHERE slug = 'abyss-arma-ice-bracelet-event' AND name_th IS NULL;
-- SKIP: Aquamarine of Purity | ice_bracelet (aquamarine-of-purity)
UPDATE items SET name_th = 'อาร์โมเนีย เบรซเล็ตน้ำแข็ง (อีเวนต์)' WHERE slug = 'armonia-ice-bracelet-event' AND name_th IS NULL;
-- SKIP: Bracelet of Leviathan | ice_bracelet (bracelet-of-leviathan)
UPDATE items SET name_th = 'บริสเทีย เบรซเล็ตน้ำแข็ง' WHERE slug = 'bristia-ice-bracelet' AND name_th IS NULL;
-- SKIP: Chloes Affection | ice_bracelet (chloes-affection)
-- SKIP: Chloes Affection (Event) | ice_bracelet (chloes-affection-event)
UPDATE items SET name_th = 'เดอุส มาชิน่า เบรซเล็ตน้ำแข็ง' WHERE slug = 'deus-machina-ice-bracelet' AND name_th IS NULL;
UPDATE items SET name_th = 'เดอุส มาชิน่า เบรซเล็ตน้ำแข็ง (อีเวนต์)' WHERE slug = 'deus-machina-ice-bracelet-event' AND name_th IS NULL;
UPDATE items SET name_th = 'ดิไวน์ เบรซเล็ตน้ำแข็ง' WHERE slug = 'divine-ice-bracelet' AND name_th IS NULL;
-- SKIP: Elite Aurora Bracelet | ice_bracelet (elite-aurora-bracelet)
-- SKIP: Elite Bracelet of Ice | ice_bracelet (elite-bracelet-of-ice)
-- SKIP: Elite Bracelet of Leviathan | ice_bracelet (elite-bracelet-of-leviathan)
-- SKIP: Elite Bracelet of Neptune | ice_bracelet (elite-bracelet-of-neptune)
-- SKIP: Elite Bracelet of the Yeti | ice_bracelet (elite-bracelet-of-the-yeti)
UPDATE items SET name_th = 'อีลิท บริสเทีย เบรซเล็ตน้ำแข็ง' WHERE slug = 'elite-bristia-ice-bracelet' AND name_th IS NULL;
UPDATE items SET name_th = 'อีลิท บริสเทีย เบรซเล็ตน้ำแข็ง (อีเวนต์)' WHERE slug = 'elite-bristia-ice-bracelet-event' AND name_th IS NULL;
-- SKIP: Elite Experimental Ice Bangle | ice_bracelet (elite-experimental-ice-bangle)
-- SKIP: Elite Ice of Sualocin | ice_bracelet (elite-ice-of-sualocin)
-- SKIP: Elite Ice of Sualocin (Event) | ice_bracelet (elite-ice-of-sualocin-event)
UPDATE items SET name_th = 'อีลิท มูเอร์ทัวร์ส เบรซเล็ตน้ำแข็ง' WHERE slug = 'elite-muertuors-ice-bracelet' AND name_th IS NULL;
-- SKIP: Elite Tempest Bracelet | ice_bracelet (elite-tempest-bracelet)
UPDATE items SET name_th = 'เอเน็กซ์ อีเธอเรียล เบรซเล็ตน้ำแข็ง' WHERE slug = 'enex-ethereal-ice-bracelet' AND name_th IS NULL;
UPDATE items SET name_th = 'อีเวนต์ อีลิท มูเอร์ทัวร์ส เบรซเล็ตน้ำแข็ง' WHERE slug = 'event-elite-muertuors-ice-bracelet' AND name_th IS NULL;
UPDATE items SET name_th = 'อีเวนต์ มูเอร์ทัวร์ส เบรซเล็ตน้ำแข็ง' WHERE slug = 'event-muertuors-ice-bracelet' AND name_th IS NULL;
UPDATE items SET name_th = 'อีวิล เบรซเล็ตน้ำแข็ง' WHERE slug = 'evil-ice-bracelet' AND name_th IS NULL;
-- SKIP: Experimental Ice Bangle | ice_bracelet (experimental-ice-bangle)
-- SKIP: Ezlight Ice Bracelet | ice_bracelet (ezlight-ice-bracelet)
-- SKIP: Ice Bangle of Meyer | ice_bracelet (ice-bangle-of-meyer)
UPDATE items SET name_th = 'เบรซเล็ตน้ำแข็งสัญญา (7 วัน)' WHERE slug = 'ice-bracelet-of-contract-7-days' AND name_th IS NULL;
-- SKIP: Ice of Sualocin | ice_bracelet (ice-of-sualocin)
-- SKIP: Ice of Sualocin (Event) | ice_bracelet (ice-of-sualocin-event)
-- SKIP: Iceberg Bangle | ice_bracelet (iceberg-bangle)
-- SKIP: Incomplete Chloes Affection | ice_bracelet (incomplete-chloes-affection)
UPDATE items SET name_th = 'ลีเจียน เบรซเล็ตน้ำแข็ง' WHERE slug = 'legion-ice-bracelet' AND name_th IS NULL;
UPDATE items SET name_th = 'มูเอร์ทัวร์ส เบรซเล็ตน้ำแข็ง' WHERE slug = 'muertuors-ice-bracelet' AND name_th IS NULL;
-- SKIP: Prospe Ice Bangle | ice_bracelet (prospe-ice-bangle)
-- SKIP: Refined Vespanola Ice Bangle | ice_bracelet (refined-vespanola-ice-bangle)
-- SKIP: Strata Devil Bracelet of Ice | ice_bracelet (strata-devil-bracelet-of-ice)
-- SKIP: Strata Devil Bracelet of Ice (Event) | ice_bracelet (strata-devil-bracelet-of-ice-event)
UPDATE items SET name_th = 'คำสั่งทรราช เบรซเล็ตน้ำแข็ง' WHERE slug = 'tyrants-order-ice-bracelet' AND name_th IS NULL;
UPDATE items SET name_th = 'คำสั่งทรราช เบรซเล็ตน้ำแข็ง (อีเวนต์)' WHERE slug = 'tyrants-order-ice-bracelet-event' AND name_th IS NULL;
UPDATE items SET name_th = 'วาเลรอน เบรซเล็ตน้ำแข็ง' WHERE slug = 'valeron-ice-bracelet' AND name_th IS NULL;
UPDATE items SET name_th = 'วาเลรอน เบรซเล็ตน้ำแข็ง (อีเวนต์)' WHERE slug = 'valeron-ice-bracelet-event' AND name_th IS NULL;
-- SKIP: Vespanola Pioneer Support Ice Bangle | ice_bracelet (vespanola-pioneer-support-ice-bangle)
UPDATE items SET name_th = '[อีเวนต์] เอเน็กซ์ อีเธอเรียล เบรซเล็ตน้ำแข็ง' WHERE slug = 'event-enex-ethereal-ice-bracelet' AND name_th IS NULL;
UPDATE items SET name_th = 'อะบิส อาร์ม่า เบรซเล็ตฟ้าผ่า' WHERE slug = 'abyss-arma-lightning-bracelet' AND name_th IS NULL;
UPDATE items SET name_th = 'อะบิส อาร์ม่า เบรซเล็ตฟ้าผ่า (อีเวนต์)' WHERE slug = 'abyss-arma-lightning-bracelet-event' AND name_th IS NULL;
UPDATE items SET name_th = 'อาร์โมเนีย เบรซเล็ตฟ้าผ่า (อีเวนต์)' WHERE slug = 'armonia-lightning-bracelet-event' AND name_th IS NULL;
-- SKIP: Bracelet of Ziz | lightning_bracelet (bracelet-of-ziz)
UPDATE items SET name_th = 'บริสเทีย เบรซเล็ตฟ้าผ่า' WHERE slug = 'bristia-lightning-bracelet' AND name_th IS NULL;
UPDATE items SET name_th = 'เดอุส มาชิน่า เบรซเล็ตฟ้าผ่า' WHERE slug = 'deus-machina-lightning-bracelet' AND name_th IS NULL;
UPDATE items SET name_th = 'เดอุส มาชิน่า เบรซเล็ตฟ้าผ่า (อีเวนต์)' WHERE slug = 'deus-machina-lightning-bracelet-event' AND name_th IS NULL;
UPDATE items SET name_th = 'ดิไวน์ เบรซเล็ตฟ้าผ่า' WHERE slug = 'divine-lightning-bracelet' AND name_th IS NULL;
-- SKIP: Elite Bracelet of Lightning | lightning_bracelet (elite-bracelet-of-lightning)
-- SKIP: Elite Bracelet of Storm | lightning_bracelet (elite-bracelet-of-storm)
-- SKIP: Elite Bracelet of Sylphide | lightning_bracelet (elite-bracelet-of-sylphide)
-- SKIP: Elite Bracelet of Uranus | lightning_bracelet (elite-bracelet-of-uranus)
-- SKIP: Elite Bracelet of Wind | lightning_bracelet (elite-bracelet-of-wind)
-- SKIP: Elite Bracelet of Ziz | lightning_bracelet (elite-bracelet-of-ziz)
UPDATE items SET name_th = 'อีลิท บริสเทีย เบรซเล็ตฟ้าผ่า' WHERE slug = 'elite-bristia-lightning-bracelet' AND name_th IS NULL;
UPDATE items SET name_th = 'อีลิท บริสเทีย เบรซเล็ตฟ้าผ่า (อีเวนต์)' WHERE slug = 'elite-bristia-lightning-bracelet-event' AND name_th IS NULL;
-- SKIP: Elite Experimental Lightning Bangle | lightning_bracelet (elite-experimental-lightning-bangle)
-- SKIP: Elite Lightning of Rotanev | lightning_bracelet (elite-lightning-of-rotanev)
-- SKIP: Elite Lightning of Rotanev (Event) | lightning_bracelet (elite-lightning-of-rotanev-event)
UPDATE items SET name_th = 'อีลิท มูเอร์ทัวร์ส เบรซเล็ตฟ้าผ่า' WHERE slug = 'elite-muertuors-lightning-bracelet' AND name_th IS NULL;
-- SKIP: Enex Ethereal Electric Bracelet | lightning_bracelet (enex-ethereal-electric-bracelet)
UPDATE items SET name_th = 'อีเวนต์ อีลิท มูเอร์ทัวร์ส เบรซเล็ตฟ้าผ่า' WHERE slug = 'event-elite-muertuors-lightning-bracelet' AND name_th IS NULL;
UPDATE items SET name_th = 'อีเวนต์ มูเอร์ทัวร์ส เบรซเล็ตฟ้าผ่า' WHERE slug = 'event-muertuors-lightning-bracelet' AND name_th IS NULL;
UPDATE items SET name_th = 'อีวิล เบรซเล็ตฟ้าผ่า' WHERE slug = 'evil-lightning-bracelet' AND name_th IS NULL;
-- SKIP: Experimental Lightning Bangle | lightning_bracelet (experimental-lightning-bangle)
-- SKIP: Incomplete Ordens Tear | lightning_bracelet (incomplete-ordens-tear)
UPDATE items SET name_th = 'ลีเจียน เบรซเล็ตฟ้าผ่า' WHERE slug = 'legion-lightning-bracelet' AND name_th IS NULL;
-- SKIP: Lightening of Rotanev (Event) | lightning_bracelet (lightening-of-rotanev-event)
-- SKIP: Lightning Bangle of Porter | lightning_bracelet (lightning-bangle-of-porter)
UPDATE items SET name_th = 'เบรซเล็ตฟ้าผ่าสัญญา (7 วัน)' WHERE slug = 'lightning-bracelet-of-contract-7-days' AND name_th IS NULL;
-- SKIP: Lightning of Rotanev | lightning_bracelet (lightning-of-rotanev)
UPDATE items SET name_th = 'มูเอร์ทัวร์ส เบรซเล็ตฟ้าผ่า' WHERE slug = 'muertuors-lightning-bracelet' AND name_th IS NULL;
-- SKIP: Ordens Tear | lightning_bracelet (ordens-tear)
-- SKIP: Ordens Tear (Event) | lightning_bracelet (ordens-tear-event)
-- SKIP: Prospe Lightning Bangle | lightning_bracelet (prospe-lightning-bangle)
-- SKIP: Refined Vespanola Lightning Bangle | lightning_bracelet (refined-vespanola-lightning-bangle)
-- SKIP: Sparkling Topaz | lightning_bracelet (sparkling-topaz)
-- SKIP: Strata Devil Bracelet of Lightning | lightning_bracelet (strata-devil-bracelet-of-lightning)
-- SKIP: Strata Devil Bracelet of Lightning (Event) | lightning_bracelet (strata-devil-bracelet-of-lightning-event)
-- SKIP: Tirlight Bracelet | lightning_bracelet (tirlight-bracelet)
-- SKIP: Tourmaline of Dominance | lightning_bracelet (tourmaline-of-dominance)
UPDATE items SET name_th = 'คำสั่งทรราช เบรซเล็ตฟ้าผ่า' WHERE slug = 'tyrants-order-lightning-bracelet' AND name_th IS NULL;
UPDATE items SET name_th = 'คำสั่งทรราช เบรซเล็ตฟ้าผ่า (อีเวนต์)' WHERE slug = 'tyrants-order-lightning-bracelet-event' AND name_th IS NULL;
UPDATE items SET name_th = 'วาเลรอน เบรซเล็ตฟ้าผ่า' WHERE slug = 'valeron-lightning-bracelet' AND name_th IS NULL;
UPDATE items SET name_th = 'วาเลรอน เบรซเล็ตฟ้าผ่า (อีเวนต์)' WHERE slug = 'valeron-lightning-bracelet-event' AND name_th IS NULL;
-- SKIP: Vespanola Pioneer Support Lightning Bangle | lightning_bracelet (vespanola-pioneer-support-lightning-bangle)
-- SKIP: [Event] Enex Ethereal Electric Bracelet | lightning_bracelet (event-enex-ethereal-electric-bracelet)
UPDATE items SET name_th = 'อะบิส อาร์ม่า ลูท' WHERE slug = 'abyss-arma-lute' AND name_th IS NULL;
UPDATE items SET name_th = 'อะบิส อาร์ม่า ลูท (อีเวนต์)' WHERE slug = 'abyss-arma-lute-event' AND name_th IS NULL;
UPDATE items SET name_th = 'ลูทแองเจิล' WHERE slug = 'angel-lute' AND name_th IS NULL;
UPDATE items SET name_th = 'อาร์โมเนีย ลูท (อีเวนต์)' WHERE slug = 'armonia-lute-event' AND name_th IS NULL;
UPDATE items SET name_th = 'บริสเทีย ลูท' WHERE slug = 'bristia-lute' AND name_th IS NULL;
-- SKIP: Carnelian of Delight | lute (carnelian-of-delight)
-- SKIP: Chloes Melody | lute (chloes-melody)
-- SKIP: Chloes Melody (Event) | lute (chloes-melody-event)
UPDATE items SET name_th = 'เดอุส มาชิน่า ลูท' WHERE slug = 'deus-machina-lute' AND name_th IS NULL;
UPDATE items SET name_th = 'เดอุส มาชิน่า ลูท (อีเวนต์)' WHERE slug = 'deus-machina-lute-event' AND name_th IS NULL;
-- SKIP: Disdain of Spica | lute (disdain-of-spica)
-- SKIP: Disdain of Spica (Event) | lute (disdain-of-spica-event)
UPDATE items SET name_th = 'ดิไวน์ ลูท' WHERE slug = 'divine-lute' AND name_th IS NULL;
-- SKIP: El Sumo Sacherdote | lute (el-sumo-sacherdote)
-- SKIP: Elite Arciliuto | lute (elite-arciliuto)
UPDATE items SET name_th = 'อีลิท บริสเทีย ลูท' WHERE slug = 'elite-bristia-lute' AND name_th IS NULL;
UPDATE items SET name_th = 'อีลิท บริสเทีย ลูท (อีเวนต์)' WHERE slug = 'elite-bristia-lute-event' AND name_th IS NULL;
-- SKIP: Elite Criticism of Spica | lute (elite-criticism-of-spica)
-- SKIP: Elite Disdain of Spica (Event) | lute (elite-disdain-of-spica-event)
-- SKIP: Elite El Sumo Sacherdote | lute (elite-el-sumo-sacherdote)
UPDATE items SET name_th = 'อีลิท ทดลอง ลูท' WHERE slug = 'elite-experimental-lute' AND name_th IS NULL;
-- SKIP: Elite Lute | lute (elite-lute)
UPDATE items SET name_th = 'อีลิท มูเอร์ทัวร์ส ลูท' WHERE slug = 'elite-muertuors-lute' AND name_th IS NULL;
-- SKIP: Elite Teorbe | lute (elite-teorbe)
UPDATE items SET name_th = 'เอเน็กซ์ อีเธอเรียล ลูท' WHERE slug = 'enex-ethereal-lute' AND name_th IS NULL;
UPDATE items SET name_th = 'อีเวนต์ อีลิท มูเอร์ทัวร์ส ลูท' WHERE slug = 'event-elite-muertuors-lute' AND name_th IS NULL;
UPDATE items SET name_th = 'อีเวนต์ มูเอร์ทัวร์ส ลูท' WHERE slug = 'event-muertuors-lute' AND name_th IS NULL;
UPDATE items SET name_th = 'อีวิล ลูท' WHERE slug = 'evil-lute' AND name_th IS NULL;
UPDATE items SET name_th = 'ทดลอง ลูท' WHERE slug = 'experimental-lute' AND name_th IS NULL;
-- SKIP: Incomplete Chloes Melody | lute (incomplete-chloes-melody)
UPDATE items SET name_th = 'ลีเจียน ลูท' WHERE slug = 'legion-lute' AND name_th IS NULL;
UPDATE items SET name_th = 'ลูทสัญญา (7 วัน)' WHERE slug = 'lute-of-contract-7-days' AND name_th IS NULL;
-- SKIP: Lute of Fortune | lute (lute-of-fortune)
UPDATE items SET name_th = 'มูเอร์ทัวร์ส ลูท' WHERE slug = 'muertuors-lute' AND name_th IS NULL;
UPDATE items SET name_th = 'พรอสเป ลูท' WHERE slug = 'prospe-lute' AND name_th IS NULL;
UPDATE items SET name_th = 'เวสปาโนลาขัดเงา ลูท' WHERE slug = 'refined-vespanola-lute' AND name_th IS NULL;
UPDATE items SET name_th = 'สตราต้า เดวิล ลูท' WHERE slug = 'strata-devil-lute' AND name_th IS NULL;
UPDATE items SET name_th = 'สตราต้า เดวิล ลูท (อีเวนต์)' WHERE slug = 'strata-devil-lute-event' AND name_th IS NULL;
UPDATE items SET name_th = 'คำสั่งทรราช ลูท' WHERE slug = 'tyrants-order-lute' AND name_th IS NULL;
UPDATE items SET name_th = 'คำสั่งทรราช ลูท (อีเวนต์)' WHERE slug = 'tyrants-order-lute-event' AND name_th IS NULL;
UPDATE items SET name_th = 'วาเลรอน ลูท' WHERE slug = 'valeron-lute' AND name_th IS NULL;
UPDATE items SET name_th = 'วาเลรอน ลูท (อีเวนต์)' WHERE slug = 'valeron-lute-event' AND name_th IS NULL;
UPDATE items SET name_th = 'สนับสนุนผู้บุกเบิกเวสปาโนลา ลูท' WHERE slug = 'vespanola-pioneer-support-lute' AND name_th IS NULL;
-- SKIP: Wilight Lute | lute (wilight-lute)
UPDATE items SET name_th = '[อีเวนต์] เอเน็กซ์ อีเธอเรียล ลูท' WHERE slug = 'event-enex-ethereal-lute' AND name_th IS NULL;
UPDATE items SET name_th = 'อะบิส อาร์ม่า จี้' WHERE slug = 'abyss-arma-pendant' AND name_th IS NULL;
UPDATE items SET name_th = 'อะบิส อาร์ม่า จี้ (อีเวนต์)' WHERE slug = 'abyss-arma-pendant-event' AND name_th IS NULL;
-- SKIP: Bronze Pendant | pendant (bronze-pendant)
-- SKIP: Charlottes Faith | pendant (charlottes-faith)
-- SKIP: Charlottes Faith (Event) | pendant (charlottes-faith-event)
UPDATE items SET name_th = 'เดอุส มาชิน่า จี้' WHERE slug = 'deus-machina-pendant' AND name_th IS NULL;
UPDATE items SET name_th = 'เดอุส มาชิน่า จี้ (อีเวนต์)' WHERE slug = 'deus-machina-pendant-event' AND name_th IS NULL;
-- SKIP: Elegant Pendant | pendant (elegant-pendant)
UPDATE items SET name_th = 'อีลิท ทดลอง จี้' WHERE slug = 'elite-experimental-pendant' AND name_th IS NULL;
UPDATE items SET name_th = 'อีลิท มูเอร์ทัวร์ส จี้' WHERE slug = 'elite-muertuors-pendant' AND name_th IS NULL;
UPDATE items SET name_th = 'เอเน็กซ์ อีเธอเรียล จี้' WHERE slug = 'enex-ethereal-pendant' AND name_th IS NULL;
UPDATE items SET name_th = 'อีเวนต์ อีลิท มูเอร์ทัวร์ส จี้' WHERE slug = 'event-elite-muertuors-pendant' AND name_th IS NULL;
UPDATE items SET name_th = 'อีเวนต์ มูเอร์ทัวร์ส จี้' WHERE slug = 'event-muertuors-pendant' AND name_th IS NULL;
UPDATE items SET name_th = 'ทดลอง จี้' WHERE slug = 'experimental-pendant' AND name_th IS NULL;
-- SKIP: Heavenly Locket | pendant (heavenly-locket)
-- SKIP: Heavenly Locket (Event) | pendant (heavenly-locket-event)
-- SKIP: Incomplete Charlottes Faith | pendant (incomplete-charlottes-faith)
UPDATE items SET name_th = 'ลีเจียน จี้' WHERE slug = 'legion-pendant' AND name_th IS NULL;
UPDATE items SET name_th = 'มูเอร์ทัวร์ส จี้' WHERE slug = 'muertuors-pendant' AND name_th IS NULL;
-- SKIP: Old Wood Pendant | pendant (old-wood-pendant)
UPDATE items SET name_th = 'จี้สัญญา (7 วัน)' WHERE slug = 'pendant-of-contract-7-days' AND name_th IS NULL;
-- SKIP: Platinum Pendant | pendant (platinum-pendant)
UPDATE items SET name_th = 'พรอสเป จี้' WHERE slug = 'prospe-pendant' AND name_th IS NULL;
-- SKIP: Pure Gold Pendant | pendant (pure-gold-pendant)
UPDATE items SET name_th = 'เวสปาโนลาขัดเงา จี้' WHERE slug = 'refined-vespanola-pendant' AND name_th IS NULL;
-- SKIP: Silver Pendant | pendant (silver-pendant)
UPDATE items SET name_th = 'สตราต้า เดวิล จี้' WHERE slug = 'strata-devil-pendant' AND name_th IS NULL;
UPDATE items SET name_th = 'สตราต้า เดวิล จี้ (อีเวนต์)' WHERE slug = 'strata-devil-pendant-event' AND name_th IS NULL;
UPDATE items SET name_th = 'คำสั่งทรราช จี้' WHERE slug = 'tyrants-order-pendant' AND name_th IS NULL;
UPDATE items SET name_th = 'คำสั่งทรราช จี้ (อีเวนต์)' WHERE slug = 'tyrants-order-pendant-event' AND name_th IS NULL;
UPDATE items SET name_th = 'วาเลรอน จี้' WHERE slug = 'valeron-pendant' AND name_th IS NULL;
UPDATE items SET name_th = 'วาเลรอน จี้ (อีเวนต์)' WHERE slug = 'valeron-pendant-event' AND name_th IS NULL;
UPDATE items SET name_th = 'สนับสนุนผู้บุกเบิกเวสปาโนลา จี้' WHERE slug = 'vespanola-pioneer-support-pendant' AND name_th IS NULL;
-- SKIP: Wooden Pendant | pendant (wooden-pendant)
UPDATE items SET name_th = '[อีเวนต์] เอเน็กซ์ อีเธอเรียล จี้' WHERE slug = 'event-enex-ethereal-pendant' AND name_th IS NULL;
UPDATE items SET name_th = 'อะบิส อาร์ม่า ปืนพก' WHERE slug = 'abyss-arma-pistol' AND name_th IS NULL;
UPDATE items SET name_th = 'อะบิส อาร์ม่า ปืนพก (อีเวนต์)' WHERE slug = 'abyss-arma-pistol-event' AND name_th IS NULL;
-- SKIP: Angel Revolvers | pistol (angel-revolvers)
UPDATE items SET name_th = 'อาร์โมเนีย ปืนพก (อีเวนต์)' WHERE slug = 'armonia-pistol-event' AND name_th IS NULL;
UPDATE items SET name_th = 'บริสเทีย ปืนพก' WHERE slug = 'bristia-pistol' AND name_th IS NULL;
-- SKIP: Chloes Insight | pistol (chloes-insight)
-- SKIP: Chloes Insight (Event) | pistol (chloes-insight-event)
-- SKIP: Desert Storm | pistol (desert-storm)
UPDATE items SET name_th = 'เดอุส มาชิน่า ปืนพก' WHERE slug = 'deus-machina-pistol' AND name_th IS NULL;
UPDATE items SET name_th = 'เดอุส มาชิน่า ปืนพก (อีเวนต์)' WHERE slug = 'deus-machina-pistol-event' AND name_th IS NULL;
UPDATE items SET name_th = 'ดิไวน์ ปืนพก' WHERE slug = 'divine-pistol' AND name_th IS NULL;
UPDATE items SET name_th = 'ปืนพกดัลลาฮัน' WHERE slug = 'dullahan-pistol' AND name_th IS NULL;
-- SKIP: El Diablo | pistol (el-diablo)
UPDATE items SET name_th = 'อีลิท Antique ปืนพก' WHERE slug = 'elite-antique-pistol' AND name_th IS NULL;
-- SKIP: Elite Beam-gun | pistol (elite-beam-gun)
UPDATE items SET name_th = 'อีลิท บริสเทีย ปืนพก' WHERE slug = 'elite-bristia-pistol' AND name_th IS NULL;
UPDATE items SET name_th = 'อีลิท บริสเทีย ปืนพก (อีเวนต์)' WHERE slug = 'elite-bristia-pistol-event' AND name_th IS NULL;
-- SKIP: Elite Chassepot | pistol (elite-chassepot)
-- SKIP: Elite Claude Baudez Nique | pistol (elite-claude-baudez-nique)
-- SKIP: Elite Echo of Steel | pistol (elite-echo-of-steel)
-- SKIP: Elite El Diablo | pistol (elite-el-diablo)
-- SKIP: Elite Experimental Revolver | pistol (elite-experimental-revolver)
-- SKIP: Elite Handgun | pistol (elite-handgun)
-- SKIP: Elite Intuition of Al Rischa | pistol (elite-intuition-of-al-rischa)
-- SKIP: Elite Intuition of Al Rischa (Event) | pistol (elite-intuition-of-al-rischa-event)
UPDATE items SET name_th = 'อีลิท Iron ปืนพก' WHERE slug = 'elite-iron-pistol' AND name_th IS NULL;
UPDATE items SET name_th = 'อีลิท มูเอร์ทัวร์ส ปืนพก' WHERE slug = 'elite-muertuors-pistol' AND name_th IS NULL;
-- SKIP: Elite Mustang Strider | pistol (elite-mustang-strider)
-- SKIP: Elite Revolver | pistol (elite-revolver)
UPDATE items SET name_th = 'เอเน็กซ์ อีเธอเรียล ปืนพก' WHERE slug = 'enex-ethereal-pistol' AND name_th IS NULL;
UPDATE items SET name_th = 'อีเวนต์ อีลิท มูเอร์ทัวร์ส ปืนพก' WHERE slug = 'event-elite-muertuors-pistol' AND name_th IS NULL;
UPDATE items SET name_th = 'อีเวนต์ มูเอร์ทัวร์ส ปืนพก' WHERE slug = 'event-muertuors-pistol' AND name_th IS NULL;
UPDATE items SET name_th = 'อีวิล ปืนพก' WHERE slug = 'evil-pistol' AND name_th IS NULL;
-- SKIP: Experimental Revolver | pistol (experimental-revolver)
-- SKIP: Flame Thrower | pistol (flame-thrower)
-- SKIP: Frozen Spitter | pistol (frozen-spitter)
-- SKIP: Hagallight Magnum | pistol (hagallight-magnum)
-- SKIP: Incomplete Chloes Insight | pistol (incomplete-chloes-insight)
-- SKIP: Intuition of Al Rischa | pistol (intuition-of-al-rischa)
-- SKIP: Intuition of Al Rischa (Event) | pistol (intuition-of-al-rischa-event)
-- SKIP: Jaspards Rifling Revolver | pistol (jaspards-rifling-revolver)
-- SKIP: Lapis Lazuli of Accuracy | pistol (lapis-lazuli-of-accuracy)
-- SKIP: Legion Revolver | pistol (legion-revolver)
-- SKIP: Lightning Gun | pistol (lightning-gun)
UPDATE items SET name_th = 'มูเอร์ทัวร์ส ปืนพก' WHERE slug = 'muertuors-pistol' AND name_th IS NULL;
UPDATE items SET name_th = 'ปืนพกสัญญา (7 วัน)' WHERE slug = 'pistol-of-contract-7-days' AND name_th IS NULL;
-- SKIP: Prospe Revolver | pistol (prospe-revolver)
-- SKIP: Refined Vespanola Revolver | pistol (refined-vespanola-revolver)
-- SKIP: Revolver of Gerad | pistol (revolver-of-gerad)
-- SKIP: Revolver of Justice | pistol (revolver-of-justice)
-- SKIP: Serpent Revolver | pistol (serpent-revolver)
UPDATE items SET name_th = 'สตราต้า เดวิล ปืนพก' WHERE slug = 'strata-devil-pistol' AND name_th IS NULL;
UPDATE items SET name_th = 'สตราต้า เดวิล ปืนพก (อีเวนต์)' WHERE slug = 'strata-devil-pistol-event' AND name_th IS NULL;
-- SKIP: The Revolver of Revenge | pistol (the-revolver-of-revenge)
UPDATE items SET name_th = 'คำสั่งทรราช ปืนพก' WHERE slug = 'tyrants-order-pistol' AND name_th IS NULL;
UPDATE items SET name_th = 'คำสั่งทรราช ปืนพก (อีเวนต์)' WHERE slug = 'tyrants-order-pistol-event' AND name_th IS NULL;
UPDATE items SET name_th = 'วาเลรอน ปืนพก' WHERE slug = 'valeron-pistol' AND name_th IS NULL;
UPDATE items SET name_th = 'วาเลรอน ปืนพก (อีเวนต์)' WHERE slug = 'valeron-pistol-event' AND name_th IS NULL;
-- SKIP: Vespanola Pioneer Support Revolver | pistol (vespanola-pioneer-support-revolver)
UPDATE items SET name_th = '[อีเวนต์] เอเน็กซ์ อีเธอเรียล ปืนพก' WHERE slug = 'event-enex-ethereal-pistol' AND name_th IS NULL;
UPDATE items SET name_th = 'อะบิส อาร์ม่า ไรเฟิล' WHERE slug = 'abyss-arma-rifle' AND name_th IS NULL;
UPDATE items SET name_th = 'อะบิส อาร์ม่า ไรเฟิล (อีเวนต์)' WHERE slug = 'abyss-arma-rifle-event' AND name_th IS NULL;
-- SKIP: Ancient Armonia Rifle | rifle (ancient-armonia-rifle)
-- SKIP: Angel Bayonet | rifle (angel-bayonet)
-- SKIP: Angel Rod Rifle | rifle (angel-rod-rifle)
UPDATE items SET name_th = 'อาร์โมเนีย ไรเฟิล (อีเวนต์)' WHERE slug = 'armonia-rifle-event' AND name_th IS NULL;
-- SKIP: Bayonet of Dewey | rifle (bayonet-of-dewey)
UPDATE items SET name_th = 'บริสเทีย ไรเฟิล' WHERE slug = 'bristia-rifle' AND name_th IS NULL;
UPDATE items SET name_th = 'เดอุส มาชิน่า ไรเฟิล' WHERE slug = 'deus-machina-rifle' AND name_th IS NULL;
UPDATE items SET name_th = 'เดอุส มาชิน่า ไรเฟิล (อีเวนต์)' WHERE slug = 'deus-machina-rifle-event' AND name_th IS NULL;
UPDATE items SET name_th = 'ดิไวน์ ไรเฟิล' WHERE slug = 'divine-rifle' AND name_th IS NULL;
-- SKIP: Elite Black Dragon | rifle (elite-black-dragon)
UPDATE items SET name_th = 'อีลิท บริสเทีย ไรเฟิล' WHERE slug = 'elite-bristia-rifle' AND name_th IS NULL;
UPDATE items SET name_th = 'อีลิท บริสเทีย ไรเฟิล (อีเวนต์)' WHERE slug = 'elite-bristia-rifle-event' AND name_th IS NULL;
-- SKIP: Elite Brown Bess | rifle (elite-brown-bess)
-- SKIP: Elite Dragon Hunter Bayonet | rifle (elite-dragon-hunter-bayonet)
-- SKIP: Elite Dreyse | rifle (elite-dreyse)
UPDATE items SET name_th = 'อีลิท ทดลอง ไรเฟิล' WHERE slug = 'elite-experimental-rifle' AND name_th IS NULL;
-- SKIP: Elite Finisher | rifle (elite-finisher)
-- SKIP: Elite Finisher Bayonet | rifle (elite-finisher-bayonet)
-- SKIP: Elite La Emperatriz | rifle (elite-la-emperatriz)
-- SKIP: Elite La Fuerza | rifle (elite-la-fuerza)
UPDATE items SET name_th = 'อีลิท Match-lock ไรเฟิล' WHERE slug = 'elite-match-lock-rifle' AND name_th IS NULL;
UPDATE items SET name_th = 'อีลิท มูเอร์ทัวร์ส ไรเฟิล' WHERE slug = 'elite-muertuors-rifle' AND name_th IS NULL;
UPDATE items SET name_th = 'อีลิท Sniper ไรเฟิล' WHERE slug = 'elite-sniper-rifle' AND name_th IS NULL;
-- SKIP: Elite Sniper Rifle Bayonet | rifle (elite-sniper-rifle-bayonet)
-- SKIP: Elite Tempest of Aquarius | rifle (elite-tempest-of-aquarius)
-- SKIP: Elite Tempest of Aquarius (Event) | rifle (elite-tempest-of-aquarius-event)
UPDATE items SET name_th = 'อีลิท Wheel-lock ไรเฟิล' WHERE slug = 'elite-wheel-lock-rifle' AND name_th IS NULL;
UPDATE items SET name_th = 'เอเน็กซ์ อีเธอเรียล ไรเฟิล' WHERE slug = 'enex-ethereal-rifle' AND name_th IS NULL;
UPDATE items SET name_th = 'อีเวนต์ อีลิท มูเอร์ทัวร์ส ไรเฟิล' WHERE slug = 'event-elite-muertuors-rifle' AND name_th IS NULL;
UPDATE items SET name_th = 'อีเวนต์ มูเอร์ทัวร์ส ไรเฟิล' WHERE slug = 'event-muertuors-rifle' AND name_th IS NULL;
-- SKIP: Evil Bayonet | rifle (evil-bayonet)
UPDATE items SET name_th = 'อีวิล ไรเฟิล' WHERE slug = 'evil-rifle' AND name_th IS NULL;
UPDATE items SET name_th = 'ทดลอง ไรเฟิล' WHERE slug = 'experimental-rifle' AND name_th IS NULL;
-- SKIP: Gold Dragon | rifle (gold-dragon)
-- SKIP: Improved Barkir Rifle (7 days) | rifle (improved-barkir-rifle-7-days)
-- SKIP: Incomplete Ordens Destruction | rifle (incomplete-ordens-destruction)
-- SKIP: La Emperatriz | rifle (la-emperatriz)
-- SKIP: La Fuerza | rifle (la-fuerza)
UPDATE items SET name_th = 'ลีเจียน ไรเฟิล' WHERE slug = 'legion-rifle' AND name_th IS NULL;
-- SKIP: Match-Lock Rifle 28 of Empire | rifle (match-lock-rifle-28-of-empire)
-- SKIP: Miquiret Steam Bayonet | rifle (miquiret-steam-bayonet)
UPDATE items SET name_th = 'มูเอร์ทัวร์ส ไรเฟิล' WHERE slug = 'muertuors-rifle' AND name_th IS NULL;
-- SKIP: Ordens Destruction | rifle (ordens-destruction)
-- SKIP: Ordens Destruction (Event) | rifle (ordens-destruction-event)
-- SKIP: Othellight Rifle | rifle (othellight-rifle)
UPDATE items SET name_th = 'พรอสเป ไรเฟิล' WHERE slug = 'prospe-rifle' AND name_th IS NULL;
UPDATE items SET name_th = 'เวสปาโนลาขัดเงา ไรเฟิล' WHERE slug = 'refined-vespanola-rifle' AND name_th IS NULL;
UPDATE items SET name_th = 'ไรเฟิลสัญญา (7 วัน)' WHERE slug = 'rifle-of-contract-7-days' AND name_th IS NULL;
-- SKIP: Rifle of Highrophant | rifle (rifle-of-highrophant)
-- SKIP: Sapphire of Concentration | rifle (sapphire-of-concentration)
UPDATE items SET name_th = 'เซอร์เพนท์ ไรเฟิล' WHERE slug = 'serpent-rifle' AND name_th IS NULL;
-- SKIP: Strata Devil Bayonet | rifle (strata-devil-bayonet)
-- SKIP: Strata Devil Bayonet (Event) | rifle (strata-devil-bayonet-event)
UPDATE items SET name_th = 'สตราต้า เดวิล ไรเฟิล' WHERE slug = 'strata-devil-rifle' AND name_th IS NULL;
UPDATE items SET name_th = 'สตราต้า เดวิล ไรเฟิล (อีเวนต์)' WHERE slug = 'strata-devil-rifle-event' AND name_th IS NULL;
-- SKIP: Tempest of Aquarius | rifle (tempest-of-aquarius)
-- SKIP: Tempest of Aquarius (Event) | rifle (tempest-of-aquarius-event)
-- SKIP: The Black Dragon | rifle (the-black-dragon)
-- SKIP: The Diamond Dragon | rifle (the-diamond-dragon)
-- SKIP: The Emerald Dragon | rifle (the-emerald-dragon)
-- SKIP: The Ruby Dragon | rifle (the-ruby-dragon)
UPDATE items SET name_th = 'คำสั่งทรราช ไรเฟิล' WHERE slug = 'tyrants-order-rifle' AND name_th IS NULL;
UPDATE items SET name_th = 'คำสั่งทรราช ไรเฟิล (อีเวนต์)' WHERE slug = 'tyrants-order-rifle-event' AND name_th IS NULL;
-- SKIP: Unlawful Bayonet | rifle (unlawful-bayonet)
UPDATE items SET name_th = 'วาเลรอน ไรเฟิล' WHERE slug = 'valeron-rifle' AND name_th IS NULL;
UPDATE items SET name_th = 'วาเลรอน ไรเฟิล (อีเวนต์)' WHERE slug = 'valeron-rifle-event' AND name_th IS NULL;
UPDATE items SET name_th = 'สนับสนุนผู้บุกเบิกเวสปาโนลา ไรเฟิล' WHERE slug = 'vespanola-pioneer-support-rifle' AND name_th IS NULL;
UPDATE items SET name_th = 'แวร์วูล์ฟ ไรเฟิล' WHERE slug = 'werewolf-rifle' AND name_th IS NULL;
UPDATE items SET name_th = '[อีเวนต์] เอเน็กซ์ อีเธอเรียล ไรเฟิล' WHERE slug = 'event-enex-ethereal-rifle' AND name_th IS NULL;
UPDATE items SET name_th = 'อะบิส อาร์ม่า ไม้เท้า' WHERE slug = 'abyss-arma-rod' AND name_th IS NULL;
UPDATE items SET name_th = 'อะบิส อาร์ม่า ไม้เท้า (อีเวนต์)' WHERE slug = 'abyss-arma-rod-event' AND name_th IS NULL;
UPDATE items SET name_th = 'ไม้เท้าแองเจิล' WHERE slug = 'angel-rod' AND name_th IS NULL;
-- SKIP: Angel Wand | rod (angel-wand)
UPDATE items SET name_th = 'อาร์โมเนีย ไม้เท้า (อีเวนต์)' WHERE slug = 'armonia-rod-event' AND name_th IS NULL;
UPDATE items SET name_th = 'บริสเทีย ไม้เท้า' WHERE slug = 'bristia-rod' AND name_th IS NULL;
-- SKIP: Broom of Little Witch | rod (broom-of-little-witch)
-- SKIP: Broom of Little Witch (Event) | rod (broom-of-little-witch-event)
-- SKIP: Chloes Wish | rod (chloes-wish)
-- SKIP: Chloes Wish (Event) | rod (chloes-wish-event)
-- SKIP: Control of Ophiuchus (Event) | rod (control-of-ophiuchus-event)
-- SKIP: Crescemento Rod | rod (crescemento-rod)
UPDATE items SET name_th = 'เดอุส มาชิน่า ไม้เท้า' WHERE slug = 'deus-machina-rod' AND name_th IS NULL;
UPDATE items SET name_th = 'เดอุส มาชิน่า ไม้เท้า (อีเวนต์)' WHERE slug = 'deus-machina-rod-event' AND name_th IS NULL;
-- SKIP: Divine Broom Stick | rod (divine-broom-stick)
UPDATE items SET name_th = 'ดิไวน์ ไม้เท้า' WHERE slug = 'divine-rod' AND name_th IS NULL;
UPDATE items SET name_th = 'อีลิท บริสเทีย ไม้เท้า' WHERE slug = 'elite-bristia-rod' AND name_th IS NULL;
UPDATE items SET name_th = 'อีลิท บริสเทีย ไม้เท้า (อีเวนต์)' WHERE slug = 'elite-bristia-rod-event' AND name_th IS NULL;
UPDATE items SET name_th = 'อีลิท ทดลอง ไม้เท้า' WHERE slug = 'elite-experimental-rod' AND name_th IS NULL;
-- SKIP: Elite Grim-stick | rod (elite-grim-stick)
UPDATE items SET name_th = 'อีลิท Jewel ไม้เท้า' WHERE slug = 'elite-jewel-rod' AND name_th IS NULL;
UPDATE items SET name_th = 'อีลิท Mage ไม้เท้า' WHERE slug = 'elite-mage-rod' AND name_th IS NULL;
UPDATE items SET name_th = 'อีลิท Mantis ไม้เท้า' WHERE slug = 'elite-mantis-rod' AND name_th IS NULL;
UPDATE items SET name_th = 'อีลิทมูนสโตนไม้เท้า' WHERE slug = 'elite-moonstone-rod' AND name_th IS NULL;
UPDATE items SET name_th = 'อีลิท มูเอร์ทัวร์ส ไม้เท้า' WHERE slug = 'elite-muertuors-rod' AND name_th IS NULL;
-- SKIP: Elite Rod | rod (elite-rod)
UPDATE items SET name_th = 'อีลิท Sage ไม้เท้า' WHERE slug = 'elite-sage-rod' AND name_th IS NULL;
-- SKIP: Elite The Control of Ophiuchus | rod (elite-the-control-of-ophiuchus)
-- SKIP: Elite Wave of Steel | rod (elite-wave-of-steel)
-- SKIP: Elite the Control of Ophiuchus (Event) | rod (elite-the-control-of-ophiuchus-event)
UPDATE items SET name_th = 'เอเน็กซ์ อีเธอเรียล ไม้เท้า' WHERE slug = 'enex-ethereal-rod' AND name_th IS NULL;
UPDATE items SET name_th = 'อีเวนต์ อีลิท มูเอร์ทัวร์ส ไม้เท้า' WHERE slug = 'event-elite-muertuors-rod' AND name_th IS NULL;
UPDATE items SET name_th = 'อีเวนต์ มูเอร์ทัวร์ส ไม้เท้า' WHERE slug = 'event-muertuors-rod' AND name_th IS NULL;
UPDATE items SET name_th = 'อีวิล ไม้เท้า' WHERE slug = 'evil-rod' AND name_th IS NULL;
UPDATE items SET name_th = 'ทดลอง ไม้เท้า' WHERE slug = 'experimental-rod' AND name_th IS NULL;
-- SKIP: Feolight Rod | rod (feolight-rod)
-- SKIP: Glacial Crystal | rod (glacial-crystal)
-- SKIP: Incomplete Chloes Wish | rod (incomplete-chloes-wish)
UPDATE items SET name_th = 'ลีเจียน ไม้เท้า' WHERE slug = 'legion-rod' AND name_th IS NULL;
UPDATE items SET name_th = 'มูเอร์ทัวร์ส ไม้เท้า' WHERE slug = 'muertuors-rod' AND name_th IS NULL;
-- SKIP: Old BWitchs Room (Event) | rod (old-bwitchs-room-event)
-- SKIP: Old Witchs Room | rod (old-witchs-room)
-- SKIP: Pearl of Excellence | rod (pearl-of-excellence)
UPDATE items SET name_th = 'พรอสเป ไม้เท้า' WHERE slug = 'prospe-rod' AND name_th IS NULL;
-- SKIP: Purni Pumpkin | rod (purni-pumpkin)
UPDATE items SET name_th = 'เวสปาโนลาขัดเงา ไม้เท้า' WHERE slug = 'refined-vespanola-rod' AND name_th IS NULL;
-- SKIP: Rod of Carla | rod (rod-of-carla)
UPDATE items SET name_th = 'ไม้เท้าสัญญา (7 วัน)' WHERE slug = 'rod-of-contract-7-days' AND name_th IS NULL;
-- SKIP: Rod of Recluse | rod (rod-of-recluse)
UPDATE items SET name_th = 'สตราต้า เดวิล ไม้เท้า' WHERE slug = 'strata-devil-rod' AND name_th IS NULL;
UPDATE items SET name_th = 'สตราต้า เดวิล ไม้เท้า (อีเวนต์)' WHERE slug = 'strata-devil-rod-event' AND name_th IS NULL;
-- SKIP: The Control of Ophiuchus | rod (the-control-of-ophiuchus)
-- SKIP: The Grim-stick | rod (the-grim-stick)
-- SKIP: The Rod of Armageddon | rod (the-rod-of-armageddon)
-- SKIP: The Rod of Pride | rod (the-rod-of-pride)
UPDATE items SET name_th = 'คำสั่งทรราช ไม้เท้า' WHERE slug = 'tyrants-order-rod' AND name_th IS NULL;
UPDATE items SET name_th = 'คำสั่งทรราช ไม้เท้า (อีเวนต์)' WHERE slug = 'tyrants-order-rod-event' AND name_th IS NULL;
UPDATE items SET name_th = 'วาเลรอน ไม้เท้า' WHERE slug = 'valeron-rod' AND name_th IS NULL;
UPDATE items SET name_th = 'วาเลรอน ไม้เท้า (อีเวนต์)' WHERE slug = 'valeron-rod-event' AND name_th IS NULL;
UPDATE items SET name_th = 'สนับสนุนผู้บุกเบิกเวสปาโนลา ไม้เท้า' WHERE slug = 'vespanola-pioneer-support-rod' AND name_th IS NULL;
UPDATE items SET name_th = '[อีเวนต์] เอเน็กซ์ อีเธอเรียล ไม้เท้า' WHERE slug = 'event-enex-ethereal-rod' AND name_th IS NULL;
UPDATE items SET name_th = 'อะบิส อาร์ม่า โรซาริโอ' WHERE slug = 'abyss-arma-rosario' AND name_th IS NULL;
UPDATE items SET name_th = 'อะบิส อาร์ม่า โรซาริโอ (อีเวนต์)' WHERE slug = 'abyss-arma-rosario-event' AND name_th IS NULL;
UPDATE items SET name_th = 'เดอุส มาชิน่า โรซาริโอ' WHERE slug = 'deus-machina-rosario' AND name_th IS NULL;
UPDATE items SET name_th = 'เดอุส มาชิน่า โรซาริโอ (อีเวนต์)' WHERE slug = 'deus-machina-rosario-event' AND name_th IS NULL;
-- SKIP: Elegant Rosario | rosario (elegant-rosario)
UPDATE items SET name_th = 'อีลิท ทดลอง โรซาริโอ' WHERE slug = 'elite-experimental-rosario' AND name_th IS NULL;
UPDATE items SET name_th = 'อีลิท มูเอร์ทัวร์ส โรซาริโอ' WHERE slug = 'elite-muertuors-rosario' AND name_th IS NULL;
-- SKIP: Enex Ethereal Rosary | rosario (enex-ethereal-rosary)
-- SKIP: Enhanced Silver Rosario | rosario (enhanced-silver-rosario)
UPDATE items SET name_th = 'อีเวนต์ อีลิท มูเอร์ทัวร์ส โรซาริโอ' WHERE slug = 'event-elite-muertuors-rosario' AND name_th IS NULL;
UPDATE items SET name_th = 'อีเวนต์ มูเอร์ทัวร์ส โรซาริโอ' WHERE slug = 'event-muertuors-rosario' AND name_th IS NULL;
UPDATE items SET name_th = 'ทดลอง โรซาริโอ' WHERE slug = 'experimental-rosario' AND name_th IS NULL;
-- SKIP: Gold Rosario | rosario (gold-rosario)
-- SKIP: Gold Rosario (Event) | rosario (gold-rosario-event)
-- SKIP: Incomplete Stellas Blessing | rosario (incomplete-stellas-blessing)
UPDATE items SET name_th = 'มูเอร์ทัวร์ส โรซาริโอ' WHERE slug = 'muertuors-rosario' AND name_th IS NULL;
UPDATE items SET name_th = 'พรอสเป โรซาริโอ' WHERE slug = 'prospe-rosario' AND name_th IS NULL;
UPDATE items SET name_th = 'โรซาริโอสัญญา (7 วัน)' WHERE slug = 'rosario-of-contract-7-days' AND name_th IS NULL;
-- SKIP: Silver Rosario | rosario (silver-rosario)
-- SKIP: Stellas Blessing | rosario (stellas-blessing)
-- SKIP: Stellas Blessing (Event) | rosario (stellas-blessing-event)
UPDATE items SET name_th = 'สตราต้า เดวิล โรซาริโอ' WHERE slug = 'strata-devil-rosario' AND name_th IS NULL;
UPDATE items SET name_th = 'สตราต้า เดวิล โรซาริโอ (อีเวนต์)' WHERE slug = 'strata-devil-rosario-event' AND name_th IS NULL;
UPDATE items SET name_th = 'คำสั่งทรราช โรซาริโอ' WHERE slug = 'tyrants-order-rosario' AND name_th IS NULL;
UPDATE items SET name_th = 'คำสั่งทรราช โรซาริโอ (อีเวนต์)' WHERE slug = 'tyrants-order-rosario-event' AND name_th IS NULL;
UPDATE items SET name_th = 'วาเลรอน โรซาริโอ' WHERE slug = 'valeron-rosario' AND name_th IS NULL;
UPDATE items SET name_th = 'วาเลรอน โรซาริโอ (อีเวนต์)' WHERE slug = 'valeron-rosario-event' AND name_th IS NULL;
-- SKIP: [Event] Enex Ethereal Rosary | rosario (event-enex-ethereal-rosary)
UPDATE items SET name_th = 'อะบิส อาร์ม่า โล่' WHERE slug = 'abyss-arma-shield' AND name_th IS NULL;
UPDATE items SET name_th = 'อะบิส อาร์ม่า โล่ (อีเวนต์)' WHERE slug = 'abyss-arma-shield-event' AND name_th IS NULL;
-- SKIP: Atlas Strength | shield (atlas-strength)
-- SKIP: Atlas Strength (Event) | shield (atlas-strength-event)
-- SKIP: Conflamme | shield (conflamme)
-- SKIP: Cumulonimbus | shield (cumulonimbus)
UPDATE items SET name_th = 'เดอุส มาชิน่า โล่' WHERE slug = 'deus-machina-shield' AND name_th IS NULL;
UPDATE items SET name_th = 'เดอุส มาชิน่า โล่ (อีเวนต์)' WHERE slug = 'deus-machina-shield-event' AND name_th IS NULL;
UPDATE items SET name_th = 'โล่ดัลลาฮัน' WHERE slug = 'dullahan-shield' AND name_th IS NULL;
-- SKIP: Elite Aquila | shield (elite-aquila)
-- SKIP: Elite Arm Guard | shield (elite-arm-guard)
-- SKIP: Elite Buckler | shield (elite-buckler)
-- SKIP: Elite Castor Wing | shield (elite-castor-wing)
UPDATE items SET name_th = 'อีลิท Iron โล่' WHERE slug = 'elite-iron-shield' AND name_th IS NULL;
-- SKIP: Elite La Templanza | shield (elite-la-templanza)
UPDATE items SET name_th = 'อีลิท มูเอร์ทัวร์ส โล่' WHERE slug = 'elite-muertuors-shield' AND name_th IS NULL;
-- SKIP: Elite Noir Plaque | shield (elite-noir-plaque)
UPDATE items SET name_th = 'อีลิท Octagon โล่' WHERE slug = 'elite-octagon-shield' AND name_th IS NULL;
-- SKIP: Elite Pollux Wing | shield (elite-pollux-wing)
-- SKIP: Elite Riposte of Arachne | shield (elite-riposte-of-arachne)
-- SKIP: Elite Riposte of Arachne (Event) | shield (elite-riposte-of-arachne-event)
-- SKIP: Elite Rouge Plaque | shield (elite-rouge-plaque)
-- SKIP: Elite Royal Guardian | shield (elite-royal-guardian)
-- SKIP: Elite Templar Guard | shield (elite-templar-guard)
UPDATE items SET name_th = 'เอเน็กซ์ อีเธอเรียล โล่' WHERE slug = 'enex-ethereal-shield' AND name_th IS NULL;
-- SKIP: Event Armonia Shield | shield (event-armonia-shield)
UPDATE items SET name_th = 'อีเวนต์ อีลิท มูเอร์ทัวร์ส โล่' WHERE slug = 'event-elite-muertuors-shield' AND name_th IS NULL;
UPDATE items SET name_th = 'อีเวนต์ มูเอร์ทัวร์ส โล่' WHERE slug = 'event-muertuors-shield' AND name_th IS NULL;
-- SKIP: Incomplete Atlas Strength | shield (incomplete-atlas-strength)
-- SKIP: Infernal Hearts | shield (infernal-hearts)
UPDATE items SET name_th = 'โคบอลท์ โล่' WHERE slug = 'kobolt-shield' AND name_th IS NULL;
-- SKIP: La Templanza | shield (la-templanza)
UPDATE items SET name_th = 'มูเอร์ทัวร์ส โล่' WHERE slug = 'muertuors-shield' AND name_th IS NULL;
-- SKIP: Phantom Guard | shield (phantom-guard)
-- SKIP: Riposte of Arachne | shield (riposte-of-arachne)
-- SKIP: Riposte of Arachne (Event) | shield (riposte-of-arachne-event)
UPDATE items SET name_th = 'โล่สัญญา (7 วัน)' WHERE slug = 'shield-of-contract-7-days' AND name_th IS NULL;
UPDATE items SET name_th = 'สตราต้า เดวิล โล่' WHERE slug = 'strata-devil-shield' AND name_th IS NULL;
UPDATE items SET name_th = 'สตราต้า เดวิล โล่ (อีเวนต์)' WHERE slug = 'strata-devil-shield-event' AND name_th IS NULL;
-- SKIP: The Grim-shout | shield (the-grim-shout)
UPDATE items SET name_th = 'คำสั่งทรราช โล่' WHERE slug = 'tyrants-order-shield' AND name_th IS NULL;
UPDATE items SET name_th = 'คำสั่งทรราช โล่ (อีเวนต์)' WHERE slug = 'tyrants-order-shield-event' AND name_th IS NULL;
UPDATE items SET name_th = 'วาเลรอน โล่' WHERE slug = 'valeron-shield' AND name_th IS NULL;
UPDATE items SET name_th = 'วาเลรอน โล่ (อีเวนต์)' WHERE slug = 'valeron-shield-event' AND name_th IS NULL;
UPDATE items SET name_th = 'แวร์วูล์ฟ โล่' WHERE slug = 'werewolf-shield' AND name_th IS NULL;
UPDATE items SET name_th = '[อีเวนต์] เอเน็กซ์ อีเธอเรียล โล่' WHERE slug = 'event-enex-ethereal-shield' AND name_th IS NULL;
UPDATE items SET name_th = 'อะบิส อาร์ม่า ช็อตกัน' WHERE slug = 'abyss-arma-shotgun' AND name_th IS NULL;
UPDATE items SET name_th = 'อะบิส อาร์ม่า ช็อตกัน (อีเวนต์)' WHERE slug = 'abyss-arma-shotgun-event' AND name_th IS NULL;
UPDATE items SET name_th = 'แองเจิล ช็อตกัน' WHERE slug = 'angel-shotgun' AND name_th IS NULL;
UPDATE items SET name_th = 'อาร์โมเนีย ช็อตกัน (อีเวนต์)' WHERE slug = 'armonia-shotgun-event' AND name_th IS NULL;
-- SKIP: Blunder of Lykaon | shotgun (blunder-of-lykaon)
-- SKIP: Blunder of Lykaon (Event) | shotgun (blunder-of-lykaon-event)
UPDATE items SET name_th = 'บริสเทีย ช็อตกัน' WHERE slug = 'bristia-shotgun' AND name_th IS NULL;
-- SKIP: Burst of Spencer | shotgun (burst-of-spencer)
-- SKIP: Charlottes Agony | shotgun (charlottes-agony)
-- SKIP: Charlottes Agony (Event) | shotgun (charlottes-agony-event)
-- SKIP: Conqueror Shotgun | shotgun (conqueror-shotgun)
-- SKIP: Crime Shotgun | shotgun (crime-shotgun)
UPDATE items SET name_th = 'เดอุส มาชิน่า ช็อตกัน' WHERE slug = 'deus-machina-shotgun' AND name_th IS NULL;
UPDATE items SET name_th = 'เดอุส มาชิน่า ช็อตกัน (อีเวนต์)' WHERE slug = 'deus-machina-shotgun-event' AND name_th IS NULL;
UPDATE items SET name_th = 'ดิไวน์ ช็อตกัน' WHERE slug = 'divine-shotgun' AND name_th IS NULL;
-- SKIP: Elite Blunder of Lykaon | shotgun (elite-blunder-of-lykaon)
-- SKIP: Elite Blunder of Lykaon (Event) | shotgun (elite-blunder-of-lykaon-event)
-- SKIP: Elite Bristia Shot Gun | shotgun (elite-bristia-shot-gun)
UPDATE items SET name_th = 'อีลิท บริสเทีย ช็อตกัน (อีเวนต์)' WHERE slug = 'elite-bristia-shotgun-event' AND name_th IS NULL;
-- SKIP: Elite Clayshooter | shotgun (elite-clayshooter)
UPDATE items SET name_th = 'อีลิท ทดลอง ช็อตกัน' WHERE slug = 'elite-experimental-shotgun' AND name_th IS NULL;
-- SKIP: Elite Imperial Shooter | shotgun (elite-imperial-shooter)
-- SKIP: Elite Los Enamorados | shotgun (elite-los-enamorados)
UPDATE items SET name_th = 'อีลิท มูเอร์ทัวร์ส ช็อตกัน' WHERE slug = 'elite-muertuors-shotgun' AND name_th IS NULL;
UPDATE items SET name_th = 'อีลิท Semi-auto ช็อตกัน' WHERE slug = 'elite-semi-auto-shotgun' AND name_th IS NULL;
-- SKIP: Elite Shotgun | shotgun (elite-shotgun)
UPDATE items SET name_th = 'เอเน็กซ์ อีเธอเรียล ช็อตกัน' WHERE slug = 'enex-ethereal-shotgun' AND name_th IS NULL;
UPDATE items SET name_th = 'อีเวนต์ อีลิท มูเอร์ทัวร์ส ช็อตกัน' WHERE slug = 'event-elite-muertuors-shotgun' AND name_th IS NULL;
UPDATE items SET name_th = 'อีเวนต์ มูเอร์ทัวร์ส ช็อตกัน' WHERE slug = 'event-muertuors-shotgun' AND name_th IS NULL;
UPDATE items SET name_th = 'อีวิล ช็อตกัน' WHERE slug = 'evil-shotgun' AND name_th IS NULL;
UPDATE items SET name_th = 'ทดลอง ช็อตกัน' WHERE slug = 'experimental-shotgun' AND name_th IS NULL;
-- SKIP: Improved Dread Buster (7 days) | shotgun (improved-dread-buster-7-days)
-- SKIP: Improved Poison Shooter (7 days) | shotgun (improved-poison-shooter-7-days)
-- SKIP: Improved Stun Gun (7 days) | shotgun (improved-stun-gun-7-days)
-- SKIP: Incomplete Charlottes Agony | shotgun (incomplete-charlottes-agony)
-- SKIP: Jalight Shotgun | shotgun (jalight-shotgun)
UPDATE items SET name_th = 'ลีเจียน ช็อตกัน' WHERE slug = 'legion-shotgun' AND name_th IS NULL;
-- SKIP: Los Enamorados | shotgun (los-enamorados)
UPDATE items SET name_th = 'มูเอร์ทัวร์ส ช็อตกัน' WHERE slug = 'muertuors-shotgun' AND name_th IS NULL;
UPDATE items SET name_th = 'อ็อกร์ ช็อตกัน' WHERE slug = 'ogre-shotgun' AND name_th IS NULL;
UPDATE items SET name_th = 'พรอสเป ช็อตกัน' WHERE slug = 'prospe-shotgun' AND name_th IS NULL;
UPDATE items SET name_th = 'เวสปาโนลาขัดเงา ช็อตกัน' WHERE slug = 'refined-vespanola-shotgun' AND name_th IS NULL;
-- SKIP: Serpent Shooter | shotgun (serpent-shooter)
UPDATE items SET name_th = 'ช็อตกันสัญญา (7 วัน)' WHERE slug = 'shotgun-of-contract-7-days' AND name_th IS NULL;
-- SKIP: Shotgun of World | shotgun (shotgun-of-world)
UPDATE items SET name_th = 'สตราต้า เดวิล ช็อตกัน' WHERE slug = 'strata-devil-shotgun' AND name_th IS NULL;
UPDATE items SET name_th = 'สตราต้า เดวิล ช็อตกัน (อีเวนต์)' WHERE slug = 'strata-devil-shotgun-event' AND name_th IS NULL;
-- SKIP: Topaz of Influence | shotgun (topaz-of-influence)
UPDATE items SET name_th = 'คำสั่งทรราช ช็อตกัน' WHERE slug = 'tyrants-order-shotgun' AND name_th IS NULL;
UPDATE items SET name_th = 'คำสั่งทรราช ช็อตกัน (อีเวนต์)' WHERE slug = 'tyrants-order-shotgun-event' AND name_th IS NULL;
UPDATE items SET name_th = 'วาเลรอน ช็อตกัน' WHERE slug = 'valeron-shotgun' AND name_th IS NULL;
UPDATE items SET name_th = 'วาเลรอน ช็อตกัน (อีเวนต์)' WHERE slug = 'valeron-shotgun-event' AND name_th IS NULL;
UPDATE items SET name_th = 'สนับสนุนผู้บุกเบิกเวสปาโนลา ช็อตกัน' WHERE slug = 'vespanola-pioneer-support-shotgun' AND name_th IS NULL;
UPDATE items SET name_th = '[อีเวนต์] เอเน็กซ์ อีเธอเรียล ช็อตกัน' WHERE slug = 'event-enex-ethereal-shotgun' AND name_th IS NULL;
UPDATE items SET name_th = 'อะบิส อาร์ม่า เบรซเล็ตพิเศษ' WHERE slug = 'abyss-arma-special-bracelet' AND name_th IS NULL;
UPDATE items SET name_th = 'อะบิส อาร์ม่า เบรซเล็ตพิเศษ (อีเวนต์)' WHERE slug = 'abyss-arma-special-bracelet-event' AND name_th IS NULL;
-- SKIP: Angel Bracelet | special_bracelet (angel-bracelet)
-- SKIP: Ansurlight Bracelet | special_bracelet (ansurlight-bracelet)
UPDATE items SET name_th = 'อาร์โมเนีย เบรซเล็ตพิเศษ (อีเวนต์)' WHERE slug = 'armonia-special-bracelet-event' AND name_th IS NULL;
-- SKIP: Assembly Logic Bangle | special_bracelet (assembly-logic-bangle)
-- SKIP: Black Bishop | special_bracelet (black-bishop)
-- SKIP: Bracelet of Empress | special_bracelet (bracelet-of-empress)
-- SKIP: Bracelet of Raien | special_bracelet (bracelet-of-raien)
-- SKIP: Bracelet of Three Kings | special_bracelet (bracelet-of-three-kings)
UPDATE items SET name_th = 'บริสเทีย เบรซเล็ตพิเศษ' WHERE slug = 'bristia-special-bracelet' AND name_th IS NULL;
UPDATE items SET name_th = 'เดอุส มาชิน่า เบรซเล็ตพิเศษ' WHERE slug = 'deus-machina-special-bracelet' AND name_th IS NULL;
UPDATE items SET name_th = 'เดอุส มาชิน่า เบรซเล็ตพิเศษ (อีเวนต์)' WHERE slug = 'deus-machina-special-bracelet-event' AND name_th IS NULL;
UPDATE items SET name_th = 'ดิไวน์ เบรซเล็ตพิเศษ' WHERE slug = 'divine-special-bracelet' AND name_th IS NULL;
-- SKIP: El Sol | special_bracelet (el-sol)
UPDATE items SET name_th = 'อีลิท บริสเทีย เบรซเล็ตพิเศษ' WHERE slug = 'elite-bristia-special-bracelet' AND name_th IS NULL;
UPDATE items SET name_th = 'อีลิท บริสเทีย เบรซเล็ตพิเศษ (อีเวนต์)' WHERE slug = 'elite-bristia-special-bracelet-event' AND name_th IS NULL;
-- SKIP: Elite El Sol | special_bracelet (elite-el-sol)
-- SKIP: Elite Experimental Bracelet | special_bracelet (elite-experimental-bracelet)
-- SKIP: Elite Muertuors Elemental Bracelet | special_bracelet (elite-muertuors-elemental-bracelet)
-- SKIP: Elite Skullic Bracer | special_bracelet (elite-skullic-bracer)
-- SKIP: Elite The Delphinus | special_bracelet (elite-the-delphinus)
-- SKIP: Elite the Delphinus (Event) | special_bracelet (elite-the-delphinus-event)
-- SKIP: Emerald of Mystery | special_bracelet (emerald-of-mystery)
UPDATE items SET name_th = 'เอเน็กซ์ อีเธอเรียล เบรซเล็ตพิเศษ' WHERE slug = 'enex-ethereal-special-bracelet' AND name_th IS NULL;
-- SKIP: Event Elite Muertuors Elemental Bracelet | special_bracelet (event-elite-muertuors-elemental-bracelet)
-- SKIP: Event Muertuors Elemental Bracelet | special_bracelet (event-muertuors-elemental-bracelet)
-- SKIP: Evil Elemental Bracelet | special_bracelet (evil-elemental-bracelet)
-- SKIP: Experimental Bracelet | special_bracelet (experimental-bracelet)
-- SKIP: Gold Bishop | special_bracelet (gold-bishop)
-- SKIP: Incomplete Stellas Judgement | special_bracelet (incomplete-stellas-judgement)
UPDATE items SET name_th = 'ลีเจียน เบรซเล็ตพิเศษ' WHERE slug = 'legion-special-bracelet' AND name_th IS NULL;
-- SKIP: Lust Bracelet | special_bracelet (lust-bracelet)
-- SKIP: Muertuors Elemental Bracelet | special_bracelet (muertuors-elemental-bracelet)
-- SKIP: Prospe Bracelet | special_bracelet (prospe-bracelet)
UPDATE items SET name_th = 'เวสปาโนลาขัดเงา เบรซเล็ตพิเศษ' WHERE slug = 'refined-vespanola-special-bracelet' AND name_th IS NULL;
UPDATE items SET name_th = 'เบรซเล็ตพิเศษสัญญา (7 วัน)' WHERE slug = 'special-bracelet-of-contract-7-days' AND name_th IS NULL;
-- SKIP: Stellas Judgement | special_bracelet (stellas-judgement)
-- SKIP: Stellas Judgement (Event) | special_bracelet (stellas-judgement-event)
-- SKIP: Strata Devil Bracelet | special_bracelet (strata-devil-bracelet)
-- SKIP: Strata Devil Bracelet (Event) | special_bracelet (strata-devil-bracelet-event)
-- SKIP: The Delphinus | special_bracelet (the-delphinus)
-- SKIP: The Delphinus (Event) | special_bracelet (the-delphinus-event)
UPDATE items SET name_th = 'คำสั่งทรราช เบรซเล็ตพิเศษ' WHERE slug = 'tyrants-order-special-bracelet' AND name_th IS NULL;
UPDATE items SET name_th = 'คำสั่งทรราช เบรซเล็ตพิเศษ (อีเวนต์)' WHERE slug = 'tyrants-order-special-bracelet-event' AND name_th IS NULL;
UPDATE items SET name_th = 'วาเลรอน เบรซเล็ตพิเศษ' WHERE slug = 'valeron-special-bracelet' AND name_th IS NULL;
UPDATE items SET name_th = 'วาเลรอน เบรซเล็ตพิเศษ (อีเวนต์)' WHERE slug = 'valeron-special-bracelet-event' AND name_th IS NULL;
UPDATE items SET name_th = 'สนับสนุนผู้บุกเบิกเวสปาโนลา เบรซเล็ตพิเศษ' WHERE slug = 'vespanola-pioneer-support-special-bracelet' AND name_th IS NULL;
-- SKIP: White Bishop | special_bracelet (white-bishop)
UPDATE items SET name_th = '[อีเวนต์] เอเน็กซ์ อีเธอเรียล เบรซเล็ตพิเศษ' WHERE slug = 'event-enex-ethereal-special-bracelet' AND name_th IS NULL;
UPDATE items SET name_th = 'อะบิส อาร์ม่า คฑา' WHERE slug = 'abyss-arma-staff' AND name_th IS NULL;
UPDATE items SET name_th = 'อะบิส อาร์ม่า คฑา (อีเวนต์)' WHERE slug = 'abyss-arma-staff-event' AND name_th IS NULL;
-- SKIP: Amethyst of Awakening | staff (amethyst-of-awakening)
UPDATE items SET name_th = 'คฑาแองเจิล' WHERE slug = 'angel-staff' AND name_th IS NULL;
UPDATE items SET name_th = 'อาร์โมเนีย คฑา (อีเวนต์)' WHERE slug = 'armonia-staff-event' AND name_th IS NULL;
UPDATE items SET name_th = 'บริสเทีย คฑา' WHERE slug = 'bristia-staff' AND name_th IS NULL;
-- SKIP: Charlottes Patience | staff (charlottes-patience)
-- SKIP: Charlottes Patience (Event) | staff (charlottes-patience-event)
UPDATE items SET name_th = 'เดอุส มาชิน่า คฑา' WHERE slug = 'deus-machina-staff' AND name_th IS NULL;
UPDATE items SET name_th = 'เดอุส มาชิน่า คฑา (อีเวนต์)' WHERE slug = 'deus-machina-staff-event' AND name_th IS NULL;
UPDATE items SET name_th = 'ดิไวน์ คฑา' WHERE slug = 'divine-staff' AND name_th IS NULL;
-- SKIP: El Mago | staff (el-mago)
UPDATE items SET name_th = 'อีลิท บริสเทีย คฑา' WHERE slug = 'elite-bristia-staff' AND name_th IS NULL;
UPDATE items SET name_th = 'อีลิท บริสเทีย คฑา (อีเวนต์)' WHERE slug = 'elite-bristia-staff-event' AND name_th IS NULL;
-- SKIP: Elite El Mago | staff (elite-el-mago)
UPDATE items SET name_th = 'อีลิท ทดลอง คฑา' WHERE slug = 'elite-experimental-staff' AND name_th IS NULL;
-- SKIP: Elite Judgment of Bennu | staff (elite-judgment-of-bennu)
-- SKIP: Elite Judgment of Bennu (Event) | staff (elite-judgment-of-bennu-event)
UPDATE items SET name_th = 'อีลิท มูเอร์ทัวร์ส คฑา' WHERE slug = 'elite-muertuors-staff' AND name_th IS NULL;
-- SKIP: Elite Staff | staff (elite-staff)
-- SKIP: Elite Staff of Gnosis | staff (elite-staff-of-gnosis)
-- SKIP: Elite Staff of Hypnosis | staff (elite-staff-of-hypnosis)
-- SKIP: Elite Staff of Simurgh | staff (elite-staff-of-simurgh)
UPDATE items SET name_th = 'เอเน็กซ์ อีเธอเรียล คฑา' WHERE slug = 'enex-ethereal-staff' AND name_th IS NULL;
UPDATE items SET name_th = 'อีเวนต์ อีลิท มูเอร์ทัวร์ส คฑา' WHERE slug = 'event-elite-muertuors-staff' AND name_th IS NULL;
UPDATE items SET name_th = 'อีเวนต์ มูเอร์ทัวร์ส คฑา' WHERE slug = 'event-muertuors-staff' AND name_th IS NULL;
UPDATE items SET name_th = 'อีวิล คฑา' WHERE slug = 'evil-staff' AND name_th IS NULL;
UPDATE items SET name_th = 'ทดลอง คฑา' WHERE slug = 'experimental-staff' AND name_th IS NULL;
-- SKIP: Forest Whisper | staff (forest-whisper)
-- SKIP: Incomplete Charlottes Patience | staff (incomplete-charlottes-patience)
-- SKIP: Judgement of Bennu (Event) | staff (judgement-of-bennu-event)
-- SKIP: Judgment of Bennu | staff (judgment-of-bennu)
UPDATE items SET name_th = 'ลีเจียน คฑา' WHERE slug = 'legion-staff' AND name_th IS NULL;
UPDATE items SET name_th = 'มูเอร์ทัวร์ส คฑา' WHERE slug = 'muertuors-staff' AND name_th IS NULL;
-- SKIP: Niedlight Staff | staff (niedlight-staff)
-- SKIP: Ogre Orb | staff (ogre-orb)
UPDATE items SET name_th = 'เวสปาโนลาขัดเงา คฑา' WHERE slug = 'refined-vespanola-staff' AND name_th IS NULL;
UPDATE items SET name_th = 'คฑาสัญญา (7 วัน)' WHERE slug = 'staff-of-contract-7-days' AND name_th IS NULL;
-- SKIP: Staff of Prophet | staff (staff-of-prophet)
UPDATE items SET name_th = 'สตราต้า เดวิล คฑา' WHERE slug = 'strata-devil-staff' AND name_th IS NULL;
UPDATE items SET name_th = 'สตราต้า เดวิล คฑา (อีเวนต์)' WHERE slug = 'strata-devil-staff-event' AND name_th IS NULL;
UPDATE items SET name_th = 'คำสั่งทรราช คฑา' WHERE slug = 'tyrants-order-staff' AND name_th IS NULL;
UPDATE items SET name_th = 'คำสั่งทรราช คฑา (อีเวนต์)' WHERE slug = 'tyrants-order-staff-event' AND name_th IS NULL;
UPDATE items SET name_th = 'วาเลรอน คฑา' WHERE slug = 'valeron-staff' AND name_th IS NULL;
UPDATE items SET name_th = 'วาเลรอน คฑา (อีเวนต์)' WHERE slug = 'valeron-staff-event' AND name_th IS NULL;
UPDATE items SET name_th = 'สนับสนุนผู้บุกเบิกเวสปาโนลา คฑา' WHERE slug = 'vespanola-pioneer-support-staff' AND name_th IS NULL;
UPDATE items SET name_th = '[อีเวนต์] เอเน็กซ์ อีเธอเรียล คฑา' WHERE slug = 'event-enex-ethereal-staff' AND name_th IS NULL;