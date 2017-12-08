package mariadb

import (
	"fmt"

	"github.com/xackery/rebuildeq/go/swagger/client"
)

func (s *Storage) GetInventory(characterId int) (inventory []*client.Item, err error) {
	if s.db == nil {
		if err = s.Initialize(); err != nil {
			return
		}
	}
	if characterId == 0 {
		err = fmt.Errorf("Invalid character id: %d", characterId)
		return
	}
	rows, err := s.db.Queryx(`SELECT itemid id, items.name
		FROM inventory 
		INNER JOIN items on items.id = inventory.itemid
		WHERE charid = ?`, characterId)
	if err != nil {
		return
	}

	for rows.Next() {
		i := client.Item{}
		if err = rows.StructScan(&i); err != nil {
			return
		}
		inventory = append(inventory, &i)
	}
	return
}
