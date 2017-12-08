package rest

import (
	"encoding/json"
	"net/http"
)

func GetCharacters(w http.ResponseWriter, r *http.Request) {
	var err error
	w.Header().Set("Content-Type", "application/json; charset=UTF-8")
	c := api.GetCharacters()
	js := []byte{}
	if js, err = json.Marshal(c); err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}
	w.WriteHeader(http.StatusOK)
	w.Header().Set("Content-Type", "application/json")
	w.Write(js)
}
