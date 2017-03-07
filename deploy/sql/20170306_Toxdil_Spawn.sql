# Add Toxdil spawn to West Freeport
INSERT INTO spawngroup SET name = "freportw_toxdil";
INSERT INTO spawnentry SET spawngroupID=(SELECT id FROM spawngroup WHERE name = "freportw_toxdil"), npcID=9123, chance=100;
INSERT INTO spawn2 SET spawngroupID=(SELECT id FROM spawngroup WHERE name = "freportw_toxdil"), zone="freportw", x=202.66, y=611.41, z=-32.57, heading=144, respawntime=1200, variance=0, pathgrid=0, _condition=0, cond_value=1, version=0, enabled=1, animation=0;
