package main

import (
	"net/http"

	"github.com/gorilla/mux"
	"github.com/xackery/rebuildeq/go/web/swagger"
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
		handler = swagger.Logger(handler, route.Name)
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
}
