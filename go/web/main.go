package main

import (
	"github.com/xackery/rebuildeq/go/web/server"
)

func main() {
	go server.StartServer()
	select {}
}
