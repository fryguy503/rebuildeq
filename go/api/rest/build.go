package rest

import (
	"encoding/json"
	"log"
	"net/http"
	"strconv"

	"github.com/gorilla/mux"
)

func TrainBuildPoint(w http.ResponseWriter, r *http.Request) {
	var err error
	w.Header().Set("Content-Type", "application/json; charset=UTF-8")
	vars := mux.Vars(r)
	id, err := strconv.Atoi(vars["id"])
	if err != nil {
		http.Error(w, err.Error(), http.StatusExpectationFailed)
		return
	}

	characterId := 661778
	//todo: do more stuff

	log.Println(id)
	build, err := api.GetSpentBuildPoints(characterId)
	if err != nil {
		http.Error(w, err.Error(), http.StatusExpectationFailed)
		return
	}

	build.Build = "55555555555555555555555555555555555555555555555555555"

	err = api.UpdateBuild(characterId, build)
	if err != nil {
		log.Printf("Failed to get build: %s\n", err.Error())
		http.Error(w, err.Error(), http.StatusExpectationFailed)
		return
	}

	w.WriteHeader(http.StatusOK)
}

func GetSpentBuildPoints(w http.ResponseWriter, r *http.Request) {
	var err error
	w.Header().Set("Content-Type", "application/json; charset=UTF-8")
	vars := mux.Vars(r)
	id, err := strconv.Atoi(vars["id"])
	if err != nil {
		http.Error(w, err.Error(), http.StatusExpectationFailed)
		return
	}
	c, err := api.GetSpentBuildPoints(id)
	if err != nil {
		log.Printf("Failed to get builds: %s\n", err.Error())
		http.Error(w, err.Error(), http.StatusExpectationFailed)
		return
	}

	js := []byte{}
	if js, err = json.Marshal(c); err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}
	w.WriteHeader(http.StatusOK)
	w.Write(js)
}
