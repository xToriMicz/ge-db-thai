-- News table for game updates from KGE (Korean Granado Espada)
CREATE TABLE IF NOT EXISTS news (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  title TEXT NOT NULL,
  title_th TEXT,
  category TEXT DEFAULT 'update',
  summary_th TEXT,
  content TEXT,
  content_th TEXT,
  thumbnail TEXT,
  source_url TEXT,
  source_key TEXT UNIQUE,
  published_at TEXT,
  created_at TEXT DEFAULT (datetime('now'))
);

CREATE INDEX IF NOT EXISTS idx_news_published ON news(published_at DESC);
CREATE INDEX IF NOT EXISTS idx_news_category ON news(category);
CREATE INDEX IF NOT EXISTS idx_news_source_key ON news(source_key);
