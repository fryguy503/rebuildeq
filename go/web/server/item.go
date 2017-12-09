package server

import (
	"log"
	"net/http"

	"github.com/gorilla/mux"
	"github.com/xackery/rebuildeq/go/swagger/client"
)

func GetItem(w http.ResponseWriter, r *http.Request) {
	vars := mux.Vars(r)

	item, resp, err := api.ItemApi.GetItem(nil, vars["id"])
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

	npcsBase, resp, err := api.NPCApi.GetNPCsByItem(nil, vars["id"])
	type NPCsExtended struct {
		*client.Npc
		ZoneSnippet   string
		ZoneSnippetId int32
		ChanceSnippet int32
	}

	npcs := []*NPCsExtended{}
	for i, _ := range npcsBase {
		npc := &NPCsExtended{
			Npc: &npcsBase[i],
		}

		if len(npc.SpawnsIn) > 0 {
			npc.ZoneSnippet = npc.SpawnsIn[0].ZoneShortName
			npc.ZoneSnippetId = npc.SpawnsIn[0].ZoneId
			npc.ChanceSnippet = npc.SpawnsIn[0].Chance
		}

		npcs = append(npcs, npc)
	}

	tmp := getTemplate("")
	if tmp == nil {

		newTmp, tErr := loadTemplate(nil, "body", "item.tpl")
		if tErr != nil {
			w.WriteHeader(http.StatusInternalServerError)
			log.Println("failed to load template", tErr.Error())
			return
		}
		newTmp, tErr = loadTemplate(newTmp, "navmenu", "navmenu.tpl")
		if tErr != nil {
			w.WriteHeader(http.StatusInternalServerError)
			log.Println("failed to load template", tErr.Error())
			return
		}
		newTmp, tErr = loadTemplate(newTmp, "root", "root.tpl")
		if tErr != nil {
			w.WriteHeader(http.StatusInternalServerError)
			log.Println("failed to load template", tErr.Error())
			return
		}
		setTemplate("item", newTmp)
		tmp = newTmp
	}
	type Content struct {
		Site Site
		Item interface{}
		NPCs interface{}
	}
	content := Content{
		Site: site,
		Item: item,
		NPCs: npcs,
	}
	for _, npc := range npcs {
		log.Println(npc.Name)
	}
	w.WriteHeader(http.StatusOK)
	if err = tmp.Execute(w, content); err != nil {
		w.WriteHeader(http.StatusInternalServerError)
		log.Println("Template rendering error", err.Error())
		return
	}
	return
}
