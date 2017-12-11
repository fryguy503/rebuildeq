package server

import (
	"fmt"
	"log"
	"net/http"

	"github.com/gorilla/mux"
	"github.com/xackery/rebuildeq/go/swagger/client"
)

func GetItem(w http.ResponseWriter, r *http.Request) {
	site := NewSite()
	site.Page = "item"
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

		if tmp, err = loadTemplate(nil, "body", "item.tpl"); err != nil {
			w.WriteHeader(http.StatusInternalServerError)
			log.Println("failed to load template", err.Error())
			return
		}

		if tmp, err = loadStandardTemplate(tmp); err != nil {
			w.WriteHeader(http.StatusInternalServerError)
			log.Println("failed to load template", err.Error())
			return
		}
		setTemplate("item", tmp)

	}
	site.Title = fmt.Sprintf("%s", item.Name)
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
