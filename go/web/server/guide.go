package server

import (
	"net/http"
)

func GetGuideGettingStarted(w http.ResponseWriter, r *http.Request) {
	site := NewSite()
	site.Title = "Getting Started on RebuildEQ"
	site.Page = "getting-started"
	site.Section = "guide"
	var err error
	tmp := getTemplate("")
	if tmp == nil {

		tmp, err = loadTemplate(nil, "body", "guide/getting_started.tpl")
		if err != nil {
			show500(w, r, err.Error())
			return
		}

		if tmp, err = loadStandardTemplate(tmp); err != nil {
			show500(w, r, err.Error())
			return
		}

		setTemplate("guide/getting_started", tmp)
	}

	type Content struct {
		Site Site
	}
	content := Content{
		Site: site,
	}

	w.WriteHeader(http.StatusOK)
	if err = tmp.Execute(w, content); err != nil {
		show500(w, r, err.Error())
		return
	}
	return
}

func GetGuideEncounterSystem(w http.ResponseWriter, r *http.Request) {
	site := NewSite()
	site.Title = "Encounter System"
	site.Page = "encounter-system"
	site.Section = "guide"
	var err error
	tmp := getTemplate("")
	if tmp == nil {

		tmp, err = loadTemplate(nil, "body", "guide/encounter_system.tpl")
		if err != nil {
			show500(w, r, err.Error())
			return
		}

		if tmp, err = loadStandardTemplate(tmp); err != nil {
			show500(w, r, err.Error())
			return
		}

		setTemplate("guide/encounter_system", tmp)
	}

	type Content struct {
		Site Site
	}
	content := Content{
		Site: site,
	}

	w.WriteHeader(http.StatusOK)
	if err = tmp.Execute(w, content); err != nil {
		show500(w, r, err.Error())
		return
	}
	return
}

func GetGuideFAQ(w http.ResponseWriter, r *http.Request) {
	site := NewSite()
	site.Title = "Frequently Asked Questions"
	site.Page = "faq"
	site.Section = "guide"
	var err error
	tmp := getTemplate("")
	if tmp == nil {

		tmp, err = loadTemplate(nil, "body", "guide/faq.tpl")
		if err != nil {
			show500(w, r, err.Error())
			return
		}

		if tmp, err = loadStandardTemplate(tmp); err != nil {
			show500(w, r, err.Error())
			return
		}

		setTemplate("guide/faq", tmp)
	}

	type Content struct {
		Site Site
	}
	content := Content{
		Site: site,
	}

	w.WriteHeader(http.StatusOK)
	if err = tmp.Execute(w, content); err != nil {
		show500(w, r, err.Error())
		return
	}
	return
}
