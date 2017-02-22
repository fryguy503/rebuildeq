# Update a_cerulean_drake bodytype to untargetable
UPDATE npc_types SET bodytype = 11 WHERE id IN (999251,999252,999253,999254,999255,999256,999257,999258);

# Create Drake Card
UPDATE items SET slots="131072", classes="65535", augtype="1", reqlevel "0",Name="Drake Card", itemtype="54", lore="", nodrop="1", loregroup="0", price="1", icon="648", weight="0", color="2147483647", size="0", material="0", updated="2017-2-21 21:14:29" WHERE id=100145;
