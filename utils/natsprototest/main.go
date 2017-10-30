package main

import (
	"fmt"
	//"time"

	"github.com/nats-io/go-nats"
)

func main() {
	var err error
	nc, _ := nats.Connect(nats.DefaultURL)
	defer nc.Close()

	// Simple Publisher
	if err = nc.Publish("pojustice", []byte("Hello World")); err != nil {
		fmt.Println("Failed to publish:", err.Error())
		return
	}
	fmt.Println("test: hello World")

	// Simple Async Subscriber
	/*nc.Subscribe("test", func(m *nats.Msg) {
		fmt.Printf("Received a message: %s\n", string(m.Data))
	})

	time.Sleep(500 * time.Second)
	*/
	return

	// Simple Sync Subscriber
	//sub, err := nc.SubscribeSync("foo")
	//m, err := sub.NextMsg(timeout)

	// Channel Subscriber
	/*ch := make(chan *nats.Msg, 64)
	sub, err := nc.ChanSubscribe("test", ch)
	if err != nil {
		fmt.Println("Error subscribing", err.Error())
		return
	}
	msg := <-ch*/

	// Unsubscribe
	//sub.Unsubscribe()

	// Requests
	//msg, err := nc.Request("help", []byte("help me"), 10*time.Millisecond)

	// Replies
	//nc.Subscribe("help", func(m *Msg) {
	//	nc.Publish(m.Reply, []byte("I can help!"))
	//})

}
