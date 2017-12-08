package rest

import (
	"encoding/json"
	"log"
	"net/http"
	"strconv"

	"github.com/gorilla/mux"
)

func GetInventory(w http.ResponseWriter, r *http.Request) {
	var err error
	w.Header().Set("Content-Type", "application/json; charset=UTF-8")
	vars := mux.Vars(r)
	id, err := strconv.Atoi(vars["id"])
	if err != nil {
		http.Error(w, err.Error(), http.StatusExpectationFailed)
		return
	}

	i, err := api.GetInventory(id)
	if err != nil {
		log.Printf("Failed to get inventory: %s\n", err.Error())
		http.Error(w, err.Error(), http.StatusExpectationFailed)
		return
	}

	js := []byte{}
	if js, err = json.Marshal(i); err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}
	w.WriteHeader(http.StatusOK)
	w.Write(js)
}
