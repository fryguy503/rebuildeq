package server

import (
	"fmt"
	"html/template"
	"net/http"
	"strconv"
	"strings"

	"github.com/gorilla/mux"
)

func GetChangelog(w http.ResponseWriter, r *http.Request) {
	var err error
	site := NewSite()
	site.Page = "changelog"
	vars := mux.Vars(r)
	ctx := GetContext(r)

	var cId int64
	if cId, err = strconv.ParseInt(vars["changelogId"], 10, 32); err != nil {
		show500(w, r, err.Error())
		return
	}
	changelogId := int32(cId)

	changelog, resp, err := api.ChangelogApi.GetChangelog(ctx, changelogId)
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

		if tmp, err = loadTemplate(nil, "body", "changelog_detail.tpl"); err != nil {
			show500(w, r, err.Error())
			return
		}

		if tmp, err = loadStandardTemplate(tmp); err != nil {
			show500(w, r, err.Error())
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
		show500(w, r, err.Error())
		return
	}
	return
}

func ListChangelog(w http.ResponseWriter, r *http.Request) {
	site := NewSite()
	site.Page = "changelog"
	site.Title = "Changelog"
	ctx := GetContext(r)
	changelogs, resp, err := api.ChangelogApi.ListChangelog(ctx)
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

		if tmp, err = loadTemplate(nil, "body", "changelog.tpl"); err != nil {
			show500(w, r, err.Error())
			return
		}

		if tmp, err = loadStandardTemplate(tmp); err != nil {
			show500(w, r, err.Error())
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
		show500(w, r, err.Error())
		return
	}
	return
}
