-- 013: Items table schema
-- 10,500+ items across 63 categories

CREATE TABLE IF NOT EXISTS items (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  item_id INTEGER,
  name TEXT NOT NULL,
  slug TEXT NOT NULL,
  category TEXT NOT NULL,
  category_group TEXT NOT NULL,
  level INTEGER,
  atk INTEGER,
  def INTEGER,
  ar INTEGER,
  dr INTEGER,
  sockets INTEGER,
  name_th TEXT
);

CREATE INDEX idx_items_category ON items(category);
CREATE INDEX idx_items_group ON items(category_group);
CREATE INDEX idx_items_level ON items(level);
CREATE INDEX idx_items_slug ON items(slug);
CREATE INDEX idx_items_name ON items(name);
