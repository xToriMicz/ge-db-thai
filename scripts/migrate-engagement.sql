-- Engagement system: ratings + comments for news and quests
-- Generic tables that support multiple content types

CREATE TABLE IF NOT EXISTS content_ratings (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  content_type TEXT NOT NULL,       -- 'news' or 'quest'
  content_id TEXT NOT NULL,         -- news.id or quest.slug
  rating INTEGER NOT NULL CHECK(rating >= 1 AND rating <= 5),
  ip_hash TEXT NOT NULL,
  created_at TEXT DEFAULT (datetime('now')),
  UNIQUE(content_type, content_id, ip_hash)
);

CREATE TABLE IF NOT EXISTS content_comments (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  content_type TEXT NOT NULL,       -- 'news' or 'quest'
  content_id TEXT NOT NULL,         -- news.id or quest.slug
  nickname TEXT NOT NULL DEFAULT 'นักผจญภัย',
  message TEXT NOT NULL,
  ip_hash TEXT NOT NULL,
  is_visible INTEGER DEFAULT 1,
  created_at TEXT DEFAULT (datetime('now'))
);

CREATE INDEX IF NOT EXISTS idx_content_ratings_lookup ON content_ratings(content_type, content_id);
CREATE INDEX IF NOT EXISTS idx_content_comments_lookup ON content_comments(content_type, content_id, is_visible);
