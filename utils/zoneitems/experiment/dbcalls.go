package main

import ( //"database/sql"
	"fmt"

	"github.com/xackery/goeq/item"
	"github.com/xackery/goeq/loot"
	"github.com/xackery/goeq/npc"
	"github.com/xackery/goeq/spawn"
	"github.com/xackery/goeq/zone"
)

func (db *Database) createTable() error {
	if db == nil {
		return fmt.Errorf("No database")
	}
	if db.instance == nil {
		return fmt.Errorf("No database instance")
	}
	query := "CREATE TABLE IF NOT EXISTS `zone_drops` (" +
		"`id` int(11) unsigned NOT NULL AUTO_INCREMENT," +
		"`item_id` int(11) DEFAULT NULL," +
		"`npc_id` int(11) DEFAULT NULL," +
		"`zone_short_name` int(11) DEFAULT NULL," +
		"`zone_id` int(11) DEFAULT NULL," +
		"PRIMARY KEY (`id`)," +
		"UNIQUE KEY `item_id` (`item_id`,`npc_id`,`zone_id`)" +
		") ENGINE=InnoDB DEFAULT CHARSET=utf8;"
	if _, err := db.instance.Exec(query); err != nil {
		return err
	}
	return nil
}

func (db *Database) truncateTable() error {
	if db == nil {
		return fmt.Errorf("No database")
	}
	if db.instance == nil {
		return fmt.Errorf("No database instance")
	}
	query := "TRUNCATE zone_drops"
	if _, err := db.instance.Exec(query); err != nil {
		return err
	}
	return nil
}

func (db *Database) getZones() ([]zone.Zone, error) {
	if db == nil {
		return nil, fmt.Errorf("No database")
	}
	if db.instance == nil {
		return nil, fmt.Errorf("No database instance")
	}
	zones := []zone.Zone{}
	query := "SELECT * from eqemu.zone"
	if err := db.instance.Select(&zones, query); err != nil {
		return nil, err
	}
	return zones, nil
}

func (db *Database) getSpawns(zoneShortname string) ([]spawn.Spawn2, error) {
	if db == nil {
		return nil, fmt.Errorf("No database")
	}
	if db.instance == nil {
		return nil, fmt.Errorf("No database instance")
	}
	spawns := []spawn.Spawn2{}
	query := "SELECT * FROM spawn2 WHERE zone = ?"
	if err := db.instance.Select(&spawns, query, zoneShortname); err != nil {
		return nil, err
	}
	return spawns, nil
}

func (db *Database) getSpawnEntries(spawngroupid int) ([]spawn.SpawnEntry, error) {
	if db == nil {
		return nil, fmt.Errorf("No database")
	}
	if db.instance == nil {
		return nil, fmt.Errorf("No database instance")
	}
	spawnentries := []spawn.SpawnEntry{}
	query := "SELECT * FROM spawnentry WHERE spawngroupid = ?"
	if err := db.instance.Select(&spawnentries, query, spawngroupid); err != nil {
		return nil, err
	}
	return spawnentries, nil
}

func (db *Database) getNpcs(npctypeid int) ([]npc.NpcTypes, error) {
	if db == nil {
		return nil, fmt.Errorf("No database")
	}
	if db.instance == nil {
		return nil, fmt.Errorf("No database instance")
	}
	npcs := []npc.NpcTypes{}
	query := "SELECT * FROM npc_types WHERE id = ?"
	if err := db.instance.Select(&npcs, query, npctypeid); err != nil {
		return nil, err
	}
	return npcs, nil
}

func (db *Database) getLoottableEntries(loottableid int) ([]loot.LootTableEntries, error) {
	if db == nil {
		return nil, fmt.Errorf("No database")
	}
	if db.instance == nil {
		return nil, fmt.Errorf("No database instance")
	}
	loottableentries := []loot.LootTableEntries{}
	query := "SELECT * FROM loottable_entries WHERE loottable_id = ?"
	if err := db.instance.Select(&loottableentries, query, loottableid); err != nil {
		return nil, err
	}
	return loottableentries, nil
}

func (db *Database) getLootdropEntries(lootdropid int) ([]loot.LootDropEntries, error) {
	if db == nil {
		return nil, fmt.Errorf("No database")
	}
	if db.instance == nil {
		return nil, fmt.Errorf("No database instance")
	}
	lootdropentries := []loot.LootDropEntries{}
	query := "SELECT * FROM lootdrop_entries WHERE lootdrop_id = ?"
	if err := db.instance.Select(&lootdropentries, query, lootdropid); err != nil {
		return nil, err
	}
	return lootdropentries, nil
}

func (db *Database) getItems(itemid int) ([]item.Item, error) {
	if db == nil {
		return nil, fmt.Errorf("No database")
	}
	if db.instance == nil {
		return nil, fmt.Errorf("No database instance")
	}
	items := []item.Item{}
	query := "SELECT * FROM items WHERE id = ?"
	if err := db.instance.Select(&items, query, itemid); err != nil {
		return nil, err
	}
	return items, nil
}
