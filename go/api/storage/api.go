package storage

import (
	"github.com/xackery/rebuildeq/go/swagger/client"
)

type Storage interface {
	GetCharacters(accountId int) (characters []*client.Character, err error)
	GetZone(zoneId int) (zone *client.Zone, err error)
	GetItem(itemId int) (zone *client.Item, err error)
	GetNPC(npcId int) (npc *client.Npc, err error)
}
