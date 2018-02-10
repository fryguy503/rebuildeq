package main

import (
	"fmt"
	"log"
	"strconv"
	"strings"
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
	//go testAsyncSubscriber()
	//go testBroadcastMessage()
	//testAsyncSubscriber("EntityEvent")
	go testAsyncEntityEventSubscriber("ecommons")
	//testZoneMessage("fieldofbone", "hello, world!")
	time.Sleep(1000 * time.Second)
}

func testAsyncSubscriber(channel string) {
	nc.Subscribe(channel, func(m *nats.Msg) {
		log.Printf("Received a message: %s\n", string(m.Data))
	})
	log.Println("Waiting on messages...")

	time.Sleep(500 * time.Second)
}

func testAsyncEntityEventSubscriber(zone string) {

	/*event := &eqproto.EntityEvent{
		Entity: &eqproto.Entity{
			Id: 1,
		},
	}
	d, err := proto.Marshal(event)
	if err != nil {
		log.Fatal(err)
	}
	if err = nc.Publish(fmt.Sprintf("zone.%s.entity.event_subscribe.all", zone), d); err != nil {
		log.Println("Failed to publish event subscribe:", err.Error())
		return
	}*/

	var opCode int64
	var index int
	nc.Subscribe(fmt.Sprintf("zone.%s.entity.event.*", zone), func(m *nats.Msg) {

		//Every event is identified by the first chunk. split it to get opcode.
		index = strings.Index(string(m.Data), "|")
		if index < 1 {
			fmt.Println("Invalid data passed (no | delimiter):", m.Data)
			return
		}

		opCode, err = strconv.ParseInt(string(m.Data[0:index]), 10, 64)
		if err != nil {
			fmt.Println("Invalid opcode passed", m.Data)
			return
		}

		var event proto.Message
		switch eqproto.OpCode(opCode) {
		case eqproto.OpCode_OP_ClientUpdate:
			event = &eqproto.PlayerPositionUpdateEvent{}
		case eqproto.OpCode_OP_Animation:
			event = &eqproto.AnimationEvent{}
		case eqproto.OpCode_OP_NewSpawn:
			event = &eqproto.SpawnEvent{}
		case eqproto.OpCode_OP_ZoneEntry:
			event = &eqproto.SpawnEvent{}
		case eqproto.OpCode_OP_HPUpdate:
			event = &eqproto.HPEvent{}
		case eqproto.OpCode_OP_MobHealth:
			event = &eqproto.HPEvent{}
		case eqproto.OpCode_OP_DeleteSpawn:
			event = &eqproto.DeleteSpawnEvent{}
		case eqproto.OpCode_OP_Damage:
			event = &eqproto.DamageEvent{}
		default:
			return
		}
		err = proto.Unmarshal(m.Data[index+1:], event)
		if err != nil {
			fmt.Println("Invalid data passed for opcode", eqproto.OpCode(opCode), err.Error(), string(m.Data[index+1:]))
			return
		}
		fmt.Println(eqproto.OpCode(opCode), event)
		//log.Printf("Received a message on %s: %s\n", m.Subject, string(m.Data))

		//proto.Unmarshal(m.Data, event)
		//log.Println(event.Op.String(), event.Entity, event.Target)
	})
	log.Println("Waiting on messages...")

	time.Sleep(500 * time.Second)
}

func testAsyncChannelMessageSubscriber() {
	nc.Subscribe("ChannelMessageWorld", func(m *nats.Msg) {
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
		ChanNum: 5, //5 is ooc, 6 is bc
	}
	d, err := proto.Marshal(message)
	if err != nil {
		log.Fatal(err)
	}
	if err = nc.Publish("ChannelMessageWorld", d); err != nil {
		log.Println("Failed to publish:", err.Error())
		return
	}
	log.Println("Sending message", message)
}

func testZoneMessage(zone string, message string) {

	if err = nc.Publish(zone, []byte(message)); err != nil {
		log.Println("Failed to publish:", err.Error())
		return
	}
	log.Println("Sent message", message, "to zone", zone)
}
