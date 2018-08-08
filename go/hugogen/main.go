package main

import (
	"fmt"
	"io/ioutil"

	_ "github.com/go-sql-driver/mysql"
	"github.com/gosimple/slug"
	"github.com/jmoiron/sqlx"
	"github.com/xackery/eqemuconfig"
	"github.com/xackery/goeq/item"
)

func main() {

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
	outPath := "../../web/content/"
	total := 150
	err = genItems(db, outPath+"item/", total)
	err = genNPCs(db, outPath+"npc/", total)
	err = genSpells(db, outPath+"spell/", total)

}

func connectDB(config *eqemuconfig.Config) (db *sqlx.DB, err error) {
	//Connect to DB
	db, err = sqlx.Open("mysql", fmt.Sprintf("%s:%s@tcp(%s:%s)/%s?charset=utf8&parseTime=true", config.Database.Username, config.Database.Password, config.Database.Host, config.Database.Port, config.Database.Db))
	if err != nil {
		return
	}
	return
}

func genItems(db *sqlx.DB, outPath string, total int) (err error) {
	rows, err := db.Queryx(fmt.Sprintf("SELECT * FROM items LIMIT %d", total))
	if err != nil {
		fmt.Println("Error deleting merchanlist", err.Error())
		return
	}

	for rows.Next() {
		it := &item.Item{}
		err = rows.StructScan(&it)
		if err != nil {
			fmt.Println("Error scanning", err.Error())
			return
		}

		outStr := "---\n"
		outStr += fmt.Sprintf("note: \"This file was auto generated. DO NOT EDIT\"\n")
		outStr += fmt.Sprintf("description: \"%s\"\n", it.Lore)
		outStr += fmt.Sprintf("id: \"%d\"\n", it.Id)
		outStr += fmt.Sprintf("icon: \"%d\"\n", it.Icon)
		outStr += fmt.Sprintf("title: \"%s\"\n", it.Name)
		outStr += fmt.Sprintf("classes: %d\n", it.Classes)
		outStr += "---\n"
		err = ioutil.WriteFile(fmt.Sprintf("%s/%s-%d.md", outPath, slug.MakeLang(it.Name, "en"), it.Id), []byte(outStr), 0644)
		if err != nil {
			fmt.Println("Error writing file:", err.Error())
			continue
		}
	}
	return
}
