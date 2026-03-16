-- 021: Stance skills table
-- 4,700 skills across 390 stances

CREATE TABLE IF NOT EXISTS skills (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  character_slug TEXT NOT NULL,
  stance_name TEXT NOT NULL,
  skill_name TEXT NOT NULL,
  skill_image TEXT
);

CREATE INDEX idx_skills_char ON skills(character_slug);
CREATE INDEX idx_skills_stance ON skills(stance_name);
