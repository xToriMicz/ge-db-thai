-- Thai translations v2: hand-translated important statuses only
-- Complex/unique entries left as English — better than bad translation

-- Common buff statuses
UPDATE statuses SET description_th = 'สถานะทั้งหมด +3, แฟชั่น +5' WHERE description = '[Looking Good] All Stats +3, Fashion +5';
UPDATE statuses SET description_th = 'พลังโจมตี +10%, เจาะเกราะ +10, ความแม่นยำ +5, คริติคอล +5, ค่าประสบการณ์ +200%, ค่าประสบการณ์สแตนซ์ +200%' WHERE description = 'ATK +10%, Penetration +10, Accuracy +5, Critical +5, EXP +200%, Stance EXP +200%';

-- Common debuffs
UPDATE statuses SET description_th = 'พลังป้องกันลด 50% เป็นเวลา 20 วินาที' WHERE description = '[Armor Crasher] DEF decreases by 50% for 20 secs.';
UPDATE statuses SET description_th = 'โจมตีและสกิลถูกจำกัดเป็นเวลา 10 วินาที, HP สูงสุดลด 25%' WHERE description = '[Burn] Attack and Skill restricted for 10 secs, Max HP drop by 25%.';
UPDATE statuses SET description_th = 'ความเร็วเคลื่อนที่ลดครึ่งหนึ่งเป็นเวลา 10 วินาที, พลังป้องกันไม่ทำงาน' WHERE description = '[Electric Shock] Decrease Movement Speed by half for 10 secs, No DEF work.';
UPDATE statuses SET description_th = 'พลังโจมตี, ความเร็วโจมตี และความเร็วเคลื่อนที่ลด 15% พลังป้องกันลด 50' WHERE description = '[Mortal Wound] Decreased ATK, ATK SPD and Movement Speed by 15%. Decreased DEF by 50.';
UPDATE statuses SET description_th = 'ลด HP อย่างต่อเนื่อง และ A.R., D.R., พลังป้องกันลดลง' WHERE description = '[Pressure] Decreases HP gradually for the duration, and A.R., D.R., DEF are decreased.';
UPDATE statuses SET description_th = 'HP สูงสุดลด 25%, ขีดจำกัดต้านทานไฟเพิ่มขึ้น, ต้านทานไฟลด 5' WHERE description = '[Sweltering] Max HP -25%, Fire RES limitation increases, decrease Fire RES -5.';
UPDATE statuses SET description_th = 'เพิ่มค่าประสบการณ์การต่อสู้ ค่าประสบการณ์สแตนซ์ ดาเมจมอนสเตอร์ และลดดาเมจจากมอนสเตอร์' WHERE description = '[Holy] Increases Battle, Stance EXP, Monster Damage and decrease Damage from monster.';

-- D.R. / A.R. statuses
UPDATE statuses SET description_th = 'D.R. -1, พลังป้องกัน -10, ความเร็วโจมตี -10%, พลังโจมตี -5%' WHERE description LIKE '[enemys] D.R. -1, DEF -10%';

-- Stun/Freeze/Poison base descriptions
UPDATE statuses SET description_th = 'ไม่สามารถเคลื่อนไหวหรือโจมตีได้' WHERE description = 'Unable to move or attack.';
UPDATE statuses SET description_th = 'ไม่สามารถเคลื่อนไหวได้' WHERE description = 'Unable to move.';
UPDATE statuses SET description_th = 'ไม่สามารถใช้สกิลได้' WHERE description = 'Unable to use skills.';
UPDATE statuses SET description_th = 'ลด HP อย่างต่อเนื่อง' WHERE description = 'HP decreases over time.';
UPDATE statuses SET description_th = 'พลังโจมตีเพิ่ม' WHERE description = 'ATK increases.';
UPDATE statuses SET description_th = 'พลังป้องกันเพิ่ม' WHERE description = 'DEF increases.';
UPDATE statuses SET description_th = 'ความเร็วเคลื่อนที่เพิ่ม' WHERE description = 'Movement Speed increases.';
UPDATE statuses SET description_th = 'ความเร็วเคลื่อนที่ลด' WHERE description = 'Movement Speed decreases.';
UPDATE statuses SET description_th = 'ความเร็วโจมตีเพิ่ม' WHERE description = 'ATK SPD increases.';
UPDATE statuses SET description_th = 'ความเร็วโจมตีลด' WHERE description = 'ATK SPD decreases.';
UPDATE statuses SET description_th = 'ฟื้นฟู HP อย่างต่อเนื่อง' WHERE description = 'HP regenerates over time.';
UPDATE statuses SET description_th = 'ฟื้นฟู SP อย่างต่อเนื่อง' WHERE description = 'SP regenerates over time.';
UPDATE statuses SET description_th = 'ดูดซับ 5% ของดาเมจที่ได้รับเป็นเวลา 1 ชั่วโมง' WHERE description = 'Absorb 5% of incoming damage for 1 hour';
UPDATE statuses SET description_th = 'พลังโจมตี, ความเร็วโจมตี และความเร็วเคลื่อนที่ลด 50%, HP สูงสุดลด 30%, การฟื้นฟู SP ปิดใช้งาน' WHERE description = 'ATK, ATK SPD and Movement Speed -50%, Max HP -30%, SP regeneration disabled';
UPDATE statuses SET description_th = 'ค่าประสบการณ์เพิ่ม 200%' WHERE description = 'EXP +200%';
UPDATE statuses SET description_th = 'ค่าประสบการณ์เพิ่ม 100%' WHERE description = 'EXP +100%';
UPDATE statuses SET description_th = 'อัตราดรอปไอเทมเพิ่ม' WHERE description = 'Item drop rate increases.';
UPDATE statuses SET description_th = 'ประเภทเกราะ' WHERE description = 'Armor Type';
UPDATE statuses SET description_th = 'ความสามารถในการต่อสู้ของตัวละครจะดีขึ้น' WHERE description = 'Characters battle ability will improve';
