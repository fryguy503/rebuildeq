UPDATE rule_values SET rule_name="Spells:PreNerfBardAEDoT", rule_value="true", ruleset_id="1", notes="" WHERE rule_name="Spells:PreNerfBardAEDoT" AND ruleset_id="1";
UPDATE spells_new SET dot_stacking_exempt = 1 WHERE id IN (703, 730)
