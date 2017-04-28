# Fix Primal Fusion Target Type
UPDATE spells_new SET `targettype` = "14" WHERE id=6276;
UPDATE spells_new SET spell_category  = 36 WHERE id = 6276;
