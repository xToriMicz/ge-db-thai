-- Fix: Strip formatting codes from statuses data
-- {#ff4848}text{/} = color codes, {br} = line break, &apos; = HTML entity, "> = tooltip remnant

UPDATE statuses SET name = REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(name,
  '{br}', ' '), '{/}', ''), '{#ff4848}', ''), '{#FF4848}', ''),
  '{#ff0000}', ''), '{#FF0000}', ''), '&apos;', ''''), '">', '')
WHERE name LIKE '%{%' OR name LIKE '%&apos;%' OR name LIKE '%">%';

UPDATE statuses SET description = REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(description,
  '{br}', ' '), '{/}', ''), '{#ff4848}', ''), '{#FF4848}', ''),
  '{#ff0000}', ''), '{#FF0000}', ''), '&apos;', '''')
WHERE description LIKE '%{%' OR description LIKE '%&apos;%';
