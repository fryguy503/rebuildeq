package web

import (
	"net/http"
	"strings"

	"github.com/xackery/rebuildeq/deploy/web/server/api"
)

func Route(w http.ResponseWriter, r *http.Request) {

	r.RequestURI = strings.ToLower(r.RequestURI)
	if strings.Index(r.RequestURI, "/api/") == 0 {
		api.HandleApiCore(w, r, api.Index)
		return
	}
	HandleWebCore(w, r, Index)
	return
}
