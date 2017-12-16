package rest

import (
	"net/http"
	"strconv"

	"github.com/gorilla/mux"
)

func TrainBuild(w http.ResponseWriter, r *http.Request) {
	var err error
	vars := mux.Vars(r)
	id, err := strconv.Atoi(vars["characterId"])
	if err != nil {
		returnError(w, r, err.Error(), http.StatusExpectationFailed)
		return
	}

	characterId := id
	//todo: do more stuff

	build, err := api.GetSpentBuildPoints(characterId)
	if err != nil {
		returnError(w, r, err.Error(), http.StatusExpectationFailed)
		return
	}

	build.Build = "55555555555555555555555555555555555555555555555555555"

	err = api.UpdateBuild(characterId, build)
	if err != nil {
		returnError(w, r, err.Error(), http.StatusExpectationFailed)
		return
	}

	w.WriteHeader(http.StatusOK)
}

func ListBuild(w http.ResponseWriter, r *http.Request) {
	var err error

	vars := mux.Vars(r)
	id, err := strconv.Atoi(vars["characterId"])
	if err != nil {
		returnError(w, r, err.Error(), http.StatusExpectationFailed)
		return
	}
	c, err := api.GetSpentBuildPoints(id)
	if err != nil {
		returnError(w, r, err.Error(), http.StatusExpectationFailed)
		return
	}

	returnData(w, r, c, http.StatusOK)
}
