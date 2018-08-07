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
	count := 0
	rows, err := db.Queryx(fmt.Sprintf("SELECT * FROM spells_new LIMIT %d", total))
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

		count++

		outStr := "+++\n"
		outStr += fmt.Sprintf("note = \"This file was auto generated. DO NOT EDIT\"\n")
		outStr += fmt.Sprintf("description = \"%s\"\n", s.Name.String)
		outStr += fmt.Sprintf("id = \"%s\"\n", s.Id)
		outStr += fmt.Sprintf("icon = \"%s\"\n", s.Icon)
		type spellEffect struct {
			Id    string
			Value string
		}
		tags := []spellEffect{
			{Id: s.Effectid1, Value: s.Effect_base_value1},
			{Id: s.Effectid2, Value: s.Effect_base_value2},
			{Id: s.Effectid3, Value: s.Effect_base_value3},
			{Id: s.Effectid4, Value: s.Effect_base_value4},
			{Id: s.Effectid5, Value: s.Effect_base_value5},
			{Id: s.Effectid6, Value: s.Effect_base_value6},
			{Id: s.Effectid7, Value: s.Effect_base_value7},
			{Id: s.Effectid8, Value: s.Effect_base_value8},
			{Id: s.Effectid9, Value: s.Effect_base_value9},
			{Id: s.Effectid10, Value: s.Effect_base_value10},
			{Id: s.Effectid11, Value: s.Effect_base_value11},
			{Id: s.Effectid12, Value: s.Effect_base_value12},
		}
		tagStr := ""
		for _, tag := range tags {
			if tag.Id == "" {
				continue
			}
			if tag.Id == "254" && s.Effect_base_value1 == "0" {
				continue
			}

			tagStr += fmt.Sprintf(`"%s", `, tag.Id)
		}
		if getType(s.Targettype) != "" {
			tagStr += fmt.Sprintf(`"%s", `, getType(s.Targettype))
		}
		if len(tagStr) > 0 {
			tagStr = tagStr[0 : len(tagStr)-2]
			outStr += fmt.Sprintf("tags = [%s]\n", tagStr)
		}
		outStr += fmt.Sprintf("title = \"%s\"\n", s.Name.String)
		outStr += fmt.Sprintf("class = \"%s\"\n", s.Classes1)
		outStr += "+++\n"
		outStr += "targetType: " + getType(s.Targettype)
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
