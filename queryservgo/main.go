package main

import (
	//"encoding/binary"
	"fmt"
	"github.com/xackery/eqemuconfig"
	"net"
	//"strconv"
	"bytes"
	"github.com/lunixbochs/struc"
	"io"
	"strings"
	"time"
)

var config eqemuconfig.Config

//This isn't used yet, just a proof of concept
/*type ServerPacket struct {
	Size         uint32 //uint32 size
	Opcode       uint16 //uint16 opcode
	Uchar        byte   //uchar  *pBuffer
	Wpos         uint32 //uint32 _wpos
	Rpos         uint32 //uint32 _rpos
	Compressed   bool   //bool   compressed
	InflatedSize uint32 //uint32 InflatedSize
	Destination  uint32 //uint32 destination
}*/

type ServerPacket struct {
	Size         uint32 `struc:"uint32,little,sizeof=Buffer"` //uint32 size
	Precode      [1]byte
	Opcode       uint16 `struc:"uint16,little"` //uint16 opcode
	Buffer       string
	Wpos         uint32 `struc:"uint32,little"` //uint32 _wpos
	Rpos         uint32 `struc:"uint32,little"` //uint32 _rpos
	Compressed   bool   `struc:"bool,little"`   //bool   compressed
	InflatedSize uint32 `struc:"uint32,little"` //uint32 InflatedSize
	Destination  uint32 `struc:"uint32,little"` //uint32 destination*/
}

type ServerSpeechStruct struct {
	To        string `struc:"[64]byte"`      //stringchar	to[64];
	From      string `struct:"[64]byte"`     //char	from[64];
	GuildBid  uint32 `struc:"uint32,little"` //uint32	guilddbid;
	MinStatus int16  `struc:"int16,little"`  //int16	minstatus;
	Type      uint32 `struc:"uint32,little"` //uint32	type;
	Message   string //char	message[0];
}

/*
0X002A2A5041434B45544D4F444551532A -  **PACKETMODEQS*
*PACKETMODEQS*4B45544D4F444551532A - *
0X9D000000001345000000000000000000 - �    E
0X00000000000000000000000000000000 -
0X00000000000000000000000000000000 -
0X00000000000000000000000000000000 -
0X000000000000005861636B6572790000 -        Xackery
0X00000000000000000000000000000000 -
0X00000000000000000000000000000000 -
0X00000000000000000000000000000000 -
0X00000000000000000000002C01050000 -            ,
0X0054657374696E672E31323300050000 -  Testing.123 
*/

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

	conn.Write(makeModePacket())
	conn.Write(makeAuthPacket())
	go readInbound(conn)
	select {}

}

func readInbound(conn net.Conn) {
	packet := make([]byte, 1024)
	conn.Read(packet) //When this starts there's always a single echo back that can be discarded..
	for {
		time.Sleep(100 * time.Millisecond)
		_, err := conn.Read(packet)
		if err != nil {
			if err == io.EOF {
				continue
			}
			fmt.Println("Error reading packet:", err.Error())
			return
		}
		var buf *bytes.Buffer
		buf = bytes.NewBuffer(packet)
		sp := &ServerPacket{}
		err = struc.Unpack(buf, sp)
		if err != nil {
			fmt.Printf("Error unpacking server packet, Opcode: %#x: %s\n", sp.Opcode, err.Error())
			//fmt.Printf("Size: %u, Opcode: %#x, Buffer: %s\n\n", sp.Size, sp.Opcode, sp.Buffer)
			//fmt.Printf("%#X - %s\n", packet, string(packet))
			continue
		}
		switch sp.Opcode {
		case ServerOP_Speech:
			fmt.Println("Speech", sp.Buffer)
			speech := &ServerSpeechStruct{}
			buf = bytes.NewBufferString(sp.Buffer)
			err = struc.Unpack(buf, speech)
			speech.From = strings.Trim(speech.From, "\x00")
			speech.To = strings.Trim(speech.To, "\x00")
			fmt.Printf("Speech struct: From %s, To %s, Message %s, Type: %u, Misc %v\n", speech.From, speech.To, speech.Message, speech.Type, speech)
		default:
			fmt.Printf("Unknown Packet Size: %u, Opcode: %#x, Buffer: %s\n\n", sp.Size, sp.Opcode, sp.Buffer)
		}
	}
}

func makeModePacket() (modePacket []byte) {
	modePacket = make([]byte, 18)
	modePacket[0] = 0
	out := []byte("**PACKETMODEQS**")
	for i, b := range out {
		modePacket[i+1] = b
	}
	modePacket[17] = 0x0d
	return
}

func makeAuthPacket() (authPacket []byte) {
	authPacket = make([]byte, 23)
	authPacket[0] = 0x17
	authPacket[1] = 0x0
	authPacket[2] = 0x0
	authPacket[3] = 0x0
	authPacket[4] = 0x0
	authPacket[5] = 0x25
	authPacket[6] = 0x0
	authPacket[7] = 0x6c
	authPacket[8] = 0xe6
	authPacket[9] = 0x0a
	authPacket[10] = 0xcd
	authPacket[11] = 0xde
	authPacket[12] = 0x9f
	authPacket[13] = 0x9d
	authPacket[14] = 0x47
	authPacket[15] = 0x3c
	authPacket[16] = 0x4c
	authPacket[17] = 0x06
	authPacket[18] = 0x68
	authPacket[19] = 0xe5
	authPacket[20] = 0x05
	authPacket[21] = 0x54
	authPacket[22] = 0x09
	return
}
