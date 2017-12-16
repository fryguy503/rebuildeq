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
		"ListBuild",
		"GET",
		"/character/{characterId}/build",
		ListBuild,
	},

	Route{
		"TrainBuild",
		"PUT",
		"/character/{characterId}/build/{buildId}/detail",
		TrainBuild,
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
		"ListItemNPC",
		"GET",
		"/item/{itemId}/npc",
		ListItemNPC,
	},

	Route{
		"GetZone",
		"GET",
		"/zone/{zoneId}/detail",
		GetZone,
	},

	Route{
		"ListZoneChart",
		"GET",
		"/zone/chart",
		ListZoneChart,
	},

	Route{
		"ListZoneSearch",
		"GET",
		"/zone/search",
		ListZoneSearch,
	},

}
