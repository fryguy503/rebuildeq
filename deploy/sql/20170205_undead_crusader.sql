# Fixes the multiple spawning of the undead crusader and makes him 100% chance to spawn at that point
DELETE FROM spawnentry WHERE spawngroupID=10895 AND npcID IN (97000, 97001, 97003);
UPDATE spawnentry SET chance = 100 WHERE spawngroupID=10895 AND npcID=97077;
UPDATE spawngroup SET despawn="0", despawn_timer="0" WHERE id=10895;
