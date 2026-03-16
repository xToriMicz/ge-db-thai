-- Simplify server_origin to official/unofficial
-- Official = exists in KGE (source of truth)
-- Unofficial = NOT in KGE (Andromida private server only)

UPDATE characters SET server_origin = 'official' WHERE server_origin = 'all';
UPDATE characters SET server_origin = 'unofficial' WHERE server_origin IN ('steam', 'andromida');
