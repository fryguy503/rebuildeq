package server

import (
	"net/http"
)

func Index(w http.ResponseWriter, r *http.Request) {
	site := NewSite()
	site.Page = "index"
	site.Title = "RebuildEQ"
	var err error
	tmp := getTemplate("")
	if tmp == nil {

		tmp, err = loadTemplate(nil, "index", "index.tpl")
		if err != nil {
			show500(w, r, err.Error())
			return
		}

		setTemplate("index", tmp)

	}

	w.WriteHeader(http.StatusOK)
	if err = tmp.Execute(w, site); err != nil {
		show500(w, r, err.Error())
		return
	}
	return
}
