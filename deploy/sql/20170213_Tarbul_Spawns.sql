# Change the rogue lion spawn points to Tarbul's spawngroup
UPDATE spawn2 set spawngroupID="13605" where id = 8676; 
UPDATE spawn2 set spawngroupID="13605" where id = 8677; 

# Increase respawn time to 6m 40s
UPDATE spawn2 SET respawntime="400" WHERE id = 8676; 
UPDATE spawn2 SET respawntime="400" WHERE id = 8677; 
UPDATE spawn2 SET respawntime="400" WHERE id = 21934;


# Limit Tarbul to one spawn in zone
UPDATE npc_types SET spawn_limit = "1" WHERE id = 15171;
