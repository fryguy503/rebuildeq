#include "nats_manager.h"
#include "nats.h"
#include "zonelist.h"
#include "../common/eqemu_logsys.h"
#include "../common/proto/channelmessage.pb.h"
#include "../common/servertalk.h"
extern ZSList zoneserver_list;

NatsManager::NatsManager()
{
	//new timers, object initialization
}

NatsManager::~NatsManager()
{
	// Destroy all our objects to avoid report of memory leak
	natsStatistics_Destroy(stats);
	natsConnection_Destroy(conn);
	natsOptions_Destroy(opts);

	// To silence reports of memory still in used with valgrind
	nats_Close();
}


//This doesn't work. It seems to loop once or twice then stop.
void NatsManager::Process()
{	
	natsMsg *msg = NULL;
	s = NATS_OK;
	for (int count = 0; (s == NATS_OK) && count < 5; count++)
	{
		s = natsSubscription_NextMsg(&msg, testSub, 1);
		if (s != NATS_OK) break;
		Log(Logs::General, Logs::World_Server, "Got Message '%s'", natsMsg_GetData(msg));
		natsMsg_Destroy(msg);
	}
	s = NATS_OK;
	for (int count = 0; (s == NATS_OK) && count < 5; count++)
	{
		s = natsSubscription_NextMsg(&msg, channelMessageSub, 1);
		if (s != NATS_OK) break;
		Log(Logs::General, Logs::World_Server, "Got Broadcast Message '%s'", natsMsg_GetData(msg));
		eqproto::ChannelMessage message;
		if (!message.ParseFromString(natsMsg_GetData(msg))) {
			Log(Logs::General, Logs::World_Server, "Failed to marshal");
			natsMsg_Destroy(msg);
			continue;
		}
		ChannelMessageEvent(&message);
	}
}

void NatsManager::OnChannelMessage(ServerChannelMessage_Struct* msg) {
	if (!conn) {
		Log(Logs::General, Logs::World_Server, "OnChannelMessage failed, no connection to NATS");
		return;
	}

	eqproto::ChannelMessage message;
	
	message.set_fromadmin(msg->fromadmin);
	message.set_deliverto(msg->deliverto);
	message.set_guilddbid(msg->guilddbid);
	message.set_noreply(msg->noreply);
	message.set_queued(msg->queued);
	message.set_chan_num(msg->chan_num);
	message.set_message(msg->message);
	message.set_to(msg->to);
	message.set_language(msg->language);
	message.set_from(msg->from);
	SendChannelMessage(&message);
	return;
}

void NatsManager::OnEmoteMessage(ServerEmoteMessage_Struct* msg) {
	if (!conn) {
		Log(Logs::General, Logs::World_Server, "OnEmoteMessage failed, no connection to NATS");
		return;
	}
	
	eqproto::ChannelMessage message;
	message.set_guilddbid(msg->guilddbid);
	message.set_minstatus(msg->minstatus);
	message.set_type(msg->type);
	message.set_message(msg->message);
	message.set_to(msg->to);	
	message.set_is_emote(true);
	SendChannelMessage(&message);
	return;
}

//Send (publish) message to NATS
void NatsManager::SendChannelMessage(eqproto::ChannelMessage* message) {
	if (!conn) {
		Log(Logs::General, Logs::World_Server, "Send channel message failed, no connection to NATS");
		return;
	}
	std::string pubMessage;
	if (!message->SerializeToString(&pubMessage)) {
		Log(Logs::General, Logs::World_Server, "Failed to serialize message to string");
		return;
	}
	s = natsConnection_PublishString(conn, "ChannelMessage", pubMessage.c_str());
	if (s != NATS_OK) {
		Log(Logs::General, Logs::World_Server, "Failed to send ChannelMessageEvent");
	}
}

//Send a message to all zone servers.
void NatsManager::ChannelMessageEvent(eqproto::ChannelMessage* message) {
	if (!conn) {
		Log(Logs::General, Logs::World_Server, "Broadcasting Message failed, no connection to NATS");
		return;
	}
	if (message->zone_id() > 0) return; //do'nt process non-zero messages
	Log(Logs::General, Logs::World_Server, "Broadcasting Message");
	if (message->is_emote()) { //emote message
		zoneserver_list.SendEmoteMessage(message->to().c_str(), message->guilddbid(), message->minstatus(), message->type(), message->message().c_str());
		return;
	}

	//normal broadcast
	char tmpname[64];
	tmpname[0] = '*';
	strcpy(&tmpname[1], message->from().c_str());	
	//TODO: add To support on tells	
	int channel = message->chan_num();
	if (channel < 1) channel = 5; //default to ooc
	zoneserver_list.SendChannelMessage(tmpname, 0, channel, message->language(), message->message().c_str());	
}

void NatsManager::Save()
{
	return;
}

void NatsManager::Load()
{	
	int64_t         last = 0;
	int64_t			start = 0;

	int total = 2;
	char * subj = "test";
	char * txt = "Hello, World";

	Log(Logs::General, Logs::World_Server, "Sending %i messages to subject '%s'", total, subj);
	

	s = natsConnection_Connect(&conn, opts);
	if (s != NATS_OK) {
		Log(Logs::General, Logs::World_Server, "Nats status isn't OK, hmm.");
		conn = NULL;
		return;
	}

	//Subscribe to test
	s = natsConnection_SubscribeSync(&testSub, conn, "test");
	s = natsConnection_SubscribeSync(&channelMessageSub, conn, "ChannelMessageWorld");

	// For maximum performance, set no limit on the number of pending messages.
	if (s == NATS_OK)
		s = natsSubscription_SetPendingLimits(testSub, -1, -1);

	//if (s == NATS_OK)
	//	s = natsSubscription_AutoUnsubscribe(testSub, (int)testSubMax);


	if (s == NATS_OK)
		s = natsStatistics_Create(&stats);

	if (s == NATS_OK)
		start = nats_Now();

	int count = 0;
	for (count = 0; (s == NATS_OK) && (count < total); count++)
	{
		s = natsConnection_PublishString(conn, subj, txt);
	}

	if (s == NATS_OK)
		s = natsConnection_FlushTimeout(conn, 1000);

	if (s == NATS_OK)
	{
		//printStats(STATS_OUT, conn, NULL, stats);
		Log(Logs::General, Logs::World_Server, "Sent %i %i %i", total, start);
	}
	else
	{
		Log(Logs::General, Logs::World_Server, "NATS error: %d - %s", s, natsStatus_GetText(s));
		nats_PrintLastErrorStack(stderr);
	}
	return;
}