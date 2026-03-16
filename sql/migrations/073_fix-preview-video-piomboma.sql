-- Migration 073: Fix preview video assignment
-- Video sZL8eU0AazE is "Pioneer Mboma" not "Ion"
-- Also update Pio character Thai names: Pio = Pioneer (ไพโอเนียร์)
-- Generated: 2026-03-16

-- Fix wrong video assignment (was Ion, should be PioMboma)
UPDATE characters SET preview_video = NULL WHERE slug = 'Ion' AND preview_video = 'sZL8eU0AazE';
UPDATE characters SET preview_video = 'sZL8eU0AazE' WHERE slug = 'PioMboma';

-- Fix Thai names: Pio = Pioneer (ไพโอเนียร์)
UPDATE characters SET name_th = 'ไพโอเนียร์ บรูนี่' WHERE name = 'PioBrunie';
UPDATE characters SET name_th = 'ไพโอเนียร์ เอ็มโบม่า' WHERE name = 'PioMboma';
