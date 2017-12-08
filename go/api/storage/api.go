package storage

import (
	"github.com/xackery/rebuildeq/go/swagger/client"
)

type Api interface {
	GetCharacters(accountId int) (characters []*client.Character, err error)
	GetZone(zoneId int) (zone *client.Zone, err error)
	GetNpc(npcId int) (npc *client.Npc, err error)
}
