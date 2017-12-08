package main

import (
	"log"

	"github.com/xackery/rebuildeq/go/api/nats"
	"github.com/xackery/rebuildeq/go/api/rest"
)

func main() {
	go rest.StartServer()
	go nats.StartServer()
	log.Println("started")
	select {}
}
