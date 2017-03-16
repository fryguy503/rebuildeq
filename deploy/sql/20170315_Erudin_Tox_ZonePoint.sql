# Remove the bad zonepoint and update the correct zonepoint so it is used.
DELETE FROM zone_points WHERE zone LIKE 'erudnext' AND target_zone_id = 414 AND client_version_mask = 4294967295;
UPDATE zone_points SET client_version_mask = 4294967295 WHERE zone LIKE 'erudnext' AND target_zone_id = 414 AND client_version_mask = 0;
