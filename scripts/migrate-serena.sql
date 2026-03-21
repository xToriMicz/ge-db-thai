-- Migration 027: Add Serena (เซเรน่า) — Large Caliber Rifle PVE
-- Source: Dev Note 668125 / xToriMicz/ge-db-thai#3

-- Character
INSERT OR IGNORE INTO characters (name, slug, display_name, name_th, type, weapons, armor_types, bio_th)
VALUES (
  'Serena', 'serena', 'Serena', 'เซเรน่า',
  'PVE',
  '["Large-Caliber Rifle"]',
  '["Coat"]',
  'ช่างปืนลึกลับ — เซเรน่าเป็นตัวละครประเภท PVE ใช้ปืนไรเฟิลลำกล้องใหญ่ มีระบบ buff สลับสถานะระหว่าง Output (พลังสูง) และ Rapid Fire (ยิงรัว) ซึ่งเปลี่ยนเอฟเฟกต์ของสกิลต่างๆ'
);

-- Stance
INSERT OR IGNORE INTO stances (character_id, name, name_th)
VALUES ((SELECT id FROM characters WHERE slug = 'serena'), 'Remodeler', 'รีโมเดลเลอร์');

-- Skills
INSERT OR IGNORE INTO skills (character_slug, stance_name, skill_name)
VALUES
  ('serena', 'Remodeler', 'Reequipement'),
  ('serena', 'Remodeler', 'Souvenir Levé'),
  ('serena', 'Remodeler', 'Fouetage'),
  ('serena', 'Remodeler', 'Tier de Soutien'),
  ('serena', 'Remodeler', 'Tiraiyage'),
  ('serena', 'Remodeler', 'Fou Combergeant');

-- Skill Details
INSERT OR IGNORE INTO skill_details (character_slug, skill_name, stance_name, description, cooldown, sp_cost, skill_type)
VALUES
  ('serena', 'Reequipement', 'Remodeler', 'Toggle buff state between Output and Rapid Fire. Duration 400s. ATK Rank+1, ATK+50%, Penetration+25, Accuracy+25.', '0 sec.', '0', 'Buff'),
  ('serena', 'Souvenir Levé', 'Remodeler', 'ATK Rank+1, Ignore DEF+10%, Technique+5. Passive support skill.', '0 sec.', '0', 'Passive'),
  ('serena', 'Fouetage', 'Remodeler', 'Ignore DEF 20. Deals 2x damage in Rapid Fire state. Triggers Output state after use.', '0 sec.', '100', 'Attack'),
  ('serena', 'Tier de Soutien', 'Remodeler', 'Ignore DEF 60. Deals 3x damage in Output state. 50% chance to Burn. Max 2 uses, CD 21s.', '21 sec.', '150', 'Attack'),
  ('serena', 'Tiraiyage', 'Remodeler', 'Ignore DEF 100. Deals 3x damage in Rapid Fire state. 40% chance to inflict Critical Wound. Max 2 uses, CD 24s.', '24 sec.', '200', 'Attack'),
  ('serena', 'Fou Combergeant', 'Remodeler', 'Ignore DEF 100. Deals 4x damage in Output state. 50% chance to Shock. Damage scales with number of targets.', '0 sec.', '250', 'Attack');
