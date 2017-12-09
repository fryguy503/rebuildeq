package mariadb

import (
	"fmt"

	"github.com/xackery/rebuildeq/go/swagger/client"
)

func (s *Storage) GetItem(itemId int) (item *client.Item, err error) {
	if s.db == nil {
		if err = s.Initialize(); err != nil {
			return
		}
	}
	if itemId == 0 {
		err = fmt.Errorf("Invalid item id: %d", itemId)
		return
	}
	item = &client.Item{}
	err = s.db.Get(item, `SELECT id, name
		FROM items 
		WHERE id = ?`, itemId)
	if err != nil {
		return
	}
	return
}
