-- Sati batch: quest_stage_items + quest_stage_rewards for O-Z
-- Using relational tables (not JSON text)

-- === PANFILO ===
-- stage 1 (id=97): no items, reward: เทเลพอร์ตสครอล
INSERT OR IGNORE INTO quest_stage_rewards (stage_id, reward_type, reward_name, quantity) VALUES (97, 'item', 'เทเลพอร์ตสครอล (กิจกรรม)', 1);

-- stage 2 (id=98): no items, reward: EXP
INSERT OR IGNORE INTO quest_stage_rewards (stage_id, reward_type, reward_name, quantity) VALUES (98, 'exp', 'ค่าประสบการณ์', 1);

-- stage 3 (id=99): 3 items, 1 reward
INSERT OR IGNORE INTO quest_stage_items (stage_id, item_name, quantity) VALUES (99, 'Wild Boar Meat', 10);
INSERT OR IGNORE INTO quest_stage_items (stage_id, item_name, quantity) VALUES (99, 'นมเฟอร์รุซซิโอ', 1);
INSERT OR IGNORE INTO quest_stage_items (stage_id, item_name, quantity) VALUES (99, 'พาสต้า + พาเมซันชีส', 1);
INSERT OR IGNORE INTO quest_stage_rewards (stage_id, reward_type, reward_name, quantity) VALUES (99, 'item', 'อิโรลิน่าแฮท', 1);

-- stage 4 (id=100): 1 item, 2 rewards
INSERT OR IGNORE INTO quest_stage_items (stage_id, item_name, quantity) VALUES (100, 'หนวดออตโตปุส', 10);
INSERT OR IGNORE INTO quest_stage_rewards (stage_id, reward_type, reward_name, quantity) VALUES (100, 'item', 'เพอร์ชา อินเซลล่า [เควสท์]', 1);
INSERT OR IGNORE INTO quest_stage_rewards (stage_id, reward_type, reward_name, quantity) VALUES (100, 'item', 'ไชนี่ คริสตัล', 1);

-- stage 5 (id=101): no items, 2 rewards
INSERT OR IGNORE INTO quest_stage_rewards (stage_id, reward_type, reward_name, quantity) VALUES (101, 'card', 'การ์ดตัวละคร แพนฟิโล่ เดอ นาร์เวซ', 1);
INSERT OR IGNORE INTO quest_stage_rewards (stage_id, reward_type, reward_name, quantity) VALUES (101, 'item', 'ไชนี่ คริสตัล', 1);

-- === SELVA ===
-- stage 1 (id=36): 1 item, 1 reward
INSERT OR IGNORE INTO quest_stage_items (stage_id, item_name, quantity) VALUES (36, 'สัญลักษณ์วีรบุรุษ', 2);
INSERT OR IGNORE INTO quest_stage_rewards (stage_id, reward_type, reward_name, quantity) VALUES (36, 'exp', 'การ์ด EXP B เวเทอรัน', 3);

-- stage 2 (id=37): no items, 1 reward
INSERT OR IGNORE INTO quest_stage_rewards (stage_id, reward_type, reward_name, quantity) VALUES (37, 'exp', 'การ์ด EXP G เวเทอรัน', 3);

-- stage 3 (id=38): 5 items, 4 rewards
INSERT OR IGNORE INTO quest_stage_items (stage_id, item_name, quantity) VALUES (38, 'แก่นปีศาจ', 1);
INSERT OR IGNORE INTO quest_stage_items (stage_id, item_name, quantity) VALUES (38, 'เนื้อหมาป่า', 5);
INSERT OR IGNORE INTO quest_stage_items (stage_id, item_name, quantity) VALUES (38, 'หัวผักกาด', 1);
INSERT OR IGNORE INTO quest_stage_items (stage_id, item_name, quantity) VALUES (38, 'กะหล่ำ', 1);
INSERT OR IGNORE INTO quest_stage_items (stage_id, item_name, quantity) VALUES (38, 'เมตามอโฟซิสสโตน', 10);
INSERT OR IGNORE INTO quest_stage_rewards (stage_id, reward_type, reward_name, quantity) VALUES (38, 'card', 'การ์ดตัวละคร เซลวา นอร์ท', 1);
INSERT OR IGNORE INTO quest_stage_rewards (stage_id, reward_type, reward_name, quantity) VALUES (38, 'item', 'ตำรา Rabida Espada', 1);
INSERT OR IGNORE INTO quest_stage_rewards (stage_id, reward_type, reward_name, quantity) VALUES (38, 'item', 'Recipe Salva Arm Shield', 1);
INSERT OR IGNORE INTO quest_stage_rewards (stage_id, reward_type, reward_name, quantity) VALUES (38, 'exp', 'การ์ด EXP B เวเทอรัน', 3);

-- stage 4 (id=39): no items, 1 reward
INSERT OR IGNORE INTO quest_stage_rewards (stage_id, reward_type, reward_name, quantity) VALUES (39, 'exp', 'การ์ด EXP G เวเทอรัน', 1);

-- stage 5 (id=40): 1 item, 1 reward
INSERT OR IGNORE INTO quest_stage_items (stage_id, item_name, quantity) VALUES (40, 'กระดาษบันทึกการสำรวจ', 30);
INSERT OR IGNORE INTO quest_stage_rewards (stage_id, reward_type, reward_name, quantity) VALUES (40, 'exp', 'การ์ด EXP G เวเทอรัน', 1);

-- stage 6 (id=41): 1 item, 1 reward
INSERT OR IGNORE INTO quest_stage_items (stage_id, item_name, quantity) VALUES (41, 'หัวใจของฟอร์โด', 20);
INSERT OR IGNORE INTO quest_stage_rewards (stage_id, reward_type, reward_name, quantity) VALUES (41, 'exp', 'การ์ด EXP G เวเทอรัน', 1);

-- === SHARON ===
-- stage 1 (id=1): no items, no rewards (just fight)

-- stage 2 (id=2): no items, 2 rewards
INSERT OR IGNORE INTO quest_stage_rewards (stage_id, reward_type, reward_name, quantity) VALUES (2, 'card', 'การ์ดตัวละคร ชารอน', 1);
INSERT OR IGNORE INTO quest_stage_rewards (stage_id, reward_type, reward_name, quantity) VALUES (2, 'exp', 'การ์ด EXP G', 3);

-- stage 3 (id=3): 3 items, 1 reward
INSERT OR IGNORE INTO quest_stage_items (stage_id, item_name, quantity) VALUES (3, 'Taurus Milk', 10);
INSERT OR IGNORE INTO quest_stage_items (stage_id, item_name, quantity) VALUES (3, 'Arctic Lazim-lam wing pieces', 10);
INSERT OR IGNORE INTO quest_stage_items (stage_id, item_name, quantity) VALUES (3, 'Superior Quality Cabaco', 10);
INSERT OR IGNORE INTO quest_stage_rewards (stage_id, reward_type, reward_name, quantity) VALUES (3, 'exp', 'การ์ด EXP G', 3);

-- stage 4 (id=4): 1 item, 1 reward
INSERT OR IGNORE INTO quest_stage_items (stage_id, item_name, quantity) VALUES (4, 'Melting Brain Chocolate', 1);
INSERT OR IGNORE INTO quest_stage_rewards (stage_id, reward_type, reward_name, quantity) VALUES (4, 'exp', 'การ์ด EXP G', 3);

-- stage 5 (id=5): no items, 1 reward
INSERT OR IGNORE INTO quest_stage_rewards (stage_id, reward_type, reward_name, quantity) VALUES (5, 'exp', 'การ์ด EXP G', 3);

-- === SOSO ===
-- stage 1 (id=53): no items, no rewards

-- stage 2 (id=54): no items, 1 reward
INSERT OR IGNORE INTO quest_stage_rewards (stage_id, reward_type, reward_name, quantity) VALUES (54, 'card', 'การ์ดตัวละคร โซโซ', 1);

-- === VINCENT ===
-- stage 1 (id=48): no items, 1 reward
INSERT OR IGNORE INTO quest_stage_rewards (stage_id, reward_type, reward_name, quantity) VALUES (48, 'exp', 'การ์ด EXP Level 71', 3);

-- stage 2-4 (id=49-51): collect records, no rewards per stage
INSERT OR IGNORE INTO quest_stage_items (stage_id, item_name, quantity) VALUES (49, 'บันทึกของ Dialos Latemen', 1);
INSERT OR IGNORE INTO quest_stage_items (stage_id, item_name, quantity) VALUES (50, 'บันทึกของ Dialos Latemen', 1);
INSERT OR IGNORE INTO quest_stage_items (stage_id, item_name, quantity) VALUES (51, 'บันทึกของ Dialos Latemen', 2);

-- stage 5 (id=52): no items, 2 rewards
INSERT OR IGNORE INTO quest_stage_rewards (stage_id, reward_type, reward_name, quantity) VALUES (52, 'exp', 'การ์ด EXP Level 71', 9);
INSERT OR IGNORE INTO quest_stage_rewards (stage_id, reward_type, reward_name, quantity) VALUES (52, 'card', 'การ์ดตัวละคร วินเซ็นต์', 1);
