package mariadb

import (
	"fmt"
	"log"

	_ "github.com/go-sql-driver/mysql"
	"github.com/jmoiron/sqlx"
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
