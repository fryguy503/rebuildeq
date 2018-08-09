package web

import (
	"log"
	"net/http"
	"time"

	"github.com/gorilla/mux"
	"github.com/xackery/rebuildeq/go/eqproto"
	"github.com/xackery/xegony/cases"
)

type route struct {
	Name        string
	Method      string
	Pattern     string
	HandlerFunc func(w http.ResponseWriter, r *http.Request, user *eqproto.User, statusCode int) (content interface{}, err error)
}

func (s *Service) applyRoutes(router *mux.Router) {
	rootPath := cases.GetConfigValue("apiSuffix")

	var routes []*route

	routes = append(routes, s.indexRoutes()...)
	routes = append(routes, s.buildRoutes()...)

	for i := range routes {
		route := routes[i]
		router.
			Methods(route.Method).
			Name(route.Name).
			Path(rootPath + route.Pattern).
			Handler(http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
				start := time.Now()

				auth, err := s.getAuthClaim(r)
				user := &eqproto.User{}
				if err == nil {
					user = auth.user
				}

				statusCode := http.StatusOK
				content, err := route.HandlerFunc(w, r, user, statusCode)
				if err != nil {
					s.writeError(w, r, err, statusCode)
				} else {
					s.writeData(w, r, content, statusCode)
				}
				log.Printf(
					"%s %s: %s in %s",
					r.Method,
					r.RequestURI,
					route.Name,
					time.Since(start),
				)
			}))
	}

	return
}
