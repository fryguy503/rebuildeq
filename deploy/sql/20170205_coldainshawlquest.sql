# Add the Ulthork Meat Pie recipe
INSERT INTO tradeskill_recipe SET name = 'Ulthork Meat Pie', tradeskill = 60, skillneeded = 0, trivial = 82, nofail = 0, replace_container = 0, notes = NULL, must_learn = 0, quest = 0, enabled = 1;
INSERT INTO tradeskill_recipe_entries SET recipe_id = (SELECT id FROM tradeskill_recipe WHERE name LIKE 'Ulthork Meat Pie'), item_id = 1453, successcount = 0, failcount = 0, componentcount = 1, salvagecount = 0, iscontainer = 0;
INSERT INTO tradeskill_recipe_entries SET recipe_id = (SELECT id FROM tradeskill_recipe WHERE name LIKE 'Ulthork Meat Pie'), item_id = 13438, successcount = 0, failcount = 0, componentcount = 1, salvagecount = 0, iscontainer = 0;
INSERT INTO tradeskill_recipe_entries SET recipe_id = (SELECT id FROM tradeskill_recipe WHERE name LIKE 'Ulthork Meat Pie'), item_id = 13090, successcount = 0, failcount = 0, componentcount = 1, salvagecount = 0, iscontainer = 0;
INSERT INTO tradeskill_recipe_entries SET recipe_id = (SELECT id FROM tradeskill_recipe WHERE name LIKE 'Ulthork Meat Pie'), item_id = 1427, successcount = 1, failcount = 0, componentcount = 0, salvagecount = 0, iscontainer = 0;
INSERT INTO tradeskill_recipe_entries SET recipe_id = (SELECT id FROM tradeskill_recipe WHERE name LIKE 'Ulthork Meat Pie'), item_id = 15, successcount = 0, failcount = 0, componentcount = 0, salvagecount = 0, iscontainer = 1;
INSERT INTO tradeskill_recipe_entries SET recipe_id = (SELECT id FROM tradeskill_recipe WHERE name LIKE 'Ulthork Meat Pie'), item_id = 17164, successcount = 0, failcount = 0, componentcount = 0, salvagecount = 0, iscontainer = 1;
INSERT INTO tradeskill_recipe_entries SET recipe_id = (SELECT id FROM tradeskill_recipe WHERE name LIKE 'Ulthork Meat Pie'), item_id = 17947, successcount = 0, failcount = 0, componentcount = 0, salvagecount = 0, iscontainer = 1;

# Add Lorekeeper Brita spawn point and group
INSERT INTO spawngroup SET name = 'thurgadina_lorekeeper_brita', delay = 0;
INSERT INTO spawnentry SET spawnentry.spawngroupID = (SELECT id FROM spawngroup WHERE name = 'thurgadina_lorekeeper_brita'), spawnentry.npcID = 115152, spawnentry.chance = 100;
INSERT INTO spawn2 SET spawngroupID = (SELECT id FROM spawngroup WHERE name = 'thurgadina_lorekeeper_brita'), zone = 'thurgadina', version = 0, x = 812, y = -181, z = -17.50, heading = 66, respawntime = 640, variance = 64, _condition = 0, cond_value = 1, enabled = 1, animation = 0;
