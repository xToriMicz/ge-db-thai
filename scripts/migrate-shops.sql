-- Migration 031: Shops from ge-db.site/andromida/Shops.php

CREATE TABLE IF NOT EXISTS shops (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT NOT NULL,
  location TEXT DEFAULT '',
  items TEXT DEFAULT '',
  UNIQUE(name)
);

INSERT OR IGNORE INTO shops (name, items) VALUES ('Shop


	All
	Arm Shield
	Blunt
	Bracelet of Fire
	Bracelet of Ice
	Bracelet of Lightning
	Cannon
	Controller
	Crescent
	Crossbow
	Cube
	Dagger
	Gaiters
	Great Sword
	Hammer
	Javelin
	Knuckle
	Large Caliber Rifle
	Lute
	Magic Scroll
	Main-Gauche
	Pistol
	Pendant
	Polearm
	Rapier
	Rifle
	Rod
	Rosario
	Sabre
	Shield
	Shotgun
	Special Bracelet
	Staff
	Sword
	Tonfa


Search 






Shop Locations
Common
Bianca [Cosmetic] Shop
	Bianca [Costume] Shop
	Blacksmith, Smith
	Clique Battle (Alliance War) Shop
	Costume Trader, Johanna (15 days)
	Costume Trader, Johanna (7 days)
	Enchant Merchant, Ana
	Expedition Shop
	Feso Shop
	Leonardo Expreso
	Kafra - Consumable Shop
	Mission - EXTRA
	Mission - Rank 1
	Mission - Rank 1+
	Mission - Rank 2
	Mission - Rank 2+
	Mission - Rank 3
	Mission - Rank 3+
	Mission - Rank 4
	Mission - Rank 4+
	Mission - Rank 5
	Mission - Rank 5+
	Mission - Rank 6
	Mission - Rank 6+
	Mission - Rank 7
	Mission - Rank 7+
	Shiny Crystal Shop
	World PvP Shop
	[Andromida Token Merchant] Character Cards
	[Andromida Token Merchant] Hot Items & Packages
	[Andromida Token Merchant] Misc
	[Andromida Token Merchant] Period Items & Consumables
	[Andromida Token Merchant] Stance Books & Pet Spirits
	[Andromida Token Merchant] Summon Stones & Pet Boxes', 'Cite de Reboldoeux
Andre (Costumes)
	Andre (Pose Guides)
	Colosseum Point Shop
	Enhance Merchant, Idge
	Equipment Merchant, Claude Baudez
	Faction Mission Shop
	Grocery Merchant, Camille
	Item Dealer, Jessica
	Karin - Supporter Shop
	Lucia - Pioneer Shop
	Lucia - Quest Shop
	Mini Game Shop
	Pioneer Token Shop - Aither
	Pioneer Token Shop - Autumn
	Pioneer Token Shop - Christmas
	Pioneer Token Shop - Hare Rev
	Pioneer Token Shop - Makima
	Pioneer Token Shop - Novia
	Pioneer Token Shop - Sorscha
	Pioneer Token Shop - Veryl
	Rebirth Shop
	[Gate of Reboldoeux Queen] Girl
	[Gate of Reboldoeux Queen] Soldier of Reboldoeux in Disguise
	[Royal Guest House] Royal Guard
	
Port of Coimbra
Equipment Merchant, Adelina
	Firearms Merchant, Bernelli
	Item Dealer, Emilia
	Jose Corthasar
	Lisa Lynway
	Magic Tools Merchant, M''Boma
	Textiles Merchant, Taylor
	
City of Auch
Firearms Merchant, Lorch
	Isabelle the Cake Girl
	Item Dealer, Schlina
	Magic Equipment Merchant, Karjalaine
	[Los Toldos] Carlos');
