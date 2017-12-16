package rest

import (
	"net/http"
	"strconv"

	"github.com/gorilla/mux"
)

func GetCharacter(w http.ResponseWriter, r *http.Request) {
	var err error
	vars := mux.Vars(r)
	id, err := strconv.Atoi(vars["characterId"])
	if err != nil {
		returnError(w, r, err.Error(), http.StatusInternalServerError)
		return
	}

	c, err := api.GetCharacter(id)
	if err != nil {
		returnError(w, r, err.Error(), http.StatusInternalServerError)
		return
	}

	returnData(w, r, c, http.StatusOK)
}

func ListCharacter(w http.ResponseWriter, r *http.Request) {
	var err error

	claims, err := getAuthClaims(r)
	if err != nil {
		returnError(w, r, err.Error(), http.StatusUnauthorized)
		return
	}

	c, err := api.GetCharacters(claims.AccountId)
	if err != nil {
		returnError(w, r, err.Error(), http.StatusExpectationFailed)
		return
	}

	returnData(w, r, c, http.StatusOK)
}
