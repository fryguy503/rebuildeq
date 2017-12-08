package main

import (
	"log"

	"github.com/xackery/rebuildeq/go/api/nats"
	"github.com/xackery/rebuildeq/go/api/rest"
	"github.com/xackery/rebuildeq/go/api/storage/mariadb"
)

func main() {
	api := &mariadb.Api{}
	go rest.StartServer(api)
	go nats.StartServer(api)
	log.Println("started")
	select {}
}
