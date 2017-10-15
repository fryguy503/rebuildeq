package main

//Analyzes each item to discover if it truly drops or not.

import (
	"fmt"
	"log"
	"os"

	_ "github.com/go-sql-driver/mysql"
	"github.com/jmoiron/sqlx"
	"github.com/xackery/eqemuconfig"
	"github.com/xackery/goeq/item"
	"github.com/xackery/goeq/loot"
)

var (
	config *eqemuconfig.Config
	f      *os.File
)

type Database struct {
	instance *sqlx.DB
}

func main() {
	var err error
	if f, err = os.Create("list.txt"); err != nil {
		log.Fatal(err.Error())
	}

	if err = loadConfig(); err != nil {
		log.Fatal(err.Error())
	}

	db := Database{}
	if err = loadDatabase(&db); err != nil {
		log.Fatal(err.Error())
	}
	offset := 0
	var items []item.Item
	itemCount := 0
	totalCount := 0
	log.Println("Analyzing items...")
	for offset == 0 || len(items) > 0 {
		if items, err = db.getItemsByOffset(offset); err != nil {
			log.Fatal("Error getting items on offset ", offset, ": ", err.Error())
		}

		offset += 1000

		if len(items) < 1 {
			log.Println("Complete")

			return
		}
		for _, item := range items {
			totalCount++
			/*
				isDropped := false
				var entry *loot.LootDropEntries
				if entry, err = db.getLootdropEntryByItemId(item.Id); err != nil {
					log.Fatal(err.Error())
				}
				if entry != nil {
					isDropped = true
				}*/

			score := db.getShinScore(&item)
			f.WriteString(fmt.Sprintf("\"%s\", %d, %d, %d, %d\n", item.Name, item.Id, score, item.Slots, item.Classes))
			itemCount++
		}
	}
	f.Close()
	log.Println("Completed with", itemCount, "/", totalCount, "entries")
}

func loadConfig() error {
	if config != nil {
		return nil
	}
	var err error
	if config, err = eqemuconfig.GetConfig(); err != nil {
		return err
	}
	return nil
}

func loadDatabase(db *Database) error {
	if db == nil {
		return fmt.Errorf("No database")
	}
	var err error
	if db.instance, err = sqlx.Open("mysql", fmt.Sprintf("%s:%s@tcp(%s:%s)/%s?charset=utf8&parseTime=true", config.Database.Username, config.Database.Password, config.Database.Host, config.Database.Port, config.Database.Db)); err != nil {
		return fmt.Errorf("error connecting to db: %s", err.Error())
	}
	return nil
}

func (db *Database) getItemById(id int) (*item.Item, error) {
	if db == nil {
		return nil, fmt.Errorf("No database")
	}
	if db.instance == nil {
		return nil, fmt.Errorf("No database instance")
	}

	items := []item.Item{}
	query := "SELECT * FROM items WHERE id = ? LIMIT 1"
	if err := db.instance.Select(&items, query, id); err != nil {
		return nil, err
	}
	if len(items) > 0 {
		return &items[0], nil
	}
	return nil, nil
}

func (db *Database) getShinScore(item *item.Item) (score int) {
	score = 1

	score += item.Ac

	highestAttribute := 0
	if item.Hp > highestAttribute {
		highestAttribute = item.Hp
	}
	score += item.Hp
	score += item.Mana
	log.Println(item.Name, item.Hp, item.Mana, "score:", score)
	return score
}

func (db *Database) getItemsByOffset(offset int) ([]item.Item, error) {
	if db == nil {
		return nil, fmt.Errorf("No database")
	}
	if db.instance == nil {
		return nil, fmt.Errorf("No database instance")
	}

	items := []item.Item{}
	query := "SELECT * FROM items LIMIT 1000 OFFSET ?"
	if err := db.instance.Select(&items, query, offset); err != nil {
		return nil, err
	}
	return items, nil
}

func (db *Database) getLootdropEntryByItemId(itemid int) (*loot.LootDropEntries, error) {
	if db == nil {
		return nil, fmt.Errorf("No database")
	}
	if db.instance == nil {
		return nil, fmt.Errorf("No database instance")
	}
	lootdropentries := []loot.LootDropEntries{}
	query := "SELECT * FROM lootdrop_entries WHERE item_id = ? LIMIT 1"
	if err := db.instance.Select(&lootdropentries, query, itemid); err != nil {
		return nil, err
	}
	if len(lootdropentries) == 0 {
		return nil, nil
	}
	return &lootdropentries[0], nil
}
