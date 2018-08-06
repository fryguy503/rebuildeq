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
	outPath := "../../web/hugo/content/item/"
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

	rows, err := db.Queryx(fmt.Sprintf("SELECT * FROM items LIMIT 20"))
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

		outStr := "+++\n"
		outStr += fmt.Sprintf("note = \"This file was auto generated. DO NOT EDIT\"\n")
		outStr += fmt.Sprintf("description = \"%s\"\n", it.Lore)
		outStr += fmt.Sprintf("id = \"%d\"\n", it.Id)
		outStr += fmt.Sprintf("icon = \"%d\"\n", it.Icon)
		outStr += fmt.Sprintf("tags = [%d]\n", it.Slots)
		outStr += fmt.Sprintf("title = \"%s\"\n", it.Name)
		outStr += fmt.Sprintf("classes = %d\n", it.Classes)
		outStr += "+++\n"
		err = ioutil.WriteFile(fmt.Sprintf("%s/%s-%d.md", outPath, slug.MakeLang(it.Name, "en"), it.Id), []byte(outStr), 0644)
		if err != nil {
			fmt.Println("Error writing file:", err.Error())
			continue
		}
	}
}

func connectDB(config *eqemuconfig.Config) (db *sqlx.DB, err error) {
	//Connect to DB
	db, err = sqlx.Open("mysql", fmt.Sprintf("%s:%s@tcp(%s:%s)/%s?charset=utf8&parseTime=true", config.Database.Username, config.Database.Password, config.Database.Host, config.Database.Port, config.Database.Db))
	if err != nil {
		return
	}
	return
}
