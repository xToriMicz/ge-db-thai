-- Maps schema
CREATE TABLE IF NOT EXISTS maps (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  slug TEXT UNIQUE NOT NULL,
  anchor TEXT NOT NULL,
  name TEXT NOT NULL,
  name_th TEXT DEFAULT '',
  level_range TEXT DEFAULT '',
  map_type TEXT DEFAULT '',  -- Field, City, Mission, PK Disabled
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS map_drops (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  map_id INTEGER NOT NULL,
  item_category TEXT NOT NULL,
  item_ref_id TEXT NOT NULL,
  item_name TEXT NOT NULL,
  FOREIGN KEY (map_id) REFERENCES maps(id),
  UNIQUE(map_id, item_category, item_ref_id)
);

CREATE TABLE IF NOT EXISTS map_connections (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  from_map_id INTEGER NOT NULL,
  to_map_slug TEXT NOT NULL,
  FOREIGN KEY (from_map_id) REFERENCES maps(id),
  UNIQUE(from_map_id, to_map_slug)
);

CREATE INDEX IF NOT EXISTS idx_maps_slug ON maps(slug);
CREATE INDEX IF NOT EXISTS idx_maps_type ON maps(map_type);
CREATE INDEX IF NOT EXISTS idx_map_drops_map ON map_drops(map_id);
CREATE INDEX IF NOT EXISTS idx_map_connections_from ON map_connections(from_map_id);
