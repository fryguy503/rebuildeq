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

var routes = Routes{
	Route{
		"Index",
		"GET",
		"//",
		Index,
	},
	/*
		Route{
			"Login",
			"GET",
			"//login",
			Login,
		},
	*/
	Route{
		"GetCalendar",
		"GET",
		"//calendar",
		GetCalendar,
	},
	/*
		Route{
			"CreateSchedule",
			"POST",
			"//scheduling/",
			CreateSchedule,
		},

		Route{
			"GetSchedule",
			"GET",
			"//scheduling/{id}",
			GetSchedule,
		},

		Route{
			"ListSchedule",
			"GET",
			"//scheduling/",
			ListSchedule,
		},

		Route{
			"UpdateSchedule",
			"PUT",
			"//scheduling/",
			UpdateSchedule,
		},

		Route{
			"GetUser",
			"GET",
			"//user/{id}",
			GetUser,
		},
	*/
}
