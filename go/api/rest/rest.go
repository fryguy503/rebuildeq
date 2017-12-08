package rest

import (
	"fmt"
	"log"
	"net/http"

	"github.com/xackery/rebuildeq/go/api/rest/swagger"
)

func StartServer() {
	log.Println("Started server")

	router := swagger.NewRouter()
	ApplyRoutes(router)

	log.Fatal(http.ListenAndServe(":8901", router))
}

func Index(w http.ResponseWriter, r *http.Request) {
	fmt.Fprintf(w, "Hello World 2!")
}
