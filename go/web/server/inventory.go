package server

import (
	"log"
	"net/http"

	"github.com/gorilla/mux"
)

func GetInventory(w http.ResponseWriter, r *http.Request) {
	site := NewSite()
	site.Page = "inventory"
	vars := mux.Vars(r)

	inventory, resp, err := api.InventoryApi.GetInventory(nil, vars["id"])
	if err != nil {
		//TODO: Handle errors more gracefully
		w.WriteHeader(http.StatusInternalServerError)
		log.Println("Failed", err.Error())
		return
	}
	if resp.StatusCode != 200 {
		w.WriteHeader(http.StatusInternalServerError)
		log.Println("Invalid status code", err.Error())
		return
	}

	character, resp, err := api.CharacterApi.GetCharacter(nil, vars["id"])
	if err != nil {
		//TODO: Handle errors more gracefully
		w.WriteHeader(http.StatusInternalServerError)
		log.Println("Failed", err.Error())
		return
	}
	if resp.StatusCode != 200 {
		w.WriteHeader(http.StatusInternalServerError)
		log.Println("Invalid status code", err.Error())
		return
	}

	tmp := getTemplate("")
	if tmp == nil {

		if tmp, err = loadTemplate(nil, "body", "inventory.tpl"); err != nil {
			w.WriteHeader(http.StatusInternalServerError)
			log.Println("failed to load template", err.Error())
			return
		}

		if tmp, err = loadStandardTemplate(tmp); err != nil {
			w.WriteHeader(http.StatusInternalServerError)
			log.Println("failed to load template", err.Error())
			return
		}
		setTemplate("inventory", tmp)

	}
	type Content struct {
		Site      Site
		Inventory interface{}
		Character interface{}
	}
	content := Content{
		Site:      site,
		Inventory: inventory,
		Character: character,
	}

	w.WriteHeader(http.StatusOK)
	if err = tmp.Execute(w, content); err != nil {
		w.WriteHeader(http.StatusInternalServerError)
		log.Println("Template rendering error", err.Error())
		return
	}
	return
}
