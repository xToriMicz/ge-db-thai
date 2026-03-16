-- 017: Raids table schema
-- 130 raid bosses

CREATE TABLE IF NOT EXISTS raids (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT NOT NULL,
  slug TEXT NOT NULL UNIQUE,
  race TEXT,
  level INTEGER,
  location TEXT,
  name_th TEXT
);

CREATE INDEX idx_raids_level ON raids(level);
CREATE INDEX idx_raids_race ON raids(race);
