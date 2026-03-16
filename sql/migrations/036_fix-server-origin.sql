-- Fix server_origin based on official sources (2026-03-14):
-- KGE: ge.hanbiton.com (263 chars)
-- Steam: granadoespada.com (197 chars listed, includes newer ones)
-- Thai: confirmed by Gabbzaa (active player)
-- Andromida: ge-db.site/andromida (292 chars, private server)

-- Step 1: Move 10 chars from 'andromida' to 'steam' (confirmed on granadoespada.com)
UPDATE characters SET server_origin = 'steam' WHERE slug IN (
  'Stia', 'Raviel', 'Kurt2', 'Lilly', 'Eunha',
  'Claret', 'Hatir', 'Beretta', 'Braise', 'Wiesel'
);

-- Step 2: Move 2 chars from 'steam' to 'andromida' (NOT on granadoespada.com)
UPDATE characters SET server_origin = 'andromida' WHERE slug IN (
  'Hass', 'Ziz2'
);

-- Step 3: Dina, Ivelar also on Steam (granadoespada.com doesn't list by slug but
-- they're available). Keep as 'andromida' until confirmed.
-- RosieICE: on Thai but not confirmed on Steam official → keep 'andromida'

-- Step 4: Add Thai server availability
-- Default: all chars available on Thai (most are)
ALTER TABLE characters ADD COLUMN on_thai INTEGER DEFAULT 1;

-- Mark 6 chars NOT on Thai server (confirmed by Gabbzaa 2026-03-14)
UPDATE characters SET on_thai = 0 WHERE slug IN (
  'Dina', 'GracieloHD', 'KevinICE', 'Mifuyu', 'PioBrunie', 'PioMboma'
);

-- Also mark Andromida-exclusive chars as not on Thai (unless confirmed)
-- Hass, Ziz2: unknown Thai status → mark 0 to be safe
UPDATE characters SET on_thai = 0 WHERE slug IN ('Hass', 'Ziz2');

-- Final summary:
-- all: 263 (KGE)
-- steam: 19 (Behemoth,CodeNameJ,Danev,Gaura,Leviathan,Mertis,Ronera,Sylvestia,Ziz + Stia,Raviel,Kurt2,Lilly,Eunha,Claret,Hatir,Beretta,Braise,Wiesel)
-- andromida: 10 (Dina,GracieloHD,Ivelar,KevinICE,Mifuyu,PioBrunie,PioMboma,RosieICE,Hass,Ziz2)
-- on_thai=0: 8 (Dina,GracieloHD,KevinICE,Mifuyu,PioBrunie,PioMboma,Hass,Ziz2)
