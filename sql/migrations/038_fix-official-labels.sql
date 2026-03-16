-- Fix: if a char exists on ANY licensed server (Thai EXE or Steam) = official
-- Rule: on Steam official (granadoespada.com) OR on Thai (on_thai=1) = official
-- Only truly unofficial = not on KGE, not on Steam, not on Thai

-- 19 on Steam official
UPDATE characters SET server_origin = 'official' WHERE slug IN (
  'Stia', 'Raviel', 'Kurt2', 'Lilly', 'Eunha',
  'Claret', 'Hatir', 'Beretta', 'Braise', 'Wiesel',
  'Behemoth', 'CodeNameJ', 'Danev', 'Gaura', 'Leviathan',
  'Mertis', 'Ronera', 'Sylvestia', 'Ziz'
);

-- 2 more: on Thai server (confirmed by Gabbzaa) but not on Steam
UPDATE characters SET server_origin = 'official' WHERE slug IN (
  'Ivelar', 'RosieICE'
);

-- Remaining unofficial (8) = on_thai=0 AND not on Steam = truly Andromida-only:
-- Dina, GracieloHD, Hass, KevinICE, Mifuyu, PioBrunie, PioMboma, Ziz2
