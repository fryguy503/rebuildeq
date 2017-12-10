package server

import (
	"log"
	"net/http"

	"github.com/gorilla/mux"
)

func GetZone(w http.ResponseWriter, r *http.Request) {
	site := NewSite()
	site.Page = "zone"
	vars := mux.Vars(r)

	zone, resp, err := api.ZoneApi.GetZone(nil, vars["id"])
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

	tmp := getTemplate("zone")
	if tmp == nil {

		if tmp, err = loadTemplate(nil, "body", "zone.tpl"); err != nil {
			w.WriteHeader(http.StatusInternalServerError)
			log.Println("failed to load template", err.Error())
			return
		}

		if tmp, err = loadStandardTemplate(tmp); err != nil {
			w.WriteHeader(http.StatusInternalServerError)
			log.Println("failed to load template", err.Error())
			return
		}
		setTemplate("zone", tmp)
	}
	type Content struct {
		Site Site
		Zone interface{}
	}
	content := Content{
		Site: site,
		Zone: zone,
	}

	w.WriteHeader(http.StatusOK)
	if err = tmp.Execute(w, content); err != nil {
		w.WriteHeader(http.StatusInternalServerError)
		log.Println("Template rendering error", err.Error())
		return
	}
	return
}
