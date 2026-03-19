-- Seed data: 20 CHARACTER unlock quests from ge.exe.in.th
-- Source: https://ge.exe.in.th/quests (scraped 2026-03-19)

-- 1. Sharon
INSERT INTO quests (slug, name_th, category, character_name, character_slug, prerequisites, level_req, source_url, total_stages)
VALUES ('sharon', 'เควสท์ปลดล็อกตัวละคร ชารอน', 'character', 'Sharon', 'sharon',
  '["Viron Part 4","Selva North unlock","Nar unlock","Ania unlock","Hellena unlock","Dark Emilia unlock","Beatrice unlock"]',
  NULL, 'https://ge.exe.in.th/quests/detail/sharon', 5);

-- 2. Dark Emilia
INSERT INTO quests (slug, name_th, category, character_name, character_slug, prerequisites, level_req, source_url, total_stages)
VALUES ('dark-emilia', 'เควสท์ปลดล็อกตัวละคร - เอมิเลียด้านมืด', 'character', 'Emilia Lunatic', 'dark-emilia',
  '["Emilia unlock","Gertrude unlock","คณะละครสัตว์อาร์เซ็น main quest","Stance Master quest"]',
  NULL, 'https://ge.exe.in.th/quests/detail/dark-emilia', 3);

-- 3. Nar
INSERT INTO quests (slug, name_th, category, character_name, character_slug, prerequisites, level_req, source_url, total_stages)
VALUES ('nar-2', 'เควสท์เสริมของตัวละคร - นาร์', 'character', 'Nar', 'nar',
  '["เออร์รัค main quest"]',
  NULL, 'https://ge.exe.in.th/quests/detail/nar-2', 5);

-- 4. Beatrice
INSERT INTO quests (slug, name_th, category, character_name, character_slug, prerequisites, level_req, source_url, total_stages)
VALUES ('beatrice', 'เควสท์ปลดล็อกตัวละคร - เบียทริช', 'character', 'Beatrice', 'beatrice',
  '["M''Boma unlock","José Cortasar unlock","M''Boma supplementary quest"]',
  NULL, 'https://ge.exe.in.th/quests/detail/beatrice', 3);

-- 5. M'Boma (supplementary)
INSERT INTO quests (slug, name_th, category, character_name, character_slug, prerequisites, level_req, source_url, total_stages)
VALUES ('mboma-ll', 'เควสท์เสริมของตัวละคร - เอ็มโบม่า', 'character', 'M''Boma', 'mboma',
  '["M''Boma unlock","José Cortasar unlock"]',
  NULL, 'https://ge.exe.in.th/quests/detail/mboma-ll', 5);

-- 6. José Cortasar
INSERT INTO quests (slug, name_th, category, character_name, character_slug, prerequisites, level_req, source_url, total_stages)
VALUES ('jose-cortasar', 'เควสท์ปลดล็อกตัวละคร - โฮเซ่ คอร์ตาซาร์', 'character', 'José Cortasar', 'jose-cortasar',
  '["Level 81+"]',
  '81', 'https://ge.exe.in.th/quests/detail/jose-cortasar', 3);

-- 7. Gertrude
INSERT INTO quests (slug, name_th, category, character_name, character_slug, prerequisites, level_req, source_url, total_stages)
VALUES ('gurtrude', 'เควสท์ปลดล็อกตัวละคร - เกอร์ทรูด', 'character', 'Gertrude', 'gertrude',
  '["Level 80+","5000 Vis","10 Shiny Crystals"]',
  '80', 'https://ge.exe.in.th/quests/detail/gurtrude', 3);

-- 8. Gracielo
INSERT INTO quests (slug, name_th, category, character_name, character_slug, prerequisites, level_req, source_url, total_stages)
VALUES ('gracielo', 'เควสท์ปลดล็อกตัวละคร - กราเซียโล่', 'character', 'Gracielo', 'gracielo',
  '["Level 1+"]',
  '1', 'https://ge.exe.in.th/quests/detail/gracielo', 8);

-- 9. Selva North
INSERT INTO quests (slug, name_th, category, character_name, character_slug, prerequisites, level_req, source_url, total_stages)
VALUES ('selva', 'เควสท์ปลดล็อกตัวละคร - เซลวา นอร์ท', 'character', 'Selva North', 'selva-north',
  '["เซเดคราม main quest"]',
  'Veteran', 'https://ge.exe.in.th/quests/detail/selva', 6);

-- 10. Irawan
INSERT INTO quests (slug, name_th, category, character_name, character_slug, prerequisites, level_req, source_url, total_stages)
VALUES ('irawan', 'เควสท์ปลดล็อกตัวละคร - ไอราวัณ', 'character', 'Irawan', 'irawan',
  '["Level 1+","10000 Vis"]',
  '1', 'https://ge.exe.in.th/quests/detail/irawan', 3);

-- 11. Ania
INSERT INTO quests (slug, name_th, category, character_name, character_slug, prerequisites, level_req, source_url, total_stages)
VALUES ('ania', 'เควสท์ปลดล็อกตัวละคร - อาเนีย', 'character', 'Ania', 'ania',
  '["ชาโต เดอ บูร์กอญ main quest","คณะละครสัตว์อาร์เซ็น"]',
  NULL, 'https://ge.exe.in.th/quests/detail/ania', 3);

-- 12. Vincent
INSERT INTO quests (slug, name_th, category, character_name, character_slug, prerequisites, level_req, source_url, total_stages)
VALUES ('vincent', 'เควสท์ปลดล็อกตัวละคร - วินเซ็นต์', 'character', 'Vincent', 'vincent',
  '["Viron main quest","André unlock"]',
  NULL, 'https://ge.exe.in.th/quests/detail/vincent', 5);

-- 13. Soso
INSERT INTO quests (slug, name_th, category, character_name, character_slug, prerequisites, level_req, source_url, total_stages)
VALUES ('soso', 'เควสท์ปลดล็อกตัวละคร - โซโซ', 'character', 'Soso', 'soso',
  '["เมืองอุช main quest"]',
  '78', 'https://ge.exe.in.th/quests/detail/soso', 2);

-- 14. Marie
INSERT INTO quests (slug, name_th, category, character_name, character_slug, prerequisites, level_req, source_url, total_stages)
VALUES ('marie', 'เควสท์ปลดล็อกตัวละคร - แมรี่', 'character', 'Marie', 'marie',
  '["เส้นทางสวรรค์และธาตุทั้ง 5","Najib Sharif unlock","Catherine unlock","Catherine Torsche unlock","ธาตุทั้ง 5 - โอไทต์"]',
  NULL, 'https://ge.exe.in.th/quests/detail/marie', 13);

-- 15. Catherine
INSERT INTO quests (slug, name_th, category, character_name, character_slug, prerequisites, level_req, source_url, total_stages)
VALUES ('catherine', 'เควสท์ปลดล็อกตัวละคร - แคทเธอรีน', 'character', 'Catherine', 'catherine',
  '["เมืองอุช main quest"]',
  '78', 'https://ge.exe.in.th/quests/detail/catherine', 9);

-- 16. Catherine Torsche
INSERT INTO quests (slug, name_th, category, character_name, character_slug, prerequisites, level_req, source_url, total_stages)
VALUES ('catherinetorsche', 'เควสท์ปลดล็อกตัวละคร - แคทเธอรีน ทอร์ช', 'character', 'Catherine Torsche', 'catherine-torsche',
  '["เส้นทางสวรรค์และธาตุทั้ง 5","Catherine unlock"]',
  NULL, 'https://ge.exe.in.th/quests/detail/catherinetorsche', 3);

-- 17. Hellena
INSERT INTO quests (slug, name_th, category, character_name, character_slug, prerequisites, level_req, source_url, total_stages)
VALUES ('hellena', 'เควสท์ปลดล็อกตัวละคร - เฮเลน่า', 'character', 'Helena', 'hellena',
  '["ชาโต เดอ บูร์กอญ main quest","Emilia unlock","Ania unlock"]',
  NULL, 'https://ge.exe.in.th/quests/detail/hellena', 3);

-- 18. Calyce
INSERT INTO quests (slug, name_th, category, character_name, character_slug, prerequisites, level_req, source_url, total_stages)
VALUES ('calyce', 'เควสท์ปลดล็อกตัวละคร - แคลิซ', 'character', 'Calyce', 'calyce',
  '[]',
  NULL, 'https://ge.exe.in.th/quests/detail/calyce', 3);

-- 19. M'Boma (unlock)
INSERT INTO quests (slug, name_th, category, character_name, character_slug, prerequisites, level_req, source_url, total_stages)
VALUES ('mboma', 'เควสท์ปลดล็อกตัวละคร - เอ็มโบม่า', 'character', 'M''Boma', 'mboma',
  '["โคอิมบรา main quest","Panfilo unlock (White Food quest)"]',
  NULL, 'https://ge.exe.in.th/quests/detail/mboma', 2);

-- 20. Emilia
INSERT INTO quests (slug, name_th, category, character_name, character_slug, prerequisites, level_req, source_url, total_stages)
VALUES ('emilia', 'เควสท์ปลดล็อกตัวละคร - เอมิเลีย', 'character', 'Emilia Giannino', 'emilia',
  '[]',
  NULL, 'https://ge.exe.in.th/quests/detail/emilia', 3);

-- 21. André
INSERT INTO quests (slug, name_th, category, character_name, character_slug, prerequisites, level_req, source_url, total_stages)
VALUES ('andre', 'เควสท์ปลดล็อกตัวละคร - อังเดร', 'character', 'André', 'andre',
  '["รีบอร์โดซ์ main quest"]',
  NULL, 'https://ge.exe.in.th/quests/detail/ekhwsthpldl-ktawlakhr-angedr', 6);

-- 22. Panfilo
INSERT INTO quests (slug, name_th, category, character_name, character_slug, prerequisites, level_req, source_url, total_stages)
VALUES ('panfilo', 'เควสท์ปลดล็อกตัวละคร - แพนฟิโล่', 'character', 'Panfilo de Narvaez', 'panfilo',
  '["Mandrake quest","Secret Potion quest","Soul of Dilos Lathemn quest"]',
  NULL, 'https://ge.exe.in.th/quests/detail/panfilo', 5);

-- 23. Najib Sharif
INSERT INTO quests (slug, name_th, category, character_name, character_slug, prerequisites, level_req, source_url, total_stages)
VALUES ('najib-sharif', 'เควสท์ปลดล็อกตัวละคร - นาจิป ชาริฟ', 'character', 'Najib Sharif', 'najib-sharif',
  '["Catherine unlock (for stage 6)"]',
  NULL, 'https://ge.exe.in.th/quests/detail/ekhwsthpldl-ktawlakhr-naacchip-chaarif', 10);

-- ===== QUEST STAGES =====
-- Note: quest_id references are based on insertion order (1-23)

-- Sharon stages (quest_id = 1)
INSERT INTO quest_stages (quest_id, stage_num, title, npc, location, coordinates, objective, boss_name) VALUES
(1, 1, 'Mysterious Woman', 'Hilton', 'Viron', 'I-7', 'พบกับหญิงปริศนาที่พยายามเข้าปราสาท', NULL),
(1, 2, 'Secret Story - Black Lightning', NULL, 'Viron', 'F-10', 'พา Beatrice ไปพบ Sharon', NULL),
(1, 3, 'Sharon''s Hope', NULL, 'Viron', 'F-10', 'พบ Sharon — เธอเข้าร่วมครอบครัว', NULL),
(1, 4, 'Emilia and Sharon', 'Emilia', 'Coimbra Harbor', 'J-7', 'แนะนำ Sharon ให้ Emilia รู้จัก', NULL),
(1, 5, 'Secret Story - Strata Vista', 'Beatrice', 'Errac', 'I-7', 'เรียนรู้ความจริงเกี่ยวกับ Strata Vista', 'Mufaza');

-- Dark Emilia stages (quest_id = 2)
INSERT INTO quest_stages (quest_id, stage_num, title, npc, location, coordinates, objective, boss_name) VALUES
(2, 1, 'ห้องวิจัยของเอมิเลีย', NULL, 'ท่าเรือโคอิมบรา', 'C-8', 'เข้าไปในห้องวิจัยของเอมิเลีย (ต้องมี Gertrude ในทีม)', 'ร่างมืด'),
(2, 2, '[Emilia Lunatic] ห้องวิจัยของเอมิเลีย', NULL, 'ท่าเรือโคอิมบรา', 'C-8', 'หาทางเข้าไปห้องวิจัย', 'เอมิเลียร่างมืด'),
(2, 3, '[Emilia Lunatic] ความจริงที่ซ่อนอยู่', NULL, 'แดนภูติหิมะ', 'E-4', 'ค้นหาความทรงจำที่แท้จริงของเอมิเลีย (ต้องมี Emilia Lunatic ในทีม)', NULL);

-- Nar stages (quest_id = 3)
INSERT INTO quest_stages (quest_id, stage_num, title, npc, location, coordinates, objective, boss_name) VALUES
(3, 1, 'ทักทายนักรบ', 'Nar', 'เออร์รัค', 'E-3', 'ทำความรู้จักกับนาร์', NULL),
(3, 2, 'หัวหน้าเออร์รัค', 'หัวหน้า', 'เออร์รัค', 'F-3', 'สร้างความเชื่อใจให้คนในเออร์รัค', NULL),
(3, 3, 'ความจริง', 'Nar', 'เออร์รัค', 'E-3', 'ฟังเรื่องราวความจริงจากนาร์', NULL),
(3, 4, 'ความศรัทธา', 'หัวหน้า', 'เออร์รัค', 'F-3', 'สำรวจดันเจี้ยนโอกุลตา', NULL),
(3, 5, 'หน้าที่ของหัวหน้า', 'หัวหน้า', 'เออร์รัค', 'F-3', 'ลอบสังหารฮาร์มัน', 'ฮาร์มัน');

-- Beatrice stages (quest_id = 4)
INSERT INTO quest_stages (quest_id, stage_num, title, npc, location, coordinates, objective, boss_name) VALUES
(4, 1, 'อนุสรณ์ [สายฟ้าสีดำ,Beatrice]', 'M''Boma', 'Coimbra', 'J-7', 'พบกับพี่สาวของเอ็มโบม่า', NULL),
(4, 2, '[สายฟ้าสีดำ,Beatrice] ความสัมพันธ์กับฟาเรล', 'Commander Farrel', 'Viron', 'J-7', 'ชมเหตุการณ์ระหว่าง Beatrice กับ M''Boma', NULL),
(4, 3, '[สายฟ้าสีดำ,Beatrice] ตอนนั้นก็เป็นแบบนั้น', 'Veatrice', 'Viron', 'E-10', 'เรียนรู้เรื่อง Tempest grimoire (ต้องมี Beatrice ในทีม)', 'Cortés');

-- M'Boma supplementary stages (quest_id = 5)
INSERT INTO quest_stages (quest_id, stage_num, title, npc, location, coordinates, objective, boss_name) VALUES
(5, 1, 'เอ็ม โบม่าที่รู้สึกตื่นเต้น', 'M''Boma', 'โคอิมบรา', 'J-7', 'เอาชนะ King of Mildew ใน Jarvier Valley', 'King of Mildew'),
(5, 2, 'โฮเซ่ และเอ็ม โบม่า', 'José Cortasar', 'โคอิมบรา', 'C-10', 'ประลองกับ José', 'José Cortasar'),
(5, 3, 'Framed M''Boma', 'ชายแก่', 'เมืองอุช', 'E-8', 'สืบสวนคดีฆาตกรรมและจับตัวอาชญากรที่แท้จริง', 'ผู้ก่อการร้าย'),
(5, 4, 'เอ็ม โบม่าที่รู้สึกซึมเศร้า', 'แพนฟิโล่', 'รีบอร์โดซ์', 'E-10', 'หาวัตถุดิบทำอาหารพิเศษ', NULL),
(5, 5, 'M''Boma ที่แน่วแน่', 'M''Boma', 'โคอิมบรา', 'J-7', 'นำอาหารพิเศษไปให้ M''Boma', NULL);

-- José Cortasar stages (quest_id = 6)
INSERT INTO quest_stages (quest_id, stage_num, title, npc, location, coordinates, objective, boss_name) VALUES
(6, 1, 'ลูกระเบิดของโจรสลัด', 'José Cortasar', 'โคอิมบรา', 'C-10', 'เก็บกระสุนปืนใหญ่จากมอนสเตอร์พาแชร์', NULL),
(6, 2, 'กล่อง T.N.T.', 'José Cortasar', 'โคอิมบรา', 'C-10', 'เก็บผงกระดองเต่าชั้นดี', 'แคนน่อน ทอร์เทส'),
(6, 3, 'การกลับมาของทหารปืนใหญ่', 'José Cortasar', 'โคอิมบรา', 'C-10', 'ดวลกับโฮเซ่และเอาชนะเขา', 'José Cortasar');

-- Gertrude stages (quest_id = 7)
INSERT INTO quest_stages (quest_id, stage_num, title, npc, location, coordinates, objective, boss_name) VALUES
(7, 1, 'สำรวจบ้านพัก ดร. ทอร์ช', 'เกอร์ทรูด', 'เมืองอุช', 'H-10', 'เอาชนะ Hon-Desk ในห้องสมุดคฤหาสน์', 'ฮอนธ์-เดสก์'),
(7, 2, 'สำรวจเรือนจำจาควิน', 'เกอร์ทรูด', 'เมืองอุช', 'H-10', 'เก็บหนังสือ 10 เล่มจากเรือนจำ', NULL),
(7, 3, 'การสืบหาเบื้องหลังของเซอร์ ลินดอน', 'บรูนี่', 'เมืองรีบอร์โดซ์', 'F-5', 'สืบหาหน่วยลับของเซอร์ ลินดอน', NULL);

-- Gracielo stages (quest_id = 8)
INSERT INTO quest_stages (quest_id, stage_num, title, npc, location, coordinates, objective, boss_name) VALUES
(8, 1, 'Gracielo: ข้าหิวมากๆ', 'Gracielo', 'Coimbra Port', 'H-10', 'ให้อาหาร Gracielo', NULL),
(8, 2, 'Gracielo: การต่อสู้ที่น่าเกรงขาม', NULL, 'Coimbra Port', 'F-7', 'เรียนรู้เรื่องราวของ Gracielo', 'Fritz'),
(8, 3, 'Battle of 100', 'Menendez', 'Reboldoeux', 'H-7', 'เอาชนะทหาร Reboldoeux 100 คน', NULL),
(8, 4, 'A True Match', 'Combat Trainer', 'Coimbra Port', 'C-8', 'เอาชนะทหาร 5 คนและครูฝึก', 'Combat Trainer'),
(8, 5, 'Las Casas by the Sea', 'Las Casas', 'Coimbra Port', 'G-2', 'เอาชนะ Las Casas', 'Las Casas'),
(8, 6, 'Tornado Reen', 'Coal Mine Guard', 'Reboldoeux Coal Mine', 'H-8', 'เอาชนะ Rin', 'Tornado Reen'),
(8, 7, 'The First Disciple', 'Selden', 'Ferruchio Junction', 'F-6', 'เอาชนะ Selden', 'Selden'),
(8, 8, 'Be the Wind!', NULL, 'Porto Bello Ruins', 'G-6', 'พบ Fritz และเรียนรู้บทเรียนสุดท้าย', NULL);

-- Selva North stages (quest_id = 9)
INSERT INTO quest_stages (quest_id, stage_num, title, npc, location, coordinates, objective, boss_name) VALUES
(9, 1, 'รายงานแก่ผู้ช่วยนักสำรวจ', 'ผู้ช่วยนักสำรวจ', 'เมืองอุช', 'C-5', 'นำสัญลักษณ์วีรบุรุษไปให้', NULL),
(9, 2, 'การส่งตัวมอนโตโรกลับ', 'นิวเนส', 'ท่าเรือโคอิมบรา', 'G-4', 'เอาชนะดอกเตอร์ฟราน', 'ดอกเตอร์ฟราน'),
(9, 3, 'ร่องรอยของมอนโตโร', 'ลูดิชา บิชา', 'ดินแดนสีขาว', 'I-7', 'สืบหาร่องรอยของมอนโตโร', 'เซลวา นอร์ท'),
(9, 4, 'สถานที่ใกล้กับพระเจ้า', 'อินเวียร์โน', 'ทุ่งราบน้ำแข็ง', 'D-7', 'หาเบาะแสคำพูดของคอร์เทส', NULL),
(9, 5, 'ความลับของเลโอโนรา', 'เลโอโนรา โรส', 'บาฮามาร์', 'F-6', 'หาทางให้เลโอโนราเล่าเรื่อง', 'ชารอน'),
(9, 6, 'การเล่นแร่แปรธาตุของไวรอน', 'เจนีอา', 'ไวรอน', 'F-6', 'หาหัวใจของฟอร์โด', NULL);

-- Irawan stages (quest_id = 10)
INSERT INTO quest_stages (quest_id, stage_num, title, npc, location, coordinates, objective, boss_name) VALUES
(10, 1, 'การโจมตีของแก๊งอันธพาล', 'ไอราวัณ', 'ท่าเรือโคอิมบรา', 'G-7', 'พบไอราวัณและต่อสู้กับแก๊งอันธพาล', 'กลุ่มอันธพาล'),
(10, 2, 'การเสริมสร้างกำลัง', 'ไอราวัณ', 'ท่าเรือโคอิมบรา', 'G-7', 'ปะทะกับกราเซียโล่ด้วยไอราวัณ', 'กราเซียโล่'),
(10, 3, 'การตัดสินใจร่วมเดินทาง', 'ไอราวัณ', 'ท่าเรือโคอิมบรา', 'G-7', 'ยืนยันการเข้าร่วมตระกูล', NULL);

-- Ania stages (quest_id = 11)
INSERT INTO quest_stages (quest_id, stage_num, title, npc, location, coordinates, objective, boss_name) VALUES
(11, 1, 'คำขอร้องของอาเนีย', 'ทหาร Ania', 'เออร์รัค', 'H-9', 'ไปพบกับอาเนีย', 'เจ้าลิวอิส อาร์เซ็นที่ 3'),
(11, 2, 'อาเนีย และ อังเดร', 'อังเดร', 'เมืองรีบอร์โดซ์', 'D-8', 'ตั้ง Ania เป็นหัวหน้าทีม ไปพบอังเดร', 'เอมิลี'),
(11, 3, 'ผลงานชิ้นโบว์แดงของอังเดร', 'อังเดร', 'เมืองรีบอร์โดซ์', 'D-8', 'หาไอเทมเพื่อให้อังเดรตัดชุดให้อาเนีย', NULL);

-- Vincent stages (quest_id = 12)
INSERT INTO quest_stages (quest_id, stage_num, title, npc, location, coordinates, objective, boss_name) VALUES
(12, 1, 'ผู้ชายในรอยสัก', 'Vincent', 'Viron', 'E-8', 'พา André ไปพบ Vincent', NULL),
(12, 2, 'ร่องรอยของนักบุญ Part 1', 'Vincent', 'Al Quelt Moreza', 'H-7', 'หาบันทึก Dilos Latemen ชิ้นที่ 1', NULL),
(12, 3, 'ร่องรอยของนักบุญ Part 2', 'Vincent', 'Al Quelt Moreza', 'B-9', 'หาบันทึก Dilos Latemen ชิ้นที่ 2', NULL),
(12, 4, 'ร่องรอยของนักบุญ Part 3', 'Vincent', 'Al Quelt Moreza Arcane', 'H-2', 'หาบันทึก Dilos Latemen ชิ้นที่ 3', NULL),
(12, 5, 'ร่องรอยของนักบุญ Part 4', 'Vincent', 'Al Quelt Moreza Personage', 'G-8', 'หาบันทึก Dilos Latemen ชิ้นที่ 4', NULL);

-- Soso stages (quest_id = 13)
INSERT INTO quest_stages (quest_id, stage_num, title, npc, location, coordinates, objective, boss_name) VALUES
(13, 1, 'สาวน้อยผู้เย็นชา', 'โซโซ', 'กิกันเต้', 'H-10', 'พูดคุยกับโซโซ', NULL),
(13, 2, 'คำขอร้องของสาวน้อยผู้เย็นชา', 'โซโซ', 'เกาะอัคคี', 'B-4', 'กำจัด แจค โอ แลนเทิร์น', 'แจค โอ แลนเทิร์น');

-- Marie stages (quest_id = 14)
INSERT INTO quest_stages (quest_id, stage_num, title, npc, location, coordinates, objective, boss_name) VALUES
(14, 1, 'ธาตุทั้ง 5', 'ดร.ทอร์ช', 'ห้องวิจัย ดร.ทอร์ช', 'E-4', 'เข้าพบ ดร.ทอร์ช', NULL),
(14, 2, 'ทำความสะอาดสวน', 'Marie', 'ห้องวิจัย ดร.ทอร์ช', NULL, 'กำจัดเกห์ดอส 40 ตัว', NULL),
(14, 3, 'ปัดฝุ่น', 'Marie', 'คฤหาสน์ ดร.ทอร์ช', 'G-7', 'ทำความสะอาด 5 จุด', NULL),
(14, 4, 'หาวัตถุดิบ', 'Marie', 'สวนพฤกษา คฤหาสน์', NULL, 'หาด้ายและเนื้อเหนียว', NULL),
(14, 5, 'หาเครื่องมือทำอาหาร', 'Marie', 'ห้องสมุด คฤหาสน์', NULL, 'หาหม้อและกระดาษติดไฟ', NULL),
(14, 6, 'จานสะอาด', 'Marie', 'โรงเรือน คฤหาสน์', 'D-7', 'หาตุ๊กตาโรโรโค', NULL),
(14, 7, 'หาฟองน้ำ', 'Marie', 'โรงเรือน คฤหาสน์', NULL, 'หาฟองน้ำจาก White Ben', NULL),
(14, 8, 'หาน้ำยา', 'Marie', 'โรงเรือน คฤหาสน์', 'H-3', 'หาน้ำยาล้างจาน', NULL),
(14, 9, 'หาไม้กวาด', 'Marie', 'โรงเรือน คฤหาสน์', NULL, 'หาไม้กวาด', NULL),
(14, 10, 'ทำความสะอาดห้องใต้ดิน', 'Marie', 'ห้องใต้ดิน คฤหาสน์', 'D-2', 'ปกป้องวิคเตอร์', 'เกรย์'),
(14, 11, 'ทำความสะอาดคฤหาสน์', 'Marie', 'คฤหาสน์ ดร.ทอร์ช', 'F-6', 'ทำความสะอาดตามจุดต่างๆ', NULL),
(14, 12, 'ทำความสะอาดเสร็จ', 'Marie', 'ห้องวิจัย ดร.ทอร์ช', NULL, 'พา Catherine Torsche ไปหา Marie', NULL),
(14, 13, 'หนังสือของแม่', 'ดร.ทอร์ช', 'ห้องวิจัย ดร.ทอร์ช', NULL, 'นำสมุดและก้อนทองคำขาว 7 ชิ้น', NULL);

-- Catherine stages (quest_id = 15)
INSERT INTO quest_stages (quest_id, stage_num, title, npc, location, coordinates, objective, boss_name) VALUES
(15, 1, 'ผู้ปกป้องคฤหาสน์', NULL, 'คฤหาสน์ ดร.ทอร์ช', 'E-3', 'สำรวจประตูลึกลับ', 'Victor'),
(15, 2, 'กุญแจโอไทต์', 'Rosene', 'คฤหาสน์ ดร.ทอร์ช', 'E-3', 'เก็บ Blue Orichalcum 100 ชิ้น', NULL),
(15, 3, 'หุ่นรับใช้ที่ไม่ขยับ', 'Carmen', 'คฤหาสน์ ดร.ทอร์ช ห้องสมุด', 'G-6', 'หาไอเทม 3 ชิ้นเพื่อปลุก Carmen', NULL),
(15, 4, 'จงทำให้คาร์แมนฟื้นกลับมา', 'Carmen', 'คฤหาสน์ ดร.ทอร์ช ห้องสมุด', 'G-6', 'ติดตั้งแหล่งพลังงานใน Carmen', NULL),
(15, 5, 'คาร์แมนและทอร์ช', 'Carmen', 'คฤหาสน์ ดร.ทอร์ช ห้องสมุด', 'G-6', 'หาริบบิ้นแดง', NULL),
(15, 6, 'นักเล่นแร่แปรธาตุ ทอร์ช', 'Dr. Torsche', 'คฤหาสน์ ดร.ทอร์ช ห้องวิจัย', 'E-4', 'พบ Dr. Torsche', 'Golems'),
(15, 7, 'ชิ้นส่วนกระดูกสันหลัง', 'Carmen', 'คฤหาสน์ ดร.ทอร์ช ห้องสมุด', 'G-6', 'หาชิ้นส่วนกระดูกสันหลัง', NULL),
(15, 8, 'ลืมตาขึ้นมา แคทเธอรีน', 'Dr. Torsche', 'คฤหาสน์ ดร.ทอร์ช ห้องวิจัย', 'E-4', 'หาหัวสำรอง Catherine', NULL),
(15, 9, 'ปลุกชีพแคทเธอรีน', 'Dr. Torsche', 'คฤหาสน์ ดร.ทอร์ช ห้องวิจัย', 'E-4', 'เก็บชิ้นส่วน Catherine ครบ (body, arms, legs, heart)', NULL);

-- Catherine Torsche stages (quest_id = 16)
INSERT INTO quest_stages (quest_id, stage_num, title, npc, location, coordinates, objective, boss_name) VALUES
(16, 1, 'ความลับในการพูดคุย', NULL, 'ห้องวิจัย ดร.ทอร์ช', 'E-4', 'แอบฟังบทสนทนาของ Dr. Torsche กับ Montoro', NULL),
(16, 2, 'ความอยากรู้เกี่ยวกับลูกสาว', 'Catherine', 'ห้องวิจัย ดร.ทอร์ช', 'E-4', 'พูดคุยกับ Catherine ตุ๊กตา แล้วเอาชนะ Catherine Torsche', 'Catherine Torsche'),
(16, 3, 'การตอบแทนของ ดร.ทอร์ช', 'Dr. Torsche', 'ห้องวิจัย ดร.ทอร์ช', 'E-4', 'พบ Dr. Torsche และมอบ Holy Water', NULL);

-- Hellena stages (quest_id = 17)
INSERT INTO quest_stages (quest_id, stage_num, title, npc, location, coordinates, objective, boss_name) VALUES
(17, 1, 'อาเนีย และ เอมิเลีย', 'Emilia', 'Coimbra Harbor', 'J-7', 'ตั้ง Ania เป็นหัวหน้า ไปพบ Emilia', NULL),
(17, 2, 'สถานการณ์ของเฮเลน่า', 'Helena', 'Safe House, Auch', 'G-9', 'ตั้ง Emilia เป็นหัวหน้า ไปพบ Helena', NULL),
(17, 3, 'การตัดสินใจของเอเจนต์', 'Simond Agent', 'Free Council, Auch', 'J-7', 'พบ Simond Agent', NULL);

-- Calyce stages (quest_id = 18)
INSERT INTO quest_stages (quest_id, stage_num, title, npc, location, coordinates, objective, boss_name) VALUES
(18, 1, 'ทหารตัวน้อย', 'แคลิซ', 'เพกาดิลลา ท่าเรือโคอิมบรา', 'B-9', 'พูดคุยกับแคลิซและต่อสู้กับโจรสลัด', 'โจรสลัด'),
(18, 2, 'การพบพานด้วยโชคชะตา', 'เกอร์ทรูด', 'เมืองอุช', 'G-9', 'ค้นหาข้อมูลการโจมตีเจ้าหญิง', NULL),
(18, 3, 'ความจริงปรากฎ', 'เจอราด โลเรน', 'เพกาดิลลา ท่าเรือโคอิมบรา', 'B-9', 'เปิดเผยความจริงเกี่ยวกับการสมคบ', 'แมนนอน');

-- M'Boma unlock stages (quest_id = 19)
INSERT INTO quest_stages (quest_id, stage_num, title, npc, location, coordinates, objective, boss_name) VALUES
(19, 1, 'รสชาติของบ้านเกิด', 'เอ็มโบม่า', 'ท่าเรือโคอิมบรา', 'J-7', 'หาอาหารบ้านเกิดให้เอ็มโบม่า', NULL),
(19, 2, 'นักรบแห่งแอบซีเนีย', 'เอ็มโบม่า', 'ท่าเรือโคอิมบรา', 'J-7', 'ประลองกับเอ็มโบม่า', 'เอ็มโบม่า');

-- Emilia stages (quest_id = 20)
INSERT INTO quest_stages (quest_id, stage_num, title, npc, location, coordinates, objective, boss_name) VALUES
(20, 1, 'ดอกเตอร์ลอเรนโซ และบันทึก', 'Emilia', 'ท่าเรือโคอิมบรา', 'J-7', 'หาเบาะแสที่ Tetra Ancient Ruins', NULL),
(20, 2, 'สิ่งที่เหลือไว้ในมือ', 'Emilia', 'ท่าเรือโคอิมบรา', 'J-7', 'นำบันทึกของพ่อไปให้นักวิจัย', NULL),
(20, 3, '[Expert Stance] Gift from Emilia', 'Emilia', 'Coimbra Bridge', 'I-5', 'ผ่าน Private Raid 6 ครั้ง', NULL);

-- André stages (quest_id = 21)
INSERT INTO quest_stages (quest_id, stage_num, title, npc, location, coordinates, objective, boss_name) VALUES
(21, 1, 'กำจัดแมนดราโกร่า', 'อังเดร', 'รีบอร์โดซ์', 'D-8', 'เก็บหนวดแมนดราโกร่า 5 ตัว', NULL),
(21, 2, 'น้ำมนต์แห่งอัล เควลท์ มอเรซา', 'Panfilo', 'รีบอร์โดซ์', 'E-10', 'ไปเอาน้ำมนต์ศักดิ์สิทธิ์', NULL),
(21, 3, 'น้ำมนต์ลึกลับ', 'อังเดร', 'รีบอร์โดซ์', 'D-8', 'ให้อังเดรดื่มน้ำมนต์', 'โซลเจอร์ส'),
(21, 4, 'คำขอร้องเกี่ยวกับดวงวิญญาณ', 'อังเดร', 'รีบอร์โดซ์', 'D-8', 'ผนึกวิญญาณของไดลอส ลาเทมน์', NULL),
(21, 5, 'อาหารสีขาว', 'อังเดร', 'รีบอร์โดซ์', 'D-8', 'หาวัตถุดิบทำอาหาร', NULL),
(21, 6, 'ขนนกที่มหัศจรรย์', 'อังเดร', 'รีบอร์โดซ์', 'D-8', 'หาขนนกสีรุ้ง 50 ชิ้น', 'ค็อคกาไดรซ์');

-- Panfilo stages (quest_id = 22)
INSERT INTO quest_stages (quest_id, stage_num, title, npc, location, coordinates, objective, boss_name) VALUES
(22, 1, 'Food and Clothing Service', 'Panfilo', 'Reboldoeux', 'E-10', 'ส่งอาหารให้ทหารที่ Queen''s Honor Gate', NULL),
(22, 2, 'Blessing of Al Quelt Moreza', 'Panfilo', 'Reboldoeux', 'E-10', 'หาน้ำมนต์ศักดิ์สิทธิ์จากดันเจี้ยน', NULL),
(22, 3, 'White Food', 'André', 'Reboldoeux', 'D-8', 'หาวัตถุดิบทำอาหารให้ André', NULL),
(22, 4, 'Taste of Homeland', 'M''Boma', 'Coimbra Harbor', 'J-7', 'ล่าหนวดออตโตปุสจาก Witch''s Valley', 'Lask-Octopus'),
(22, 5, 'Protect the Farm', 'Panfilo', 'Reboldoeux', 'E-10', 'ป้องกันฟาร์มจากหมาป่า (วัวห้ามตายเกิน 5)', NULL);

-- Najib Sharif stages (quest_id = 23)
INSERT INTO quest_stages (quest_id, stage_num, title, npc, location, coordinates, objective, boss_name) VALUES
(23, 1, 'กล่องใส่ชาของโอพอร์โต', 'นาจิป', 'รีบอร์โดซ์', 'D-7', 'ตอบข้อสงสัยของกล่องใส่ชาปริศนา', NULL),
(23, 2, 'งานอดิเรกของนาจิป', 'นาจิป', 'รีบอร์โดซ์', 'D-7', 'หา Blazing Ruby จากซิจมันต์', 'ซิจมันต์'),
(23, 3, 'บาร์กเกอร์ ไรเฟิล', 'นาจิป', 'รีบอร์โดซ์', 'D-7', 'ล่าหาเฮมาไทต์ใน Al Quelt Moreza', NULL),
(23, 4, 'สวอปม์ มังกี้', 'นาจิป', 'รีบอร์โดซ์', 'D-7', 'ล่าลิงใน Thuringenwald', 'หัวหน้าลิง'),
(23, 5, 'แลกเปลี่ยนโบราณวัตถุ', 'นาจิป', 'รีบอร์โดซ์', 'D-7', 'แลกเปลี่ยนของกับชายเคร่งขรึม', NULL),
(23, 6, 'เฟอร์นิเจอร์ โรโรโค', 'นาจิป', 'รีบอร์โดซ์', 'D-7', 'หาเฟอร์นิเจอร์ในคฤหาสน์ ดร.ทอร์ช', NULL),
(23, 7, 'การตรวจสอบเฟอร์นิเจอร์', 'นาจิป', 'รีบอร์โดซ์', 'D-7', 'ตรวจสอบเฟอร์นิเจอร์กับวีร่า', NULL),
(23, 8, 'ซ่อมเครื่องเรือน', 'นาจิป', 'รีบอร์โดซ์', 'D-7', 'หาแผ่นไม้แข็งจากที่ราบมรกต', NULL),
(23, 9, 'ของที่ลืม', 'นาจิป', 'รีบอร์โดซ์', 'D-7', 'ตรวจสอบกล่องเก่าๆ', NULL),
(23, 10, 'การเดินทางตีราคากล่อง', 'เวสปาโนลา', 'ไวรอน', 'G-10', 'เปิดกล่องเก่าจากไข่มุก', NULL);
