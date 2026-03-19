-- Quest tables for GE Database Thai
-- CHARACTER quest type only (20 quests)

CREATE TABLE IF NOT EXISTS quests (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  slug TEXT UNIQUE NOT NULL,
  name_th TEXT NOT NULL,
  category TEXT NOT NULL DEFAULT 'character',
  character_name TEXT,
  character_slug TEXT,
  prerequisites TEXT, -- JSON array of strings
  level_req TEXT,
  source_url TEXT,
  total_stages INTEGER DEFAULT 0,
  created_at TEXT DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS quest_stages (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  quest_id INTEGER NOT NULL,
  stage_num INTEGER NOT NULL,
  title TEXT,
  npc TEXT,
  location TEXT,
  coordinates TEXT,
  objective TEXT,
  boss_name TEXT,
  conditions TEXT,
  FOREIGN KEY (quest_id) REFERENCES quests(id)
);

CREATE TABLE IF NOT EXISTS quest_stage_items (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  stage_id INTEGER NOT NULL,
  item_name TEXT NOT NULL,
  quantity INTEGER DEFAULT 1,
  FOREIGN KEY (stage_id) REFERENCES quest_stages(id)
);

CREATE TABLE IF NOT EXISTS quest_stage_rewards (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  stage_id INTEGER NOT NULL,
  reward_type TEXT,
  reward_name TEXT NOT NULL,
  quantity INTEGER DEFAULT 1,
  FOREIGN KEY (stage_id) REFERENCES quest_stages(id)
);

CREATE INDEX IF NOT EXISTS idx_quests_slug ON quests(slug);
CREATE INDEX IF NOT EXISTS idx_quests_character ON quests(character_slug);
CREATE INDEX IF NOT EXISTS idx_quest_stages_quest ON quest_stages(quest_id);
CREATE INDEX IF NOT EXISTS idx_quest_items_stage ON quest_stage_items(stage_id);
CREATE INDEX IF NOT EXISTS idx_quest_rewards_stage ON quest_stage_rewards(stage_id);
