-- 029: Refresh stance_details and skill_details with fixed parser data
-- Fixes: extractTextLines bug that was dropping first/last text nodes
-- Result: correct lv25_bonus values, more complete skill level data

DELETE FROM skill_details;
DELETE FROM stance_details;
