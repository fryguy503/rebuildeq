package rest

import (
	"encoding/json"
	"net/http"
	"strconv"

	"github.com/gorilla/mux"
)

func GetItem(w http.ResponseWriter, r *http.Request) {
	var err error
	vars := mux.Vars(r)
	id, err := strconv.Atoi(vars["itemId"])
	if err != nil {
		returnError(w, r, err.Error(), http.StatusExpectationFailed)
		return
	}

	c, err := api.GetItem(id)
	if err != nil {
		returnError(w, r, err.Error(), http.StatusExpectationFailed)
		return
	}

	js := []byte{}
	if js, err = json.Marshal(c); err != nil {
		returnError(w, r, err.Error(), http.StatusExpectationFailed)
		return
	}
	w.WriteHeader(http.StatusOK)
	w.Write(js)
}

func ListItemNPC(w http.ResponseWriter, r *http.Request) {
	var err error
	vars := mux.Vars(r)
	id, err := strconv.Atoi(vars["itemId"])
	if err != nil {
		returnError(w, r, err.Error(), http.StatusExpectationFailed)
		return
	}

	c, err := api.GetNPCsByItem(id)
	if err != nil {
		returnError(w, r, err.Error(), http.StatusExpectationFailed)
		return
	}

	js := []byte{}
	if js, err = json.Marshal(c); err != nil {
		returnError(w, r, err.Error(), http.StatusExpectationFailed)
		return
	}
	w.WriteHeader(http.StatusOK)
	w.Write(js)
}
