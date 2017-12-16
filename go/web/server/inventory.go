package server

import (
	"fmt"
	"net/http"
	"strconv"

	"github.com/gorilla/mux"
	"github.com/xackery/rebuildeq/go/swagger/client"
)

func ListInventory(w http.ResponseWriter, r *http.Request) {
	var err error
	site := NewSite()
	site.Page = "inventory"
	vars := mux.Vars(r)
	ctx := GetContext(r)
	var cId int64
	if cId, err = strconv.ParseInt(vars["characterId"], 10, 0); err != nil {
		show404(w, r, err.Error())
	}
	characterId := int32(cId)
	inventory, resp, err := api.InventoryApi.ListInventory(ctx, characterId)
	if err != nil {
		show500(w, r, err.Error())
		return
	}
	if resp.StatusCode != 200 {
		show500(w, r, err.Error())
		return
	}

	character, resp, err := api.CharacterApi.GetCharacter(ctx, characterId)
	if err != nil {
		show500(w, r, err.Error())
		return
	}
	if resp.StatusCode != 200 {
		show500(w, r, err.Error())
		return
	}

	tmp := getTemplate("")
	if tmp == nil {

		if tmp, err = loadTemplate(nil, "body", "inventory.tpl"); err != nil {
			show500(w, r, err.Error())
			return
		}

		if tmp, err = loadStandardTemplate(tmp); err != nil {
			show500(w, r, err.Error())
			return
		}
		setTemplate("inventory", tmp)

	}
	site.Title = fmt.Sprintf("%s's Inventory", character.Name)
	itemInventory := map[int]client.Item{}

	for i, _ := range inventory {
		itemInventory[int(inventory[i].Slot)] = inventory[i]
	}

	type Content struct {
		Site      Site
		Inventory map[int]client.Item
		Character interface{}
	}
	content := Content{
		Site:      site,
		Inventory: itemInventory,
		Character: character,
	}

	w.WriteHeader(http.StatusOK)
	if err = tmp.Execute(w, content); err != nil {
		show500(w, r, err.Error())
		return
	}
	return
}
