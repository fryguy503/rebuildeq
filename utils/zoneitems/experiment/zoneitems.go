//Simply builds a db up of items.
package main

/*
#iterate zones
#SELECT short_name, zoneidnumber, long_name FROM zone;
#get spawngroupid of zone
#SELECT spawngroupid FROM spawn2 WHERE zone = "crushbone";
#get npcs of spawngroup
#SELECT npcid FROM spawnentry WHERE spawngroupid = 541;
#get loottable_id of npc
#SELECT NAME, loottable_id FROM npc_types WHERE id = 58007;
#get lootdrops
#SELECT lootdrop_id FROM loottable_entries WHERE loottable_id = 1719;
#get itemid of drops
#SELECT item_id FROM lootdrop_entries WHERE lootdrop_id = 3348;
#get item data.
#SELECT * FROM items WHERE id = 5040;
*/
import ( //"database/sql"
	"fmt"
	"log"
	"time"

	_ "github.com/go-sql-driver/mysql"
	"github.com/jmoiron/sqlx"
	"github.com/xackery/eqemuconfig"
	"github.com/xackery/goeq/item"
	"github.com/xackery/goeq/loot"
	"github.com/xackery/goeq/npc"
	"github.com/xackery/goeq/spawn"
	"github.com/xackery/goeq/zone"
)

type DataPack struct {
	zone.Zone
	spawn.Spawn2
	spawn.SpawnEntry
	npc.NpcTypes
	loot.LootTableEntries
	loot.LootDropEntries
	item.Item
}

var (
	config             *eqemuconfig.Config
	zoneChan           chan DataPack
	spawnChan          chan DataPack
	spawnEntryChan     chan DataPack
	npctypeChan        chan DataPack
	loottableEntryChan chan DataPack
	lootdropEntryChan  chan DataPack
	insertChan         chan DataPack
	db                 Database
)

type Database struct {
	instance *sqlx.DB
}

func main() {
	var err error
	zoneChan = make(chan DataPack, 5000)
	for i := 0; i < 5; i++ {
		go zoneWorker()
	}

	spawnChan = make(chan DataPack, 5000)
	for i := 0; i < 5; i++ {
		go spawnWorker()
	}

	spawnEntryChan = make(chan DataPack, 5000)
	for i := 0; i < 5; i++ {
		go spawnEntryWorker()
	}
	npctypeChan = make(chan DataPack, 5000)
	for i := 0; i < 5; i++ {
		go npctypeWorker()
	}
	loottableEntryChan = make(chan DataPack, 5000)
	for i := 0; i < 5; i++ {
		go loottableEntryWorker()
	}
	lootdropEntryChan = make(chan DataPack, 5000)
	for i := 0; i < 5; i++ {
		go lootdropEntryWorker()
	}

	insertChan = make(chan DataPack)
	go insertWorker()

	if err = loadConfig(); err != nil {
		log.Fatal(err.Error())
	}

	if err = loadDatabase(&db); err != nil {
		log.Fatal(err.Error())
	}

	if err = db.createTable(); err != nil {
		log.Fatal(err.Error())
	}
	if err = db.truncateTable(); err != nil {
		log.Fatal(err.Error())
	}

	zones := []zone.Zone{}
	if zones, err = db.getZones(); err != nil {
		log.Fatal(err.Error())
	}

	for _, zone := range zones {
		fmt.Print(zone.Short_name.String)

		if zone.Min_status > 0 {
			fmt.Printf(" Skipping, status > 0, %d\n", zone.Min_status)
			continue
		}
		data := DataPack{
			Zone: zone,
		}
		zoneChan <- data
		fmt.Print("\n")
	}

	time.Sleep(5 * time.Second)
	for {
		if len(zoneChan) == 0 && len(insertChan) == 0 {
			break
		}
		//fmt.Println(len(zoneChan), len(spawnChan), len(spawnEntryChan), len(npctypeChan), len(loottableEntryChan), len(lootdropEntryChan))
		time.Sleep(5 * time.Second)
	}
	time.Sleep(1 * time.Second)
	//trim the last
	log.Println("Done!")
	return
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
