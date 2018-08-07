package main

import (
	"fmt"
	"io/ioutil"
	"os"

	_ "github.com/go-sql-driver/mysql"
	"github.com/gosimple/slug"
	"github.com/jmoiron/sqlx"
	"github.com/xackery/goeq/npc"
)

func genNPCs(db *sqlx.DB, outPath string, total int) (err error) {
	err = os.MkdirAll(outPath, 0644)
	if err != nil {
		fmt.Println("Error making directory", err.Error())
		return
	}
	count := 0
	rows, err := db.Queryx(fmt.Sprintf("SELECT * FROM npc_types LIMIT %d", total))
	if err != nil {
		fmt.Println("Error deleting merchanlist", err.Error())
		return
	}

	for rows.Next() {
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
		db.Get(&val, "SELECT count(spawngroupID) FROM spawnentry WHERE npcid = ?", n.Id.Int64)
		if val < 1 {
			outStr += "isspawn: false\n"
		} else {
			outStr += "isspawn: true\n"
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
		//TODO
		outStr += fmt.Sprintf("zone: %d\n", 0)
		outStr += fmt.Sprintf("zonename: %s\n", "not supported")
		outStr += fmt.Sprintf("lootcount: %d\n", 0)
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
