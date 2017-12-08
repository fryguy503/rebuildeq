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
	err = s.db.Get(npc, `SELECT id, name
		FROM npc_types 
		WHERE id = ?`, npcId)
	if err != nil {
		return
	}

	return
}
