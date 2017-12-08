package server 

import (
	"net/http"
	"fmt"
	"github.com/gorilla/mux"
)

type Route struct {
	Name        string
	Method      string
	Pattern     string
	HandlerFunc http.HandlerFunc
}

type Routes []Route

func NewRouter() *mux.Router {
	router := mux.NewRouter().StrictSlash(true)
	for _, route := range routes {
		var handler http.Handler
		handler = route.HandlerFunc
		handler = Logger(handler, route.Name)

		router.
			Methods(route.Method).
			Path(route.Pattern).
			Name(route.Name).
			Handler(handler)
	}

	return router
}

func Index(w http.ResponseWriter, r *http.Request) {
	fmt.Fprintf(w, "Hello World!")
}

var routes = Routes{
	Route{
		"Index",
		"GET",
		"/",
		Index,
	},

	Route{
		"PostLogin",
		"POST",
		"/login",
		PostLogin,
	},

	Route{
		"GetSpentBuildPoints",
		"GET",
		"/builds/{id}",
		GetSpentBuildPoints,
	},

	Route{
		"TrainBuildPoint",
		"PUT",
		"/build/{id}",
		TrainBuildPoint,
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
