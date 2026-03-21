-- Sati translation batch: H-M statuses (47 entries)
-- Rule: translate full sentence, keep game terms (ATK/DEF/HP) in English
-- If description is just [Name] with no detail, translate the concept

-- H
UPDATE statuses SET description_th = 'สวรรค์' WHERE id = 883;
UPDATE statuses SET description_th = 'น้ำหนักมาก — ลดความเร็วเคลื่อนที่' WHERE id = 895;
UPDATE statuses SET description_th = 'พรศักดิ์สิทธิ์' WHERE id = 907;
UPDATE statuses SET description_th = 'ร้อน! — รับดาเมจไฟต่อเนื่อง' WHERE id = 919;
UPDATE statuses SET description_th = 'ไฮเปอร์ชาร์จ — เพิ่มพลังโจมตีชั่วคราว' WHERE id = 924;

-- I
UPDATE statuses SET description_th = 'ปืนเย็นปรับปรุง — เพิ่มประสิทธิภาพปืน Cooling Gun' WHERE id = 956;
UPDATE statuses SET description_th = 'อินดิกาซิออน — สกิลนำทาง' WHERE id = 1010;
UPDATE statuses SET description_th = 'เงาสกัดกั้น — ลดความสามารถศัตรู' WHERE id = 1021;
UPDATE statuses SET description_th = 'ผู้ฝึกสอน — เพิ่ม EXP ให้สมาชิกปาร์ตี้' WHERE id = 1029;
UPDATE statuses SET description_th = 'เพิ่มพลังออร่า ระดับ I' WHERE id = 1033;
UPDATE statuses SET description_th = 'เพิ่มพลังออร่า ระดับ II' WHERE id = 1034;
UPDATE statuses SET description_th = 'แนะนำ — สถานะเริ่มต้น' WHERE id = 1039;
UPDATE statuses SET description_th = 'อินเบอร์ตีร์ 2 — สกิลกลับด้าน' WHERE id = 1041;

-- K
UPDATE statuses SET description_th = 'คาริน โหมดบุก — เพิ่มพลังโจมตีของ Karin' WHERE id = 1070;
UPDATE statuses SET description_th = 'คาร์ลเมเซ่ — สกิลเฉพาะตัว' WHERE id = 1073;
UPDATE statuses SET description_th = 'คูราสท์ — สถานะพิเศษ' WHERE id = 1088;

-- L
UPDATE statuses SET description_th = 'จำกัด — ลดความสามารถชั่วคราว' WHERE id = 1128;
UPDATE statuses SET description_th = 'เชื่อมต่อ — เชื่อมโยงกับเป้าหมาย' WHERE id = 1130;
UPDATE statuses SET description_th = 'โชคดีโจมตี — มีโอกาสโจมตี Critical เพิ่มขึ้น' WHERE id = 1138;
UPDATE statuses SET description_th = 'เรืองแสง — เปล่งแสงสว่าง' WHERE id = 1140;
UPDATE statuses SET description_th = 'ความบ้าคลั่งของ Revenant' WHERE id = 1141;
UPDATE statuses SET description_th = 'Yusmachina คลั่ง — โหมดโจมตีรุนแรง' WHERE id = 1142;

-- M
UPDATE statuses SET description_th = 'ยกเลิกเวทมนตร์ — ป้องกันการใช้เวทมนตร์' WHERE id = 1154;
UPDATE statuses SET description_th = 'บดเวทมนตร์ — ลด Magic RES ศัตรู' WHERE id = 1159;
UPDATE statuses SET description_th = 'ค่าต้านทานเวทมนตร์เปลี่ยน' WHERE id = 1161;
UPDATE statuses SET description_th = 'ลดพลังเวทมนตร์ — ลดดาเมจเวทศัตรู' WHERE id = 1165;
UPDATE statuses SET description_th = 'มาเกเตา — สกิลเฉพาะตัว' WHERE id = 1177;
UPDATE statuses SET description_th = 'ฟื้นฟูมานา — เพิ่มอัตราฟื้นฟู SP' WHERE id = 1178;
UPDATE statuses SET description_th = 'มันดาริเนีย — สถานะพิเศษ' WHERE id = 1180;
UPDATE statuses SET description_th = 'พ่นหินอ่อน — โจมตีระยะไกล' WHERE id = 1181;
UPDATE statuses SET description_th = 'สารทดลองของ Marchetti — เพิ่มสถิติชั่วคราว' WHERE id = 1182;
UPDATE statuses SET description_th = 'ตราแห่งการล้างแค้น — เพิ่มดาเมจต่อเป้าหมายที่ถูก mark' WHERE id = 1186;
UPDATE statuses SET description_th = 'ตราวิญญาณ — ทำเครื่องหมายวิญญาณศัตรู' WHERE id = 1187;
UPDATE statuses SET description_th = 'ความแม่นปืน — เพิ่ม Accuracy สำหรับอาวุธยิง' WHERE id = 1190;
UPDATE statuses SET description_th = 'เพิ่ม Max HP ของโคโลนี' WHERE id = 1193;
UPDATE statuses SET description_th = 'เพิ่ม Max HP ของหอคอยรักษาการณ์โคโลนี' WHERE id = 1194;
UPDATE statuses SET description_th = 'ลดพลังประชิด — ลดดาเมจโจมตีระยะประชิดศัตรู' WHERE id = 1206;
UPDATE statuses SET description_th = 'ความมืดละลาย — เปิดใช้งาน' WHERE id = 1209;
UPDATE statuses SET description_th = 'ความมืดละลาย — ระดับ 1' WHERE id = 1210;
UPDATE statuses SET description_th = 'ความมืดละลาย — ระดับ 2' WHERE id = 1211;
UPDATE statuses SET description_th = 'ความมืดละลาย — ระดับ 3' WHERE id = 1212;
UPDATE statuses SET description_th = 'ชิ้นส่วนความทรงจำ' WHERE id = 1214;
UPDATE statuses SET description_th = 'คุกคาม — ลดพลังศัตรูในรัศมี' WHERE id = 1215;
UPDATE statuses SET description_th = 'แพ้ความสูง — ลดสถิติเมื่ออยู่บนภูเขา' WHERE id = 1243;
UPDATE statuses SET description_th = 'ไข่ลึกลับแตก' WHERE id = 1248;
UPDATE statuses SET description_th = 'หีบลึกลับ' WHERE id = 1249;
UPDATE statuses SET description_th = 'พืชลึกลับ' WHERE id = 1250;
