package main

import (
	"log"
	"time"

	"github.com/golang/protobuf/proto"
	"github.com/nats-io/go-nats"
	"github.com/xackery/rebuildeq/go/eqproto"
)

var (
	nc  *nats.Conn
	err error
)

func main() {

	if nc, err = nats.Connect(nats.DefaultURL); err != nil {
		log.Fatal(err)
	}
	defer nc.Close()

	//testSyncSubscriber()
	//testAsyncSubscriber()
	testBroadcastMessage()
	time.Sleep(1000 * time.Second)
}

func testPublish() {
	if err = nc.Publish("ChannelMessage", []byte("Hello World")); err != nil {
		log.Println("Failed to publish:", err.Error())
		return
	}
	log.Println("test: hello World")
}

func testAsyncSubscriber() {
	nc.Subscribe("ChannelMessage", func(m *nats.Msg) {
		//log.Printf("Received a message: %s\n", string(m.Data))
		message := &eqproto.ChannelMessage{}
		proto.Unmarshal(m.Data, message)
		log.Println(message)
	})
	log.Println("Waiting on messages...")

	time.Sleep(500 * time.Second)
}

func testSyncSubscriber() {
	sub, err := nc.SubscribeSync("ChannelMessage")
	if err != nil {
		log.Fatal(err)
	}

	if m, err := sub.NextMsg(10 * time.Second); err != nil {
		log.Fatal(err)
	} else {
		log.Println(m)
	}
}

func testChannelSubscriber() {
	ch := make(chan *nats.Msg, 64)
	sub, err := nc.ChanSubscribe("ChannelMessage", ch)
	if err != nil {
		log.Println("Error subscribing", err.Error())
		return
	}
	msg := <-ch
	log.Println(sub, msg)
}

/*
func testRequestReply() {
	msg, err := nc.Request("help", []byte("help me"), 10*time.Millisecond)
	nc.Subscribe("help", func(m *Msg) {
		nc.Publish(m.Reply, []byte("I can help!"))
	})
}*/

func testBroadcastMessage() {
	message := &eqproto.ChannelMessage{
		From:    "Someone",
		Message: "Test",
		ChanNum: 6, //5 is ooc, 6 is bc
	}
	d, err := proto.Marshal(message)
	if err != nil {
		log.Fatal(err)
	}
	if err = nc.Publish("ChannelMessage", d); err != nil {
		log.Println("Failed to publish:", err.Error())
		return
	}
	log.Println("Sending message", message)
}
