package main

import (
	"fmt"
	"time"

	_ "github.com/go-sql-driver/mysql"
	"github.com/jmoiron/sqlx"
	"github.com/rs/zerolog"
	"github.com/rs/zerolog/log"
	"github.com/xackery/eqemuconfig"
)

func main() {

	zerolog.TimeFieldFormat = ""

	zerolog.SetGlobalLevel(zerolog.InfoLevel)
	logInfo := log.Info()
	logError := log.Error()
	t := time.Now()
	zerolog.SetGlobalLevel(zerolog.DebugLevel)

	config, err := eqemuconfig.GetConfig()
	if err != nil {
		fmt.Println("Error getting config:", err.Error())
		return
	}
	db, err := connectDB(config)
	if err != nil {

	}
	if err != nil {
		fmt.Println("Error connecting to DB:", err.Error())
		return
	}
	contentPath := "../../web/content/"
	staticPath := "../../web/static/"
	mapSrcPath := "../../deploy/client/rof/Resources/maps/"

	total := 500000

	maps, err := genMaps(db, mapSrcPath, staticPath+"map/", total)
	if err != nil {
		logError.Err(err).Str("src", mapSrcPath).Str("dest", staticPath+"map/").Msg("genMaps")
	}

	err = genItems(db, contentPath+"item/", total)
	if err != nil {
		logError.Err(err).Str("path", contentPath+"item/").Msg("genItems")
		logInfo.Msg("fail on item")
	}

	err = genNPCs(db, maps, contentPath+"npc/", total)
	if err != nil {
		logError.Err(err).Str("path", contentPath+"npc/").Msg("genNPCs")
	}

	err = genSpells(db, contentPath+"spell/", total)
	if err != nil {
		logError.Err(err).Str("path", contentPath+"spell/").Msg("genSpells")
	}

	logInfo.Dur("run", time.Since(t)).Msg("done")
}

func connectDB(config *eqemuconfig.Config) (db *sqlx.DB, err error) {
	//Connect to DB
	db, err = sqlx.Open("mysql", fmt.Sprintf("%s:%s@tcp(%s:%s)/%s?charset=utf8&parseTime=true", config.Database.Username, config.Database.Password, config.Database.Host, config.Database.Port, config.Database.Db))
	if err != nil {
		return
	}
	return
}
