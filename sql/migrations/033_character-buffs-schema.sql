-- Character Buffs (Job Skills) — unique per-character buff
-- Each character has exactly one buff with level-based effects

CREATE TABLE IF NOT EXISTS character_buffs (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  character_slug TEXT NOT NULL UNIQUE,
  buff_name TEXT NOT NULL,
  buff_image TEXT,
  description TEXT,
  target TEXT,
  casting_time TEXT,
  cooldown TEXT,
  duration TEXT,
  sp_cost TEXT,
  consume_item TEXT,
  levels TEXT DEFAULT '[]'
);

CREATE INDEX IF NOT EXISTS idx_character_buffs_slug ON character_buffs(character_slug);
