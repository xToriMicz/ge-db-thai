-- 019: Remove junk/placeholder items with no real names
-- These are untranslated items in the game DB (e.g., <$>10004166</>)

DELETE FROM items WHERE name LIKE '%&lt;%' OR name LIKE '%&gt;%';
DELETE FROM items WHERE name LIKE '%<%' OR name LIKE '%>%';
