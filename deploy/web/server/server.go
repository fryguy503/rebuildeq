package server

import (
	//"encoding/json"
	//"fmt"
	"log"
	"net/http"
	//"os"

	"github.com/xackery/rebuildeq/deploy/web/server/web"
	"github.com/xackery/rebuildeq/deploy/web/storage/database/sqlx"
)

func Start(addr string) {
	_, err := sqlx.New()
	if err != nil {
		log.Fatal("Failed to get database", err.Error())
	}

	if err = web.Initialize(); err != nil {
		log.Fatal("Error initializing web", err.Error())
	}

	http.HandleFunc("/", web.Route)
	log.Println("Listening on", addr)

	if err = http.ListenAndServe(addr, nil); err != nil {
		log.Fatal("Listen & Server failed:", err.Error())
	}
}
