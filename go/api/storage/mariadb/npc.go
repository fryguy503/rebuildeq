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
	err = s.db.Get(npc, `SELECT nt.id, nt.name
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
		//characters = append(characters, &c)
	}

	//Get drops

	return
}
