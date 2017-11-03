package listener

import (
	"fmt"
	"log"
	"strings"
	"time"

	"github.com/golang/protobuf/proto"
	"github.com/nats-io/go-nats"
	"github.com/xackery/eqemuconfig"
	"github.com/xackery/rebuildeq/go/discordnats/discord"
	"github.com/xackery/rebuildeq/go/eqproto"
)

var newNATS bool

var nc *nats.Conn

func GetNATS() (conn *nats.Conn) {
	conn = nc
	return
}

func ListenToNATS(eqconfig *eqemuconfig.Config, disco *discord.Discord) {
	var err error
	config = eqconfig
	channelID = config.Discord.ChannelID

	if err = connectNATS(config); err != nil {
		log.Println("[NATS] Warning while getting NATS connection:", err.Error())
		return
	}

	if err = checkForNATSMessages(nc, disco); err != nil {
		log.Println("[NATS] Warning while checking for messages:", err.Error())
	}
	nc.Close()
	nc = nil
	return
}

func connectNATS(config *eqemuconfig.Config) (err error) {
	if nc != nil {
		return
	}
	if nc, err = nats.Connect(nats.DefaultURL); err != nil {
		log.Fatal(err)
	}
	log.Printf("[NATS] Connected\n")
	return
}

func checkForNATSMessages(nc *nats.Conn, disco *discord.Discord) (err error) {

	chans := map[int]string{
		4:   "auctions:",
		5:   "OOC:",
		13:  "", //encounter
		15:  "", //system wide message
		256: "says:",
		260: "OOC:",
		261: "auctions:",
		263: "announcement:",
		269: "", //broadcast
	}
	var chanType string
	var ok bool

	nc.Subscribe("ChannelMessage", func(nm *nats.Msg) {
		channelMessage := &eqproto.ChannelMessage{}
		proto.Unmarshal(nm.Data, channelMessage)

		if channelMessage.IsEmote {
			channelMessage.ChanNum = channelMessage.Type
		}

		if chanType, ok = chans[int(channelMessage.ChanNum)]; !ok {
			log.Printf("[NATS] Unknown channel: %d with message: %s", channelMessage.ChanNum, channelMessage.Message)
			return
		}

		channelMessage.From = strings.Replace(channelMessage.From, "_", " ", -1)

		if strings.Contains(channelMessage.From, " ") {
			channelMessage.From = fmt.Sprintf("%s [%s]", channelMessage.From[:strings.Index(channelMessage.From, " ")], channelMessage.From[strings.Index(channelMessage.From, " ")+1:])
		}
		channelMessage.From = alphanumeric(channelMessage.From) //purify name to be alphanumeric

		//message = message[strings.Index(message, "says ooc, '")+11 : len(message)-padOffset]
		if channelMessage.ChanNum == 269 && strings.Contains(channelMessage.Message, "opened a box to find") {
			channelMessage.From = ":gift:"
			channelMessage.Message += " :gift:"
		}
		if channelMessage.ChanNum == 15 {
			channelMessage.From = ":loudspeaker:"
		}

		if channelMessage.ChanNum == 269 && strings.Contains(channelMessage.Message, "Welcome back to the server,") {
			channelMessage.From = ":hand_splayed::skin-tone-1:"
		}

		if channelMessage.ChanNum == 13 && strings.Contains(channelMessage.Message, "successfully stopped") {
			channelMessage.From = ":whale:"
			channelMessage.Message += " :crocodile:"
		}
		channelMessage.Message = convertLinks("", channelMessage.Message)

		if _, err = disco.SendMessage(channelID, fmt.Sprintf("**%s %s** %s", channelMessage.From, chanType, channelMessage.Message)); err != nil {
			log.Printf("[NATS] Error sending message (%s: %s) %s", channelMessage.From, channelMessage.Message, err.Error())
			return
		}

		log.Printf("[NATS] %d %s: %s\n", channelMessage.ChanNum, channelMessage.From, channelMessage.Message)
	})

	for {
		if nc.Status() != nats.CONNECTED {
			log.Println("[NATS] Disconnected, status is", nc.Status())
			break
		}
		time.Sleep(6000 * time.Second)
	}
	return
}

func sendNATSMessage(from string, message string) {
	if nc == nil {
		log.Println("[NATS] not connected?")
		return
	}
	channelMessage := &eqproto.ChannelMessage{
		//From:    from + " says from discord, '",
		IsEmote: true,
		Message: fmt.Sprintf("%s says from discord, '%s'", from, message),
		ChanNum: 260,
		Type:    260,
	}
	msg, err := proto.Marshal(channelMessage)
	if err != nil {
		log.Printf("[NATS] Error marshalling %s %s: %s", from, message, err.Error())
		return
	}
	err = nc.Publish("ChannelMessageWorld", msg)
	if err != nil {
		log.Printf("[NATS] Error publishing: %s", err.Error())
		return
	}
}
