package server

import (
	"log"
	"net/http"
)

func GetCharacter(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Content-Type", "application/json; charset=UTF-8")

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
	log.Println(character)

	w.WriteHeader(http.StatusOK)
}

func GetCharacters(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Content-Type", "application/json; charset=UTF-8")

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
	log.Println(characters)
	w.WriteHeader(http.StatusOK)
}
