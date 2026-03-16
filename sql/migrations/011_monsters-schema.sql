-- Monsters schema
CREATE TABLE IF NOT EXISTS monsters (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT NOT NULL,
  name_th TEXT DEFAULT '',
  race TEXT DEFAULT '',
  level INTEGER DEFAULT 0,
  is_boss BOOLEAN DEFAULT 0,
  location TEXT DEFAULT '',
  map_slug TEXT DEFAULT '',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX IF NOT EXISTS idx_monsters_level ON monsters(level);
CREATE INDEX IF NOT EXISTS idx_monsters_race ON monsters(race);
CREATE INDEX IF NOT EXISTS idx_monsters_boss ON monsters(is_boss);
CREATE INDEX IF NOT EXISTS idx_monsters_map ON monsters(map_slug);
