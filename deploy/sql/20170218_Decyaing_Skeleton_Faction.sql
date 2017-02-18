# Change all decaying skeletons to KoS
UPDATE npc_types SET npc_faction_id = 0 WHERE name LIKE 'a_decaying_skeleton';
