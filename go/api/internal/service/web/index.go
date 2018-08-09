package web

import (
	"net/http"

	"github.com/xackery/rebuildeq/go/eqproto"
)

func (s *Service) indexRoutes() (routes []*route) {
	routes = []*route{
		{
			"Index",
			"GET",
			"/",
			s.index,
		},
	}
	return
}

// Index handles the root endpoint of /api/
func (s *Service) index(w http.ResponseWriter, r *http.Request, user *eqproto.User, statusCode int) (content interface{}, err error) {
	type Content struct {
		Message string
	}

	content = &Content{
		Message: "Index",
	}
	return
}
