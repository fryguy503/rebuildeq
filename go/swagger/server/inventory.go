package server 

import (
	"net/http"
)

type Inventory struct {

}

func ListInventory(w http.ResponseWriter, r *http.Request) {
		w.Header().Set("Content-Type", "application/json; charset=UTF-8")
		w.WriteHeader(http.StatusOK)
}

