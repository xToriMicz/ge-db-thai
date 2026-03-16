-- 025: Stance details — stats, info, lv25 bonus per unique stance
-- ~500 unique stances with full combat stats

CREATE TABLE IF NOT EXISTS stance_details (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  stance_name TEXT NOT NULL,
  equipped_items TEXT DEFAULT 'None',
  icon_x INTEGER,
  icon_y INTEGER,

  -- Info (combat behavior)
  targets TEXT,
  attack_range TEXT,
  splash TEXT,
  hits_per_attack TEXT,
  hits_flying TEXT DEFAULT 'No',
  flying TEXT DEFAULT 'No',
  regenerate_sp TEXT DEFAULT 'No',

  -- Damage modifiers from info
  physical_dmg_mod TEXT,
  shooting_dmg_mod TEXT,
  magical_dmg_mod TEXT,

  -- Stats
  aspd TEXT,
  bonus_atk TEXT,
  mspd TEXT,
  mspd_limit TEXT,
  acc TEXT,
  eva TEXT,
  blk TEXT,
  fire_res TEXT DEFAULT '0',
  ice_res TEXT DEFAULT '0',
  lightning_res TEXT DEFAULT '0',
  abnormal_res TEXT DEFAULT '0',

  -- Level 25 Bonus
  lv25_bonus TEXT DEFAULT '{}',
  lv25_bonus_extra TEXT,

  UNIQUE(stance_name)
);

CREATE INDEX idx_stance_details_name ON stance_details(stance_name);

-- Skill details — full skill info per unique skill
CREATE TABLE IF NOT EXISTS skill_details (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  skill_name TEXT NOT NULL,
  stance_name TEXT NOT NULL,
  skill_image TEXT,
  description TEXT,
  target TEXT,
  casting_time TEXT,
  cooldown TEXT,
  duration TEXT,
  hits_flying TEXT,
  knock_down TEXT,
  sp_cost TEXT,
  aggro TEXT,
  skill_type TEXT,
  levels TEXT DEFAULT '[]',
  special TEXT DEFAULT '[]',

  UNIQUE(skill_name, stance_name)
);

CREATE INDEX idx_skill_details_stance ON skill_details(stance_name);
CREATE INDEX idx_skill_details_name ON skill_details(skill_name);
