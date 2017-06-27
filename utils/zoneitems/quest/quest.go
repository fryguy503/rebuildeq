package main

import (
	"bufio"
	"fmt"
	"log"
	"os"
	"path/filepath"
	"strings"

	_ "github.com/go-sql-driver/mysql"
	"github.com/jmoiron/sqlx"
	"github.com/xackery/eqemuconfig"
	"github.com/xackery/goeq/npc"
	"github.com/xackery/goeq/zone"
)

var (
	config     *eqemuconfig.Config
	prefixPath string
	db         Database
)

type Database struct {
	instance *sqlx.DB
}

func main() {
	var err error
	if err = loadConfig(); err != nil {
		log.Fatal(err.Error())
	}

	db = Database{}
	if err = loadDatabase(&db); err != nil {
		log.Fatal(err.Error())
	}
	//os.Chdir("../../deploy/server/quests")
	prefixPath = "../../../deploy/server/quests/"
	err = filepath.Walk(prefixPath, visit)
	if err != nil {
		log.Fatal("Error filepath", err.Error())
	}
}

func visit(path string, f os.FileInfo, err error) error {

	if f.IsDir() {
		//fmt.Println("Dir", path)
		return nil
	}

	dir, filename := filepath.Split(path)
	dir = strings.Replace(dir, prefixPath, "", -1)
	if len(dir) < 2 {
		return nil
	}
	dir = dir[0 : len(dir)-1]
	if !strings.Contains(filename, ".pl") && !strings.Contains(filename, ".lua") {
		return nil
	}

	if len(filename) < 1 {
		return nil
	}

	npcname := ""
	if strings.Contains(filename, ".pl") {
		npcname = filename[0 : len(filename)-3]
	}
	if strings.Contains(filename, ".lua") {
		npcname = filename[0 : len(filename)-4]
	}

	zone_id := getZoneByShortname(dir)
	if zone_id < 1 {
		//fmt.Println("Zone skipped", dir)
		return nil
	}

	npc_id := getNpcByNameOrId(npcname)
	if npc_id < 1 {
		//fmt.Println("NPC skipped", filename)
		return nil
	}

	fmt.Println(dir, npcname)

	file, err := os.Open(path)
	if err != nil {
		log.Fatal(err)
	}
	defer file.Close()

	//fmt.Println(dir, filename)
	scanner := bufio.NewScanner(file)
	for scanner.Scan() {
		parse := strings.TrimSpace(strings.Replace(strings.ToLower(scanner.Text()), " ", "", -1))
		if !strings.Contains(parse, "summonitem(") {
			continue
		}

		item_id := parse[strings.Index(parse, "summonitem(")+11:]
		if len(item_id) < 2 {
			continue
		}
		item_id = item_id[0:strings.Index(item_id, ")")]
		if len(item_id) < 2 {
			continue
		}
		if item_id == "0" {
			continue
		}

		fmt.Println(zone_id, npc_id, item_id, dir, filename)
		insertQuery := "REPLACE INTO zone_drops (item_id, npc_id, zone_id, is_quest) VALUES (?, ?, ?, ?)"
		stmt, _ := db.instance.Prepare(insertQuery)
		if _, err = stmt.Exec(item_id, npc_id, zone_id, 1); err != nil {
			log.Fatal(err.Error())
		}

		//fmt.Println(scanner.Text())
	}

	if err := scanner.Err(); err != nil {
		log.Fatal(err)
	}
	//log.Fatal("Done")
	return nil
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

func getZoneByShortname(shortname string) int {
	zones := []zone.Zone{}
	query := "SELECT * from zone WHERE min_status = 0 AND short_name = ? LIMIT 1"
	if err := db.instance.Select(&zones, query, shortname); err != nil {
		log.Fatal("Error getting ", shortname, ": ", err.Error())
		return 0
	}
	if len(zones) == 0 {
		return 0
	}
	return zones[0].Zoneidnumber
}

func getNpcByNameOrId(npcname string) int64 {
	npcs := []npc.NpcTypes{}
	query := "SELECT * from npc_types WHERE id = ? OR Name = ?"
	if err := db.instance.Select(&npcs, query, npcname, npcname); err != nil {
		log.Fatal("Error getting", npcname, err.Error())
		return 0
	}
	if len(npcs) == 0 {
		return 0
	}
	return npcs[0].Id.Int64
}
