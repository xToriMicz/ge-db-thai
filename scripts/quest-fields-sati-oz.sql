-- Sati batch: Quest structured fields O-Z (required_items, rewards, conditions, boss_name)
-- 23 stages across panfilo, selva, sharon, soso, vincent

-- === PANFILO (quest_id=22) ===
UPDATE quest_stages SET conditions = 'Lv.1', required_items = '[]', rewards = '["เทเลพอร์ตสครอล (กิจกรรม)"]', boss_name = NULL WHERE quest_id = 22 AND stage_num = 1;
UPDATE quest_stages SET conditions = 'Lv.16 + ผ่านเควสท์ กำจัดแมนดราโดร่า', required_items = '[]', rewards = '["ค่าประสบการณ์"]', boss_name = NULL WHERE quest_id = 22 AND stage_num = 2;
UPDATE quest_stages SET conditions = 'Lv.24 + ผ่านเควสท์ น้ำมนต์ลึกลับ และ คำขอร้องเกี่ยวกับดวงวิญญาณ', required_items = '["Wild Boar Meat x10", "นมเฟอร์รุซซิโอ x1", "พาสต้า+พาเมซันชีส x1"]', rewards = '["อิโรลิน่าแฮท x1"]', boss_name = NULL WHERE quest_id = 22 AND stage_num = 3;
UPDATE quest_stages SET conditions = 'ผ่านด่าน 3', required_items = '["หนวดออตโตปุส x10"]', rewards = '["เพอร์ชา อินเซลล่า [เควสท์]", "ไชนี่ คริสตัล"]', boss_name = NULL WHERE quest_id = 22 AND stage_num = 4;
UPDATE quest_stages SET conditions = 'Lv.50 + ห้ามให้วัวตายเกิน 5 ตัว', required_items = '[]', rewards = '["การ์ดตัวละคร แพนฟิโล่ เดอ นาร์เวซ", "ไชนี่ คริสตัล"]', boss_name = NULL WHERE quest_id = 22 AND stage_num = 5;

-- === SELVA (quest_id=9) ===
UPDATE quest_stages SET conditions = 'Veteran + ผ่านเควสท์หลัก Sedecram', required_items = '["สัญลักษณ์วีรบุรุษ x2"]', rewards = '["การ์ด EXP B เวเทอรัน x3"]', boss_name = NULL WHERE quest_id = 9 AND stage_num = 1;
UPDATE quest_stages SET conditions = 'ผ่านด่าน 1', required_items = '[]', rewards = '["การ์ด EXP G เวเทอรัน x3"]', boss_name = 'ดอกเตอร์ฟราน โมห์เธียน, คริสซาลิส' WHERE quest_id = 9 AND stage_num = 2;
UPDATE quest_stages SET conditions = 'ผ่านด่าน 2', required_items = '["แก่นปีศาจ x1", "เนื้อหมาป่า x5", "หัวผักกาด x1", "กะหล่ำ x1", "เมตามอโฟซิสสโตน x10"]', rewards = '["การ์ดตัวละคร เซลวา นอร์ท", "ตำรา Rabida Espada", "Recipe Salva Arm Shield", "การ์ด EXP B เวเทอรัน x3"]', boss_name = 'เซลวา นอร์ท, ชารอน' WHERE quest_id = 9 AND stage_num = 3;
UPDATE quest_stages SET conditions = 'ผ่านด่าน 3 + มีเซลวา นอร์ทในทีม + อย่างน้อย 2 คน', required_items = '[]', rewards = '["การ์ด EXP G เวเทอรัน x1"]', boss_name = NULL WHERE quest_id = 9 AND stage_num = 4;
UPDATE quest_stages SET conditions = 'ผ่านด่าน 4 + มีเซลวา นอร์ทในทีม', required_items = '["กระดาษบันทึกการสำรวจ x30"]', rewards = '["การ์ด EXP G เวเทอรัน x1"]', boss_name = 'ชารอน' WHERE quest_id = 9 AND stage_num = 5;
UPDATE quest_stages SET conditions = 'ผ่านด่าน 5 + มีเซลวา นอร์ทในทีม', required_items = '["หัวใจของฟอร์โด x20"]', rewards = '["การ์ด EXP G เวเทอรัน x1"]', boss_name = NULL WHERE quest_id = 9 AND stage_num = 6;

-- === SHARON (quest_id=1) ===
UPDATE quest_stages SET conditions = 'ผ่านเควสท์ 7 อัน: เซลวา นาร์ อาเนีย เฮเลน่า เอมิเลียด้านมืด เบียทริซ + ไวรอน ตอน 4', required_items = '[]', rewards = '[]', boss_name = 'ชารอน' WHERE quest_id = 1 AND stage_num = 1;
UPDATE quest_stages SET conditions = 'เบียทริซต้องเป็นหัวหน้าทีม', required_items = '[]', rewards = '["การ์ดตัวละคร ชารอน", "การ์ด EXP G x3"]', boss_name = NULL WHERE quest_id = 1 AND stage_num = 2;
UPDATE quest_stages SET conditions = 'ชารอนเป็นหัวหน้าทีม', required_items = '["Taurus Milk x10", "Arctic Lazim-lam wing pieces x10", "Superior Quality Cabaco x10"]', rewards = '["การ์ด EXP G x3"]', boss_name = NULL WHERE quest_id = 1 AND stage_num = 3;
UPDATE quest_stages SET conditions = 'มีชารอน เอมิเลีย อาเนีย ในทีม', required_items = '["Melting Brain Chocolate x1"]', rewards = '["การ์ด EXP G x3"]', boss_name = 'อาเนีย, จาร์เล็น (มูฟาซา)' WHERE quest_id = 1 AND stage_num = 4;
UPDATE quest_stages SET conditions = 'มีชารอน 1 คนในทีมเท่านั้น', required_items = '[]', rewards = '["การ์ด EXP G x3"]', boss_name = NULL WHERE quest_id = 1 AND stage_num = 5;

-- === SOSO (quest_id=13) ===
UPDATE quest_stages SET conditions = 'Lv.78 + ผ่านเควสท์เนื้อเรื่องหลักเมืองอุช', required_items = '[]', rewards = '[]', boss_name = 'โซโซ' WHERE quest_id = 13 AND stage_num = 1;
UPDATE quest_stages SET conditions = 'ผ่านด่าน 1', required_items = '[]', rewards = '["การ์ดตัวละคร โซโซ"]', boss_name = 'แจค โอ แลนเทิร์น' WHERE quest_id = 13 AND stage_num = 2;

-- === VINCENT (quest_id=12) ===
UPDATE quest_stages SET conditions = 'ผ่านเนื้อเรื่องหลักไวรอน + ปลดล็อกอังเดร + มีอังเดรในทีม', required_items = '[]', rewards = '["การ์ด EXP Level 71 x3"]', boss_name = NULL WHERE quest_id = 12 AND stage_num = 1;
UPDATE quest_stages SET conditions = 'ผ่านด่าน 1', required_items = '["บันทึกของ Dialos Latemen x1"]', rewards = '[]', boss_name = NULL WHERE quest_id = 12 AND stage_num = 2;
UPDATE quest_stages SET conditions = 'ผ่านด่าน 2', required_items = '["บันทึกของ Dialos Latemen x1"]', rewards = '[]', boss_name = NULL WHERE quest_id = 12 AND stage_num = 3;
UPDATE quest_stages SET conditions = 'ผ่านด่าน 3', required_items = '["บันทึกของ Dialos Latemen x2"]', rewards = '[]', boss_name = NULL WHERE quest_id = 12 AND stage_num = 4;
UPDATE quest_stages SET conditions = 'ผ่านด่าน 4', required_items = '[]', rewards = '["การ์ด EXP Level 71 x9", "การ์ดตัวละคร วินเซ็นต์"]', boss_name = NULL WHERE quest_id = 12 AND stage_num = 5;
