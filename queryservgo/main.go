package main

import (
	//"encoding/binary"
	"fmt"
	"github.com/xackery/eqemuconfig"
	"net"
	"strconv"
	"strings"
)

var config eqemuconfig.Config

//This isn't used yet, just a proof of concept
type ServerPacket struct {
	Size         uint32 //uint32 size
	Opcode       uint16 //uint16 opcode
	Uchar        byte   //uchar  *pBuffer
	Wpos         uint32 //uint32 _wpos
	Rpos         uint32 //uint32 _rpos
	Compressed   bool   //bool   compressed
	InflatedSize uint32 //uint32 InflatedSize
	Destination  uint32 //uint32 destination
}

func main() {
	//Load config in same directory
	config, err := eqemuconfig.GetConfig()
	if err != nil {
		fmt.Println("Error loading config:", err.Error())
		return
	}
	fmt.Println("Connecting to", config.World.Tcp.Ip+":"+config.World.Tcp.Port)
	conn, err := net.Dial("tcp", config.World.Tcp.Ip+":"+config.World.Tcp.Port)
	if err != nil {
		fmt.Println("Error connecting:", err.Error())
		return
	}
	//The auth packet seems to be 0x0025, but this is failing.
	conn.Write([]byte(strconv.Itoa(0x0025)))
	packet := make([]byte, 16)

	for {

		_, err := conn.Read(packet)
		if err != nil {
			fmt.Println("Error reading packet:", err.Error())
			return
		}
		//There's logic to fallback to console when the packet isn't sent proper.
		if strings.Contains(string(packet), "Username:") {
			conn.Write([]byte(strconv.Itoa(4)))
			fmt.Println("Sending Packet Username attempt")
		} else {
			//Raw dump of any packets received
			fmt.Printf("%#X - %s", packet, string(packet))
			//fmt.Println(n, strings.TrimSpace(string(packet)), packet)
		}
	}
}
