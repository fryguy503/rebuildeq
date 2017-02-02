# Update shimmering geonid to geonid faction
UPDATE npc_types SET npc_faction_id=446 WHERE id=119142;

# Remove scribed spells and memmed spells that do not belong on mages
DELETE FROM character_memmed_spells WHERE spell_id IN (398, 399, 400, 397, 402, 403, 404, 401, 336, 395, 396, 335, 497, 498, 499, 496, 570, 571, 572, 569, 574, 575, 576, 573, 621, 622, 623, 620, 625, 626, 627, 624, 629, 630, 631, 628, 632, 634, 635, 633, 1671, 1673, 1674, 1672, 1675, 1677, 1678, 1676, 1400, 1402, 1404);
DELETE FROM character_spells WHERE spell_id IN (398, 399, 400, 397, 402, 403, 404, 401, 336, 395, 396, 335, 497, 498, 499, 496, 570, 571, 572, 569, 574, 575, 576, 573, 621, 622, 623, 620, 625, 626, 627, 624, 629, 630, 631, 628, 632, 634, 635, 633, 1671, 1673, 1674, 1672, 1675, 1677, 1678, 1676, 1400, 1402, 1404);

# Kill all pets
DELETE FROM character_pet_info WHERE char_id IN (SELECT id FROM character_data WHERE character_data.class = 13);
DELETE FROM character_pet_buffs WHERE char_id IN (SELECT id FROM character_data WHERE character_data.class = 13);
DELETE FROM character_pet_inventory WHERE char_id IN (SELECT id FROM character_data WHERE character_data.class = 13);

# Fix OoT -> EFP Translocation
UPDATE spells_new SET teleport_zone = "freporte", effect_base_value1 = -1041, effect_base_value2 = -14, effect_base_value3 = -50, effect_base_value4 = 36 WHERE id = 2283;

# Added key requirement for the HS East Key
UPDATE doors SET keyitem = 20516 WHERE zone = "charasis" AND doorid = 9;

# Update body types for forest giants
UPDATE npc_types SET bodytype = 4 WHERE name LIKE 'a_forest_giant%';

# Added Dozekar Card
REPLACE INTO `items` (`id`, `minstatus`, `Name`, `aagi`, `ac`, `accuracy`, `acha`, `adex`, `aint`, `artifactflag`, `asta`, `astr`, `attack`, `augrestrict`, `augslot1type`, `augslot1visible`, `augslot2type`, `augslot2visible`, `augslot3type`, `augslot3visible`, `augslot4type`, `augslot4visible`, `augslot5type`, `augslot5visible`, `augslot6type`, `augslot6visible`, `augtype`, `avoidance`, `awis`, `bagsize`, `bagslots`, `bagtype`, `bagwr`, `banedmgamt`, `banedmgraceamt`, `banedmgbody`, `banedmgrace`, `bardtype`, `bardvalue`, `book`, `casttime`, `casttime_`, `charmfile`, `charmfileid`, `classes`, `color`, `combateffects`, `extradmgskill`, `extradmgamt`, `price`, `cr`, `damage`, `damageshield`, `deity`, `delay`, `augdistiller`, `dotshielding`, `dr`, `clicktype`, `clicklevel2`, `elemdmgtype`, `elemdmgamt`, `endur`, `factionamt1`, `factionamt2`, `factionamt3`, `factionamt4`, `factionmod1`, `factionmod2`, `factionmod3`, `factionmod4`, `filename`, `focuseffect`, `fr`, `fvnodrop`, `haste`, `clicklevel`, `hp`, `regen`, `icon`, `idfile`, `itemclass`, `itemtype`, `ldonprice`, `ldontheme`, `ldonsold`, `light`, `lore`, `loregroup`, `magic`, `mana`, `manaregen`, `enduranceregen`, `material`, `herosforgemodel`, `maxcharges`, `mr`, `nodrop`, `norent`, `pendingloreflag`, `pr`, `procrate`, `races`, `range`, `reclevel`, `recskill`, `reqlevel`, `sellrate`, `shielding`, `size`, `skillmodtype`, `skillmodvalue`, `slots`, `clickeffect`, `spellshield`, `strikethrough`, `stunresist`, `summonedflag`, `tradeskills`, `favor`, `weight`, `UNK012`, `UNK013`, `benefitflag`, `UNK054`, `UNK059`, `booktype`, `recastdelay`, `recasttype`, `guildfavor`, `UNK123`, `UNK124`, `attuneable`, `nopet`, `updated`, `comment`, `UNK127`, `pointtype`, `potionbelt`, `potionbeltslots`, `stacksize`, `notransfer`, `stackable`, `UNK134`, `UNK137`, `proceffect`, `proctype`, `proclevel2`, `proclevel`, `UNK142`, `worneffect`, `worntype`, `wornlevel2`, `wornlevel`, `UNK147`, `focustype`, `focuslevel2`, `focuslevel`, `UNK152`, `scrolleffect`, `scrolltype`, `scrolllevel2`, `scrolllevel`, `UNK157`, `serialized`, `verified`, `serialization`, `source`, `UNK033`, `lorefile`, `UNK014`, `svcorruption`, `skillmodmax`, `UNK060`, `augslot1unk2`, `augslot2unk2`, `augslot3unk2`, `augslot4unk2`, `augslot5unk2`, `augslot6unk2`, `UNK120`, `UNK121`, `questitemflag`, `UNK132`, `clickunk5`, `clickunk6`, `clickunk7`, `procunk1`, `procunk2`, `procunk3`, `procunk4`, `procunk6`, `procunk7`, `wornunk1`, `wornunk2`, `wornunk3`, `wornunk4`, `wornunk5`, `wornunk6`, `wornunk7`, `focusunk1`, `focusunk2`, `focusunk3`, `focusunk4`, `focusunk5`, `focusunk6`, `focusunk7`, `scrollunk1`, `scrollunk2`, `scrollunk3`, `scrollunk4`, `scrollunk5`, `scrollunk6`, `scrollunk7`, `UNK193`, `purity`, `evoitem`, `evoid`, `evolvinglevel`, `evomax`, `clickname`, `procname`, `wornname`, `focusname`, `scrollname`, `dsmitigation`, `heroic_str`, `heroic_int`, `heroic_wis`, `heroic_agi`, `heroic_dex`, `heroic_sta`, `heroic_cha`, `heroic_pr`, `heroic_dr`, `heroic_fr`, `heroic_cr`, `heroic_mr`, `heroic_svcorrup`, `healamt`, `spelldmg`, `clairvoyance`, `backstabdmg`, `created`, `elitematerial`, `ldonsellbackrate`, `scriptfileid`, `expendablearrow`, `powersourcecapacity`, `bardeffect`, `bardeffecttype`, `bardlevel2`, `bardlevel`, `bardunk1`, `bardunk2`, `bardunk3`, `bardunk4`, `bardunk5`, `bardname`, `bardunk7`, `UNK214`, `UNK219`, `UNK220`, `UNK221`, `heirloom`, `UNK223`, `UNK224`, `UNK225`, `UNK226`, `UNK227`, `UNK228`, `UNK229`, `UNK230`, `UNK231`, `UNK232`, `UNK233`, `UNK234`, `placeable`, `UNK236`, `UNK237`, `UNK238`, `UNK239`, `UNK240`, `UNK241`, `epicitem`) VALUES (100144, 0, 'Dozekar the Cursed Card', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1000, 1000, '', '0', 65535, 2147483647, '0', 0, 0, 100, 0, 0, 0, 0, 0, 47001, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', -1, 0, 0, 0, 0, 0, 0, 648, 'IT63', 0, 54, 0, 0, 0, 0, 'This item is yet to be discovered', 0, 1, 0, 0, 0, 0, 0, -1, 0, 1, 1, 0, 0, 0, 65535, 0, 0, 0, 0, 1111, 0, 0, -1, 0, 98304, 71, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '2012-12-27 10:34:28', '', 0, 0, 0, 0, 1, 0, 0, '', 0, -1, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, '0000-00-00 00:00:00', '2009-05-08 22:01:35', '', '13THFLOOR', 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, '0000000000000000000', 0, '', -1, 0, 0, 0, 0, '', -1, 0, 0, 0, 0, 0, '', -1, 0, 0, 0, 0, 0, '', -1, 0, 0, 0, 0, 0, '', -1, 0, 0, 0, 0, 0, 0, '', '', '', '', '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '2003-11-13 04:01:16', 0, 70, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, '', -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);

# Made Kael and WToV armor drops stackable like HoT armor drops
update items set stacksize = 100, stackable = 1 WHERE id in (24905, 24900, 24902, 24904, 24906, 24901, 24903, 24905, 24900, 24902, 24904, 24906, 24901, 24903, 24919, 24914, 24916, 24918, 24920, 24915, 24917, 24912, 24907, 24909, 24911, 24913, 24908, 24910, 24919, 24914, 24916, 24918, 24920, 24915, 24917, 24912, 24907, 24909, 24911, 24913, 24908, 24910, 24905, 24900, 24902, 24904, 24906, 24901, 24903, 24926, 24921, 24923, 24925, 24927, 24922, 24924, 24926, 24921, 24923, 24925, 24927, 24922, 24924, 24926, 24921, 24923, 24925, 24927, 24922, 24924, 24926, 24921, 24923, 24925, 24927, 24922, 24924, 24905, 24900, 24902, 24904, 24906, 24901, 24903, 24905, 24900, 24902, 24904, 24906, 24901, 24903, 24912, 24907, 24909, 24911, 24913, 24908, 24910);

# Updated body types for Burynai
UPDATE npc_types SET bodytype = 21 WHERE race IN (144,602);

# Update Veil of Elements spell effect_base_value1
UPDATE spells_new set spells_new.effectid1 = 314 WHERE spells_new.id = 2537;

# Remove HS key from keyring
DELETE FROM keyring WHERE item_id = 20600;
DELETE FROM inventory WHERE itemid = 20600;

# Make elenium and shards magical so they cannot be pickpocketed
UPDATE items SET items.magic = 1 WHERE id IN (100006, 100048);

# Added zoneline offset for CB/GFay
UPDATE zone_points SET target_x_offset = -216 WHERE zone = "crushbone" AND target_zone_id = 54;
UPDATE zone_points SET target_x_offset = 216 WHERE zone = "gfaydark" AND target_zone_id = 58;

# Clean up character combos that shouldn't exist
DELETE FROM char_create_combinations WHERE start_zone = 394 OR class IN (15, 16) OR race IN (330,130);

# Clean up expansion errors at character select
UPDATE char_create_combinations SET expansions_req = 0;