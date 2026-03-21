-- Migration 026: Community guides / tips system
CREATE TABLE IF NOT EXISTS guides (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  title TEXT NOT NULL,
  body TEXT NOT NULL,
  content_type TEXT NOT NULL DEFAULT 'general',
  content_id TEXT,
  author TEXT NOT NULL DEFAULT 'ชุมชน',
  ip_hash TEXT,
  is_visible INTEGER DEFAULT 1,
  created_at TEXT DEFAULT (datetime('now')),
  updated_at TEXT DEFAULT (datetime('now'))
);

CREATE INDEX IF NOT EXISTS idx_guides_content ON guides(content_type, content_id);
CREATE INDEX IF NOT EXISTS idx_guides_visible ON guides(is_visible);
