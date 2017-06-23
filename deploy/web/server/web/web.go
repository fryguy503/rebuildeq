package web

import (
	"log"
	"net/http"
	"os"
	//"strings"
)

func Initialize() (err error) {
	if err = ReloadTemplates(); err != nil {
		return
	}
	return
}

func HandleWebCore(w http.ResponseWriter, r *http.Request, handler func(http.ResponseWriter, *http.Request) (err error)) {
	var err error

	err = Index(w, r)
	if err != nil {
		log.Println("index:", err)
	}
	return
	/*if strings.Index(r.RequestURI, "/index") == 0 {
		err = Index(w, r)
		if err != nil {
			log.Println("index:", err)
		}
	}*/
	//if err = handler(w, r); err != nil {
	//	log.Println("WebCore", err.Error())
	//	failSafeRoute(w, r)
	//	return
	//}

	/*
		switch r.RequestURI {
		case "/":
			web.HandleWebCore(w, r, web.Index)
		case "/api/":
			api.HandleApiCore(w, r, api.Index)
		default:
			web.HandleWebCore(w, r, web.Index)

			//rest
			if strings.Contains("/api/", r.RequestURI) {
				rest := &api.Rest{
					Status:  404,
					Message: "Endpoint not found.",
				}
				if err = json.NewEncoder(w).Encode(rest); err != nil {
					err = fmt.Errorf("failed to encode json object: %s", err.Error())
				}
				return
			}
			//web
			http.FileServer(http.Dir("./static/")).ServeHTTP(w, r)

			break
		}*/

	failSafeRoute(w, r)

	return
}

func failSafeRoute(w http.ResponseWriter, r *http.Request) {
	log.Println("static" + r.RequestURI)
	if _, err := os.Stat("static" + r.RequestURI); os.IsNotExist(err) {
		//404
	}
	http.FileServer(http.Dir("static/")).ServeHTTP(w, r)
	return
}
