package main

import (
	"fmt"
	"io/ioutil"
	"regexp"

	_ "github.com/go-sql-driver/mysql"
	"github.com/gosimple/slug"
	"github.com/jmoiron/sqlx"
	"github.com/xackery/goeq/item"
)

func genItems(db *sqlx.DB, outPath string, total int) (err error) {
	query := "SELECT count(id) FROM items LIMIT ?"
	totalRows := 0
	db.Get(&totalRows, query, total)
	if totalRows < total {
		total = totalRows
	}
	if total > totalRows {
		total = totalRows
	}
	rows, err := db.Queryx("SELECT * FROM items LIMIT ?", total)
	if err != nil {
		fmt.Println("Error deleting merchanlist", err.Error())
		return
	}
	counter := 0
	reg := regexp.MustCompile("\"")
	for rows.Next() {
		if counter%1000 == 0 {
			fmt.Printf("items %d / %d\n", counter, total)
		}
		counter++
		it := &item.Item{}
		err = rows.StructScan(&it)
		if err != nil {
			fmt.Println("Error scanning", err.Error())
			return
		}

		outStr := "---\n"
		outStr += fmt.Sprintf("note: \"This file was auto generated. DO NOT EDIT\"\n")
		outStr += fmt.Sprintf("description: \"%s\"\n", reg.ReplaceAllString(it.Lore, "'"))
		outStr += fmt.Sprintf("id: \"%d\"\n", it.Id)
		outStr += fmt.Sprintf("icon: \"%d\"\n", it.Icon)
		outStr += fmt.Sprintf("title: \"%s\"\n", reg.ReplaceAllString(it.Name, "'"))
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
