package main

import (
	"fmt"
	"log"

	_ "github.com/go-sql-driver/mysql"
	"github.com/jmoiron/sqlx"
	"github.com/xackery/eqemuconfig"
	"github.com/xackery/goeq/inventory"
	"github.com/xackery/goeq/item"
)

var (
	config *eqemuconfig.Config
	char   *Character
)

type Database struct {
	instance *sqlx.DB
}

type Character struct {
	Name string
}

func (c *Character) IsManaUser() bool {
	return false
}

func main() {
	var err error
	if err = loadConfig(); err != nil {
		log.Fatal(err.Error())
	}

	db := Database{}
	if err = loadDatabase(&db); err != nil {
		log.Fatal(err.Error())
	}
	id := 662233

	char := &Character{}

	inventories := []inventory.Inventory{}

	if inventories, err = db.getInventoryByCharacterId(id); err != nil {
		log.Fatal(err.Error())
	}

	score := 0
	var itemData *item.Item
	for _, inv := range inventories {
		if inv.Slotid > 20 {
			continue
		}
		if itemData, err = db.getItemById(inv.Itemid); err != nil {
			log.Fatal("Error with item: ", err.Error())
		}
		if itemData == nil {
			continue
		}

		score += db.getShinScore(itemData)
		if inv.Augslot1 > 0 {
			if itemData, err = db.getItemById(inv.Augslot1); err != nil {
				log.Fatal("Error with item: ", err.Error())
			}
			if itemData == nil {
				continue
			}
			score += db.getShinScore(itemData)
		}
		if inv.Augslot2 > 0 {
			if itemData, err = db.getItemById(inv.Augslot2); err != nil {
				log.Fatal("Error with item: ", err.Error())
			}
			if itemData == nil {
				continue
			}
			score += db.getShinScore(itemData)
		}
		if inv.Augslot3 > 0 {
			if itemData, err = db.getItemById(inv.Augslot3); err != nil {
				log.Fatal("Error with item: ", err.Error())
			}
			if itemData == nil {
				continue
			}
			score += db.getShinScore(itemData)
		}
		if inv.Augslot4 > 0 {
			if itemData, err = db.getItemById(inv.Augslot4); err != nil {
				log.Fatal("Error with item: ", err.Error())
			}
			if itemData == nil {
				continue
			}
			score += db.getShinScore(itemData)
		}
		if inv.Augslot5 > 0 {
			if itemData, err = db.getItemById(inv.Augslot5); err != nil {
				log.Fatal("Error with item: ", err.Error())
			}
			if itemData == nil {
				continue
			}
			score += db.getShinScore(itemData)
		}
		if inv.Augslot6 > 0 {
			if itemData, err = db.getItemById(inv.Augslot6); err != nil {
				log.Fatal("Error with item: ", err.Error())
			}
			if itemData == nil {
				continue
			}
			score += db.getShinScore(itemData)
		}
	}
	log.Println("Name:", char.Name, "Inv: ", len(inventories), "Score: ", score)
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
	if char.IsManaUser() {
		if item.Mana > highestAttribute {
			highestAttribute = item.Mana
		}
		score += item.Mana
	}
	log.Println(item.Name, item.Hp, item.Mana, "score:", score)
	return score
}

func (db *Database) getInventoryByCharacterId(id int) ([]inventory.Inventory, error) {
	if db == nil {
		return nil, fmt.Errorf("No database")
	}
	if db.instance == nil {
		return nil, fmt.Errorf("No database instance")
	}

	inventories := []inventory.Inventory{}
	query := "SELECT * FROM inventory WHERE charid = ?"
	if err := db.instance.Select(&inventories, query, id); err != nil {
		return nil, err
	}
	return inventories, nil
}
