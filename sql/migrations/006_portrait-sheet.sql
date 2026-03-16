-- Characters using portrait02.webp sprite sheet
UPDATE characters SET portrait_sheet = 2 WHERE slug IN (
  'Behemoth', 'Karmen', 'BerroniffRare', 'CodeNameJ',
  'Danev', 'Gaura', 'Hass', 'Leviathan',
  'Mertis', 'Rebecca', 'Ronera', 'Ziz2',
  'Sylvestia', 'Ziz'
);
