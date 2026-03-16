-- GE Database Thai — D1 Schema
-- Characters, stances, and their relationships

CREATE TABLE IF NOT EXISTS characters (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  slug TEXT UNIQUE NOT NULL,
  name TEXT NOT NULL,
  display_name TEXT NOT NULL,
  name_th TEXT DEFAULT '',
  type TEXT NOT NULL DEFAULT 'unknown', -- basic, recruit, cash, accomplish
  armor_types TEXT DEFAULT '[]', -- JSON array
  weapons TEXT DEFAULT '[]', -- JSON array
  portrait_x INTEGER DEFAULT 0,
  portrait_y INTEGER DEFAULT 0,
  portrait_class TEXT DEFAULT 'portrait',
  str INTEGER DEFAULT 0,
  agi INTEGER DEFAULT 0,
  hp INTEGER DEFAULT 0,
  dex INTEGER DEFAULT 0,
  int_stat INTEGER DEFAULT 0, -- 'int' is reserved
  sen INTEGER DEFAULT 0,
  starting_level INTEGER DEFAULT 1,
  bio TEXT DEFAULT '',
  bio_th TEXT DEFAULT '',
  starting_armor TEXT DEFAULT '',
  starting_weapon TEXT DEFAULT '',
  buff TEXT DEFAULT '',
  buff_level INTEGER DEFAULT 0,
  is_new BOOLEAN DEFAULT 0,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS stances (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  character_id INTEGER NOT NULL,
  name TEXT NOT NULL,
  name_th TEXT DEFAULT '',
  FOREIGN KEY (character_id) REFERENCES characters(id),
  UNIQUE(character_id, name)
);

CREATE INDEX IF NOT EXISTS idx_characters_type ON characters(type);
CREATE INDEX IF NOT EXISTS idx_characters_slug ON characters(slug);
CREATE INDEX IF NOT EXISTS idx_stances_character ON stances(character_id);
