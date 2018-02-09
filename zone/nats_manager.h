#ifndef _NATS_H
#define _NATS_H
#include "nats.h"
#include "event_codes.h"
#include "entity.h";
#include "mob.h";


#include "../common/opcodemgr.h"
#include "../common/global_define.h"
#include "../common/types.h"

class NatsManager
{
public:
	NatsManager();
	~NatsManager();
	void Process();
	void Unregister();
	bool IsZoneSubscribed() { return (subscribedZonename.length() != 0); };
	void ZoneSubscribe(const char * zonename);
	void Load();
	void DailyGain(int account_id, int character_id, const char * identity, int levels_gained = 0, int experience_gained = 0, int money_earned = 0);
	void OnEntityEvent(const EmuOpcode op, Entity * ent, Entity * target);
	bool isEntitySubscribed(const uint16 ID);
	void SendAdminMessage(std::string adminMessage);
protected:
	bool isEntityEventAllEnabled = true;
	natsConnection *conn = NULL;
	natsStatus      s;
	natsOptions *opts = NULL;
	std::string subscribedZonename;
	//global zone subscriptions
	natsSubscription *zoneSub = NULL;
	natsSubscription *channelMessageSub = NULL;
	natsSubscription *adminMessageSub = NULL;
	//zone specific subscriptions
	natsSubscription *zoneChannelMessageSub = NULL;
	natsSubscription *zoneAdminMessageSub = NULL;
	natsSubscription *zoneEntityEventSubscribeAllSub = NULL;
	natsSubscription *zoneEntityEventSubscribeSub = NULL;
	natsSubscription *zoneEntityEventListSub = NULL;
	natsSubscription *zoneEntityEventSub = NULL;
};

#endif