-- Add server_origin to characters
-- Values: 'all' (KGE+Steam+Andro), 'steam' (Steam+Andro, not KGE), 'andromida' (Andro-only)
ALTER TABLE characters ADD COLUMN server_origin TEXT DEFAULT 'all';

-- Steam+Andromida only (11 chars — not in KGE)
UPDATE characters SET server_origin = 'steam' WHERE slug IN (
  'Behemoth', 'CodeNameJ', 'Danev', 'Gaura', 'Hass',
  'Leviathan', 'Mertis', 'Ronera', 'Ziz2', 'Sylvestia', 'Ziz'
);

-- Andromida-only (18 chars — not in KGE or Steam)
UPDATE characters SET server_origin = 'andromida' WHERE slug IN (
  'Beretta', 'Braise', 'Claret', 'Dina', 'Eunha',
  'GracieloHD', 'Hatir', 'Ivelar', 'KevinICE', 'Kurt2',
  'Lilly', 'Mifuyu', 'PioBrunie', 'PioMboma', 'Raviel',
  'RosieICE', 'Stia', 'Wiesel'
);
