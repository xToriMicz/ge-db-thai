-- Migration: Import Serena full data from scrape (data/full/Serena.json)
-- Covers: stances, stance_details, skills, skill_details, character_buff, preview_video
-- Source: ge-db.site/andromida/Serena.php scraped 2026-04-03

-- ============================================================
-- 1. Bare Knuckle stance (missing from DB)
-- ============================================================
INSERT OR IGNORE INTO stances (character_id, name, name_th)
VALUES ((SELECT id FROM characters WHERE slug = 'serena'), 'Bare Knuckle', 'แบร์นัคเคิล');

-- Bare Knuckle stance details
INSERT OR REPLACE INTO stance_details (
  stance_name, equipped_items, icon_x, icon_y,
  targets, attack_range, splash, hits_per_attack, hits_flying, flying, regenerate_sp,
  physical_dmg_mod, shooting_dmg_mod, magical_dmg_mod,
  aspd, bonus_atk, mspd, mspd_limit, acc, eva, blk,
  fire_res, ice_res, lightning_res, abnormal_res,
  lv25_bonus, lv25_bonus_extra
) VALUES (
  'Bare Knuckle', 'None', -150, 0,
  '1 enemy', '1m away', 'None', '2', 'No', 'No', 'Yes',
  NULL, NULL, NULL,
  '167', '0%', '1', '8.50', '100', '0', '0',
  '0', '0', '0', '0',
  '{}', 'None'
);

-- ============================================================
-- 2. Remasterer stance details (missing info/stats/lv25_bonus)
-- ============================================================
INSERT OR REPLACE INTO stance_details (
  stance_name, equipped_items, icon_x, icon_y,
  targets, attack_range, splash, hits_per_attack, hits_flying, flying, regenerate_sp,
  physical_dmg_mod, shooting_dmg_mod, magical_dmg_mod,
  aspd, bonus_atk, mspd, mspd_limit, acc, eva, blk,
  fire_res, ice_res, lightning_res, abnormal_res,
  lv25_bonus, lv25_bonus_extra
) VALUES (
  'Remasterer', 'Heavy Rifle', -350, -400,
  '1 enemy', '0.5~18m away', 'None', '2', 'Yes', 'No', 'Yes',
  '+10%', '-5%', '-20%',
  '200', '570%', '1', '8.00', '15', '0', '0',
  '0', '0', '0', '0',
  '{"Ignore DEF":"+10%","Critical":"+10","Penetration":"20+15","Immunity":"5+5"}',
  'Additional DMG against Monster according to 2 * 50'
);

-- ============================================================
-- 3. Skills — INSERT with image (skills table)
-- ============================================================
-- Delete old entries first to avoid duplicates
DELETE FROM skills WHERE character_slug = 'serena';

INSERT INTO skills (character_slug, stance_name, skill_name, skill_image)
VALUES
  ('serena', 'Remasterer', 'Souvenir Leve', 'rmd_souvenirlevee.jpg'),
  ('serena', 'Remasterer', 'Pointaje', 'rmd_pointage.jpg'),
  ('serena', 'Remasterer', 'Tier de Sutian', 'rmd_tirdesoutien.jpg'),
  ('serena', 'Remasterer', 'Tiraiaju', 'rmd_tiraillage.jpg'),
  ('serena', 'Remasterer', 'Pou Converge', 'rmd_feuxconvergents.jpg');

-- ============================================================
-- 4. Skill Details — full fields from Serena.json
-- ============================================================
DELETE FROM skill_details WHERE character_slug = 'serena';

-- Souvenir Leve
INSERT INTO skill_details (
  character_slug, skill_name, stance_name, skill_image,
  description, target, casting_time, cooldown, duration,
  hits_flying, knock_down, sp_cost, aggro, skill_type,
  levels, special
) VALUES (
  'serena', 'Souvenir Leve', 'Remasterer', 'rmd_souvenirlevee.jpg',
  'Serena cuts through the distractions of the past.',
  'Self-buff', 'Instant', '13 sec.', '400 seconds',
  'Yes', 'No', '200', '0', 'Buff',
  '[{"level":"Level 1","value":"Duration: 400 seconds"},{"level":"Level 10","value":"Duration: 400 seconds"},{"level":"Level 11","value":"Duration: 400 seconds"},{"level":"Level 12","value":"Duration: 400 seconds"},{"level":"Level 13","value":"Duration: 400 seconds"}]',
  '[]'
);

-- Pointaje
INSERT INTO skill_details (
  character_slug, skill_name, stance_name, skill_image,
  description, target, casting_time, cooldown, duration,
  hits_flying, knock_down, sp_cost, aggro, skill_type,
  levels, special
) VALUES (
  'serena', 'Pointaje', 'Remasterer', 'rmd_pointage.jpg',
  'Fires a rapid burst of shots at the target.',
  '4 enemies within 3m radius', 'Instant', '8 sec.', '1.066 sec.',
  'Yes', 'No', '150', '0', 'Shooting',
  '[{"level":"Level 1","value":"АТК: 310%"},{"level":"Level 10","value":"АТК: 620%"}]',
  '[]'
);

-- Tier de Sutian
INSERT INTO skill_details (
  character_slug, skill_name, stance_name, skill_image,
  description, target, casting_time, cooldown, duration,
  hits_flying, knock_down, sp_cost, aggro, skill_type,
  levels, special
) VALUES (
  'serena', 'Tier de Sutian', 'Remasterer', 'rmd_tirdesoutien.jpg',
  'Throws and fires explosives to control the surrounding area.',
  'Up to 10 enemies within 10m', '0.666 sec.', '10 sec.', '3.667 sec.',
  'Yes', 'Yes', '300', '50', 'Shooting',
  '[{"level":"Level 1","value":"АТК: 460%"},{"level":"Level 10","value":"АТК: 919%"}]',
  '[]'
);

-- Tiraiaju
INSERT INTO skill_details (
  character_slug, skill_name, stance_name, skill_image,
  description, target, casting_time, cooldown, duration,
  hits_flying, knock_down, sp_cost, aggro, skill_type,
  levels, special
) VALUES (
  'serena', 'Tiraiaju', 'Remasterer', 'rmd_tiraillage.jpg',
  'Fires a barrage at the target, followed by a powerful single shot.',
  '1 enemy within 20m', '1.066 sec.', '15 sec.', '3.1 sec.',
  'Yes', 'Yes', '320', '100', 'Shooting',
  '[{"level":"Level 1","value":"АТК: 740%"},{"level":"Level 10","value":"АТК: 1480%"}]',
  '[]'
);

-- Pou Converge
INSERT INTO skill_details (
  character_slug, skill_name, stance_name, skill_image,
  description, target, casting_time, cooldown, duration,
  hits_flying, knock_down, sp_cost, aggro, skill_type,
  levels, special
) VALUES (
  'serena', 'Pou Converge', 'Remasterer', 'rmd_feuxconvergents.jpg',
  'Devastates the area ahead using a special shell.',
  'Up to 12 enemies within a 20m x 6m area in front', '1.333 sec.', '22 sec.', '3.166 sec.',
  'Yes', 'Yes', '470', '100', 'Shooting',
  '[{"level":"Level 1","value":"АТК: 1330%"},{"level":"Level 10","value":"АТК: 2660%"}]',
  '[]'
);

-- ============================================================
-- 5. Character Buff — Le Equipement
-- ============================================================
INSERT OR REPLACE INTO character_buffs (
  character_slug, buff_name, buff_image,
  description, target, casting_time, cooldown, duration,
  sp_cost, consume_item, levels
) VALUES (
  'serena', 'Le Equipement', 'job_reequipement.jpg',
  'Serena maintains and modifies her firearm.',
  'Self-buff (no target required)',
  '0.666 sec.', '3 sec.', '2.333 sec.',
  '250', 'Ancient Star Orb × 5',
  '[{"level":"Level 10","effects":["Duration: 400 seconds","[Modification - Firepower], [Modification - Rapid Fire] Shared","Attack Rating +1","Attack +50%","Physical Penetration +25","Accuracy +25","[Modification - Firepower] Physical Penetration +10","[Modification - Rapid Fire] Attack Speed +30%, Casting Time -10%","Switches to a different trigger each time the skill is used"]}]'
);

-- ============================================================
-- 6. Preview Video — FatSnake Serena
-- ============================================================
UPDATE characters SET preview_video = 'p_jCJ7rQgS0' WHERE slug = 'serena';
