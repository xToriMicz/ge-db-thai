-- Batch 30: Mixed remaining gaps (various letters)

UPDATE statuses SET description_th = 'อาคารปกป้องผู้สร้าง' WHERE id = 289;
UPDATE statuses SET description_th = 'buff สกิลงานของ Meister Lorch' WHERE id = 291;
UPDATE statuses SET description_th = 'ละเว้นพลังป้องกัน +3% ต่อระดับ, เจาะเกราะกายภาพ +5 ต่อระดับ' WHERE id = 292;
UPDATE statuses SET description_th = 'A.R./D.R. +1, เจาะเกราะ +10%, เพิ่มดาเมจโจมตีปกติตาม STR และ DEX' WHERE id = 294;
UPDATE statuses SET description_th = 'เพิ่มพลังโจมตีเวทย์ เจาะเกราะเวทย์ ความเร็วโจมตี A.R./D.R. ดาเมจมอนสเตอร์' WHERE id = 298;
UPDATE statuses SET description_th = 'โจมตีเป้าหมายเพิ่มธาตุไฟ และต้านทานไฟเพิ่ม' WHERE id = 299;
UPDATE statuses SET description_th = 'D.R. -1, พลังป้องกัน -10, ต้านทานไฟ -10' WHERE id = 300;
UPDATE statuses SET description_th = 'สถานะทั้งหมด +3, ค่าประสบการณ์การต่อสู้ +20%, สแตนซ์ +20%, อัตราดรอป +20%' WHERE id = 301;
UPDATE statuses SET description_th = 'HP สูงสุด -25% เพิ่มขีดจำกัดต้านทานไฟ ลดต้านทานไฟ 5' WHERE id = 302;
UPDATE statuses SET description_th = 'A.R. +1, D.R. +1, พลังโจมตี +25%, พลังป้องกัน +10, ดาเมจมอนสเตอร์ +60%' WHERE id = 456;
UPDATE statuses SET description_th = 'A.R. +1, D.R. +1, พลังโจมตี +25%, พลังป้องกัน +10, ดาเมจมอนสเตอร์ +60%' WHERE id = 457;
UPDATE statuses SET description_th = 'หลบสกิลหนึ่งครั้ง หรือเพิ่มดาเมจสกิล' WHERE id = 501;
UPDATE statuses SET description_th = 'สกิลแรงขึ้นเมื่อบล็อกหรือหลบโจมตีศัตรู' WHERE id = 503;
UPDATE statuses SET description_th = 'พลังโจมตี +10% ต่อระดับ, ความแม่นยำ +10 ต่อระดับ, ความเร็วเคลื่อนที่ -20% ต่อระดับ' WHERE id = 505;
UPDATE statuses SET description_th = 'พลังป้องกัน -3 ต่อระดับ (สูงสุด 3) ความเร็วเคลื่อนที่ -10%' WHERE id = 507;
UPDATE statuses SET description_th = 'เพิ่มดาเมจมอนสเตอร์' WHERE id = 508;
UPDATE statuses SET description_th = 'ลดความเร็วเคลื่อนที่ชั่วคราว และลด SP อย่างรวดเร็ว' WHERE id = 509;
UPDATE statuses SET description_th = 'ได้รับบาดแผลสาหัส พลังโจมตี ความเร็วโจมตี ความเร็วเคลื่อนที่ -15% พลังป้องกัน -50' WHERE id = 511;
UPDATE statuses SET description_th = 'ลดความสามารถโจมตี' WHERE id = 512;
UPDATE statuses SET description_th = 'ไม่สามารถเคลื่อนที่ 10 วินาที ได้รับดาเมจเวทย์มาก ละเว้นดาเมจกายภาพ' WHERE id = 513;
UPDATE statuses SET description_th = 'เป้าหมายได้รับดาเมจ 3 เท่าชั่วคราว' WHERE id = 514;
UPDATE statuses SET description_th = 'ถูกโจมตีเกินจำนวนหนึ่งครั้งจะตาย' WHERE id = 515;
UPDATE statuses SET description_th = 'ลดความเร็วเคลื่อนที่และ HP สูงสุดชั่วคราว' WHERE id = 517;
UPDATE statuses SET description_th = 'ลดสถานะทั้งหมด' WHERE id = 518;
UPDATE statuses SET description_th = 'ลดความเร็วเคลื่อนที่ 20%' WHERE id = 520;
UPDATE statuses SET description_th = 'ลดความเร็วเคลื่อนที่ 50%' WHERE id = 521;
UPDATE statuses SET description_th = 'ไม่สามารถใช้ไอเทม [Ordens Curse]' WHERE id = 523;
UPDATE statuses SET description_th = 'ยิงกระสุนที่มีพลังศักดิ์สิทธิ์' WHERE id = 597;

-- N-O remaining
UPDATE statuses SET description_th = 'ลดความเร็วเคลื่อนที่ของมอนสเตอร์' WHERE name = 'Negative Zone' AND description_th IS NULL;
UPDATE statuses SET description_th = 'ยิงกระสุนที่มีพลังศักดิ์สิทธิ์' WHERE name = 'Neutral Shot' AND description_th IS NULL;
UPDATE statuses SET description_th = 'โจมตีปกติจะแรงขึ้น' WHERE name = 'Normal Enhancement' AND description_th IS NULL;
UPDATE statuses SET description_th = 'เพิ่มพลังโจมตีตลอดเวลา' WHERE name = 'Offensive Stance' AND description_th IS NULL;
UPDATE statuses SET description_th = 'เพิ่มพลังโจมตีของสิ่งเรียก' WHERE name = 'Offensive Summon' AND description_th IS NULL;
UPDATE statuses SET description_th = 'ลดค่าประสบการณ์ที่ได้รับ' WHERE name = 'Overconfidence' AND description_th IS NULL;
