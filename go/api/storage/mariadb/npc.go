package mariadb

import (
	"fmt"

	"github.com/xackery/rebuildeq/go/swagger/client"
)

func (s *Storage) GetNPC(npcId int) (npc *client.Npc, err error) {
	if s.db == nil {
		if err = s.Initialize(); err != nil {
			return
		}
	}
	if npcId == 0 {
		err = fmt.Errorf("Invalid npc id: %d", npcId)
		return
	}
	npc = &client.Npc{}
	err = s.db.Get(npc, `SELECT nt.id, nt.name, nt.loottable_id loottableid
		FROM npc_types nt
		WHERE nt.id = ? LIMIT 1`, npcId)
	if err != nil {
		return
	}

	//get every spawn entry
	rows, err := s.db.Queryx(`SELECT se.chance, s.variance, s.x, s.y, s.z, z.short_name zoneshortname, z.long_name zonename, z.id zoneid
		FROM spawnentry se
		INNER JOIN spawn2 s ON s.spawngroupid = se.spawngroupid
		INNER JOIN zone z ON z.short_name = s.zone
		WHERE se.npcid = ? AND s.version = 0 AND s.enabled = 1`, npcId)
	if err != nil {
		return
	}
	for rows.Next() {
		se := client.SpawnEntry{}
		if err = rows.StructScan(&se); err != nil {
			return
		}

		npc.SpawnsIn = append(npc.SpawnsIn, se)
	}

	type LootDrops struct {
		Probability int32
		Lootdropid  int32
		Loottableid int32
		Itemid      int32
		Charges     int32
		Chance      float32
	}

	//Get drops
	rows, err = s.db.Queryx(`SELECT lt.probability, lt.loottable_id loottableid, lt.lootdrop_id lootdropid, ld.item_charges charges, ld.item_id itemid, ld.chance
		FROM loottable_entries lt
		INNER JOIN lootdrop_entries ld ON ld.lootdrop_id = lt.lootdrop_id	
		WHERE lt.loottable_id = ? GROUP BY lt.loottable_id, lt.lootdrop_id`, npc.LootTableId)
	if err != nil {
		return
	}

	lte := client.LootTableEntry{
		LootTableId: npc.LootTableId,
	}

	for rows.Next() {
		ld := LootDrops{}
		if err = rows.StructScan(&ld); err != nil {
			return
		}

		lte.Probability = ld.Probability
		lde := client.LootDropEntry{
			ItemId:      ld.Itemid,
			LootDropId:  ld.Lootdropid,
			ItemCharges: ld.Charges,
			Chance:      ld.Chance,
		}
		lte.LootDrops = append(lte.LootDrops, lde)
	}
	npc.LootTableEntry = &lte

	return
}
