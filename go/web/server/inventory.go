package server

import (
	"fmt"
	"net/http"

	"github.com/gorilla/mux"
	"github.com/xackery/rebuildeq/go/swagger/client"
)

func GetInventory(w http.ResponseWriter, r *http.Request) {
	site := NewSite()
	site.Page = "inventory"
	vars := mux.Vars(r)
	ctx := GetContext(r)
	inventory, resp, err := api.InventoryApi.GetInventory(ctx, vars["id"])
	if err != nil {
		show500(w, r, err.Error())
		return
	}
	if resp.StatusCode != 200 {
		show500(w, r, err.Error())
		return
	}

	character, resp, err := api.CharacterApi.GetCharacter(ctx, vars["id"])
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
