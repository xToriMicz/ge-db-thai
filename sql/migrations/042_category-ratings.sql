-- Multi-category user ratings (PVE, PVP, Bossing, Support, Farming, Versatility, Overall)
CREATE TABLE IF NOT EXISTS character_category_ratings (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  character_slug TEXT NOT NULL,
  category TEXT NOT NULL DEFAULT 'overall', -- overall, pve, pvp, bossing, support, farming, versatility
  rating INTEGER NOT NULL CHECK(rating >= 1 AND rating <= 5),
  ip_hash TEXT NOT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  UNIQUE(character_slug, category, ip_hash)
);

CREATE INDEX IF NOT EXISTS idx_cat_ratings_slug ON character_category_ratings(character_slug);
CREATE INDEX IF NOT EXISTS idx_cat_ratings_cat ON character_category_ratings(category);

-- Migrate existing ratings as 'overall'
INSERT OR IGNORE INTO character_category_ratings (character_slug, category, rating, ip_hash, created_at)
  SELECT character_slug, 'overall', rating, ip_hash, created_at FROM character_ratings;
