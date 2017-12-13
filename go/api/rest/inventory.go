package rest

import (
	"net/http"
	"strconv"

	"github.com/gorilla/mux"
)

func GetInventory(w http.ResponseWriter, r *http.Request) {
	var err error

	vars := mux.Vars(r)
	id, err := strconv.Atoi(vars["id"])
	if err != nil {
		returnError(w, r, err.Error(), http.StatusInternalServerError)
		return
	}

	i, err := api.GetInventory(id)
	if err != nil {
		returnError(w, r, err.Error(), http.StatusInternalServerError)
		return
	}

	returnData(w, r, i, http.StatusOK)
}
