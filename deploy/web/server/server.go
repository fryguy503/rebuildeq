package server

import (
	//"encoding/json"
	//"fmt"
	"log"
	"net/http"
	//"os"
	//"strings"

	"github.com/xackery/rebuildeq/deploy/web/storage/database/sqlx"
	//restpkg "github.com/xackery/shinshop/webserver/rest"
	//"github.com/xackery/shinshop/webserver/web"
	//"github.com/xackery/shinshop/webserver/www"
)

func Start(addr string) {
	_, err := sqlx.New()
	if err != nil {
		log.Fatal("Failed to get database", err.Error())
	}

	//http.HandleFunc("/", router)
	log.Println("Listening on", addr)

	if err = http.ListenAndServe(addr, nil); err != nil {
		log.Fatal("Listen & Server failed:", err.Error())
	}
}

/*
func router(w http.ResponseWriter, r *http.Request) {
	var err error

	if len(r.RequestURI) == 0 {
		r.RequestURI = "/"
	}
	if r.RequestURI[len(r.RequestURI)-1:len(r.RequestURI)] != "/" {
		r.RequestURI += "/"
	}
	r.RequestURI = strings.ToLower(r.RequestURI)
	switch r.RequestURI {
	case "/":
		handleWebCore(w, r, web.Index)
	case "/api/":
		handleRestCore(w, r, restpkg.Index)
	default:
		//rest
		if strings.Contains("/api/", r.RequestURI) {
			rest := &restpkg.Rest{
				Status:  0,
				Message: "Invalid endpoint requested.",
			}
			if err = json.NewEncoder(w).Encode(rest); err != nil {
				err = fmt.Errorf("failed to encode json object: %s", err.Error())
			}
			return
		}

		//web
		if os.Getenv("SHINDEV") == "1" {
			http.FileServer(http.Dir("www/")).ServeHTTP(w, r)
		} else {
			http.FileServer(www.AssetFS()).ServeHTTP(w, r)
		}
		break
	}
}
*/
