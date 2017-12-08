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
		"GetCharacters",
		"GET",
		"/characters",
		GetCharacters,
	},

	Route{
		"GetCharacter",
		"GET",
		"/character/{id}",
		GetCharacter,
	},

	Route{
		"GetZone",
		"GET",
		"/zone/{id}",
		GetZone,
	},

	Route{
		"GetNPC",
		"GET",
		"/npc/{id}",
		GetNPC,
	},

	Route{
		"GetItem",
		"GET",
		"/item/{id}",
		GetItem,
	},

	Route{
		"GetInventory",
		"GET",
		"/inventory/{id}",
		GetInventory,
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
}
