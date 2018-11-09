#Issue #2766: Ice Burrower's in west waste are not suppose to summon
#Remove summon ability for Ice Borrowers
UPDATE `eqemu`.`npc_types` SET `special_abilities` = NULL WHERE (`id` = '120010');
