package server

import (
	"log"
	"net/http"

	"github.com/gorilla/mux"
)

func GetChangelog(w http.ResponseWriter, r *http.Request) {
	site := NewSite()
	site.Page = "changelog"
	vars := mux.Vars(r)

	changelog, resp, err := api.ChangelogApi.GetChangelog(nil, vars["id"])
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

		if tmp, err = loadTemplate(nil, "body", "changelog.tpl"); err != nil {
			w.WriteHeader(http.StatusInternalServerError)
			log.Println("failed to load template", err.Error())
			return
		}

		if tmp, err = loadStandardTemplate(tmp); err != nil {
			w.WriteHeader(http.StatusInternalServerError)
			log.Println("failed to load template", err.Error())
			return
		}
		setTemplate("changelog", tmp)
	}
	type Content struct {
		Site      Site
		Changelog interface{}
	}
	content := Content{
		Site:      site,
		Changelog: changelog,
	}
	w.WriteHeader(http.StatusOK)
	if err = tmp.Execute(w, content); err != nil {
		w.WriteHeader(http.StatusInternalServerError)
		log.Println("Template rendering error", err.Error())
		return
	}
	return
}

func GetChangelogs(w http.ResponseWriter, r *http.Request) {
	site := NewSite()
	site.Page = "changelog"

	changelogs, resp, err := api.ChangelogApi.GetChangelogs(nil)
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

		if tmp, err = loadTemplate(nil, "body", "changelogs.tpl"); err != nil {
			w.WriteHeader(http.StatusInternalServerError)
			log.Println("failed to load template", err.Error())
			return
		}

		if tmp, err = loadStandardTemplate(tmp); err != nil {
			w.WriteHeader(http.StatusInternalServerError)
			log.Println("failed to load template", err.Error())
			return
		}
		setTemplate("changelogs", tmp)
	}
	type Content struct {
		Site       Site
		Changelogs interface{}
	}
	content := Content{
		Site:       site,
		Changelogs: changelogs,
	}

	w.WriteHeader(http.StatusOK)
	if err = tmp.Execute(w, content); err != nil {
		w.WriteHeader(http.StatusInternalServerError)
		log.Println("Template rendering error", err.Error())
		return
	}
	return
}
