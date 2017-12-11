package server

import (
	"log"
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

		if tmp, err = loadTemplate(nil, "body", "npc.tpl"); err != nil {
			w.WriteHeader(http.StatusInternalServerError)
			log.Println("failed to load template", err.Error())
			return
		}

		if tmp, err = loadStandardTemplate(tmp); err != nil {
			w.WriteHeader(http.StatusInternalServerError)
			log.Println("failed to load template", err.Error())
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
		w.WriteHeader(http.StatusInternalServerError)
		log.Println("Template rendering error", err.Error())
		return
	}
	return
}
