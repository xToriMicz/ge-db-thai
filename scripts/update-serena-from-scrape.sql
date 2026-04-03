-- Migration: Update Serena data from scrape (ge-db.site/andromida/Serena.php)
-- Source: scrape-full-character.mjs output → data/full/Serena.json
-- Fixes: stance name Remodeler→Remasterer, skill names from scrape

-- Update character stats
UPDATE characters SET
  bio_th = 'ลูกสาวคนเดียวของอดีตดยุคแห่งเบเธล — หลังพ่อถูกเนรเทศจากเหตุสังหารหมู่ เซเรน่าถูกทอดทิ้งในตระกูล เธอสละนามสกุลและออกเดินทางสู่ทวีปใหม่ ใช้ปืนไรเฟิลหนักในท่า Remasterer สลับระหว่าง Firepower และ Rapid Fire',
  weapons = '["Heavy Rifle"]'
WHERE slug = 'serena';

-- Fix stance name
UPDATE stances SET name = 'Remasterer', name_th = 'รีมาสเตอร์เรอร์'
WHERE character_id = (SELECT id FROM characters WHERE slug = 'serena')
  AND name = 'Remodeler';

-- Update skill names to match ge-db.site scrape
UPDATE skills SET skill_name = 'Le Equipement' WHERE character_slug = 'serena' AND skill_name = 'Reequipement';
UPDATE skills SET skill_name = 'Souvenir Leve' WHERE character_slug = 'serena' AND skill_name = 'Souvenir Levé';
UPDATE skills SET skill_name = 'Pointaje', stance_name = 'Remasterer' WHERE character_slug = 'serena' AND skill_name = 'Fouetage';
UPDATE skills SET skill_name = 'Tier de Sutian', stance_name = 'Remasterer' WHERE character_slug = 'serena' AND skill_name = 'Tier de Soutien';
UPDATE skills SET skill_name = 'Tiraiaju', stance_name = 'Remasterer' WHERE character_slug = 'serena' AND skill_name = 'Tiraiyage';
UPDATE skills SET skill_name = 'Pou Converge', stance_name = 'Remasterer' WHERE character_slug = 'serena' AND skill_name = 'Fou Combergeant';

-- Update stance_name in skill_details
UPDATE skill_details SET stance_name = 'Remasterer' WHERE character_slug = 'serena';

-- Update skill_details with accurate data from scrape
UPDATE skill_details SET
  skill_name = 'Le Equipement',
  description = 'Serena maintains and modifies her firearm. Toggle buff: Firepower (+Penetration+10) / Rapid Fire (+ASPD+30%, -CastTime 10%). ATK+50%, Penetration+25, Accuracy+25. Duration 400s.',
  cooldown = '3 sec.',
  sp_cost = '250',
  skill_type = 'Buff'
WHERE character_slug = 'serena' AND skill_name IN ('Reequipement', 'Le Equipement');

UPDATE skill_details SET
  skill_name = 'Souvenir Leve',
  description = 'Serena cuts through the distractions of the past. Monster DMG+50%, All Stats+5, Ignore DEF scales to 13%. Duration 400s.',
  cooldown = '13 sec.',
  sp_cost = '200',
  skill_type = 'Buff'
WHERE character_slug = 'serena' AND skill_name IN ('Souvenir Levé', 'Souvenir Leve');

UPDATE skill_details SET
  skill_name = 'Pointaje',
  description = 'Fires a rapid burst of shots at the target. 4 enemies within 3m radius. ATK 620% at Lv10. Reduces cooldowns 2s on additional cast.',
  cooldown = '8 sec.',
  sp_cost = '150',
  skill_type = 'Shooting'
WHERE character_slug = 'serena' AND skill_name IN ('Fouetage', 'Pointaje');

UPDATE skill_details SET
  skill_name = 'Tier de Sutian',
  description = 'Throws and fires explosives to control the surrounding area. Up to 10 enemies within 10m. ATK 919% at Lv10. 20% flame chance. 3x damage in Firepower state.',
  cooldown = '10 sec.',
  sp_cost = '300',
  skill_type = 'Shooting'
WHERE character_slug = 'serena' AND skill_name IN ('Tier de Soutien', 'Tier de Sutian');

UPDATE skill_details SET
  skill_name = 'Tiraiaju',
  description = 'Fires a barrage at the target, followed by a powerful single shot. 1 enemy within 20m. ATK 1480% at Lv10. 40% critical wound chance.',
  cooldown = '15 sec.',
  sp_cost = '320',
  skill_type = 'Shooting'
WHERE character_slug = 'serena' AND skill_name IN ('Tiraiyage', 'Tiraiaju');

UPDATE skill_details SET
  skill_name = 'Pou Converge',
  description = 'Devastates the area ahead using a special shell. Up to 12 enemies in 20m x 6m frontal area. ATK 2660% at Lv10. 50% impact chance. 4x damage in Firepower state.',
  cooldown = '22 sec.',
  sp_cost = '470',
  skill_type = 'Shooting'
WHERE character_slug = 'serena' AND skill_name IN ('Fou Combergeant', 'Pou Converge');
