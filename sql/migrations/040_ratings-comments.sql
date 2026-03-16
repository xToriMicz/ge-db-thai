-- Character Ratings (1-5 stars, one per IP per character)
CREATE TABLE IF NOT EXISTS character_ratings (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  character_slug TEXT NOT NULL,
  rating INTEGER NOT NULL CHECK(rating >= 1 AND rating <= 5),
  ip_hash TEXT NOT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  UNIQUE(character_slug, ip_hash)
);

CREATE INDEX IF NOT EXISTS idx_ratings_slug ON character_ratings(character_slug);

-- Character Comments (anti-spam: rate limited, honeypot, time gate)
CREATE TABLE IF NOT EXISTS character_comments (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  character_slug TEXT NOT NULL,
  nickname TEXT NOT NULL,
  message TEXT NOT NULL,
  ip_hash TEXT NOT NULL,
  is_visible INTEGER DEFAULT 1,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX IF NOT EXISTS idx_comments_slug ON character_comments(character_slug);
CREATE INDEX IF NOT EXISTS idx_comments_visible ON character_comments(is_visible);
