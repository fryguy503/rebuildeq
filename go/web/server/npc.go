package server

import (
	"net/http"

	"github.com/gorilla/mux"
)

func GetNPC(w http.ResponseWriter, r *http.Request) {
	site := NewSite()
	site.Page = "npc"
	vars := mux.Vars(r)
	ctx := GetContext(r)
	npc, resp, err := api.NPCApi.GetNPC(ctx, vars["id"])
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

		if tmp, err = loadTemplate(nil, "body", "npc.tpl"); err != nil {
			show500(w, r, err.Error())
			return
		}

		if tmp, err = loadStandardTemplate(tmp); err != nil {
			show500(w, r, err.Error())
			return
		}
		setTemplate("npc", tmp)

	}
	type Content struct {
		Site Site
		Npc  interface{}
	}
	site.Title = npc.CleanName
	content := Content{
		Site: site,
		Npc:  npc,
	}

	w.WriteHeader(http.StatusOK)
	if err = tmp.Execute(w, content); err != nil {
		show500(w, r, err.Error())
		return
	}
	return
}
