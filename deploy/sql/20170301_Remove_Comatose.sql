# Remove comatose spell from spellbooks and spellbars
DELETE FROM character_spells WHERE spell_id = 3685;
DELETE FROM character_memmed_spells WHERE spell_id = 3685;
