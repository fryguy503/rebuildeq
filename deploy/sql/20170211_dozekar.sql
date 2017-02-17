# Set multiplier 2 on Dozekar gem drop (requires hotfix/shared_memory refresh)
UPDATE lootdrop_entries SET multiplier=2 WHERE lootdrop_id=165857 AND item_id=101400;

# Lower respawn rate to 12 hours
UPDATE spawn2 SET respawntime="43200" WHERE id=25326;

# Add unslowable flag
UPDATE npc_types SET special_abilities="1,1^6,1^12,1^13,1^14,1^15,1^16,1^17,1^21,1^42,1" WHERE id=124037;
