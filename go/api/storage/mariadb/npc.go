package mariadb

import (
	"fmt"

	"github.com/xackery/rebuildeq/go/swagger/client"
)

func (s *Storage) GetNPC(npcId int32) (npc *client.Npc, err error) {
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
		WHERE se.npcid = ? AND z.min_status = 0 AND s.version = 0 
			AND s.enabled = 1
		GROUP BY z.short_name
		ORDER BY se.chance DESC`, npcId)
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
		Itemname    string
		Charges     int32
		Chance      float32
	}

	//Get drops
	rows, err = s.db.Queryx(`SELECT lt.probability, items.name itemname, lt.loottable_id loottableid, lt.lootdrop_id lootdropid, ld.item_charges charges, ld.item_id itemid, ld.chance
		FROM loottable_entries lt
		INNER JOIN lootdrop_entries ld ON ld.lootdrop_id = lt.lootdrop_id
		INNER JOIN items ON items.id = ld.item_id
		WHERE lt.loottable_id = ? AND ld.chance > 0 GROUP BY lt.loottable_id, lt.lootdrop_id ORDER BY ld.chance DESC`, npc.LootTableId)
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
			ItemName:    ld.Itemname,
			LootDropId:  ld.Lootdropid,
			ItemCharges: ld.Charges,
			Chance:      ld.Chance,
		}
		lte.LootDrops = append(lte.LootDrops, lde)
	}
	npc.Drops = &lte

	return
}

func (s *Storage) GetNPCsByItem(itemId int) (npcs []*client.Npc, err error) {
	//First, get npcs
	if s.db == nil {
		if err = s.Initialize(); err != nil {
			return
		}
	}
	if itemId == 0 {
		err = fmt.Errorf("Invalid item id: %d", itemId)
		return
	}

	rows, err := s.db.Queryx(`SELECT nt.id
		FROM lootdrop_entries ld
		INNER JOIN loottable_entries lt ON lt.lootdrop_id = ld.lootdrop_id
		INNER JOIN npc_types nt ON nt.loottable_id = lt.loottable_id
		WHERE ld.item_id = ? AND ld.chance > 0 ORDER BY chance DESC LIMIT 10`, itemId)
	if err != nil {
		return
	}

	for rows.Next() {
		n := &client.Npc{}
		if err = rows.StructScan(n); err != nil {
			return
		}

		if n, err = s.GetNPC(n.Id); err != nil {
			return
		}
		npcs = append(npcs, n)
	}
	return
}
