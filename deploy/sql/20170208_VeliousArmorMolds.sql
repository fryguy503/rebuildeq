# Fix stackable and stacksize on Corroded BP
UPDATE items SET stackable = 1, stacksize = 100 WHERE name = 'Corroded Breastplate';

# Fix stackable and stacksize on all torn enchanted silk
UPDATE items SET stackable = 1, stacksize = 100 WHERE name LIKE 'torn enchanted silk%';
