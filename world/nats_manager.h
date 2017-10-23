#ifndef NATS_MANAGER_H
#define NATS_MANAGER_H

#include "../common/global_define.h"
#include "../common/types.h"
#include "../common/timer.h"
#include "nats.h"
#include <map>
#include <list>

class NatsManager
{
public:
	NatsManager();
	~NatsManager();

	void Process();
	void Save();
	void Load();
	void Unload();
protected:
	natsConnection *conn = NULL;
	natsStatus      s;
	natsStatistics *stats = NULL;
	natsOptions *opts = NULL;
	natsSubscription *testSub = NULL;
	//int testSubMax = 100;
};

#endif