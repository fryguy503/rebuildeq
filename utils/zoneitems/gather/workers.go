package main

import (
	"fmt"
	"log"
	"time"
)

func zoneWorker() {
	for {
		data := <-zoneChan
		zonename := data.Zone.Short_name.String
		spawns, err := db.getSpawns(zonename)
		if err != nil {
			log.Fatal("zone:", err.Error())
		}
		for _, spawn2 := range spawns {
			data.Spawn2 = spawn2
			spawnChan <- data
		}
	}
}

func spawnWorker() {
	for {
		data := <-spawnChan
		spawngroupid := data.Spawn2.Spawngroupid
		spawnentries, err := db.getSpawnEntries(spawngroupid)
		if err != nil {
			log.Fatal("spawnentry:", err.Error())
		}
		for _, spawnentry := range spawnentries {
			data.SpawnEntry = spawnentry
			spawnEntryChan <- data
		}
	}
}

func spawnEntryWorker() {
	for {
		data := <-spawnEntryChan
		npcid := data.SpawnEntry.Npcid
		npcs, err := db.getNpcs(npcid)
		if err != nil {
			log.Fatal("npcs:", err.Error())
		}
		for _, npc := range npcs {
			data.NpcTypes = npc
			npctypeChan <- data
		}

	}
}
func npctypeWorker() {
	for {
		data := <-npctypeChan
		loottableid := data.NpcTypes.Loottable_id
		loottableentries, err := db.getLoottableEntries(loottableid)
		if err != nil {
			log.Fatal("loottable:", err.Error())
		}
		for _, loottableentry := range loottableentries {
			data.LootTableEntries = loottableentry
			loottableEntryChan <- data
		}

	}
}

func loottableEntryWorker() {
	for {
		data := <-loottableEntryChan
		lootdropid := data.LootTableEntries.Lootdrop_id
		lootdropentries, err := db.getLootdropEntries(lootdropid)
		if err != nil {
			log.Fatal("lootdrop:", err.Error())
		}
		for _, lootdropentry := range lootdropentries {
			data.LootDropEntries = lootdropentry
			lootdropEntryChan <- data
		}

	}
}

func lootdropEntryWorker() {
	for {
		data := <-lootdropEntryChan

		itemid := data.LootDropEntries.Item_id
		items, err := db.getItems(itemid)

		if err != nil {
			log.Fatal("items", err.Error())
		}
		for _, itementry := range items {
			data.Item = itementry
			insertChan <- data
			/*
				var id int
				getQuery := fmt.Sprintf("SELECT id FROM zone_drops WHERE item_id = %d AND npc_id = %d AND zone_id = %d", itementry.Id, data.NpcTypes.Id.Int64, data.Zone.Id.Int64)
				err = db.instance.Get(&id, getQuery)
				if id > 0 {
					//fmt.Println("Duplicate of", itementry.Id)
					continue
				}
			*/

		}
	}
}

func insertWorker() {
	insertCount := 0
	insertQuery := "INSERT INTO zone_drops (item_id, npc_id, zone_id) VALUES"
	insertVals := []interface{}{}
	doDump := false

	for {
		select {
		case data := <-insertChan:
			insertCount++
			if insertCount%1000 == 0 {
				fmt.Printf("%d, ", insertCount)
			}

			insertQuery += "(?, ?, ?),"
			insertVals = append(insertVals, data.Item.Id, data.NpcTypes.Id, data.Zone.Zoneidnumber)
		case <-time.After(1 * time.Second):
			doDump = true
		}
		if insertCount%10000 == 0 || doDump {
			fmt.Printf(", inserting 10k non-unique records...(%d zones left)\n", len(zoneChan))
			insertQuery = insertQuery[0 : len(insertQuery)-1]
			stmt, _ := db.instance.Prepare(insertQuery)
			if _, err := stmt.Exec(insertVals...); err != nil {
				log.Fatal(err.Error())
			}
			//reset query
			insertQuery = "INSERT INTO zone_drops (item_id, npc_id, zone_id) VALUES"
			insertVals = []interface{}{}
			doDump = false
		}
	}
}
