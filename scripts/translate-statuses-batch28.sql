-- Batch 28: I section — Increase series + others (947-1050)

UPDATE statuses SET description_th = 'ต้านทานดาเมจเวทย์ที่ใช้กับตัวเองอย่างมาก' WHERE id = 947;
UPDATE statuses SET description_th = 'ถูกใยแมงมุมจับ ตกลงพื้นและหยุดเคลื่อนไหว' WHERE id = 948;
UPDATE statuses SET description_th = 'เพิ่มเจาะเกราะจิต A.R. และภูมิคุ้มกัน ยกเลิกเมื่อเปลี่ยนสแตนซ์' WHERE id = 949;
UPDATE statuses SET description_th = 'หยุดเคลื่อนไหว การหลบและบล็อกลดเป็น 0 เป็นเวลา 10 วินาที' WHERE id = 950;
UPDATE statuses SET description_th = 'เมื่อ buff หมด จะถูกสตั้นหนัก' WHERE id = 951;
UPDATE statuses SET description_th = 'A.R. เพิ่ม +1' WHERE id = 952;
UPDATE statuses SET description_th = 'A.R. และ D.R. เพิ่ม +1 หายเมื่อเปลี่ยนพื้นที่' WHERE id = 953;
UPDATE statuses SET description_th = 'D.R. เพิ่ม +1' WHERE id = 955;
UPDATE statuses SET description_th = 'ไม่สามารถทำอะไรได้ ได้รับดาเมจ 2 เท่าตลอดระยะเวลา' WHERE id = 957;
UPDATE statuses SET description_th = '[Lv 1]: ดาเมจมอนสเตอร์ +100%, ละเว้นพลังป้องกัน +17%, เจาะเกราะ +16' WHERE id = 958;
UPDATE statuses SET description_th = 'เพิ่มความสามารถในการต่อสู้ด้วยการปรับปรุงเกราะ' WHERE id = 959;
UPDATE statuses SET description_th = 'เพิ่มดาเมจกายภาพให้สมาชิกทีมทั้งหมด' WHERE id = 960;
UPDATE statuses SET description_th = 'แสดงพลังของ Three Mudras Ten Chi Jin' WHERE id = 961;

-- Increase series
UPDATE statuses SET description_th = 'เพิ่ม AGI ของสมาชิกทั้งหมดชั่วคราว' WHERE id = 962;
UPDATE statuses SET description_th = 'เพิ่มสถานะทั้งหมดของสมาชิกทั้งหมดชั่วคราว' WHERE id = 963;
UPDATE statuses SET description_th = 'เพิ่ม DEX ของสมาชิกทั้งหมดชั่วคราว' WHERE id = 964;
UPDATE statuses SET description_th = 'เพิ่ม HP ของสมาชิกทั้งหมดชั่วคราว' WHERE id = 965;
UPDATE statuses SET description_th = 'เพิ่ม INT ของสมาชิกทั้งหมดชั่วคราว' WHERE id = 966;
UPDATE statuses SET description_th = 'เพิ่ม SEN ของสมาชิกทั้งหมดชั่วคราว' WHERE id = 967;
UPDATE statuses SET description_th = 'เพิ่ม STR ของสมาชิกทั้งหมดชั่วคราว' WHERE id = 968;
UPDATE statuses SET description_th = 'เพิ่ม A.R.' WHERE id = 969;
UPDATE statuses SET description_th = 'เพิ่มพลังโจมตี +5%' WHERE id = 971;
UPDATE statuses SET description_th = 'เพิ่มความเร็วโจมตี' WHERE id = 975;
UPDATE statuses SET description_th = 'เพิ่มความแม่นยำ +5%' WHERE id = 978;
UPDATE statuses SET description_th = 'เพิ่มบล็อก' WHERE id = 980;
UPDATE statuses SET description_th = 'เพิ่มค่าประสบการณ์การต่อสู้ +20% หายเมื่อเปลี่ยนพื้นที่' WHERE id = 981;
UPDATE statuses SET description_th = 'เพิ่ม D.R. +0.5' WHERE id = 982;
UPDATE statuses SET description_th = 'เพิ่มพลังป้องกัน' WHERE id = 985;
UPDATE statuses SET description_th = 'เพิ่มต้านทาน Debuff' WHERE id = 987;
UPDATE statuses SET description_th = 'เพิ่มโอกาสได้รับไอเทม 10% หายเมื่อเปลี่ยนพื้นที่' WHERE id = 988;
UPDATE statuses SET description_th = 'เพิ่มค่าประสบการณ์การต่อสู้ หายเมื่อเปลี่ยนพื้นที่' WHERE id = 990;
UPDATE statuses SET description_th = 'เพิ่มการหลบ' WHERE id = 993;
UPDATE statuses SET description_th = 'เพิ่มพลังโจมตีไฟ' WHERE id = 994;
UPDATE statuses SET description_th = 'เพิ่มต้านทานไฟ' WHERE id = 995;
UPDATE statuses SET description_th = 'เพิ่มพลังโจมตีน้ำแข็ง' WHERE id = 996;
UPDATE statuses SET description_th = 'เพิ่มต้านทานน้ำแข็ง' WHERE id = 997;
UPDATE statuses SET description_th = 'เพิ่มภูมิคุ้มกัน' WHERE id = 998;
UPDATE statuses SET description_th = 'เพิ่มพลังโจมตีสายฟ้า' WHERE id = 999;
UPDATE statuses SET description_th = 'เพิ่มต้านทานสายฟ้า' WHERE id = 1000;

-- More Increase series
UPDATE statuses SET description_th = 'เพิ่ม HP สูงสุด' WHERE name = 'Increase Max HP' AND description_th IS NULL;
UPDATE statuses SET description_th = 'เพิ่ม SP สูงสุด' WHERE name = 'Increase Max SP' AND description_th IS NULL;
UPDATE statuses SET description_th = 'เพิ่มพลังโจมตีจิต' WHERE name = 'Increase Mental ATK' AND description_th IS NULL;
UPDATE statuses SET description_th = 'เพิ่มต้านทานจิต' WHERE name = 'Increase Mental RES' AND description_th IS NULL;
UPDATE statuses SET description_th = 'เพิ่มความเร็วเคลื่อนที่' WHERE name = 'Increase Move SPD' AND description_th IS NULL;
UPDATE statuses SET description_th = 'เพิ่มเจาะเกราะ' WHERE name = 'Increase Penetration' AND description_th IS NULL;
UPDATE statuses SET description_th = 'เพิ่มค่าประสบการณ์สแตนซ์ 50% หายเมื่อเปลี่ยนพื้นที่' WHERE name = 'Increase Stance EXP' AND description_th IS NULL;
