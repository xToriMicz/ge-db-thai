-- Migration 044: Cross-entity linking
-- Add linking columns for stable map↔item, raid↔map, raid↔monster connections

-- 1. map_drops: add item_slug to link with items table
ALTER TABLE map_drops ADD COLUMN item_slug TEXT DEFAULT NULL;

-- 2. raids: add map_slug to link with maps table
ALTER TABLE raids ADD COLUMN map_slug TEXT DEFAULT NULL;

-- 3. Populate map_drops.item_slug by exact name match
UPDATE map_drops SET item_slug = (
  SELECT slug FROM items WHERE LOWER(items.name) = LOWER(map_drops.item_name) LIMIT 1
) WHERE item_slug IS NULL;

-- 4. Populate raids.map_slug by exact location match
UPDATE raids SET map_slug = (
  SELECT slug FROM maps WHERE maps.name = raids.location LIMIT 1
) WHERE map_slug IS NULL;
