package server

import (
	"html/template"
	"log"
	"net/http"

	"github.com/gorilla/mux"
)

func GetZone(w http.ResponseWriter, r *http.Request) {
	site := NewSite()
	site.Page = "zone"
	vars := mux.Vars(r)

	if vars["id"] == "chart" {
		GetZoneChart(w, r)
		return
	}

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

	tmp := getTemplate("")
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

	site.Title = zone.Name

	w.WriteHeader(http.StatusOK)
	if err = tmp.Execute(w, content); err != nil {
		w.WriteHeader(http.StatusInternalServerError)
		log.Println("Template rendering error", err.Error())
		return
	}
	return
}

func GetZoneChart(w http.ResponseWriter, r *http.Request) {
	site := NewSite()
	site.Page = "zone"

	zones, resp, err := api.ZoneApi.GetZoneChart(nil)
	if err != nil {
		//TODO: Handle errors more gracefully
		w.WriteHeader(http.StatusInternalServerError)
		log.Println("Failed api request", err.Error())
		return
	}
	if resp.StatusCode != 200 {
		w.WriteHeader(http.StatusInternalServerError)
		log.Println("Invalid status code", err.Error())
		return
	}

	tmp := getTemplate("")
	if tmp == nil {

		funcMap := template.FuncMap{"iszonelevel": isZoneLevel}

		tmp = template.New("body").Funcs(funcMap)

		if tmp, err = loadTemplate(tmp, "body", "zone_chart.tpl"); err != nil {
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
		Site  Site
		Zones interface{}
	}
	content := Content{
		Site:  site,
		Zones: zones,
	}

	w.WriteHeader(http.StatusOK)
	if err = tmp.Execute(w, content); err != nil {
		w.WriteHeader(http.StatusInternalServerError)
		log.Println("Template rendering error", err.Error())
		return
	}
	return
}

func isZoneLevel(level int32, levels int32) bool {
	return ((levels & level) == level)
}
