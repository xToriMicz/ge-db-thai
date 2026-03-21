-- Batch 1: Common debuff/buff statuses (hand-translated full sentences)
-- Focus: frequently encountered statuses in gameplay

-- Abyss Stigma (multi-level debuff)
UPDATE statuses SET description_th = '[ระดับ 1]: พลังป้องกัน -3, ต้านทานทั้งหมด -3 เป็นเวลา 10 วินาที [ระดับ 2]: D.R. -1, พลังป้องกัน -6 [ระดับ 3]: D.R. -1, พลังป้องกัน -9' WHERE id = 15;

-- Abet
UPDATE statuses SET description_th = '[Abet] D.R. -1, พลังโจมตี -20%, ความเร็วเคลื่อนที่ -20%' WHERE id = 11;

-- Acelerar
UPDATE statuses SET description_th = '[Acelerar] A.R. +2, เวลาร่ายสกิล -30%' WHERE id = 20;

-- Acide et Poison
UPDATE statuses SET description_th = '[Acide et Poison] [PvP] A.R. -1, D.R. -1, พลังป้องกัน -10, ภูมิคุ้มกัน -10, เจาะเกราะ -10' WHERE id = 21;

-- Agony
UPDATE statuses SET description_th = '[Agony] ลดความเร็วเคลื่อนที่ และลด HP อย่างต่อเนื่อง' WHERE id = 43;

-- Action
UPDATE statuses SET description_th = '[Action] พลังโจมตี +40%, เวลาร่ายสกิล -20%, ดาเมจที่โดนทั้งหมด +30%, D.R. -2' WHERE id = 23;

-- Action - Acceleration
UPDATE statuses SET description_th = '[Action - Acceleration] ความเร็วเคลื่อนที่ +10%, ขีดจำกัดความเร็วเคลื่อนที่ +10%' WHERE id = 24;

-- Alchemic Strengthening
UPDATE statuses SET description_th = '[Alchemic Strengthening] A.R. +1, พลังโจมตี +20%, เวลาร่ายสกิล -10%' WHERE id = 50;

-- Aegis Shield
UPDATE statuses SET description_th = 'ระยะเวลา: 90 วินาที พลังป้องกัน +2 ต่อระดับ buff, HP สูงสุด +3% ต่อระดับ buff' WHERE id = 36;

-- Aether
UPDATE statuses SET description_th = '[Aether] พลังโจมตี +25%, เจาะเกราะ +20, เวลาร่ายสกิล -30%' WHERE id = 38;

-- Alchemic Realm - Fire/Ice/Plague
UPDATE statuses SET description_th = '[Alchemic Realm - Fire] พลังป้องกัน -10%, [PvP] HP สูงสุด -25%, [มอนสเตอร์] HP สูงสุด -20%' WHERE id = 51;
UPDATE statuses SET description_th = '[Alchemic Realm - Ice] ความเร็วเคลื่อนที่ -20%, [PvP] อัตราหลบ -50%, [มอนสเตอร์] ความเร็วโจมตี -30%' WHERE id = 52;
UPDATE statuses SET description_th = '[Alchemic Realm - Plague] HP สูงสุด -5%, [PvP] HP สูงสุด -20%, SP สูงสุด -50%' WHERE id = 53;

-- Aggravation of Scar
UPDATE statuses SET description_th = 'แผลเป็นรุนแรงขึ้นจากคำสาปของ Baron' WHERE id = 40;

-- Common simple statuses
UPDATE statuses SET description_th = 'หยุดเคลื่อนไหวชั่วคราว' WHERE name = 'Stun' AND description_th IS NULL;
UPDATE statuses SET description_th = 'แช่แข็ง ไม่สามารถเคลื่อนไหวได้' WHERE name = 'Freeze' AND description_th IS NULL;
UPDATE statuses SET description_th = 'ได้รับพิษ ลด HP อย่างต่อเนื่อง' WHERE name = 'Poison' AND description_th IS NULL;
UPDATE statuses SET description_th = 'ลุกไหม้ ลด HP อย่างต่อเนื่อง' WHERE name = 'Burn' AND description_th IS NULL;
UPDATE statuses SET description_th = 'หลับ ไม่สามารถเคลื่อนไหวหรือโจมตีได้' WHERE name = 'Sleep' AND description_th IS NULL;
UPDATE statuses SET description_th = 'กลัว ไม่สามารถเคลื่อนไหวได้' WHERE name = 'Fear' AND description_th IS NULL;
UPDATE statuses SET description_th = 'ช็อก ไม่สามารถเคลื่อนไหวได้' WHERE name = 'Shock' AND description_th IS NULL;
UPDATE statuses SET description_th = 'เงียบ ไม่สามารถใช้สกิลได้' WHERE name = 'Silence' AND description_th IS NULL;
UPDATE statuses SET description_th = 'สับสน เคลื่อนที่แบบสุ่ม' WHERE name = 'Confusion' AND description_th IS NULL;
UPDATE statuses SET description_th = 'มืดบอด ลดความแม่นยำ' WHERE name = 'Blind' AND description_th IS NULL;
UPDATE statuses SET description_th = 'ล้มลง ไม่สามารถเคลื่อนไหวชั่วคราว' WHERE name = 'Knockdown' AND description_th IS NULL;
UPDATE statuses SET description_th = 'ล้มลง ไม่สามารถเคลื่อนไหวชั่วคราว' WHERE name = 'Knock Down' AND description_th IS NULL;

-- Common buff names
UPDATE statuses SET description_th = 'เพิ่มพลังโจมตี' WHERE name = 'ATK Up' AND description_th IS NULL;
UPDATE statuses SET description_th = 'เพิ่มพลังป้องกัน' WHERE name = 'DEF Up' AND description_th IS NULL;
UPDATE statuses SET description_th = 'เพิ่มความเร็วเคลื่อนที่' WHERE name = 'Speed Up' AND description_th IS NULL;
UPDATE statuses SET description_th = 'เพิ่มความเร็วโจมตี' WHERE name = 'ATK SPD Up' AND description_th IS NULL;
UPDATE statuses SET description_th = 'กันตาย HP เหลือ 1' WHERE name = 'Invincible' AND description_th IS NULL;

-- Barrier types
UPDATE statuses SET description_th = 'สร้างแบริเออร์ดูดซับดาเมจ' WHERE name = 'Barrier' AND description_th IS NULL;
UPDATE statuses SET description_th = 'สร้างแบริเออร์ป้องกันดาเมจ' WHERE name = 'Magic Barrier' AND description_th IS NULL;

-- Blessing types
UPDATE statuses SET description_th = 'ได้รับพร เพิ่มสถานะต่างๆ' WHERE name = 'Blessing' AND description_th IS NULL;
UPDATE statuses SET description_th = 'พรศักดิ์สิทธิ์ เพิ่มพลังโจมตีและป้องกัน' WHERE name = 'Divine Blessing' AND description_th IS NULL;

-- Provoke/Aggro
UPDATE statuses SET description_th = 'ยั่วยุ ศัตรูโจมตีตัวนี้เป็นเป้าหมายหลัก' WHERE name = 'Provoke' AND description_th IS NULL;
UPDATE statuses SET description_th = 'ยั่วยุ ดึงความสนใจศัตรู' WHERE name = 'Taunt' AND description_th IS NULL;

-- Resurrection
UPDATE statuses SET description_th = 'ฟื้นคืนชีพ' WHERE name = 'Resurrection' AND description_th IS NULL;
UPDATE statuses SET description_th = 'ฟื้นคืนชีพอัตโนมัติเมื่อตาย' WHERE name = 'Auto Resurrection' AND description_th IS NULL;
