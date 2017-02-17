# nektulos to east commonlands
DELETE FROM zone_points WHERE zone = "nektulos" AND target_zone_id = 408;
UPDATE zone_points SET client_version_mask = 4294967295 WHERE zone = "nektulos" AND target_zone_id = 22;
