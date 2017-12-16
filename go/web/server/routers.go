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
		"/changelog/{changelogId}/detail",
		GetChangelog,
	},

	Route{
		"ListChangelog",
		"GET",
		"/changelog",
		ListChangelog,
	},

	Route{
		"GetCharacter",
		"GET",
		"/character/{characterId}/detail",
		GetCharacter,
	},

	Route{
		"ListCharacter",
		"GET",
		"/character",
		ListCharacter,
	},

	Route{
		"ListZoneSearch",
		"GET",
		"/zone/search",
		ListZoneSearch,
	},

	Route{
		"ListZoneChart",
		"GET",
		"/zone/chart",
		ListZoneChart,
	},

	Route{
		"ListInventory",
		"GET",
		"/character/{characterId}/inventory",
		ListInventory,
	},

	Route{
		"GetItem",
		"GET",
		"/item/{itemId}/detail",
		GetItem,
	},

	Route{
		"GetNPC",
		"GET",
		"/npc/{npcId}/detail",
		GetNPC,
	},

	Route{
		"GetZone",
		"GET",
		"/zone/{zoneId}/detail",
		GetZone,
	},

	Route{
		"ListBuild",
		"GET",
		"/character/{chracterId}/build",
		ListBuild,
	},

	Route{
		"ListBuild",
		"GET",
		"/build/{chracterId}/detail",
		ListBuild,
	},

	Route{
		"ListZoneChart",
		"GET",
		"/zone/chart",
		ListZoneChart,
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
