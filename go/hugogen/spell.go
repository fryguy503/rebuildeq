package main

import (
	"fmt"
	"io/ioutil"
	"strconv"

	_ "github.com/go-sql-driver/mysql"
	"github.com/gosimple/slug"
	"github.com/jmoiron/sqlx"
	"github.com/xackery/goeq/spell"
)

func genSpells(db *sqlx.DB, outPath string, total int) (err error) {
	totalRows := 0
	db.Get(&totalRows, "SELECT count(id) FROM spells_new LIMIT ?", total)
	if totalRows < total {
		total = totalRows
	}

	count := 0
	rows, err := db.Queryx("SELECT * FROM spells_new LIMIT ?", total)
	if err != nil {
		fmt.Println("Error deleting merchanlist", err.Error())
		return
	}

	for rows.Next() {
		s := &spell.SpellsNew{}
		err = rows.StructScan(&s)
		if err != nil {
			fmt.Println("Error scanning", err.Error())
			return
		}

		if count%1000 == 0 {
			fmt.Printf("spell %d / %d\n", count, total)
		}
		count++
		outStr := "---\n"
		outStr += fmt.Sprintf("note: This file was auto generated. DO NOT EDIT\n")
		outStr += fmt.Sprintf("description: \"%s\"\n", s.Name.String)
		outStr += fmt.Sprintf("id: %s\n", s.Id)
		outStr += fmt.Sprintf("icon: %s\n", s.Icon)
		outStr += "effects:\n"
		outStr += fmt.Sprintf("  effect1:\n    id: %s\n    base: %s\n    limit: %s\n", s.Effectid1, s.Effect_base_value1, s.Effect_limit_value1)
		outStr += fmt.Sprintf("  effect2:\n    id: %s\n    base: %s\n    limit: %s\n", s.Effectid2, s.Effect_base_value2, s.Effect_limit_value2)
		outStr += fmt.Sprintf("  effect3:\n    id: %s\n    base: %s\n    limit: %s\n", s.Effectid3, s.Effect_base_value3, s.Effect_limit_value3)
		outStr += fmt.Sprintf("  effect4:\n    id: %s\n    base: %s\n    limit: %s\n", s.Effectid4, s.Effect_base_value4, s.Effect_limit_value4)
		outStr += fmt.Sprintf("  effect5:\n    id: %s\n    base: %s\n    limit: %s\n", s.Effectid5, s.Effect_base_value5, s.Effect_limit_value5)
		outStr += fmt.Sprintf("  effect6:\n    id: %s\n    base: %s\n    limit: %s\n", s.Effectid6, s.Effect_base_value6, s.Effect_limit_value6)
		outStr += fmt.Sprintf("  effect7:\n    id: %s\n    base: %s\n    limit: %s\n", s.Effectid7, s.Effect_base_value7, s.Effect_limit_value7)
		outStr += fmt.Sprintf("  effect8:\n    id: %s\n    base: %s\n    limit: %s\n", s.Effectid8, s.Effect_base_value8, s.Effect_limit_value8)
		outStr += fmt.Sprintf("  effect9:\n    id: %s\n    base: %s\n    limit: %s\n", s.Effectid9, s.Effect_base_value9, s.Effect_limit_value9)
		outStr += fmt.Sprintf("  effect10:\n    id: %s\n    base: %s\n    limit: %s\n", s.Effectid10, s.Effect_base_value10, s.Effect_limit_value10)
		outStr += fmt.Sprintf("  effect11:\n    id: %s\n    base: %s\n    limit: %s\n", s.Effectid11, s.Effect_base_value11, s.Effect_limit_value11)
		outStr += fmt.Sprintf("  effect12:\n    id: %s\n    base: %s\n    limit: %s\n", s.Effectid12, s.Effect_base_value12, s.Effect_limit_value12)
		outStr += fmt.Sprintf("targettype: %s\n", getType(s.Targettype))
		outStr += fmt.Sprintf("title: \"%s\"\n", s.Name.String)
		outStr += fmt.Sprintf("class: %s\n", s.Classes1)
		outStr += "---\n"
		err = ioutil.WriteFile(fmt.Sprintf("%s/%s-%s.md", outPath, slug.MakeLang(s.Name.String, "en"), s.Id), []byte(outStr), 0644)
		if err != nil {
			fmt.Println("Error writing file:", err.Error())
			continue
		}
	}

	fmt.Println(count, "total spells")
	return
}

type spellTargetType struct {
	ID   int64  `json:"ID,omitempty"`
	Name string `json:"name,omitempty"`
}

func getType(id string) (name string) {
	intID, err := strconv.ParseInt(id, 10, 64)
	if err != nil {
		return
	}
	for _, t := range types {
		if t.ID == intID {
			name = t.Name
			return
		}
	}
	name = "unknown"
	return
}

var types = []spellTargetType{
	{
		ID:   0,
		Name: "Special",
	},
	{
		ID:   1,
		Name: "Line of Sight",
	},
	{
		ID:   2,
		Name: "Old PBAE (Unused)",
	},
	{
		ID:   3,
		Name: "Own Group",
	},
	{
		ID:   4,
		Name: "PBAE",
	},
	{
		ID:   5,
		Name: "Single",
	},
	{
		ID:   6,
		Name: "Self Only",
	},
	{
		ID:   8,
		Name: "Targeted AE",
	},
	{
		ID:   9,
		Name: "Animals Only",
	},
	{
		ID:   10,
		Name: "Undead Only",
	},
	{
		ID:   11,
		Name: "Summoned",
	},
	{
		ID:   13,
		Name: "Life Tap",
	},
	{
		ID:   14,
		Name: "Own Pet",
	},
	{
		ID:   15,
		Name: "Corpse",
	},
	{
		ID:   16,
		Name: "Plants",
	},
	{
		ID:   17,
		Name: "Special Velious Giants",
	},
	{
		ID:   18,
		Name: "Special Velious Dragons",
	},
	{
		ID:   20,
		Name: "Targeted AE Life Tap",
	},
	{
		ID:   24,
		Name: "AE Undead Only",
	},
	{
		ID:   25,
		Name: "AE Summoned Only",
	},
	{
		ID:   32,
		Name: "AE HateList/Casters Only",
	},
	{
		ID:   33,
		Name: "NPC's Hate List",
	},
	{
		ID:   34,
		Name: "Lost Dungeon Object",
	},
	{
		ID:   35,
		Name: "Muramite",
	},
	{
		ID:   36,
		Name: "AE PCs Only",
	},
	{
		ID:   37,
		Name: "AE NPCs Only",
	},
	{
		ID:   38,
		Name: "Any Summoned Pet",
	},
	{
		ID:   39,
		Name: "Group (No Pets)",
	},
	{
		ID:   40,
		Name: "Raid AE",
	},
	{
		ID:   41,
		Name: "Group (Targetable)",
	},
	{
		ID:   42,
		Name: "Directional Cone",
	},
	{
		ID:   43,
		Name: "Group With Pets",
	},
	{
		ID:   44,
		Name: "Beam",
	},
	{
		ID:   45,
		Name: "Ring",
	},
	{
		ID:   46,
		Name: "Target's Target",
	},
	{
		ID:   47,
		Name: "Targeted Pet's Master",
	},
	{
		ID:   50,
		Name: "Targeted AE (No Pets)",
	},
}
