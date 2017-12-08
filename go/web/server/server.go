package server

import (
	"fmt"
	"log"
	"net/http"

	"github.com/gorilla/mux"
	"github.com/xackery/rebuildeq/go/swagger/client"
)

var (
	api *client.APIClient
)

//Global variables loaded to most templates
type Site struct {
	Title string //Title of site
}

type Route struct {
	Name        string
	Method      string
	Pattern     string
	HandlerFunc http.HandlerFunc
}

type Routes []Route

func StartServer() {

	cfg := client.NewConfiguration()
	cfg.BasePath = "http://127.0.0.1:8901"
	api = client.NewAPIClient(cfg)
	router := NewRouter()
	router.StrictSlash(false)

	log.Fatal(http.ListenAndServe(":8080", router))
}

func Index(w http.ResponseWriter, r *http.Request) {

	fmt.Fprintf(w, "Please contact Shin on discord to learn more about the API.")
}

func NewRouter() *mux.Router {
	router := mux.NewRouter().StrictSlash(true)
	for _, route := range routes {
		var handler http.Handler
		handler = route.HandlerFunc
		//handler = serevr.Logger(handler, route.Name)

		router.
			Methods(route.Method).
			Path(route.Pattern).
			Name(route.Name).
			Handler(handler)
	}

	router.PathPrefix("/").Handler(http.StripPrefix("/", http.FileServer(http.Dir("www"))))

	return router
}

var routes = Routes{
	Route{
		"Index",
		"GET",
		"/",
		Index,
	},

	Route{
		"GetChangelog",
		"GET",
		"/changelog/{id}",
		GetChangelog,
	},

	Route{
		"GetChangelogs",
		"GET",
		"/changelogs",
		GetChangelogs,
	},

	Route{
		"GetCharacter",
		"GET",
		"/character/{id}",
		GetCharacter,
	},

	Route{
		"GetCharacters",
		"GET",
		"/characters",
		GetCharacters,
	},

	Route{
		"GetInventory",
		"GET",
		"/inventory/{id}",
		GetInventory,
	},

	Route{
		"GetItem",
		"GET",
		"/item/{id}",
		GetItem,
	},

	Route{
		"GetNPC",
		"GET",
		"/npc/{id}",
		GetNPC,
	},

	Route{
		"GetZone",
		"GET",
		"/zone/{id}",
		GetZone,
	},
}
