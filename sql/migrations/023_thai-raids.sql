-- Migration 023: Thai raid boss names (130 raids)
-- Transliteration rules:
--   Proper nouns → Thai phonetic
--   Descriptive words (Great, King, Hell, Ancient, etc.) → Thai meaning
--   Mixed: translate descriptive + transliterate name
--   Numbers kept as-is

-- Abyss group (อะบิส = deep void / darkness realm)
UPDATE raids SET name_th = 'อะบิส' WHERE name = 'Abyss';
UPDATE raids SET name_th = 'อะบิส เอเบ็ธ' WHERE name = 'Abyss Abeth';
UPDATE raids SET name_th = 'อะบิส อะเฟียร์' WHERE name = 'Abyss Afear';
UPDATE raids SET name_th = 'กองทัพอะบิส' WHERE name = 'Abyss Army';
UPDATE raids SET name_th = 'อะบิส เครย์' WHERE name = 'Abyss Cray';
UPDATE raids SET name_th = 'อะบิส เดธกลอช' WHERE name = 'Abyss Deathgloshe';
UPDATE raids SET name_th = 'อะบิส เดเซ็ธ' WHERE name = 'Abyss Deceth';
UPDATE raids SET name_th = 'อะบิส กลูม' WHERE name = 'Abyss Gloom';
UPDATE raids SET name_th = 'อะบิส โกร์กอน ชีลด์' WHERE name = 'Abyss Gorgon Shield';
UPDATE raids SET name_th = 'อะบิส แฮสเซน' WHERE name = 'Abyss Hassen';
UPDATE raids SET name_th = 'อะบิส แฮทซ์' WHERE name = 'Abyss Hatz';
UPDATE raids SET name_th = 'อะบิส แมดดี้' WHERE name = 'Abyss Maddie';
UPDATE raids SET name_th = 'อะบิส ซอร์โรว์' WHERE name = 'Abyss Sorrow';

-- A
UPDATE raids SET name_th = 'โกเล็มโบราณ ทาลอส' WHERE name = 'Ancient Golem Talos';
UPDATE raids SET name_th = 'อาร์บรีมอน 1' WHERE name = 'Arbremon 1' AND slug = 'raid-monraidarbremon1';
UPDATE raids SET name_th = 'อาร์บรีมอน 1' WHERE name = 'Arbremon 1' AND slug = 'raid-monraidarbremon2';
UPDATE raids SET name_th = 'อาร์กัสเบรน' WHERE name = 'Argusbrain';
UPDATE raids SET name_th = 'หมีที่ติดเชื้ออะบิส' WHERE name = 'Bear Infected with Abyss';
UPDATE raids SET name_th = 'สัตว์ร้าย, เยอร์เกน' WHERE name = 'Beast, Juergen';
UPDATE raids SET name_th = 'สัตว์ร้าย, เยอร์เกน เฟอร์โฮลเดน' WHERE name = 'Beast, Jurgen Furholden';
UPDATE raids SET name_th = 'ซานุกผู้ทรยศ' WHERE name = 'Betrayal Sunuk';
UPDATE raids SET name_th = 'ผีมรณะสีดำ' WHERE name = 'Black Death Wraith';
UPDATE raids SET name_th = 'ควินนิทูลาผู้คลั่งเลือด' WHERE name = 'Blood-Drunken Quinnitula';
UPDATE raids SET name_th = 'ผีมรณะสีน้ำเงิน' WHERE name = 'Blue Death Wraith';
UPDATE raids SET name_th = 'บรีซ' WHERE name = 'Breeze';
UPDATE raids SET name_th = 'บรอนเทส' WHERE name = 'Brontes';

-- C
UPDATE raids SET name_th = 'แคนเดลา' WHERE name = 'Candela';
UPDATE raids SET name_th = 'คาซูร์โร' WHERE name = 'Cazurro';
UPDATE raids SET name_th = 'คีเมร่า หมายเลข 666' WHERE name = 'Chimera No. 666';
UPDATE raids SET name_th = 'ครูซ' WHERE name = 'Cruise';
UPDATE raids SET name_th = 'ผู้ถูกสาป' WHERE name = 'Cursed Person';
UPDATE raids SET name_th = 'ไซคลอปส์' WHERE name = 'Cyclops';

-- D
UPDATE raids SET name_th = 'จอร์มองกานด์มืด' WHERE name = 'Dark Jormongand';
UPDATE raids SET name_th = 'เดคาราเวีย' WHERE name = 'Dekaravia';
UPDATE raids SET name_th = 'ยูนิผู้น่ารังเกียจ' WHERE name = 'Despicable Uni';
UPDATE raids SET name_th = 'ดิอาโบล' WHERE name = 'Diablo';
UPDATE raids SET name_th = 'นายพลโทปาทริกยอน บาร์โต (บิดเบือน)' WHERE name = 'Distorted Patrikyon Barto Lieutenant General';
UPDATE raids SET name_th = 'นายพลโทปาทริกยอน ทากิ (บิดเบือน)' WHERE name = 'Distorted Patrikyon Taki Lieutenant General';
UPDATE raids SET name_th = 'หมาป่าขาวบิดเบือน' WHERE name = 'Distorted White Wolf';
UPDATE raids SET name_th = 'ทาสแห่งหายนะ' WHERE name = 'Doom Slave';
UPDATE raids SET name_th = 'โดรอล จอมทัพมังกร' WHERE name = 'Dorol the Dragon Warlord';
UPDATE raids SET name_th = 'ดุลลาฮาน, คาเบซา' WHERE name = 'Dullahan, Cabeza';

-- E
UPDATE raids SET name_th = 'ไอน์ชีเวอร์' WHERE name = 'Einschiever';
UPDATE raids SET name_th = 'ออโต้บารอน T เสริมพลัง' WHERE name = 'Enhanced Auto Baron T';
UPDATE raids SET name_th = 'หัวหน้ายามเอโวรา, พันโทแคสเซิลดอร์' WHERE name = 'Evora Chief Guard, Lt. Colonel Castledorr';
UPDATE raids SET name_th = 'ผู้นำหน่วยปราบปรามเอโวรา, พันโทซีโร่' WHERE name = 'Evora Riot Squad Leader, Lt. Colonel Zero';
UPDATE raids SET name_th = 'ผู้นำหน่วยสำรวจเอโวรา, พันโทวิซเฮาส์' WHERE name = 'Evora Search Party Leader, Wiz House Lt. Colonel';
UPDATE raids SET name_th = 'ผู้นำหน่วยจู่โจมเอโวรา, พันโทโคลชิส' WHERE name = 'Evora Striking Force Leader, Lt. Colonel Colchis';
UPDATE raids SET name_th = 'อันเดอร์เทเกอร์ทดลอง' WHERE name = 'Experimental Undertaker';

-- F
UPDATE raids SET name_th = 'อะบิสแรก ออสคูรัส' WHERE name = 'First Abyss Oscuras';
UPDATE raids SET name_th = 'ทหารราบ ซานบก' WHERE name = 'Footman Sanbok';
UPDATE raids SET name_th = 'ทหารราบ ซานุก' WHERE name = 'Footman Sunuk';

-- G
UPDATE raids SET name_th = 'โกลด์การัส' WHERE name = 'Goldgaras';
UPDATE raids SET name_th = 'มหาตะกละ' WHERE name = 'Great Gluttony';
UPDATE raids SET name_th = 'มหาลิช' WHERE name = 'Great Lich';
UPDATE raids SET name_th = 'มหาลิง' WHERE name = 'Great Monkey';
UPDATE raids SET name_th = 'กริฟฟอน' WHERE name = 'Griffon';
UPDATE raids SET name_th = 'สุนัขเฝ้าบ้าน, เซอร์เวอรัส' WHERE name = 'Guard Dog, Serverus';
UPDATE raids SET name_th = 'สุนัขเฝ้าบ้าน, เซอร์เวอรัส' WHERE name = 'Guard dog, Serverus';

-- H
UPDATE raids SET name_th = 'แม่ทัพนรก, คอบส์' WHERE name = 'Hell General, Cobs';
UPDATE raids SET name_th = 'แม่ทัพนรก, มาร์เซีย' WHERE name = 'Hell General, Marcia';
UPDATE raids SET name_th = 'แม่ทัพนรก, เวล' WHERE name = 'Hell General, Veil';
UPDATE raids SET name_th = 'จอมมารนรก' WHERE name = 'Hell Lord';
UPDATE raids SET name_th = 'ออกเจฟฟ์ผู้หิวโหย' WHERE name = 'Hungry Ogjeff';

-- J
UPDATE raids SET name_th = 'โจชัว เบเซลเรน' WHERE name = 'Joshua Baselrane';

-- K
UPDATE raids SET name_th = 'ผู้ถือกุญแจ' WHERE name = 'Key Holder';
UPDATE raids SET name_th = 'ราชาเบเทลจุส' WHERE name = 'King Betelgeuse';
UPDATE raids SET name_th = 'ราชาแคสเตอร์' WHERE name = 'King Castor';
UPDATE raids SET name_th = 'ราชาหัวมังกร 1' WHERE name = 'King Dragon Head 1';
UPDATE raids SET name_th = 'ราชาหัวมังกร 2' WHERE name = 'King Dragon Head 2';
UPDATE raids SET name_th = 'ราชาพอลลักซ์' WHERE name = 'King Pollux';
UPDATE raids SET name_th = 'คราณัส จอมทัพผู้ยิ่งใหญ่' WHERE name = 'Kranus the Great Warlord';
UPDATE raids SET name_th = 'คุมบา' WHERE name = 'Kumba';

-- L
UPDATE raids SET name_th = 'ลาวิด' WHERE name = 'Lavid';
UPDATE raids SET name_th = 'ลิฟวร์' WHERE name = 'Livre';
UPDATE raids SET name_th = 'แม่มดราคะ' WHERE name = 'Lust Witch';

-- M
UPDATE raids SET name_th = 'นักเวทแห่งความสิ้นหวัง' WHERE name = 'Mage of Despair';
UPDATE raids SET name_th = 'นักเวทแห่งความโลภ' WHERE name = 'Mage of Greed';
UPDATE raids SET name_th = 'นักเวทแห่งความเจ็บปวด' WHERE name = 'Mage of Pain';
UPDATE raids SET name_th = 'ผู้บัญชาการกองพันที่ 1 กองทหารเวทย์, ไวเคานต์ลิลลี่' WHERE name = 'Magic Corps 1st Battalion Commander, Viscount Lily';
UPDATE raids SET name_th = 'หน่วยสนับสนุนเวทย์, พันตรีชานะ' WHERE name = 'Magic Support Unit, Major Shana';
UPDATE raids SET name_th = 'อาวุธชำระล้างมนุษยชาติ, อีวิล' WHERE name = 'Mankind-Cleansing-Weapon, Evil';
UPDATE raids SET name_th = 'มันทารา' WHERE name = 'Mantara';
UPDATE raids SET name_th = 'เมเดีย' WHERE name = 'Medeia';
UPDATE raids SET name_th = 'นาวาสผู้กินความทรงจำ' WHERE name = 'Memory-Eating Navas';
UPDATE raids SET name_th = 'ราชาแห่งวิญญาณ' WHERE name = 'Monarch of Ghost';
UPDATE raids SET name_th = 'มูนไนท์' WHERE name = 'Moon Night';
UPDATE raids SET name_th = 'ปลากบกลายพันธุ์ 3' WHERE name = 'Mutated Frogfish 3';

-- N
UPDATE raids SET name_th = 'โนเวีย' WHERE name = 'Novia';

-- P
UPDATE raids SET name_th = 'ผู้นำหน่วยปราบปรามปาทริกยอน, พันโทอาฟเตอร์ช็อก' WHERE name = 'Patrikyon Riot Squad Leader, Lt. Colonel After Shock';
UPDATE raids SET name_th = 'หน่วยสำรวจปาทริกยอน, พันโทคิลบอร์น' WHERE name = 'Patrikyon Search Party, Lt. Colonel Killborn';
UPDATE raids SET name_th = 'หน่วยจู่โจมปาทริกยอน, พันโทแม็กซ์ 12' WHERE name = 'Patrikyon Striking Force, Lt. Colonel Max 12';
UPDATE raids SET name_th = 'พลูตอน' WHERE name = 'Pluton';

-- Q
UPDATE raids SET name_th = 'ควีนส์อีตเตอร์' WHERE name = 'Queenz-eater';

-- R
UPDATE raids SET name_th = 'วิญญาณไทแทนสีน้ำเงินผู้บ้าคลั่ง' WHERE name = 'Reckless Blue Titans Spirit';
UPDATE raids SET name_th = 'วิญญาณไทแทนสีแดงผู้บ้าคลั่ง' WHERE name = 'Reckless Red Titans Spirit';
UPDATE raids SET name_th = 'ผีมรณะสีแดง' WHERE name = 'Red Death Wraith';
UPDATE raids SET name_th = 'หัวหน้ายามเร็กซ์, พันเอกมาดอร์' WHERE name = 'Rex Chief Guard, Colonel Mador';
UPDATE raids SET name_th = 'ไรโนเซอร์' WHERE name = 'Rhinoceur';
UPDATE raids SET name_th = 'ไซด็อกพเนจร' WHERE name = 'Roaming Cydog';
UPDATE raids SET name_th = 'โรส, หัวใจ' WHERE name = 'Rose, The Heart';
UPDATE raids SET name_th = 'โรส, จิตวิญญาณ' WHERE name = 'Rose, The Spirit';
UPDATE raids SET name_th = 'รูอินครูเกอร์แห่งชีวิต' WHERE name = 'Ruincruger of Life';

-- S
UPDATE raids SET name_th = 'โซเทอแรล' WHERE name = 'Sauterelle';
UPDATE raids SET name_th = 'ซานบกผู้น่ากลัว' WHERE name = 'Scary Sanbok';
UPDATE raids SET name_th = 'เซคเมต' WHERE name = 'Sekhmet';
UPDATE raids SET name_th = 'ชีโอลแห่งตัณหา' WHERE name = 'Sheol of Desire';
UPDATE raids SET name_th = 'โซลทีกัส' WHERE name = 'Soltiegus';
UPDATE raids SET name_th = 'โซล มอธเทน' WHERE name = 'Soul Mothtein';
UPDATE raids SET name_th = 'ดิวิโนผิวเหล็ก' WHERE name = 'Steel Skin Divino';
UPDATE raids SET name_th = 'สโตน คอร์เตส' WHERE name = 'Stone Cortes';
UPDATE raids SET name_th = 'ทหารรบหลงทาง' WHERE name = 'Straggled Combat Soldier';
UPDATE raids SET name_th = 'ยามหลงทาง' WHERE name = 'Straggled Guard';
UPDATE raids SET name_th = 'ทหารหอกหลงทาง' WHERE name = 'Straggled Lanceman';
UPDATE raids SET name_th = 'ทหารโล่หลงทาง' WHERE name = 'Straggled Peltast';

-- T
UPDATE raids SET name_th = 'ซิเคาผู้ไม่ย่อท้อ' WHERE name = 'Tenacious Sicao';
UPDATE raids SET name_th = 'เทสเซอเร ฟาร์เรล' WHERE name = 'Tesserae Pharrel';
UPDATE raids SET name_th = 'เทสทอร์เมนโต' WHERE name = 'Testormento';
UPDATE raids SET name_th = 'นักเก็บเกี่ยว' WHERE name = 'The Harvester';
UPDATE raids SET name_th = 'เอลมินอร์หน้าหนา' WHERE name = 'Thick Face Elminor';
UPDATE raids SET name_th = 'ปอร์เตโรแห่งกาลเวลาและอวกาศ' WHERE name = 'Time and Space Portero';
UPDATE raids SET name_th = 'นักสู้วิญญาณไทแทน' WHERE name = 'Titans Spirit Fighter';
UPDATE raids SET name_th = 'คู่แฝดแห่งสุข เนฟทิส' WHERE name = 'Twin Pleasure Nephthys';
UPDATE raids SET name_th = 'คู่แฝดแห่งกาม เนฟทิส' WHERE name = 'Twin Sensual Nephthys';

-- U
UPDATE raids SET name_th = 'อันเดอร์เทเกอร์' WHERE name = 'Undertaker';
UPDATE raids SET name_th = 'ยูเรอัส' WHERE name = 'Uraeus';

-- V
UPDATE raids SET name_th = 'แวร์โก้ผู้ถูกสาป' WHERE name = 'Vergo the Cursed';
UPDATE raids SET name_th = 'เกเรโรผู้ดุร้าย' WHERE name = 'Violent Gerero';

-- W
UPDATE raids SET name_th = 'วูล์ฟไรเนอร์' WHERE name = 'Wolfriner';
UPDATE raids SET name_th = 'เดวิลแห่งพิโรธ' WHERE name = 'Wrath Devil';
