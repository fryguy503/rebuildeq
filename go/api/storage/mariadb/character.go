package mariadb

import (
	"fmt"

	"github.com/xackery/rebuildeq/go/swagger/client"
)

func (s *Storage) GetCharacters(accountId int) (characters []*client.Character, err error) {
	if s.db == nil {
		if err = s.Initialize(); err != nil {
			return
		}
	}
	if accountId == 0 {
		err = fmt.Errorf("Invalid account id: %d", accountId)
		return
	}
	rows, err := s.db.Queryx(`SELECT id, name, zone_id zoneid 
		FROM character_data 
		WHERE account_id = ?`, accountId)
	if err != nil {
		return
	}

	for rows.Next() {
		c := client.Character{}
		if err = rows.StructScan(&c); err != nil {
			return
		}
		characters = append(characters, &c)
	}
	return
}
