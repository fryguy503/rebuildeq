#Add Translocator Nelyrin NPC
INSERT INTO npc_types (name, lastname, level, race, class, bodytype, hp, mana, gender, texture, helmtexture, 
herosforgemodel, size, hp_regen_rate, mana_regen_rate, loottable_id, merchant_id, alt_currency_id, npc_spells_id, 
npc_spells_effects_id, npc_faction_id, adventure_template_id, trap_template, mindmg, maxdmg, attack_count, 
npcspecialattks, special_abilities, aggroradius, assistradius, face, luclin_hairstyle, luclin_haircolor, 
luclin_eyecolor, luclin_eyecolor2, luclin_beardcolor, luclin_beard, drakkin_heritage, drakkin_tattoo, drakkin_details, 
armortint_id, armortint_red, armortint_green, armortint_blue, d_melee_texture1, d_melee_texture2, ammo_idfile, 
prim_melee_type, sec_melee_type, ranged_type, runspeed, MR, CR, DR, FR, PR, Corrup, PhR, see_invis, see_invis_undead, 
qglobal, AC, npc_aggro, spawn_limit, attack_speed, attack_delay, findable, STR, STA, DEX, AGI, _INT, WIS, CHA, 
see_hide, see_improved_hide, trackable, isbot, exclude, ATK, Accuracy, Avoidance, slow_mitigation, version, maxlevel, 
scalerate, private_corpse, unique_spawn_by_name, underwater, isquest, emoteid, spellscale, healscale, no_target_hotkey, 
raid_target, armtexture, bracertexture, handtexture, legtexture, feettexture, light, walkspeed, peqid, unique_, fixed) 
VALUES ("Nelyrin", "Translocator", "65", "5", "41", "1", "34500", "0", "1", "2", "0", "0", "5", "0", "0", "0", 
"1000002", "0", "0", "0", "0", "0", "0", "0", "0", "-1", "", "19,1^20,1^24,1", "0", "0", "0", "1", "1", "1", "1", "1", 
"0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "IT10", "28", "28", "7", "0", "0", "0", "0", "0", "0", "0", "0", "0", 
"0", "0", "0", "0", "0", "0", "30", "0", "75", "75", "75", "75", "80", "75", "75", "0", "0", "1", "0", "1", "0", "0", 
"0", "0", "0", "0", "100", "0", "0", "0", "0", "0", "100", "100", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", 
"0", "0");

# Add Translocator Nelyrin spawn to East Commons
INSERT INTO spawngroup SET name = "ecommons-Translocator-Nelyrin";
INSERT INTO spawnentry SET spawngroupID=(SELECT id FROM spawngroup WHERE name = "ecommons-Translocator-Nelyrin"), 
npcID=(SELECT id FROM npc_types WHERE name = "Nelyrin"), chance=100;
INSERT INTO spawn2 SET spawngroupID=(SELECT id FROM spawngroup WHERE name = "ecommons-Translocator-Nelyrin"), 
zone="ecommons", x=-102.14, y=-1839.09, z=2.19, heading=246.1, respawntime=1, variance=0, pathgrid=0, _condition=0, 
cond_value=1, version=0, enabled=1, animation=0;
