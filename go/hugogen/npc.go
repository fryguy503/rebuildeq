package main

import (
	"fmt"
	"io/ioutil"
	"os"

	_ "github.com/go-sql-driver/mysql"
	"github.com/gosimple/slug"
	"github.com/jmoiron/sqlx"
	"github.com/pkg/errors"
	"github.com/xackery/goeq/loot"
	"github.com/xackery/goeq/npc"
	"github.com/xackery/goeq/zone"
)

func genNPCs(db *sqlx.DB, outPath string, total int) (err error) {
	err = os.MkdirAll(outPath, 0644)
	if err != nil {
		fmt.Println("Error making directory", err.Error())
		return
	}

	var rows2 *sqlx.Rows

	zones := make(map[int64]*zone.Zone)
	rows, err := db.Queryx(fmt.Sprintf("SELECT * FROM zone"))
	if err != nil {
		err = errors.Wrap(err, "failed to select zones")
		return
	}
	for rows.Next() {
		zone := &zone.Zone{}
		err = rows.StructScan(&zone)
		if err != nil {
			err = errors.Wrap(err, "failed to load zone")
			return
		}
		zones[zone.Id.Int64] = zone
	}

	count := 0
	rows, err = db.Queryx(fmt.Sprintf("SELECT * FROM npc_types LIMIT %d", total))
	if err != nil {
		fmt.Println("Error deleting merchanlist", err.Error())
		return
	}

	var zone *zone.Zone
	var ok bool
	for rows.Next() {
		zone = nil
		n := &npc.NpcTypes{}
		err = rows.StructScan(&n)
		if err != nil {
			fmt.Println("Error scanning", err.Error())
			return
		}

		count++

		outStr := "---\n"
		outStr += fmt.Sprintf("note: \"This file was auto generated. DO NOT EDIT\"\n")
		outStr += fmt.Sprintf("description: \"%d\"\n", n.Race)
		outStr += fmt.Sprintf("id: \"%d\"\n", n.Id.Int64)
		outStr += fmt.Sprintf("icon: \"%d\"\n", 1)
		//outStr += fmt.Sprintf("tags: [%d]\n", n.Id.Int64)
		outStr += fmt.Sprintf("title: \"%s\"\n", n.Name)
		var val int
		err = db.Get(&val, "SELECT spawngroupID FROM spawnentry WHERE npcid = ?", n.Id.Int64)
		if err != nil {
			//err = errors.Wrap(err, "failed to get spawnentry")
			//return
		}
		if val < 1 {
			outStr += "isspawn: false\n"
		} else {
			outStr += "isspawn: true\n"
			zoneName := ""
			err = db.Get(&zoneName, "SELECT zone FROM spawn2 WHERE spawngroupID = ?", val)
			if err != nil {
				err = errors.Wrap(err, "failed to get spawn2")
				return
			}
			for _, z := range zones {
				if z.Short_name.String == zoneName {
					zone = z
				}
			}
		}
		outStr += fmt.Sprintf("gender: %d\n", n.Gender)
		outStr += fmt.Sprintf("gendername: %s\n", getGender(n.Gender))
		outStr += fmt.Sprintf("bodytype: %d\n", n.Bodytype)
		outStr += fmt.Sprintf("bodytypename: %s\n", getBodytype(n.Bodytype))
		outStr += fmt.Sprintf("race: %d\n", n.Race)
		outStr += fmt.Sprintf("racename: %s\n", getRace(n.Race))
		outStr += fmt.Sprintf("class: %d\n", n.Class)
		outStr += fmt.Sprintf("classname: %s\n", getClass(n.Class))
		outStr += fmt.Sprintf("level: %d\n", n.Level)
		outStr += fmt.Sprintf("mindamage: %d\n", n.Mindmg)
		outStr += fmt.Sprintf("maxdamage: %d\n", n.Maxdmg)
		outStr += fmt.Sprintf("hp: %d\n", n.Hp)

		if zone == nil {
			zone, ok = zones[n.Id.Int64/1000]
			if !ok {
				//err = errors.Wrap(err, "failed to load zone entry")
				//return
			}
		}
		if zone == nil {
			outStr += fmt.Sprintf("zone:\n")
			outStr += fmt.Sprintf("  id: %d\n", 0)
			outStr += fmt.Sprintf("  shortname: %s\n", "none")
			outStr += fmt.Sprintf("  name: %s\n", "None")
		} else {
			outStr += fmt.Sprintf("zone:\n")
			outStr += fmt.Sprintf("  id: %d\n", zone.Id.Int64)
			outStr += fmt.Sprintf("  shortname: %s\n", zone.Short_name.String)
			outStr += fmt.Sprintf("  name: %s\n", zone.Long_name.String)
		}

		lootTotal := 0
		if n.Loottable_id > 0 {
			lt := &loot.LootTable{}
			err = db.Get(lt, "SELECT * FROM loottable WHERE id = ?", n.Loottable_id)
			if lt == nil {
				err = errors.Wrapf(err, "invalid loot table: %d", n.Loottable_id)
				return
			}
			outStr += "loot:\n"
			outStr += fmt.Sprintf("  mincash: %d\n", lt.Mincash)
			outStr += fmt.Sprintf("  maxcash: %d\n", lt.Maxcash)

			outStr += "  entries:\n"
			counter := 0
			rows, err = db.Queryx("SELECT * FROM loottable_entries WHERE loottable_id = ?", n.Loottable_id)
			if err != nil {
				err = errors.Wrap(err, "failed to get lte")
				return
			}
			for rows.Next() {
				lte := &loot.LootTableEntries{}
				err = rows.StructScan(lte)
				if err != nil {
					err = errors.Wrap(err, "failed to scan lte")
					return
				}
				outStr += fmt.Sprintf("    entry%d:\n", counter)
				outStr += fmt.Sprintf("      multiplier: %d\n", lte.Multiplier)
				outStr += fmt.Sprintf("      droplimit: %d\n", lte.Droplimit)
				outStr += fmt.Sprintf("      mindrop: %d\n", lte.Mindrop)
				outStr += fmt.Sprintf("      probability: %f\n", lte.Probability)
				outStr += fmt.Sprintf("      drops:\n")
				dropCounter := 0
				rows2, err = db.Queryx("SELECT * FROM lootdrop_entries WHERE lootdrop_id = ?", lte.Lootdrop_id)
				if err != nil {
					err = errors.Wrap(err, "failed to find lootdrop entry")
					return
				}
				for rows2.Next() {
					lde := &loot.LootDropEntries{}
					err = rows.StructScan(lde)
					if err != nil {
						err = errors.Wrap(err, "failed to scan lde")
						return
					}
					outStr += fmt.Sprintf("        entry%d:\n", dropCounter)
					outStr += fmt.Sprintf("          chance: %f\n", lde.Chance)
					outStr += fmt.Sprintf("          multiplier: %d\n", lde.Multiplier)
					outStr += fmt.Sprintf("          item:\n")
					outStr += fmt.Sprintf("            id: %d\n", lde.Item_id)
					outStr += fmt.Sprintf("            charges: %d\n", lde.Item_charges)
					dropCounter++
					lootTotal++
				}
				counter++
			}
		}
		outStr += fmt.Sprintf("lootcount: %d\n", lootTotal)
		outStr += "---\n"
		err = ioutil.WriteFile(fmt.Sprintf("%s/%s-%d.md", outPath, slug.MakeLang(n.Name, "en"), n.Id.Int64), []byte(outStr), 0644)
		if err != nil {
			fmt.Println("Error writing file:", err.Error())
			continue
		}
	}

	fmt.Println(count, "total npcs")
	return
}

func getGender(id int) string {
	switch id {
	case 0:
		return "Male"
	case 1:
		return "Female"
	default:
		return "Neutral"
	}
}

func getBodytype(id int) string {
	return "Medium"
}

func getRace(id int) string {
	return "Not supported"
}

func getClass(id int) string {
	return "Not supported"
}
