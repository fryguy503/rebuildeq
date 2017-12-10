package mariadb

import (
	"fmt"

	"github.com/xackery/rebuildeq/go/swagger/client"
)

func (s *Storage) GetCharacter(characterId int) (character *client.Character, err error) {
	if s.db == nil {
		if err = s.Initialize(); err != nil {
			return
		}
	}
	if characterId == 0 {
		err = fmt.Errorf("Invalid character id: %d", characterId)
		return
	}
	character = &client.Character{}
	err = s.db.Get(character, `SELECT id, name, zone_id zoneid, class classid
		FROM character_data 
		WHERE id = ?`, characterId)
	if err != nil {
		return
	}

	return
}

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
	rows, err := s.db.Queryx(`SELECT id, name, zone_id zoneid, class classid
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
