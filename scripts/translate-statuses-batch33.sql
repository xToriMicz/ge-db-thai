-- Batch 33: Final remaining translatable entries

UPDATE statuses SET description_th = 'เดิมคือ [Blessing of Mercenaries] ไม่สามารถรับได้อีกหลังปฏิรูป' WHERE id = 832;
UPDATE statuses SET description_th = 'พลังป้องกัน -1, ความเร็วโจมตี -1% ต่อระดับ (สูงสุด 10) เปลี่ยนเป็น [Sonic Break] ที่ระดับ 10' WHERE id = 845;
UPDATE statuses SET description_th = 'ถูก Jane จับได้มากขึ้น ตามระดับจะได้รับผลกระทบต่อความสามารถ' WHERE id = 847;
UPDATE statuses SET description_th = 'Caisse จับจุดอ่อนของคุณ' WHERE id = 849;
UPDATE statuses SET description_th = 'ได้รับดาเมจเพิ่มจากสกิลถัดไป' WHERE id = 850;
UPDATE statuses SET description_th = 'ไม่สามารถเคลื่อนที่หรือใช้สกิลชั่วคราว ต้านทานลด' WHERE id = 851;
UPDATE statuses SET description_th = 'เคลื่อนที่แบบสุ่มชั่วคราว ได้รับดาเมจเมื่อยกเลิก debuff' WHERE id = 853;
UPDATE statuses SET description_th = 'เพิ่มค่าประสบการณ์การต่อสู้และสแตนซ์ 20%' WHERE id = 854;
UPDATE statuses SET description_th = 'เพิ่มคริติคอล ความแม่นยำ และเจาะเกราะไฟ' WHERE id = 855;
UPDATE statuses SET description_th = 'เพิ่มค่าประสบการณ์การต่อสู้ 100%' WHERE id = 858;
UPDATE statuses SET description_th = 'เพิ่มค่าประสบการณ์สแตนซ์ 100%' WHERE id = 859;
UPDATE statuses SET description_th = 'เพิ่มความแม่นยำ การหลบ และบล็อก' WHERE id = 860;
UPDATE statuses SET description_th = 'ถูกปกป้องโดย Argus' WHERE id = 862;
UPDATE statuses SET description_th = 'เพิ่มบล็อก 10 วินาที แต่ความเร็วเคลื่อนที่ -30% จำกัดสกิล' WHERE id = 864;
UPDATE statuses SET description_th = 'เพิ่มความสามารถยิง' WHERE id = 865;
UPDATE statuses SET description_th = 'เพิ่มพลังโจมตีประชิด ความแม่นยำ คริติคอล ทำดาเมจเพิ่มเติม' WHERE id = 866;
UPDATE statuses SET description_th = 'เพิ่มเจาะเกราะเวทย์' WHERE id = 1001;

-- I remaining misc
UPDATE statuses SET description_th = 'เพิ่มดาเมจต่อมอนสเตอร์ตามจำนวน buff ที่มี' WHERE name = 'Inspiration' AND description_th IS NULL;
UPDATE statuses SET description_th = 'เพิ่มดาเมจประเภทไฟ' WHERE name = 'Intensity - Fire' AND description_th IS NULL;
UPDATE statuses SET description_th = 'เพิ่มดาเมจประเภทน้ำแข็ง' WHERE name = 'Intensity - Ice' AND description_th IS NULL;
UPDATE statuses SET description_th = 'เพิ่มดาเมจประเภทสายฟ้า' WHERE name = 'Intensity - Lightning' AND description_th IS NULL;
UPDATE statuses SET description_th = 'เพิ่มดาเมจประเภทจิต' WHERE name = 'Intensity - Mental' AND description_th IS NULL;
