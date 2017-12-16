package rest

import (
	"encoding/json"
	"log"
	"net/http"
	"strconv"

	"github.com/gorilla/mux"
)

func GetNPC(w http.ResponseWriter, r *http.Request) {
	var err error
	vars := mux.Vars(r)
	npcId, err := strconv.Atoi(vars["npcId"])
	log.Println(vars["id"])
	if err != nil {
		returnError(w, r, err.Error(), http.StatusExpectationFailed)
		return
	}

	c, err := api.GetNPC(int32(npcId))
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
