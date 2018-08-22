package main

import (
	"fmt"
	"io/ioutil"
	"os"
	"strings"

	"regexp"

	_ "github.com/go-sql-driver/mysql"
	"github.com/gosimple/slug"
	"github.com/jmoiron/sqlx"
	"github.com/pkg/errors"
	"github.com/rs/zerolog/log"
	"github.com/xackery/goeq/grid"
	"github.com/xackery/goeq/item"
	"github.com/xackery/goeq/loot"
	"github.com/xackery/goeq/npc"
	"github.com/xackery/goeq/spawn"
	"github.com/xackery/goeq/zone"
)

func genNPCs(db *sqlx.DB, maps *Map, outPath string, total int) (err error) {
	logInfo := log.Info()
	err = os.MkdirAll(outPath, 0644)
	if err != nil {
		fmt.Println("Error making directory", err.Error())
		return
	}

	var rows2 *sqlx.Rows
	var rows3 *sqlx.Rows
	var rows4 *sqlx.Rows
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
		zones[int64(zone.Zoneidnumber)] = zone
	}

	//fmt.Println(len(zones), "zones")
	/*type npcEntry struct {
		minLevel int
		maxLevel int
		spawnLoc
	}
	npcs := make(map[string]bool)*/

	totalRows := 0
	db.Get(&totalRows, "SELECT count(id) FROM npc_types LIMIT ?", total)
	if totalRows < total {
		total = totalRows
	}
	if total > totalRows {
		total = totalRows
	}
	count := 0

	fmt.Printf("npc %d / %d\n", count, total)

	lastID := int64(0)
	for {
		rows, err = db.Queryx("SELECT * FROM npc_types WHERE id > ? ORDER BY id ASC LIMIT 10", lastID)
		if err != nil {
			fmt.Println("Error selecting npc_types", err.Error())
			return
		}

		rowCount := 0

		var zone *zone.Zone
		var ok bool
		for rows.Next() {
			rowCount++
			zone = nil
			n := &npc.NpcTypes{}
			err = rows.StructScan(&n)
			if err != nil {
				fmt.Println("Error scanning", err.Error())
				return
			}

			logInfo.Int("count", count)

			lastID = n.Id.Int64

			count++
			logInfo.Int64("npcID", lastID)

			if count%1000 == 0 {
				fmt.Printf("npc %d / %d\n", count, total)
			}
			outStr := "---\n"
			outStr += fmt.Sprintf("note: \"This file was auto generated. DO NOT EDIT\"\n")

			outStr += fmt.Sprintf("description: \"%d\"\n", n.Race)
			outStr += fmt.Sprintf("id: \"%d\"\n", n.Id.Int64)
			outStr += fmt.Sprintf("icon: \"%d\"\n", 1)
			//outStr += fmt.Sprintf("tags: [%d]\n", n.Id.Int64)
			outStr += fmt.Sprintf("title: \"%s\"\n", n.Name)
			var val int

			outStr += fmt.Sprintf("zone:\n")
			if zone == nil {
				zone, ok = zones[n.Id.Int64/1000]
				if !ok {
					//err = errors.Wrap(err, "failed to load zone entry")
					//return
				}
			}
			if zone == nil {
				outStr += addLine(1, "id", "0")
				outStr += addLine(1, "shortname", "none")
				outStr += addLine(1, "name", "none")
				continue
			} else {
				if zone.Min_status > 0 {
					continue
				}
				outStr += addLine(1, "id", fmt.Sprintf("%d", zone.Id.Int64))
				outStr += addLine(1, "shortname", zone.Short_name.String)
				outStr += addLine(1, "name", zone.Long_name.String)
			}

			err = db.Get(&val, "SELECT spawngroupID FROM spawnentry WHERE npcid = ?", n.Id.Int64)
			if err != nil {
				//err = errors.Wrap(err, "failed to get spawnentry")
				//return
			}

			zoneName := ""
			spawnCounter := 0
			rows2, err = db.Queryx("SELECT * FROM spawn2 WHERE spawngroupID = ?", val)
			if err != nil {
				err = errors.Wrap(err, "failed to get spawn2")
				return
			}
			isSpawn := false
			for rows2.Next() {
				s2 := &spawn.Spawn2{}
				err = rows2.StructScan(s2)
				if err != nil {
					err = errors.Wrap(err, "failed to get spawn2 scan")
					return
				}

				if !isSpawn {
					outStr += addLine(1, "spawns", "")
					isSpawn = true
				}

				zoneName = s2.Zone.String
				logInfo.Str("zone", zoneName)
				entry, mapFound := maps.entries[zoneName]
				if !mapFound {
					err = errors.Wrapf(err, "map %s not found in map loader", zoneName)
					return
				}
				
				outStr += addLine(2, fmt.Sprintf("spawn%d", spawnCounter), "")
				outStr += addLine(3, "respawntime", fmt.Sprintf("%d", s2.Respawntime))
				outStr += addLine(3, "variance", fmt.Sprintf("%d", s2.Variance))
				outStr += addLine(3, "x", fmt.Sprintf("%f", s2.X))
				outStr += addLine(3, "y", fmt.Sprintf("%f", s2.Y))
				outStr += addLine(3, "z", fmt.Sprintf("%f", s2.Z))
				outStr += addLine(3, "aspect", fmt.Sprintf("%f", entry.Aspect))
				
				x := -s2.X
				x += entry.XOffset
				x *= entry.Aspect
				//x = 0 - ((s2.X - entry.XOffset) * entry.Aspect)
				//x = s2.X + entry.Width /2

				//uleat
				//x = 0 - ((s2.X - entry.XOffset) * entry.AspectX)
				
				y := s2.Y
				y += entry.YOffset
				y *= entry.Aspect
				y -= 240
				//y = entry.YOffset - (s2.Y * entry.Aspect)
				//y = ((s2.Y + entry.YOffset) * entry.Aspect)
				//y = -s2.Y + entry.Width /2
				//y += entry.Height
				//y = 0 - ((s2.Y - entry.YOffset) * entry.AspectY)

				
				
				outStr += addLine(3, "xOffset", fmt.Sprintf("%f", entry.XOffset))
				outStr += addLine(3, "yOffset", fmt.Sprintf("%f", entry.YOffset))
				outStr += addLine(3, "xMap", fmt.Sprintf("%f", x))
				outStr += addLine(3, "yMap", fmt.Sprintf("%f", y))//-(entry.Height/2)))
				outStr += addLine(3, "id", fmt.Sprintf("%d", s2.Id.Int64))
				outStr += addLine(3, "spawngroupid", fmt.Sprintf("%d", s2.Spawngroupid))

				if s2.Pathgrid > 0 {					
					gridCounter := 0
					rows3, err = db.Queryx("SELECT * FROM grid_entries WHERE gridid = ? AND zoneid = ?", s2.Pathgrid, zone.Zoneidnumber)
					if err != nil {
						err = errors.Wrap(err, "failed to get grid")
						return
					}
					isGrids := false
					
					for rows3.Next() {
						gridCounter++
						g := &grid.GridEntries{}
						err = rows3.StructScan(g)
						if err != nil {
							err = errors.Wrap(err, "failed to scan grid")
							return
						}

						if !isGrids {
							outStr += addLine(3, "grids", "")
							isGrids = true
						}

						x := -g.X
						x += entry.XOffset
						x *= entry.Aspect
						//x = 0 - ((g.X - entry.XOffset) * entry.Aspect)
						

						y := g.Y
						y += entry.YOffset
						y *= entry.Aspect
						y -= 240
						//y = ((g.Y + entry.YOffset) * entry.Aspect)

						outStr += addLine(4, fmt.Sprintf("entry%d", gridCounter), "")
						outStr += addLine(5, "id", fmt.Sprintf("%d", g.Gridid))
						outStr += addLine(5, "index", fmt.Sprintf("%d", gridCounter))
						outStr += addLine(5, "xMap", fmt.Sprintf("%f", x))
						outStr += addLine(5, "yMap", fmt.Sprintf("%f", y))
						outStr += addLine(5, "z", fmt.Sprintf("%f", g.Z))						
						outStr += addLine(5, "x", fmt.Sprintf("%f", g.X))
						outStr += addLine(5, "y", fmt.Sprintf("%f", g.Y))
						outStr += addLine(5, "pause", fmt.Sprintf("%d", g.Pause))
						outStr += addLine(5, "heading", fmt.Sprintf("%f", g.Heading))
						outStr += addLine(5, "zoneid", fmt.Sprintf("%d", g.Zoneid))
					}
					rows3.Close()
					fmt.Println(gridCounter)
				}
				spawnCounter++
			}
			rows2.Close()

			

			outStr += addLine(0, "gender", fmt.Sprintf("%d", n.Gender))
			outStr += addLine(0, "gendername", getGender(n.Gender))
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


			//LOOT
			lootTotal := 0
			if n.Loottable_id > 0 {
				if count > total {
					fmt.Println(count, "total npcs")
					return
				}
				//fmt.Println("loot")
				lt := &loot.LootTable{}
				err = db.Get(lt, "SELECT * FROM loottable WHERE id = ?", n.Loottable_id)
				if lt == nil {
					err = errors.Wrapf(err, "invalid loot table: %d", n.Loottable_id)
					return
				}
				outStr += "loot:\n"
				outStr += addLine(1, "mincash", fmt.Sprintf("%d", lt.Mincash))
				outStr += addLine(1, "maxcash", fmt.Sprintf("%d", lt.Maxcash))

				outStr += "  entries:\n"
				counter := 0
				rows2, err = db.Queryx("SELECT * FROM loottable_entries WHERE loottable_id = ?", n.Loottable_id)
				if err != nil {
					err = errors.Wrap(err, "failed to get lte")
					return
				}
				for rows2.Next() {
					lte := &loot.LootTableEntries{}
					err = rows2.StructScan(lte)
					if err != nil {
						err = errors.Wrap(err, "failed to scan lte")
						return
					}
					outStr += addLine(2, fmt.Sprintf("entry%d", counter), "")
					outStr += addLine(3, "multiplier", fmt.Sprintf("%d", lte.Multiplier))
					outStr += addLine(3, "droplimit", fmt.Sprintf("%d", lte.Droplimit))
					outStr += addLine(3, "mindrop", fmt.Sprintf("%d", lte.Mindrop))
					outStr += addLine(3, "probability", fmt.Sprintf("%f", lte.Probability))
					outStr += addLine(3, "drops", "")
					dropCounter := 0
					rows3, err = db.Queryx("SELECT * FROM lootdrop_entries WHERE lootdrop_id = ?", lte.Lootdrop_id)
					if err != nil {
						err = errors.Wrap(err, "failed to find lootdrop entry")
						return
					}
					for rows3.Next() {
						lde := &loot.LootDropEntries{}
						err = rows3.StructScan(lde)
						if err != nil {
							err = errors.Wrap(err, "failed to scan lde")
							return
						}
						outStr += addLine(4, fmt.Sprintf("entry%d", dropCounter), "")
						outStr += addLine(5, "chance", fmt.Sprintf("%f", lde.Chance))
						outStr += addLine(5, "multiplier", fmt.Sprintf("%d", lde.Multiplier))
						outStr += addLine(5, "item", "")
						outStr += addLine(6, "id", fmt.Sprintf("%d", lde.Item_id))
						outStr += addLine(6, "charges", fmt.Sprintf("%d", lde.Item_charges))
						item := &item.Item{}
						rows4, err = db.Queryx("SELECT * FROM items WHERE id = ? LIMIT 1", lde.Item_id)
						if err != nil {
							err = errors.Wrap(err, "failed to get item")
							return
						}
						for rows4.Next() {
							err = rows4.StructScan(item)
							if err != nil {
								err = errors.Wrap(err, "failed to scan item")
								return
							}
							outStr += addLine(6, "name", item.Name)
							outStr += addLine(6, "icon", fmt.Sprintf("%d", item.Icon))
						}
						rows4.Close()

						dropCounter++
						lootTotal++
					}
					rows3.Close()
					counter++
				}
				rows2.Close()
			}
			outStr += fmt.Sprintf("lootcount: %d\n", lootTotal)
			outStr += "---\n"
			err = ioutil.WriteFile(fmt.Sprintf("%s/%s-%d.md", outPath, slug.MakeLang(n.Name, "en"), n.Id.Int64), []byte(outStr), 0644)
			if err != nil {
				fmt.Println("Error writing file:", err.Error())
				continue
			}
			//		fmt.Println(count, "/", total)
		}
		if rowCount == 0 {
			break
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

func addLine(tab int, key string, value string) string {
	outStr := ""
	outStr += strings.Repeat(" ", tab*2)
	reg := regexp.MustCompile("\"")
	key = reg.ReplaceAllString(key, "'")
	value = reg.ReplaceAllString(value, "'")

	if len(value) == 0 {
		outStr += fmt.Sprintf("%s:\n", key)
		return outStr
	}

	outStr += fmt.Sprintf("%s: \"%s\"\n", key, value)
	return outStr

}
