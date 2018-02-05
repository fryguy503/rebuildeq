#include "nats_manager.h"
#include "nats.h"
#include "zonelist.h"
#include "world_config.h"
#include "login_server_list.h"
#include "clientlist.h"
#include "worlddb.h"

#include "../common/seperator.h"
#include "../common/eqemu_logsys.h"
#include "../common/proto/message.pb.h"
#include "../common/servertalk.h"
#include "../common/string_util.h"

extern ZSList zoneserver_list;
extern LoginServerList loginserverlist;
extern ClientList client_list;
const WorldConfig *worldConfig;

NatsManager::NatsManager()
{
	//new timers, object initialization
	worldConfig = WorldConfig::get();
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

	s = NATS_OK;
	for (int count = 0; (s == NATS_OK) && count < 5; count++)
	{
		s = natsSubscription_NextMsg(&msg, commandMessageSub, 1);
		if (s != NATS_OK) break;
		Log(Logs::General, Logs::World_Server, "Got Command Message '%s'", natsMsg_GetData(msg));
		eqproto::CommandMessage message;
		
			
		if (!message.ParseFromString(natsMsg_GetData(msg))) {
			Log(Logs::General, Logs::World_Server, "Failed to marshal");
			natsMsg_Destroy(msg);
			continue;
		}		
		CommandMessageEvent(&message, natsMsg_GetReply(msg));
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

void NatsManager::SendAdminMessage(std::string adminMessage) {
	if (!conn) {
		Log(Logs::General, Logs::World_Server, "Send channel message failed, no connection to NATS");
		return;
	}

	eqproto::ChannelMessage message;
	message.set_message(adminMessage.c_str());
	std::string pubMessage;
	if (!message.SerializeToString(&pubMessage)) {
		Log(Logs::General, Logs::World_Server, "Failed to serialize message to string");
		return;
	}
	s = natsConnection_PublishString(conn, "AdminMessage", pubMessage.c_str());
	if (s != NATS_OK) {
		Log(Logs::General, Logs::World_Server, "Failed to SendAdminMessage");
	}
	Log(Logs::General, Logs::World_Server, "AdminMessage: %s", adminMessage.c_str());
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

void NatsManager::CommandMessageEvent(eqproto::CommandMessage* message, const char* reply) {
	if (!conn) {
		Log(Logs::General, Logs::World_Server, "Command Message failed, no connection to NATS");
		return;
	}
	std::string pubMessage;
	//Log(Logs::General, Logs::World_Server, "Command: %s", message->command().c_str());
	// message->params()
	
	
	if (message->command().compare("who") == 0) {		
		message->set_result(client_list.GetWhoAll());
	}

	if (message->command().compare("unlock") == 0) {
		WorldConfig::UnlockWorld();
		if (loginserverlist.Connected()) loginserverlist.SendStatus();
		message->set_result("Server is now unlocked.");
	}

	if (message->command().compare("lock") == 0) {		
		WorldConfig::LockWorld();
		if (loginserverlist.Connected()) loginserverlist.SendStatus();
		message->set_result("Server is now locked.");
	}

	if (message->command().compare("setidentity") == 0) {
		if (message->params_size() < 2) {
			message->set_result("Usage: !setidentity <accountid> <name>.");
		}
		else {
			uint32 accountid = atoi(message->params(0).c_str());
			if (!database.SetIdentity(accountid, message->params(1).c_str())) {
				message->set_result("Failed to set identity, database step failed.");
			}
			else {
				message->set_result(StringFormat("Set identity of %i to %s.", accountid, message->params(1).c_str()));
			}			
		}
	}

	if(message->command().compare("worldshutdown") == 0) {
		uint32 time=0;
		uint32 interval=0;

		if(message->params_size() < 1) {
			message->set_result("worldshutdown - Shuts down the server and all zones.\n \
		Usage: worldshutdown now - Shuts down the server and all zones immediately.\n \
		Usage: worldshutdown disable - Stops the server from a previously scheduled shut down.\n \
		Usage: worldshutdown [timer] [interval] - Shuts down the server and all zones after [timer] seconds and sends warning every [interval] seconds\n");
		} else if(message->params_size() == 2 && ((time=atoi(message->params(0).c_str()))>0) && ((interval=atoi(message->params(1).c_str()))>0)) {
			message->set_result(StringFormat("Sending shutdown packet now, World will shutdown in: %i minutes with an interval of: %i seconds",  (time / 60), interval));
			zoneserver_list.WorldShutDown(time, interval);
		}
		else if(strcasecmp(message->params(0).c_str(), "now") == 0){
			message->set_result("Sending shutdown packet now");
			zoneserver_list.WorldShutDown(0, 0);
		}
		else if(strcasecmp(message->params(0).c_str(), "disable") == 0){
			message->set_result("Shutdown prevented, next time I may not be so forgiving...");
			zoneserver_list.SendEmoteMessage(0, 0, 0, 15, "<SYSTEMWIDE MESSAGE>:SYSTEM MSG:World shutdown aborted.");
			zoneserver_list.shutdowntimer->Disable();
			zoneserver_list.reminder->Disable();
		}
	}

	if (message->result().length() <= 1) {
		message->set_result("Failed to parse command.");		
	}

	if (!message->SerializeToString(&pubMessage)) {
		Log(Logs::General, Logs::World_Server, "Failed to serialize command message to string");
		return;
	}

	s = natsConnection_PublishString(conn, reply, pubMessage.c_str());
	if (s != NATS_OK) {
		Log(Logs::General, Logs::World_Server, "Failed to send CommandMessageEvent");
		return;
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
	s = natsConnection_ConnectTo(&conn, StringFormat("nats://%s:%d", worldConfig->NATSHost.c_str(), worldConfig->NATSPort).c_str());
	if (s != NATS_OK) {
		Log(Logs::General, Logs::World_Server, "Nats status isn't OK, hmm.");
		conn = NULL;
		return;
	}

	s = natsConnection_SubscribeSync(&channelMessageSub, conn, "ChannelMessageWorld");
	s = natsConnection_SubscribeSync(&commandMessageSub, conn, "CommandMessageWorld");

	// For maximum performance, set no limit on the number of pending messages.
	if (s == NATS_OK) s = natsSubscription_SetPendingLimits(testSub, -1, -1);

	Log(Logs::General, Logs::World_Server, "NATS Connected.");
	return;
}