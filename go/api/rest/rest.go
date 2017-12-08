package rest

import (
	"fmt"
	"log"
	"net/http"

	"github.com/xackery/rebuildeq/go/api/storage"
	"github.com/xackery/rebuildeq/go/swagger/server"
)

var api storage.Storage

func StartServer(s storage.Storage) {
	log.Println("Started server")
	api = s
	router := server.NewRouter()
	ApplyRoutes(router)

	log.Fatal(http.ListenAndServe(":8901", router))
}

func Index(w http.ResponseWriter, r *http.Request) {
	fmt.Fprintf(w, "Please contact Shin on discord to learn more about the API.")
}
