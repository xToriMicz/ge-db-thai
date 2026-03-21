-- Migration 028: Status effects table
-- Source: ge-db.site/andromida/Status.php
-- Data will be inserted by Kumo (separate SQL file)

CREATE TABLE IF NOT EXISTS statuses (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT NOT NULL UNIQUE,
  description TEXT NOT NULL DEFAULT '',
  description_th TEXT DEFAULT '',
  type TEXT NOT NULL DEFAULT 'misc',
  created_at TEXT DEFAULT (datetime('now'))
);

CREATE INDEX IF NOT EXISTS idx_statuses_type ON statuses(type);
CREATE INDEX IF NOT EXISTS idx_statuses_name ON statuses(name);
