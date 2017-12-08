package mariadb

import (
	"fmt"
	"log"

	_ "github.com/go-sql-driver/mysql"
	"github.com/jmoiron/sqlx"
	"github.com/xackery/rebuildeq/go/swagger/client"
)

type Api struct {
	db *sqlx.DB
}

func (a *Api) Initialize() (err error) {

	if a.db, err = sqlx.Open("mysql", fmt.Sprintf("root@tcp(127.0.0.1:3306)/eqemu?charset=utf8&parseTime=true")); err != nil {
		return
	}
	log.Println("Loaded database")
	return
}

func (a *Api) GetCharacters(accountId int) (characters []*client.Character, err error) {
	if a.db == nil {
		if err = a.Initialize(); err != nil {
			return
		}
	}
	if accountId == 0 {
		err = fmt.Errorf("Invalid account id: %d", accountId)
		return
	}
	rows, err := a.db.Queryx(`SELECT id, name, zone_id zoneid 
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
		log.Println("Test:", c.Name)
		characters = append(characters, &c)
	}
	return
}

func (a *Api) GetZone(zoneId int) (zone *client.Zone, err error) {
	if a.db == nil {
		if err = a.Initialize(); err != nil {
			return
		}
	}
	if zoneId == 0 {
		err = fmt.Errorf("Invalid zone id: %d", zoneId)
		return
	}
	zone = &client.Zone{}
	err = a.db.Get(zone, `SELECT id, long_name name, short_name shortname 
		FROM zone 
		WHERE id = ?`, zoneId)
	if err != nil {
		return
	}

	return
}
