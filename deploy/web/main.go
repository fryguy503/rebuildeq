package main

import (
	"log"
	"os"
	"os/signal"

	"github.com/xackery/rebuildeq/deploy/web/server"
)

var onServerError chan bool

func main() {
	go server.Start(":8080")

	onOSSignal := make(chan os.Signal, 10)
	signal.Notify(onOSSignal, os.Interrupt, os.Kill)

	select {
	case err := <-onServerError:
		log.Printf("Exiting due to server error:")
		log.Print(err)
		os.Exit(1)
	case sig := <-onOSSignal:
		log.Printf("Exiting due to OS signal (signal = %q).", sig)
	}

}
