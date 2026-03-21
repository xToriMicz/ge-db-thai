-- Phase 5C: Simple view counter analytics
-- Track page views per character/item and popular search queries

CREATE TABLE IF NOT EXISTS page_views (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  content_type TEXT NOT NULL,
  content_id TEXT NOT NULL,
  ip_hash TEXT,
  viewed_at TEXT DEFAULT (datetime('now'))
);
CREATE INDEX IF NOT EXISTS idx_views_content ON page_views(content_type, content_id);

CREATE TABLE IF NOT EXISTS popular_searches (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  query TEXT NOT NULL,
  searched_at TEXT DEFAULT (datetime('now'))
);
CREATE INDEX IF NOT EXISTS idx_searches_query ON popular_searches(query);
