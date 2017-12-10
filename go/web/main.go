package main

import (
	"log"

	"github.com/xackery/rebuildeq/go/web/server"
)

func main() {
	log.Println("Started server")
	go server.StartServer()
	select {}
}
