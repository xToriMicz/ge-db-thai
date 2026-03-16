-- Character Tier Ratings (Editor-curated, 6 categories, score 1-10)
CREATE TABLE IF NOT EXISTS character_tiers (
  character_slug TEXT PRIMARY KEY,
  pve INTEGER DEFAULT 0 CHECK(pve >= 0 AND pve <= 10),
  pvp INTEGER DEFAULT 0 CHECK(pvp >= 0 AND pvp <= 10),
  bossing INTEGER DEFAULT 0 CHECK(bossing >= 0 AND bossing <= 10),
  support INTEGER DEFAULT 0 CHECK(support >= 0 AND support <= 10),
  support_type TEXT DEFAULT NULL, -- 'heal', 'buff', 'both', NULL
  farming INTEGER DEFAULT 0 CHECK(farming >= 0 AND farming <= 10),
  versatility INTEGER DEFAULT 0 CHECK(versatility >= 0 AND versatility <= 10),
  tier TEXT DEFAULT NULL, -- SS/S/A/B/C/D
  notes TEXT DEFAULT NULL,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX IF NOT EXISTS idx_tiers_tier ON character_tiers(tier);
