-- Migration 045: Fuzzy cross-links for raids → maps
-- Manual mapping for raid locations that don't have exact map name matches

-- Imperium Rex (Distorted time) → Distorted Time : Imperium Rex
UPDATE raids SET map_slug = 'duncasile02raid' WHERE location = 'Imperium Rex (Distorted time)' AND map_slug IS NULL;

-- Imperium Arma (Distorted time) → no exact map, link to Imperium Glory raid variant
UPDATE raids SET map_slug = 'duncasile03raid' WHERE location = 'Imperium Arma (Distorted time)' AND map_slug IS NULL;

-- Lucifer Castle sub-areas → closest map
UPDATE raids SET map_slug = 'btllucifer01' WHERE location = 'Lucifer Castle, Banquet Hall' AND map_slug IS NULL;
UPDATE raids SET map_slug = 'dunlucifer01' WHERE location = 'Lucifer Castle, Basement Warehouse' AND map_slug IS NULL;
UPDATE raids SET map_slug = 'duncaslucifer02' WHERE location = 'Lucifer Castle, Reception Hall of Oblivion' AND map_slug IS NULL;

-- Armonia sub-areas → closest Armonia maps
UPDATE raids SET map_slug = 'dunarm01cash' WHERE location = 'Armonia, En Celar' AND map_slug IS NULL;
UPDATE raids SET map_slug = 'dunarm05red' WHERE location = 'Armonia, Biego' AND map_slug IS NULL;
UPDATE raids SET map_slug = 'dunarm02' WHERE location = 'Armonia, El Soltado' AND map_slug IS NULL;

-- Quiritatio variants
UPDATE raids SET map_slug = 'dunquiritatio02' WHERE location LIKE 'Quiritatio%' AND map_slug IS NULL;

-- Bahama
UPDATE raids SET map_slug = 'dunbah01' WHERE location = 'Bahama, Underground Cave 2F' AND map_slug IS NULL;
UPDATE raids SET map_slug = 'btlbah05' WHERE location = 'Demigod Forest' AND map_slug IS NULL;
UPDATE raids SET map_slug = 'btlbah05' WHERE location = 'Camellia Thea' AND map_slug IS NULL;

-- Ustiur
UPDATE raids SET map_slug = 'btlust02' WHERE location = 'Ustiur, Zona Uno' AND map_slug IS NULL;

-- Distorted Armonia
UPDATE raids SET map_slug = 'dunarm05red' WHERE location LIKE 'Distorted Armonia%' AND map_slug IS NULL;
