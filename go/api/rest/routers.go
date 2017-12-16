package rest

import (
	"net/http"

	"github.com/gorilla/mux"
	"github.com/xackery/rebuildeq/go/swagger/server"
)

type Route struct {
	Name        string
	Method      string
	Pattern     string
	HandlerFunc http.HandlerFunc
}

type Routes []Route

//Apply new routes based on override
func ApplyRoutes(router *mux.Router) {
	if router == nil {
		return
	}
	for _, route := range routes {
		var handler http.Handler
		handler = route.HandlerFunc
		handler = server.Logger(handler, route.Name)
		r := router.GetRoute(route.Name)
		r.Handler(handler)
		//fmt.Println("overrode " + route.Name)
	}
	return
}

//Define routes you want to override here
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
		"/changelog/{id}/detail",
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
		"/npc/{id}/detail",
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
