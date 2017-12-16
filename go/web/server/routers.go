package server

import (
	"net/http"

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
		"GetZoneSearch",
		"GET",
		"/zone/search",
		GetZoneSearch,
	},

	Route{
		"GetZoneChart",
		"GET",
		"/zone/chart",
		GetZoneChart,
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

	Route{
		"GetBuild",
		"GET",
		"/build/{id}",
		GetBuild,
	},

	Route{
		"GetBuild",
		"GET",
		"/build",
		GetBuild,
	},

	Route{
		"GetZone",
		"GET",
		"/zone",
		GetZone,
	},

	Route{
		"GetGuideGettingStarted",
		"GET",
		"/guide/getting-started",
		GetGuideGettingStarted,
	},

	Route{
		"GetGuideEncounterSystem",
		"GET",
		"/guide/encounter-system",
		GetGuideEncounterSystem,
	},

	Route{
		"GetGuideFAQ",
		"GET",
		"/guide/faq",
		GetGuideFAQ,
	},
}
