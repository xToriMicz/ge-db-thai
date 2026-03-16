-- 030: Fix skill_details to be per-character
-- Previous model deduped by (skill_name, stance_name) which was wrong
-- Same stance can have different skills depending on the character

DROP TABLE IF EXISTS skill_details;

CREATE TABLE IF NOT EXISTS skill_details (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  character_slug TEXT NOT NULL,
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

  UNIQUE(skill_name, stance_name, character_slug)
);

CREATE INDEX idx_skill_details_char ON skill_details(character_slug);
CREATE INDEX idx_skill_details_stance ON skill_details(stance_name);
CREATE INDEX idx_skill_details_name ON skill_details(skill_name);
