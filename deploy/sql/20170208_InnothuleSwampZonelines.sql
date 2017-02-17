# Fix grobb to innothule zoneline 
DELETE FROM zone_points WHERE zone = "grobb" AND target_zone_id = 413;
UPDATE zone_points SET client_version_mask = 4294967295 WHERE zone = "grobb" AND target_zone_id = 46;
# Fix guktop to innothule zoneline 
DELETE FROM zone_points WHERE zone = "guktop" AND target_zone_id = 413;
UPDATE zone_points SET client_version_mask = 4294967295 WHERE zone = "guktop" AND target_zone_id = 46;
# Fix feerrott to innothule zoneline 
DELETE FROM zone_points WHERE zone = "feerrott" AND target_zone_id = 413;
UPDATE zone_points SET client_version_mask = 4294967295 WHERE zone = "feerrott" AND target_zone_id = 46;
