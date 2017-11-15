#ifndef _NATS_H
#define _NATS_H
#include "nats.h"

#include "../common/global_define.h"
#include "../common/types.h"

class NatsManager
{
public:
	NatsManager();
	~NatsManager();
	void Process();
	void Unregister();
	bool IsZoneSubscribed() { return (subscribedZonename != NULL && subscribedZonename[0] != '\0'); };
	void ZoneSubscribe(const char * zonename);
	void Load();
	void DailyGain(int account_id, int character_id, const char * identity, int levels_gained = 0, int experience_gained = 0, int money_earned = 0);
	void SendAdminMessage(std::string adminMessage);
protected:
	natsConnection *conn = NULL;
	natsStatus      s;
	natsOptions *opts = NULL;
	natsSubscription *zoneSub = NULL;
	natsSubscription *adminMessageSub = NULL;
	const char * subscribedZonename;	
};

#endif