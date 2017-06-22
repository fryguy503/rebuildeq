package sqlx

import (
	"fmt"

	_ "github.com/go-sql-driver/mysql"
	"github.com/jmoiron/sqlx"
	"github.com/xackery/rebuildeq/deploy/web/storage"
)

var (
	dbInstance *Sqlx
)

type Sqlx struct {
	instance *sqlx.DB
}

func New() (*Sqlx, error) {
	if dbInstance != nil {
		return dbInstance, nil
	}

	var err error

	config, err := storage.GetConfig()
	if err != nil {
		return nil, err
	}

	db := &Sqlx{}
	if db.instance, err = sqlx.Open("mysql", fmt.Sprintf("%s:%s@tcp(%s:%s)/%s?charset=utf8&parseTime=true", config.Database.Username, config.Database.Password, config.Database.Host, config.Database.Port, config.Database.Db)); err != nil {
		return nil, fmt.Errorf("error connecting to db: %s", err.Error())
	}
	dbInstance = db
	return db, nil
}
