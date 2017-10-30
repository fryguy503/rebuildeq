#ifndef NATS_MANAGER_H
#define NATS_MANAGER_H

#include "../common/global_define.h"
#include "../common/types.h"
#include "../common/timer.h"
#include "../common/proto/chatmessage.pb.h"
#include "nats.h"
#include <map>
#include <list>

class NatsManager
{
public:
	NatsManager();
	~NatsManager();

	void Process();
	void BroadcastMessage(eqproto::ChatMessage* message);
	void Save();
	void Load();
protected:
	natsConnection *conn = NULL;
	natsStatus      s;
	natsStatistics *stats = NULL;
	natsOptions *opts = NULL;
	natsSubscription *testSub = NULL;
	natsSubscription *broadcastMessageSub = NULL;
	//int testSubMax = 100;
};

#endif