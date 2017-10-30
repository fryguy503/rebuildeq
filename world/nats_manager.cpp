#include "nats_manager.h"
#include "nats.h"
#include "zonelist.h"
#include "../common/eqemu_logsys.h"
#include "../common/proto/chatmessage.pb.h"

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
		s = natsSubscription_NextMsg(&msg, broadcastMessageSub, 1);
		if (s != NATS_OK) break;
		Log(Logs::General, Logs::World_Server, "Got Broadcast Message '%s'", natsMsg_GetData(msg));
		eqproto::ChatMessage chatMessage;
		if (!chatMessage.ParseFromString(natsMsg_GetData(msg))) {
			Log(Logs::General, Logs::World_Server, "Failed to marshal");
			natsMsg_Destroy(msg);
			continue;
		}
		natsMsg_Destroy(msg);
		BroadcastMessage(&chatMessage);

	}
}

//Send a message to all zone servers.
void NatsManager::BroadcastMessage(eqproto::ChatMessage* message)
{
	Log(Logs::General, Logs::World_Server, "Broadcasting Message");
	char tmpname[64];
	tmpname[0] = '*';
	strcpy(&tmpname[1], message->from().c_str());
	//TODO: add To support on tells	
	int channel = message->channel();
	if (channel < 1) channel = 5; //default to ooc
	zoneserver_list.SendChannelMessage(tmpname, 0, channel, message->language(), message->message().c_str());
}

void NatsManager::Save()
{
	return;
}

void NatsManager::Load()
{	

	
	/*// This is a simple protobuf example I have cooked in.
	ChatMessage chatMessage;
	chatMessage.set_sender("shin");
	chatMessage.set_message("hello");
	Log(Logs::General, Logs::World_Server, "Protobuf test: '%s'", chatMessage.SerializeAsString().c_str());
	*/
	int64_t         last = 0;
	int64_t			start = 0;

	int total = 2;
	char * subj = "test";
	char * txt = "Hello, World";

	Log(Logs::General, Logs::World_Server, "Sending %i messages to subject '%s'", total, subj);
	

	s = natsConnection_Connect(&conn, opts);
	if (s != NATS_OK) {
		Log(Logs::General, Logs::World_Server, "Nats status isn't OK, hmm.");
		return;
	}

	//Subscribe to test
	s = natsConnection_SubscribeSync(&testSub, conn, "test");
	s = natsConnection_SubscribeSync(&broadcastMessageSub, conn, "BroadcastMessage");

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