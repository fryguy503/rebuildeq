package swagger 

import (
	"net/http"
)

type Character struct {

}

func GetCharacters(w http.ResponseWriter, r *http.Request) {
		w.Header().Set("Content-Type", "application/json; charset=UTF-8")
		w.WriteHeader(http.StatusOK)
}

