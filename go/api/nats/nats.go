package nats

import (
	"fmt"
	"log"
	"regexp"
	"strconv"
	"strings"
	"time"

	"github.com/golang/protobuf/proto"
	"github.com/nats-io/go-nats"
	"github.com/xackery/rebuildeq/go/eqproto"
)

func StartServer() (err error) {

	var nc *nats.Conn
	if nc, err = nats.Connect(nats.DefaultURL); err != nil {
		return
	}
	defer nc.Close()
	checkForNATSMessages(nc)
	select {}
}

func checkForNATSMessages(nc *nats.Conn) (err error) {
	nc.Subscribe("ChannelMessage", OnChannelMessage)
	nc.Subscribe("AdminMessage", OnAdminMessage)

	for {
		if nc.Status() != nats.CONNECTED {
			log.Println("[NATS] Disconnected, status is", nc.Status())
			break
		}
		time.Sleep(6000 * time.Second)
	}
	return
}

func OnAdminMessage(nm *nats.Msg) {
	channelMessage := &eqproto.ChannelMessage{}
	proto.Unmarshal(nm.Data, channelMessage)

	log.Printf("[NATS] AdminMessage: %s\n", channelMessage.Message)
}

func OnChannelMessage(nm *nats.Msg) {
	channelMessage := &eqproto.ChannelMessage{}
	proto.Unmarshal(nm.Data, channelMessage)

	if channelMessage.IsEmote {
		channelMessage.ChanNum = channelMessage.Type
	}

	channelMessage.From = strings.Replace(channelMessage.From, "_", " ", -1)

	if strings.Contains(channelMessage.From, " ") {
		channelMessage.From = fmt.Sprintf("%s [%s]", channelMessage.From[:strings.Index(channelMessage.From, " ")], channelMessage.From[strings.Index(channelMessage.From, " ")+1:])
	}
	channelMessage.From = alphanumeric(channelMessage.From) //purify name to be alphanumeric

	if strings.Contains(channelMessage.Message, "Summoning you to") { //GM messages are relaying to discord!
		return
	}

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

	log.Printf("[NATS] %d %s: %s\n", channelMessage.ChanNum, channelMessage.From, channelMessage.Message)
}

func convertLinks(prefix string, message string) (messageFixed string) {
	messageFixed = message
	if strings.Count(message, "") > 1 {
		sets := strings.SplitN(message, "", 3)

		itemid, err := strconv.ParseInt(sets[1][0:6], 16, 32)
		if err != nil {
			itemid = 0
		}
		itemname := sets[1][56:]
		itemlink := prefix
		if itemid > 0 && len(prefix) > 0 {
			itemlink = fmt.Sprintf(" %s%d (%s)", itemlink, itemid, itemname)
		} else {
			itemlink = fmt.Sprintf(" *%s* ", itemname)
		}
		messageFixed = sets[0] + itemlink + sets[2]
		if strings.Count(message, "") > 1 {
			messageFixed = convertLinks(prefix, messageFixed)
		}
	}
	return
}

func alphanumeric(data string) (sData string) {
	sData = data
	re := regexp.MustCompile("[^a-zA-Z0-9_]+")
	sData = re.ReplaceAllString(sData, "")
	return
}
