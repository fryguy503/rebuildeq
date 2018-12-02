#ifndef NATS_H
#define NATS_H

#include "nats.h"

#include "world_config.h"
#include "../common/global_define.h"
#include "../common/types.h"
#include "../common/timer.h"
#ifndef PROTO_H
#define PROTO_H
#include "../common/message.pb.h"
#endif
#include "../common/servertalk.h"

class NatsManager
{
public:
	NatsManager();
	~NatsManager();

	void Process();
	void OnChannelMessage(ServerChannelMessage_Struct * msg);
	void OnEmoteMessage(ServerEmoteMessage_Struct * msg);
	void SendAdminMessage(std::string adminMessage, const char* reply = nullptr);
	void GetChannelMessage(pb::ChannelMessage* message, const char* reply = nullptr);
	void SendChannelMessage(pb::ChannelMessage* message, const char* reply = nullptr);
	void GetCommandMessage(pb::CommandMessage* message, const char* reply = nullptr);
	void SendCommandMessage(pb::CommandMessage* message, const char* reply = nullptr);
	void Save();
	void Load();
protected:
	bool connect();
	Timer nats_timer;
	natsConnection *conn = NULL;
	natsStatus      s;
	natsStatistics *stats = NULL;
	natsOptions *opts = NULL;
	natsSubscription *channelMessageSub = NULL;
	natsSubscription *commandMessageSub = NULL;
	natsSubscription *adminMessageSub = NULL;
};

#endif