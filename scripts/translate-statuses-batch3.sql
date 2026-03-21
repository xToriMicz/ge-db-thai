-- Batch 3: A-section continued (58-83)

UPDATE statuses SET description_th = 'เพิ่มความเร็วโจมตีและอัตราคริติคอลเป็นระยะเวลาหนึ่ง แต่ลดพลังป้องกัน' WHERE id = 58;
UPDATE statuses SET description_th = 'A.R. +1, D.R. +1, เจาะเกราะ +10, เวลาล้มลง -50%, เพิ่มพลังโจมตี' WHERE id = 60;
UPDATE statuses SET description_th = 'พลังโจมตี +5%, พลังโจมตีเวทย์ +4%, มีโอกาสใส่ [Cold Storm] ให้ศัตรู' WHERE id = 61;
UPDATE statuses SET description_th = 'เพิ่มค่าโจมตี แต่ลดค่าป้องกัน' WHERE id = 63;
UPDATE statuses SET description_th = 'เพิ่ม SP สูงสุดและพลังโจมตีจิต แต่ลดความเร็วเคลื่อนที่' WHERE id = 66;
UPDATE statuses SET description_th = 'เพิ่มพลังโจมตีตลอดระยะเวลา' WHERE id = 67;
UPDATE statuses SET description_th = 'เพิ่มความสามารถทางกายภาพโดยขับเคลื่อนร่างกายเป็นสัตว์ร้าย' WHERE id = 69;
UPDATE statuses SET description_th = 'พลังโบราณแห่งความโกลาหล ไม่สามารถแยกแยะพวกเดียวกันได้' WHERE id = 70;
UPDATE statuses SET description_th = 'ได้รับสิทธิ์เข้าดันเจี้ยนโบราณ' WHERE id = 72;
UPDATE statuses SET description_th = 'ใช้พลังโบราณมากเกินไป ความเร็วเคลื่อนที่ลดลง' WHERE id = 73;
UPDATE statuses SET description_th = 'เพิ่มค่าประสบการณ์การต่อสู้และสแตนซ์ 50% ลดดาเมจ 10%' WHERE id = 79;
UPDATE statuses SET description_th = 'A.R. +1, ดาเมจมอนสเตอร์ Lifeless +30%, เจาะเกราะ +10' WHERE id = 80;
UPDATE statuses SET description_th = 'ความโกรธรุนแรง เพิ่มพลังโจมตีและป้องกัน' WHERE id = 81;
UPDATE statuses SET description_th = '[PvP] ดาเมจที่ได้รับจากสแตนซ์ [Zilea] เพิ่มขึ้น ดาเมจต่อ [Atlas] ลดลง' WHERE id = 82;
UPDATE statuses SET description_th = 'ความเร็วเคลื่อนที่ลดครึ่งหนึ่ง และพลังป้องกันลดลง' WHERE id = 83;

-- B-section
UPDATE statuses SET description_th = 'แบริเออร์กันดาเมจ' WHERE name = 'Barrier' AND description_th IS NULL;
UPDATE statuses SET description_th = 'เพิ่มพลังโจมตีเมื่ออยู่ในสถานะ Berserk' WHERE name = 'Berserk' AND description_th IS NULL;
UPDATE statuses SET description_th = 'เลือดไหล ลด HP อย่างต่อเนื่อง' WHERE name = 'Bleeding' AND description_th IS NULL;
UPDATE statuses SET description_th = 'บล็อกดาเมจ' WHERE name = 'Block' AND description_th IS NULL;
UPDATE statuses SET description_th = 'เพิ่มพลังและความสามารถ' WHERE name = 'Boost' AND description_th IS NULL;
UPDATE statuses SET description_th = 'ลดพลังป้องกันของศัตรู' WHERE name = 'Break Armor' AND description_th IS NULL;
UPDATE statuses SET description_th = 'พลังโจมตีเพิ่มอย่างมาก' WHERE name = 'Buff ATK' AND description_th IS NULL;
UPDATE statuses SET description_th = 'พลังป้องกันเพิ่มอย่างมาก' WHERE name = 'Buff DEF' AND description_th IS NULL;
