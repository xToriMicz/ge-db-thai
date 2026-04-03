-- Migration: Fix Serena portrait position + buff image + preview video
-- Source: ge-db.site/andromida/Serena.php — portrait background-position: -2210px -130px

-- 1. Portrait position (from sprite sheet CSS)
-- ge-db.site uses: background-position: -2210px -130px
-- Our DB stores as portraitX, portraitY on characters table
-- But characters-list.json uses portraitX/portraitY — update there too

-- 2. Fix buff_image (was NULL, should be job_reequipement.jpg)
UPDATE character_buffs
SET buff_image = 'job_reequipement.jpg'
WHERE character_slug = 'serena';

-- 3. Ensure preview_video is set
UPDATE characters
SET preview_video = 'p_jCJ7rQgS0'
WHERE slug = 'serena';

-- Note: Skill images are served via worker image proxy
-- /img/skills/{filename} → R2 lazy cache → ge-db.site fallback
-- No manual R2 upload needed — auto-fetched on first access
