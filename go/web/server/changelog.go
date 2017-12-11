package server

import (
	"fmt"
	"html/template"
	"log"
	"net/http"
	"strings"

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
	site.Title = fmt.Sprintf("Changelog - %s", changelog.Title)
	changelog.Body = strings.Replace(changelog.Body, "\n", "<br/>", -1)
	changelog.Body = "<ul>\n" + changelog.Body
	changelog.Body = strings.Replace(changelog.Body, "*", "<li>", -1)
	changelog.Body = "\n</ul>" + changelog.Body
	type Content struct {
		Site      Site
		Changelog interface{}
		Body      template.HTML
	}
	content := Content{
		Site:      site,
		Changelog: changelog,
		Body:      template.HTML(changelog.Body),
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
	site.Title = "Changelog"
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
	for i, _ := range changelogs {
		if strings.Contains(changelogs[i].Body, "*") {
			changelogs[i].Body = changelogs[i].Body[strings.Index(changelogs[i].Body, "*")+1:]
			if strings.Contains(changelogs[i].Body, "*") {
				count := strings.Count(changelogs[i].Body, "*")
				changelogs[i].Body = changelogs[i].Body[0:strings.Index(changelogs[i].Body, "*")]
				if len(changelogs[i].Body) > 100 {
					changelogs[i].Body = changelogs[i].Body[0:100]
				}
				changelogs[i].Body += fmt.Sprintf(", plus %d more changes", count)
			}
			changelogs[i].Body = strings.Replace(changelogs[i].Body, "*", "", -1)
		}
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
