package server

import (
	"log"
	"net/http"
)

func GetCharacter(w http.ResponseWriter, r *http.Request) {

	character, resp, err := api.CharacterApi.GetCharacter(nil, "661778")
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

	tmp := getTemplate("character")
	if tmp == nil {

		newTmp, tErr := loadTemplate(nil, "body", "character.tpl")
		if tErr != nil {
			w.WriteHeader(http.StatusInternalServerError)
			log.Println("failed to load template", tErr.Error())
			return
		}
		newTmp, tErr = loadTemplate(newTmp, "root", "root.tpl")
		if tErr != nil {
			w.WriteHeader(http.StatusInternalServerError)
			log.Println("failed to load template", tErr.Error())
			return
		}
		setTemplate("character", newTmp)
		tmp = newTmp
	}

	w.WriteHeader(http.StatusOK)
	if err = tmp.Execute(w, character); err != nil {
		w.WriteHeader(http.StatusInternalServerError)
		log.Println("Template rendering error", err.Error())
		return
	}
	return
}

func GetCharacters(w http.ResponseWriter, r *http.Request) {
	//w.Header().Set("Content-Type", "application/json; charset=UTF-8")

	characters, resp, err := api.CharacterApi.GetCharacters(nil)
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
	tmp := getTemplate("characters")
	if tmp == nil {

		newTmp, tErr := loadTemplate(nil, "body", "characters.tpl")
		if tErr != nil {
			w.WriteHeader(http.StatusInternalServerError)
			log.Println("failed to load template", tErr.Error())
			return
		}
		newTmp, tErr = loadTemplate(newTmp, "root", "root.tpl")
		if tErr != nil {
			w.WriteHeader(http.StatusInternalServerError)
			log.Println("failed to load template", tErr.Error())
			return
		}
		setTemplate("characters", newTmp)
		tmp = newTmp
	}

	w.WriteHeader(http.StatusOK)
	if err = tmp.Execute(w, characters); err != nil {
		w.WriteHeader(http.StatusInternalServerError)
		log.Println("Template rendering error", err.Error())
		return
	}
	return
}
