package main

import ()

type ServerChannelMessage struct {
	DeliverTo string `struc:"[64]byte,little"`  //char deliverto[64];
	To        string `struc:"[64]byte,little"`  //char to[64];
	From      string `struc:"[64]byte,little"`  //char from[64];
	FromAdmin uint8  `struc:"uint8,little"`     //uint8 fromadmin;
	NoReply   bool   `struc:"bool,little"`      //bool noreply;
	ChanNum   uint16 `struc:"uint16,little"`    //uint16 chan_num;
	GuildDBId uint32 `struc:"uint32,little"`    //uint32 guilddbid;
	Language  uint16 `struc:"uint16,little"`    //uint16 language;
	Queued    uint8  `struc:"uint8,little"`     //uint8 queued; // 0 = not queued, 1 = queued, 2 = queue full, 3 = offline
	Message   string `struc:"[511]byte,little"` //char message[0];
}

type ServerPacket struct {
	Size         uint32  `struc:"uint32,little,sizeof=Buffer"` //uint32 size
	Precode      [1]byte //this is an odd padding issue
	Opcode       uint16  `struc:"uint16,little"` //uint16 opcode
	Buffer       string
	Wpos         uint32 `struc:"uint32,little"` //uint32 _wpos
	Rpos         uint32 `struc:"uint32,little"` //uint32 _rpos
	Compressed   bool   `struc:"bool,little"`   //bool   compressed
	InflatedSize uint32 `struc:"uint32,little"` //uint32 InflatedSize
	Destination  uint32 `struc:"uint32,little"` //uint32 destination*/
}

type ServerPacketOut struct {
	Size    uint32  `struc:"uint32,little,sizeof=Buffer"` //uint32 size
	Precode [1]byte //this is an odd padding issue
	Opcode  uint16  `struc:"uint16,little"` //uint16 opcode
	Buffer  []byte
}

type ServerSpeech struct {
	To        string `struc:"[64]byte,little"`  //stringchar	to[64];
	From      string `struc:"[64]byte,little"`  //char	from[64];
	GuildDBId uint   `struc:"uint32,little"`    //uint32	guilddbid;
	MinStatus int    `struc:"int16,little"`     //int16	minstatus;
	Type      uint   `struc:"uint32,little"`    //uint32	type;
	Message   string `struc:"[511]byte,little"` //char	message[0];
}

type ServerMotd struct {
	MyName string `struc:"[64]byte,little"`  //char	myname[64]; // User that set the motd
	Motd   string `struc:"[512]byte,little"` //char	motd[512]; // the new MoTD
}
