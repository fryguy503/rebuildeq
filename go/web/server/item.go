package server

import (
	"fmt"
	"net/http"
	"strconv"

	"github.com/gorilla/mux"
	"github.com/xackery/rebuildeq/go/swagger/client"
)

func GetItem(w http.ResponseWriter, r *http.Request) {
	var err error
	site := NewSite()
	site.Page = "item"
	vars := mux.Vars(r)
	ctx := GetContext(r)

	var iId int64
	if iId, err = strconv.ParseInt(vars["itemId"], 10, 0); err != nil {
		show404(w, r, err.Error())
	}
	itemId := int32(iId)

	item, resp, err := api.ItemApi.GetItem(ctx, itemId)
	if err != nil {
		show500(w, r, err.Error())
		return
	}
	if resp.StatusCode != 200 {
		show404(w, r, err.Error())
		return
	}

	npcsBase, resp, err := api.NPCApi.ListItemNPC(ctx, itemId)
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
			show404(w, r, "Failed to load template: "+err.Error())
			return
		}

		if tmp, err = loadStandardTemplate(tmp); err != nil {
			show404(w, r, "Failed to load template: "+err.Error())
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

	w.WriteHeader(http.StatusOK)
	if err = tmp.Execute(w, content); err != nil {
		show404(w, r, "Failed to render template: "+err.Error())
		return
	}
	return
}
