-- Migration 096: Add consume_item, soft/heavy armor ATK to skill_details + consume to stance_details
-- Source: ge-db.site has these fields per skill/stance but our DB didn't track them

-- skill_details: consume_item (e.g. "Metal Shell Ammo x 3")
ALTER TABLE skill_details ADD COLUMN consume_item TEXT;

-- skill_details: soft/heavy/light armor ATK modifiers (e.g. "110%", "90%", "105%")
ALTER TABLE skill_details ADD COLUMN soft_armor_atk TEXT;
ALTER TABLE skill_details ADD COLUMN heavy_armor_atk TEXT;
ALTER TABLE skill_details ADD COLUMN light_armor_atk TEXT;

-- stance_details: consume per normal attack (e.g. "Metal Shell Ammo x 2")
ALTER TABLE stance_details ADD COLUMN consume TEXT;
