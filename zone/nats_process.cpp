#include "nats.h"
#include "nats_process.h"

#include "../common/eqemu_logsys.h"
#include "../common/proto/channelmessage.pb.h"


Nats::Nats()
{
	//new timers, object initialization
}

Nats::~Nats()
{
	// Destroy all our objects to avoid report of memory leak
	natsStatistics_Destroy(stats);
	natsConnection_Destroy(conn);
	natsOptions_Destroy(opts);

	// To silence reports of memory still in used with valgrind
	nats_Close();
}

void Nats::Process(const char * zonename)
{
	//Log(Logs::General, Logs::Zone_Server, "NATS");
	if (subscribedZonename != zonename) {				
		s = natsConnection_SubscribeSync(&zoneSub, conn, zonename);
		
		subscribedZonename = zonename;
		Log(Logs::General, Logs::Zone_Server, "Subscribed to %s", subscribedZonename);
		// For maximum performance, set no limit on the number of pending messages.
		if (s == NATS_OK)
			s = natsSubscription_SetPendingLimits(zoneSub, -1, -1);
	}

	natsMsg *msg = NULL;
	for (int count = 0; (s == NATS_OK) && count < 100; count++)
	{
		s = natsSubscription_NextMsg(&msg, zoneSub, 1);
		if (s != NATS_OK) break;
		Log(Logs::General, Logs::World_Server, "Got Message '%s'", natsMsg_GetData(msg));
		natsMsg_Destroy(msg);
	}
}

void Nats::Unregister()
{
	s = natsSubscription_Unsubscribe(zoneSub);
	if (s != NATS_OK) {
		Log(Logs::General, Logs::Zone_Server, "Unsubscribe failed");
		return;
	}
	Log(Logs::General, Logs::Zone_Server, "NATS Unsubscribed");
}


void Nats::Load()
{


	/*// This is a simple protobuf example I have cooked in.
	ChatMessage chatMessage;
	chatMessage.set_sender("shin");
	chatMessage.set_message("hello");
	Log(Logs::General, Logs::World_Server, "Protobuf test: '%s'", chatMessage.SerializeAsString().c_str());
	*/
	

	s = natsConnection_Connect(&conn, opts);
	if (s != NATS_OK) {
		Log(Logs::General, Logs::World_Server, "Nats status isn't OK, hmm.");
		return;
	}

	Log(Logs::General, Logs::Zone_Server, "NATS Initialized.");
	return;
}