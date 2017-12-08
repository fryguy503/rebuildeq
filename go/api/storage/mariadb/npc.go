package mariadb

import (
	"fmt"

	"github.com/xackery/rebuildeq/go/swagger/client"
)

func (a *Api) GetNpc(npcId int) (npc *client.Npc, err error) {
	if a.db == nil {
		if err = a.Initialize(); err != nil {
			return
		}
	}
	if npcId == 0 {
		err = fmt.Errorf("Invalid npc id: %d", npcId)
		return
	}
	npc = &client.Npc{}
	err = a.db.Get(npc, `SELECT id, name
		FROM npc_types 
		WHERE id = ?`, npcId)
	if err != nil {
		return
	}

	return
}
