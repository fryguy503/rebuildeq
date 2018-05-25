#adjust the level that exp loss and item loss starts at to match the website descriptions
UPDATE rule_values SET rule_name="Character:DeathExpLossLevel", rule_value="11", ruleset_id="1", notes="" WHERE rule_name="Character:DeathExpLossLevel" AND ruleset_id="1";
UPDATE rule_values SET rule_name="Character:DeathItemLossLevel", rule_value="41", ruleset_id="1", notes="" WHERE rule_name="Character:DeathItemLossLevel" AND ruleset_id="1";
