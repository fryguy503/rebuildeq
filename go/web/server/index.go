package server

import (
	"log"
	"net/http"
)

func Index(w http.ResponseWriter, r *http.Request) {
	var err error
	tmp := getTemplate("")
	if tmp == nil {

		newTmp, tErr := loadTemplate(nil, "index", "index.tpl")
		if tErr != nil {
			w.WriteHeader(http.StatusInternalServerError)
			log.Println("failed to load template", tErr.Error())
			return
		}

		setTemplate("index", newTmp)
		tmp = newTmp

	}

	w.WriteHeader(http.StatusOK)
	if err = tmp.Execute(w, site); err != nil {
		w.WriteHeader(http.StatusInternalServerError)
		log.Println("Template rendering error", err.Error())
		return
	}
	return
}
