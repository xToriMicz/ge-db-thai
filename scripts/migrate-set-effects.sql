-- Migration 030: Set Effects from ge-db.site/andromida/setEffect.php

CREATE TABLE IF NOT EXISTS set_effects (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  set_name TEXT NOT NULL,
  pieces TEXT NOT NULL,
  bonus TEXT NOT NULL,
  UNIQUE(set_name, pieces)
);
CREATE INDEX IF NOT EXISTS idx_set_effects_name ON set_effects(set_name);

INSERT OR IGNORE INTO set_effects (set_name, pieces, bonus) VALUES ('StrataSet', 'Armor Weapon Ear Neck Belt Glove Boots
		[1 set]', 'HP +1000, IMM +1, Penetration +2');
INSERT OR IGNORE INTO set_effects (set_name, pieces, bonus) VALUES ('StrataSet', '[2 set]', 'HP +1000, IMM +1, Penetration +2');
INSERT OR IGNORE INTO set_effects (set_name, pieces, bonus) VALUES ('StrataSet', '[3 set]', 'HP +1000, IMM +1, Penetration +2');
INSERT OR IGNORE INTO set_effects (set_name, pieces, bonus) VALUES ('StrataSet', '[4 set]', 'HP +1000, IMM +1, Penetration +2');
INSERT OR IGNORE INTO set_effects (set_name, pieces, bonus) VALUES ('StrataSet', '[5 set]', 'A.R. +1, D.R. +1, HP +1000, IMM +1, Penetration +2');
INSERT OR IGNORE INTO set_effects (set_name, pieces, bonus) VALUES ('StrataSet', '[6 set]', 'No Bonus');
INSERT OR IGNORE INTO set_effects (set_name, pieces, bonus) VALUES ('StrataSet', '[7 set]', 'No Bonus');
INSERT OR IGNORE INTO set_effects (set_name, pieces, bonus) VALUES ('BristiaSet', 'Weapon Ear Neck Belt Glove Boots
		[1 set]', 'ATK +1%, HP +1500, IMM +1, Penetration +2');
INSERT OR IGNORE INTO set_effects (set_name, pieces, bonus) VALUES ('BristiaSet', '[2 set]', 'ATK +1%, HP +1500, IMM +1, Penetration +2');
INSERT OR IGNORE INTO set_effects (set_name, pieces, bonus) VALUES ('BristiaSet', '[3 set]', 'ATK +2%, HP +1500, IMM +1, Penetration +2');
INSERT OR IGNORE INTO set_effects (set_name, pieces, bonus) VALUES ('BristiaSet', '[4 set]', 'ATK +3%, HP +1500, IMM +1, Penetration +2');
INSERT OR IGNORE INTO set_effects (set_name, pieces, bonus) VALUES ('BristiaSet', '[5 set]', 'ATK +3%, HP +1500, IMM +1, Penetration +2, A.R. +1');
INSERT OR IGNORE INTO set_effects (set_name, pieces, bonus) VALUES ('BristiaSet', '[6 set]', 'No Bonus');
INSERT OR IGNORE INTO set_effects (set_name, pieces, bonus) VALUES ('ArmoniaSet', 'Armor Weapon Ear Neck Belt Glove Boots
		[1 set]', 'ATK +1%, HP +2000, Penetration +2, IMM +1');
INSERT OR IGNORE INTO set_effects (set_name, pieces, bonus) VALUES ('ArmoniaSet', '[2 set]', 'ATK +1%, HP +2000, Penetration +2, IMM +1');
INSERT OR IGNORE INTO set_effects (set_name, pieces, bonus) VALUES ('ArmoniaSet', '[3 set]', 'ATK +2%, HP +2000, Penetration +2, IMM +1');
INSERT OR IGNORE INTO set_effects (set_name, pieces, bonus) VALUES ('ArmoniaSet', '[4 set]', 'ATK +3%, HP +2000, Penetration +2, IMM +1');
INSERT OR IGNORE INTO set_effects (set_name, pieces, bonus) VALUES ('ArmoniaSet', '[5 set]', 'ATK +3%, HP +2000, Penetration +2, IMM +1, A.R.+1');
INSERT OR IGNORE INTO set_effects (set_name, pieces, bonus) VALUES ('ArmoniaSet', '[6 set]', 'No Bonus');
INSERT OR IGNORE INTO set_effects (set_name, pieces, bonus) VALUES ('ArmoniaSet', '[7 set]', 'No Bonus');
INSERT OR IGNORE INTO set_effects (set_name, pieces, bonus) VALUES ('ZodiacSet', 'Weapon Ear Neck Belt Glove Boots
		[1 set]', 'ATK +1%, Monster Damage +2%, HP +1000, IMM +1, Penetration +1');
INSERT OR IGNORE INTO set_effects (set_name, pieces, bonus) VALUES ('ZodiacSet', '[2 set]', 'ATK +1%, Monster Damage +2%, HP +1000, IMM +1, Penetration +1');
INSERT OR IGNORE INTO set_effects (set_name, pieces, bonus) VALUES ('ZodiacSet', '[3 set]', 'ATK +2%, Monster Damage +2%, HP +1000, IMM +1, Penetration +1');
INSERT OR IGNORE INTO set_effects (set_name, pieces, bonus) VALUES ('ZodiacSet', '[4 set]', 'ATK +3%, Monster Damage +2%, HP +1000, IMM +1, Penetration +1');
INSERT OR IGNORE INTO set_effects (set_name, pieces, bonus) VALUES ('ZodiacSet', '[5 set]', 'ATK +3%, Monster Damage +2%, HP +1000, IMM +1, Penetration +1, A.R. +1');
INSERT OR IGNORE INTO set_effects (set_name, pieces, bonus) VALUES ('ZodiacSet', '[6 set]', 'No Bonus');
INSERT OR IGNORE INTO set_effects (set_name, pieces, bonus) VALUES ('EvilSet', 'Armor Weapon Ear Neck Belt Glove Boots
		[1 set]', 'HP +1000, IMM +1, Penetration +2');
INSERT OR IGNORE INTO set_effects (set_name, pieces, bonus) VALUES ('EvilSet', '[2 set]', 'HP +1000, IMM +1, Penetration +2');
INSERT OR IGNORE INTO set_effects (set_name, pieces, bonus) VALUES ('EvilSet', '[3 set]', 'HP +1000, IMM +1, Penetration +2');
INSERT OR IGNORE INTO set_effects (set_name, pieces, bonus) VALUES ('EvilSet', '[4 set]', 'HP +1000, IMM +1, Penetration +2');
INSERT OR IGNORE INTO set_effects (set_name, pieces, bonus) VALUES ('EvilSet', '[5 set]', 'HP +1000, IMM +1, Penetration +2, D.R. +1');
INSERT OR IGNORE INTO set_effects (set_name, pieces, bonus) VALUES ('EvilSet', '[6 set]', 'No Bonus');
INSERT OR IGNORE INTO set_effects (set_name, pieces, bonus) VALUES ('EvilSet', '[7 set]', 'No Bonus');
INSERT OR IGNORE INTO set_effects (set_name, pieces, bonus) VALUES ('ValeronSet', 'Armor Weapon Ear Neck Belt Glove Boots
		[1 set]', 'ATK +3%, HP +4000, Penetration +2, IMM +1');
INSERT OR IGNORE INTO set_effects (set_name, pieces, bonus) VALUES ('ValeronSet', '[2 set]', 'ATK +3%, HP +4000, Penetration +2, IMM +1');
INSERT OR IGNORE INTO set_effects (set_name, pieces, bonus) VALUES ('ValeronSet', '[3 set]', 'ATK +3%, HP +4000, Penetration +2, IMM +1');
INSERT OR IGNORE INTO set_effects (set_name, pieces, bonus) VALUES ('ValeronSet', '[4 set]', 'ATK +3%, HP +4000, Penetration +2, IMM +1');
INSERT OR IGNORE INTO set_effects (set_name, pieces, bonus) VALUES ('ValeronSet', '[5 set]', 'ATK +3%, HP +4000, Penetration +2, IMM +1, A.R. +1, D.R. +1, All Stats +5, All Damage -10%');
INSERT OR IGNORE INTO set_effects (set_name, pieces, bonus) VALUES ('ValeronSet', '[6 set]', 'ATK +3%, HP +4000, Penetration +2, IMM +1');
INSERT OR IGNORE INTO set_effects (set_name, pieces, bonus) VALUES ('ValeronSet', '[7 set]', 'ATK +3%, HP +4000, Penetration +2, IMM +1');
INSERT OR IGNORE INTO set_effects (set_name, pieces, bonus) VALUES ('DivinecSet', 'Weapon Ear Neck Belt Glove Boots
		[1 set]', 'ATK +1%, Monster Damage +1%, HP +1000, IMM +1, Penetration +2');
INSERT OR IGNORE INTO set_effects (set_name, pieces, bonus) VALUES ('DivinecSet', '[2 set]', 'ATK +1%, Monster Damage +1%, HP +1000, IMM +1, Penetration +2');
INSERT OR IGNORE INTO set_effects (set_name, pieces, bonus) VALUES ('DivinecSet', '[3 set]', 'ATK +1%, Monster Damage +1%, HP +1000, IMM +1, Penetration +2');
INSERT OR IGNORE INTO set_effects (set_name, pieces, bonus) VALUES ('DivinecSet', '[4 set]', 'ATK +1%, Monster Damage +1%, HP +1000, IMM +1, Penetration +2');
INSERT OR IGNORE INTO set_effects (set_name, pieces, bonus) VALUES ('DivinecSet', '[5 set]', 'ATK +1%, Monster Damage +1%, HP +1000, IMM +1, Penetration +2');
INSERT OR IGNORE INTO set_effects (set_name, pieces, bonus) VALUES ('DivinecSet', '[6 set]', 'No Bonus');
INSERT OR IGNORE INTO set_effects (set_name, pieces, bonus) VALUES ('RoyalSet', 'Armor Weapon Ear Neck Belt Glove Boots
		[1 set]', 'ATK +2%, Monster Damage +4%, HP +2000, Penetration +2, IMM +1');
INSERT OR IGNORE INTO set_effects (set_name, pieces, bonus) VALUES ('RoyalSet', '[2 set]', 'ATK +2%, Monster Damage +4%, HP +2000, Penetration +2, IMM +1');
INSERT OR IGNORE INTO set_effects (set_name, pieces, bonus) VALUES ('RoyalSet', '[3 set]', 'ATK +2%, Monster Damage +4%, HP +2000, Penetration +2, IMM +1');
INSERT OR IGNORE INTO set_effects (set_name, pieces, bonus) VALUES ('RoyalSet', '[4 set]', 'ATK +2%, Monster Damage +4%, HP +2000, Penetration +2, IMM +1');
INSERT OR IGNORE INTO set_effects (set_name, pieces, bonus) VALUES ('RoyalSet', '[5 set]', 'ATK +2%, Monster Damage +8%, HP +2000, Penetration +2, IMM +1, A.R. +1, D.R. +1, All Stats +5, All Damage -10%');
INSERT OR IGNORE INTO set_effects (set_name, pieces, bonus) VALUES ('RoyalSet', '[6 set]', 'ATK +2%, Monster Damage +4%, HP +2000, Penetration +2, IMM +1');
INSERT OR IGNORE INTO set_effects (set_name, pieces, bonus) VALUES ('RoyalSet', '[7 set]', 'ATK +2%, Monster Damage +4%, HP +2000, Penetration +2, IMM +1');
INSERT OR IGNORE INTO set_effects (set_name, pieces, bonus) VALUES ('AbyssArmaSet', 'Armor Weapon Ear Neck Belt Glove Boots
		[1 set]', 'HP +4000, Penetration +2, IMM +2');
INSERT OR IGNORE INTO set_effects (set_name, pieces, bonus) VALUES ('AbyssArmaSet', '[2 set]', 'HP +4000, Penetration +2, IMM +2, D.R. +1. All Stats +5');
INSERT OR IGNORE INTO set_effects (set_name, pieces, bonus) VALUES ('AbyssArmaSet', '[3 set]', 'HP +4000, Penetration +2, IMM +2');
INSERT OR IGNORE INTO set_effects (set_name, pieces, bonus) VALUES ('AbyssArmaSet', '[4 set]', 'HP +4000, Penetration +2, IMM +2');
INSERT OR IGNORE INTO set_effects (set_name, pieces, bonus) VALUES ('AbyssArmaSet', '[5 set]', 'HP +4000, Penetration +2, IMM +2');
INSERT OR IGNORE INTO set_effects (set_name, pieces, bonus) VALUES ('AbyssArmaSet', '[6 set]', 'HP +4000, Penetration +2, IMM +2');
INSERT OR IGNORE INTO set_effects (set_name, pieces, bonus) VALUES ('AbyssArmaSet', '[7 set]', 'HP +4000, Penetration +2, IMM +2');
INSERT OR IGNORE INTO set_effects (set_name, pieces, bonus) VALUES ('DesafioSet', 'Ear Neck Belt Glove Boots
		[1 set]', 'HP +800, Monster Damage +2%, Penetration +1, IMM +1');
INSERT OR IGNORE INTO set_effects (set_name, pieces, bonus) VALUES ('DesafioSet', '[2 set]', 'HP +800, Monster Damage +2%, Penetration +1, IMM +1');
INSERT OR IGNORE INTO set_effects (set_name, pieces, bonus) VALUES ('DesafioSet', '[3 set]', 'HP +800, Monster Damage +2%, Penetration +1, IMM +1');
INSERT OR IGNORE INTO set_effects (set_name, pieces, bonus) VALUES ('DesafioSet', '[4 set]', 'HP +800, Monster Damage +2%, Penetration +1, IMM +1');
INSERT OR IGNORE INTO set_effects (set_name, pieces, bonus) VALUES ('DesafioSet', '[5 set]', 'D.R. +1, HP +800, Monster Damage +2%, Penetration +1, IMM +1');
INSERT OR IGNORE INTO set_effects (set_name, pieces, bonus) VALUES ('ElitelegionSet', 'Ring
		[2 set]', 'A.R. +1, D.R. +1');
INSERT OR IGNORE INTO set_effects (set_name, pieces, bonus) VALUES ('MakinaSet', 'Weapon Ear Neck Belt Glove Boots
		[1 set]', 'HP +4,000, ATK +4%, Penetration +2');
INSERT OR IGNORE INTO set_effects (set_name, pieces, bonus) VALUES ('MakinaSet', '[2 set]', 'HP +4,000, ATK +4%, Penetration +2, A.R. +1, All Stats +5');
INSERT OR IGNORE INTO set_effects (set_name, pieces, bonus) VALUES ('MakinaSet', '[3 set]', 'HP +4,000, ATK +4%, Penetration +2');
INSERT OR IGNORE INTO set_effects (set_name, pieces, bonus) VALUES ('MakinaSet', '[4 set]', 'HP +4,000, ATK +4%, Penetration +2');
INSERT OR IGNORE INTO set_effects (set_name, pieces, bonus) VALUES ('MakinaSet', '[5 set]', 'HP +4,000, ATK +4%, Penetration +2');
INSERT OR IGNORE INTO set_effects (set_name, pieces, bonus) VALUES ('MakinaSet', '[6 set]', 'HP +4,000, ATK +4%, Penetration +2');
INSERT OR IGNORE INTO set_effects (set_name, pieces, bonus) VALUES ('NewbieBTypeSet', 'Armor Weapon Ear Neck Belt Glove Boots
		[1 set]', 'HP +1000, IMM +1, Penetration +2');
INSERT OR IGNORE INTO set_effects (set_name, pieces, bonus) VALUES ('NewbieBTypeSet', '[2 set]', 'HP +1000, IMM +1, Penetration +2');
INSERT OR IGNORE INTO set_effects (set_name, pieces, bonus) VALUES ('NewbieBTypeSet', '[3 set]', 'HP +1000, IMM +1, Penetration +2');
INSERT OR IGNORE INTO set_effects (set_name, pieces, bonus) VALUES ('NewbieBTypeSet', '[4 set]', 'HP +1000, IMM +1, Penetration +2');
INSERT OR IGNORE INTO set_effects (set_name, pieces, bonus) VALUES ('NewbieBTypeSet', '[5 set]', 'HP +1000, IMM +1, Penetration +2, D.R. +1');
INSERT OR IGNORE INTO set_effects (set_name, pieces, bonus) VALUES ('NewbieBTypeSet', '[6 set]', 'No Bonus');
INSERT OR IGNORE INTO set_effects (set_name, pieces, bonus) VALUES ('NewbieBTypeSet', '[7 set]', 'No Bonus');
INSERT OR IGNORE INTO set_effects (set_name, pieces, bonus) VALUES ('TyrantOrderSet', 'Weapon Ear Neck Belt Glove Boots
		[1 set]', 'HP +4000, Penetration +2, IMM +2');
INSERT OR IGNORE INTO set_effects (set_name, pieces, bonus) VALUES ('TyrantOrderSet', '[2 set]', 'HP +4000, Penetration +2, IMM +2, A.R. +1. All Stats +5');
INSERT OR IGNORE INTO set_effects (set_name, pieces, bonus) VALUES ('TyrantOrderSet', '[3 set]', 'HP +4000, Penetration +2, IMM +2');
INSERT OR IGNORE INTO set_effects (set_name, pieces, bonus) VALUES ('TyrantOrderSet', '[4 set]', 'HP +4000, Penetration +2, IMM +2');
INSERT OR IGNORE INTO set_effects (set_name, pieces, bonus) VALUES ('TyrantOrderSet', '[5 set]', 'HP +4000, Penetration +2, IMM +2');
INSERT OR IGNORE INTO set_effects (set_name, pieces, bonus) VALUES ('TyrantOrderSet', '[6 set]', 'HP +4000, Penetration +2, IMM +2');
INSERT OR IGNORE INTO set_effects (set_name, pieces, bonus) VALUES ('QuiriSet', 'Weapon Ear Neck Belt Glove Boots
		[1 set]', 'HP +1,000, Monster Damage +2%, Penetration +2');
INSERT OR IGNORE INTO set_effects (set_name, pieces, bonus) VALUES ('QuiriSet', '[2 set]', 'HP +1,000, Monster Damage +2%, Penetration +2');
INSERT OR IGNORE INTO set_effects (set_name, pieces, bonus) VALUES ('QuiriSet', '[3 set]', 'HP +1,000, Monster Damage +2%, Penetration +2');
INSERT OR IGNORE INTO set_effects (set_name, pieces, bonus) VALUES ('QuiriSet', '[4 set]', 'HP +1,000, Monster Damage +2%, Penetration +2');
INSERT OR IGNORE INTO set_effects (set_name, pieces, bonus) VALUES ('QuiriSet', '[5 set]', 'HP +1,000, Monster Damage +2%, Penetration +2, All Stats +7');
INSERT OR IGNORE INTO set_effects (set_name, pieces, bonus) VALUES ('QuiriSet', '[6 set]', 'HP +1,000, Monster Damage +2%, Penetration +2');
INSERT OR IGNORE INTO set_effects (set_name, pieces, bonus) VALUES ('LegionSet', 'Weapon Armor Ear Neck Belt Glove Boots
		[1 set]', 'HP +1,000, ATK +4%, Monster Damage +4%, Penetration +2');
INSERT OR IGNORE INTO set_effects (set_name, pieces, bonus) VALUES ('LegionSet', '[2 set]', 'HP +1,000, ATK +4%, Monster Damage +4%, Penetration +2');
INSERT OR IGNORE INTO set_effects (set_name, pieces, bonus) VALUES ('LegionSet', '[3 set]', 'HP +1,000, ATK +4%, Monster Damage +4%, Penetration +2');
INSERT OR IGNORE INTO set_effects (set_name, pieces, bonus) VALUES ('LegionSet', '[4 set]', 'HP +1,000, ATK +4%, Monster Damage +4%, Penetration +2');
INSERT OR IGNORE INTO set_effects (set_name, pieces, bonus) VALUES ('LegionSet', '[5 set]', 'A.R. +1, D.R. +1, HP +5,000, ATK +4%, Monster Damage +4%, Penetration +2');
INSERT OR IGNORE INTO set_effects (set_name, pieces, bonus) VALUES ('LegionSet', '[6 set]', 'A.R. +1, D.R. +1, HP +5,000, ATK +4%, Monster Damage +4%, Penetration +2');
INSERT OR IGNORE INTO set_effects (set_name, pieces, bonus) VALUES ('LegionSet', '[7 set]', 'A.R. +1, D.R. +1, HP +5,000, ATK +4%, Monster Damage +4%, Penetration +2, All Stats +7');
INSERT OR IGNORE INTO set_effects (set_name, pieces, bonus) VALUES ('Star2Set', 'Weapon Armor Ear Neck Belt Glove Boots
		[1 set]', 'DEF +1, IMM +2, ALL DMG -2%');
INSERT OR IGNORE INTO set_effects (set_name, pieces, bonus) VALUES ('Star2Set', '[2 set]', 'DEF +1, IMM +2, ALL DMG -2%');
INSERT OR IGNORE INTO set_effects (set_name, pieces, bonus) VALUES ('Star2Set', '[3 set]', 'DEF +1, IMM +2, ALL DMG -2%');
INSERT OR IGNORE INTO set_effects (set_name, pieces, bonus) VALUES ('Star2Set', '[4 set]', 'D.R. +1, DEF +1, IMM +4, ALL RES +2, ALL DMG -2%');
INSERT OR IGNORE INTO set_effects (set_name, pieces, bonus) VALUES ('Star2Set', '[5 set]', 'A.R. +1, DEF +1, IMM +2, ALL RES +3, ALL DMG -2%');
INSERT OR IGNORE INTO set_effects (set_name, pieces, bonus) VALUES ('Star2Set', '[6 set]', 'DEF +1, IMM +3 ALL RES +5, All Stats +3');
INSERT OR IGNORE INTO set_effects (set_name, pieces, bonus) VALUES ('Star2Set', '[7 set]', 'DEF +1, IMM +5 ALL RES +5, All Stats +3');
INSERT OR IGNORE INTO set_effects (set_name, pieces, bonus) VALUES ('GiltineSet', 'Weapon Armor Ear Neck Belt Glove Boots
		[1 set]', 'ATK +2%');
INSERT OR IGNORE INTO set_effects (set_name, pieces, bonus) VALUES ('GiltineSet', '[2 set]', 'ATK +2%, PEN +2');
INSERT OR IGNORE INTO set_effects (set_name, pieces, bonus) VALUES ('GiltineSet', '[3 set]', 'ATK +2%, PEN +4');
INSERT OR IGNORE INTO set_effects (set_name, pieces, bonus) VALUES ('GiltineSet', '[4 set]', 'ATK +4%, PEN +4, All Stats +5');
INSERT OR IGNORE INTO set_effects (set_name, pieces, bonus) VALUES ('GiltineSet', '[5 set]', 'A.R. +1, D.R. +1, ATK +5%, PEN +5, All Stats +5, All Skills +1');
INSERT OR IGNORE INTO set_effects (set_name, pieces, bonus) VALUES ('LaimaSet', 'Weapon Armor Ear Neck Belt Glove Boots
		[1 set]', 'ATK +2%');
INSERT OR IGNORE INTO set_effects (set_name, pieces, bonus) VALUES ('LaimaSet', '[2 set]', 'ATK +2%, All RES +2, IMM +2');
INSERT OR IGNORE INTO set_effects (set_name, pieces, bonus) VALUES ('LaimaSet', '[3 set]', 'ATK +2%, All RES +4, IMM +4');
INSERT OR IGNORE INTO set_effects (set_name, pieces, bonus) VALUES ('LaimaSet', '[4 set]', 'ATK +2%, All RES +4, IMM +4, All DMG -5%');
INSERT OR IGNORE INTO set_effects (set_name, pieces, bonus) VALUES ('LaimaSet', '[5 set]', 'A.R. +1, D.R. +1, ATK +2%, All RES +5, IMM +10, All DMG -5%, All Skills +1');
INSERT OR IGNORE INTO set_effects (set_name, pieces, bonus) VALUES ('VigilarSet', 'Weapon Armor Ear Neck Belt Glove Boots
		[1 set]', 'ATK +4%');
INSERT OR IGNORE INTO set_effects (set_name, pieces, bonus) VALUES ('VigilarSet', '[2 set]', 'ATK +4%, Penetration +4');
INSERT OR IGNORE INTO set_effects (set_name, pieces, bonus) VALUES ('VigilarSet', '[3 set]', 'ATK +4%, Penetration +4');
INSERT OR IGNORE INTO set_effects (set_name, pieces, bonus) VALUES ('VigilarSet', '[4 set]', 'ATK +4%, Penetration +4, All Stats +5');
INSERT OR IGNORE INTO set_effects (set_name, pieces, bonus) VALUES ('VigilarSet', '[5 set]', 'A.R. +1, D.R. +1, ATK +5%, Penetration +5, All Stats +5');
INSERT OR IGNORE INTO set_effects (set_name, pieces, bonus) VALUES ('LucidSet', 'Weapon Armor Ear Neck Belt Glove Boots
		[1 set]', 'DEF +2');
INSERT OR IGNORE INTO set_effects (set_name, pieces, bonus) VALUES ('LucidSet', '[2 set]', 'DEF +2, IMM +2');
INSERT OR IGNORE INTO set_effects (set_name, pieces, bonus) VALUES ('LucidSet', '[3 set]', 'DEF +2, IMM +2');
INSERT OR IGNORE INTO set_effects (set_name, pieces, bonus) VALUES ('LucidSet', '[4 set]', 'DEF +2, IMM +2, All RES +5');
INSERT OR IGNORE INTO set_effects (set_name, pieces, bonus) VALUES ('LucidSet', '[5 set]', '[Lucid]: D.R. +1, DEF +7, IMM +10, All RES +10, All DMG -10%, All Skills +1');
INSERT OR IGNORE INTO set_effects (set_name, pieces, bonus) VALUES ('DreamingSet', 'Weapon Armor Ear Neck Belt Glove Boots
		[1 set]', 'ATK +2%');
INSERT OR IGNORE INTO set_effects (set_name, pieces, bonus) VALUES ('DreamingSet', '[2 set]', 'ATK +2%, PEN +2');
INSERT OR IGNORE INTO set_effects (set_name, pieces, bonus) VALUES ('DreamingSet', '[3 set]', 'ATK +2%, PEN +2');
INSERT OR IGNORE INTO set_effects (set_name, pieces, bonus) VALUES ('DreamingSet', '[4 set]', 'ATK +2%, PEN +2');
INSERT OR IGNORE INTO set_effects (set_name, pieces, bonus) VALUES ('DreamingSet', '[5 set]', '[Dreaming]: A.R. +1, ATK +8%, PEN +6, All Stats +3, PVP DMG +20%, All DMG +50%, All Skills +1');
INSERT OR IGNORE INTO set_effects (set_name, pieces, bonus) VALUES ('ReverieSet', 'Weapon Armor Ear Neck Belt Glove Boots
		[1 set]', 'ATK +2%');
INSERT OR IGNORE INTO set_effects (set_name, pieces, bonus) VALUES ('ReverieSet', '[2 set]', 'ATK +2%, Monster ATK +5%');
INSERT OR IGNORE INTO set_effects (set_name, pieces, bonus) VALUES ('ReverieSet', '[3 set]', 'ATK +2%, Monster ATK +10%');
INSERT OR IGNORE INTO set_effects (set_name, pieces, bonus) VALUES ('ReverieSet', '[4 set]', 'ATK +2%, Monster ATK +15%');
INSERT OR IGNORE INTO set_effects (set_name, pieces, bonus) VALUES ('ReverieSet', '[5 set]', '[Reverie]: A.R./D.R. +1, ATK +2%, Monster ATK +25%, All Stats +5, PVP DMG +5%, ALL DMG +5%, All Skills +1');
INSERT OR IGNORE INTO set_effects (set_name, pieces, bonus) VALUES ('BossRaidSet', 'Armor Ear Neck Belt Glove Boots
		[1 set]', 'ATK +5%');
INSERT OR IGNORE INTO set_effects (set_name, pieces, bonus) VALUES ('BossRaidSet', '[2 set]', 'ATK +5%, PEN +5');
INSERT OR IGNORE INTO set_effects (set_name, pieces, bonus) VALUES ('BossRaidSet', '[3 set]', 'ATK +5%, PEN +5, IMM +2, All Damage Reduction -1%');
INSERT OR IGNORE INTO set_effects (set_name, pieces, bonus) VALUES ('BossRaidSet', '[4 set]', 'ATK +5%, PEN +5, IMM +3, All Damage Reduction -1%');
INSERT OR IGNORE INTO set_effects (set_name, pieces, bonus) VALUES ('BossRaidSet', '[5 set]', 'A.R. +1, D.R. +1, ATK +5%, PEN +5, IMM +5, All Stats +5, All Damage Reduction -2%');
INSERT OR IGNORE INTO set_effects (set_name, pieces, bonus) VALUES ('MuertuorsSet', 'Weapon Ear Neck Belt Glove Boots
		[1 set]', 'ATK +4%, HP +2000, PEN +4, IMM +3');
INSERT OR IGNORE INTO set_effects (set_name, pieces, bonus) VALUES ('MuertuorsSet', '[2 set]', 'ATK +4%, HP +2000, PEN +4, IMM +3');
INSERT OR IGNORE INTO set_effects (set_name, pieces, bonus) VALUES ('MuertuorsSet', '[3 set]', 'ATK +4%, HP +2000, PEN +4, IMM +3');
INSERT OR IGNORE INTO set_effects (set_name, pieces, bonus) VALUES ('MuertuorsSet', '[4 set]', 'ATK +4%, HP +2000, PEN +4, IMM +3, All DMG taken -10%');
INSERT OR IGNORE INTO set_effects (set_name, pieces, bonus) VALUES ('MuertuorsSet', '[5 set]', 'ATK +4%, HP +2000, PEN +4, IMM +3, A.R. +2');
INSERT OR IGNORE INTO set_effects (set_name, pieces, bonus) VALUES ('MuertuorsSet', '[6 set]', 'ATK +4%, HP +2000, PEN +5, IMM +3, All Stats +5, D.R. +2');
