#Issue #2766: Ice Burrower's in west waste are not suppose to summon
#Remove summon ability for Ice Borrowers
UPDATE `npc_types` SET `special_abilities` = NULL WHERE (`id` = '120010');

#Issue 1736 - Add (Armor Quest) last name to Lieutenant_Bythgar
UPDATE npc_types SET lastname="Armor Quest" WHERE id=115071; -- whovian (10-Nov-18  2:48:18)
