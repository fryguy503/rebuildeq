package main

import (
	"log"

	"github.com/xackery/rebuildeq/go/api/nats"
	"github.com/xackery/rebuildeq/go/api/rest"
	"github.com/xackery/rebuildeq/go/api/storage/mariadb"
)

func main() {
	storage := &mariadb.Storage{}
	go rest.StartServer(storage)
	go nats.StartServer(storage)
	log.Println("started")
	select {}
}
