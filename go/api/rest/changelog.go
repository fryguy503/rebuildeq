package rest

import (
	"net/http"
	"strconv"

	"github.com/gorilla/mux"
)

func GetChangelog(w http.ResponseWriter, r *http.Request) {
	var err error
	vars := mux.Vars(r)
	id, err := strconv.Atoi(vars["id"])
	if err != nil {
		returnError(w, r, err.Error(), http.StatusExpectationFailed)
		return
	}

	c, err := api.GetChangelog(id)
	if err != nil {
		returnError(w, r, err.Error(), http.StatusInternalServerError)
		return
	}

	returnData(w, r, c, http.StatusOK)
}

func GetChangelogs(w http.ResponseWriter, r *http.Request) {
	var err error
	c, err := api.GetChangelogs()
	if err != nil {
		returnError(w, r, err.Error(), http.StatusExpectationFailed)
		return
	}

	returnData(w, r, c, http.StatusOK)
}
