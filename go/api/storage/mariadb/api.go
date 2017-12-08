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

func (a *Api) GetCharacters() (characters []*client.Character, err error) {
	if a.db == nil {
		if err = a.Initialize(); err != nil {
			return
		}
	}
	id := 74887
	rows, err := a.db.Queryx(`SELECT id, name, zone_id zoneid 
		FROM character_data 
		WHERE account_id = ?`, id)
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
