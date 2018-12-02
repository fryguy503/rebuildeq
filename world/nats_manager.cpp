#include "nats_manager.h"
#include "nats.h"
#include "zonelist.h"
#include "login_server_list.h"
#include "clientlist.h"
#include "cliententry.h"
#include "worlddb.h"

#include <google/protobuf/arena.h>
#include "../common/seperator.h"
#include "../common/eqemu_logsys.h"
#ifndef PROTO_H
#define PROTO_H
#include "../common/message.pb.h"
#endif
#include "../common/servertalk.h"
#include "../common/string_util.h"

extern ZSList zoneserver_list;
extern LoginServerList loginserverlist;
extern ClientList client_list;
const WorldConfig *worldConfig;

google::protobuf::Arena the_arena;

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

bool NatsManager::connect() {
	auto ncs = natsConnection_Status(conn);
	if (ncs == CONNECTED)
		return true;
	if (nats_timer.Enabled() && !nats_timer.Check())
		return false;

	natsOptions *opts = NULL;
	natsOptions_Create(&opts);
	natsOptions_SetMaxReconnect(opts, 0);
	natsOptions_SetReconnectWait(opts, 0);
	natsOptions_SetAllowReconnect(opts, false);
	//The timeout is going to cause a 100ms delay on all connected clients every X seconds (20s)
	//since this blocks the connection. It can be set lower or higher delay, 
	//but since NATS is a second priority I wanted server impact minimum.
	natsOptions_SetTimeout(opts, 100);
	std::string connection = StringFormat("nats://%s:%d", worldConfig->NATSHost.c_str(), worldConfig->NATSPort);
	if (worldConfig->NATSHost.length() == 0)
		connection = "nats://localhost:4222";

	natsOptions_SetURL(opts, connection.c_str());
	s = natsConnection_Connect(&conn, opts);
	natsOptions_Destroy(opts);
	if (s != NATS_OK) {
		Log(Logs::General, Logs::NATS, "failed to connect to %s: %s, retrying in 20s", connection.c_str(), nats_GetLastError(&s));
		conn = NULL;
		nats_timer.Enable();
		nats_timer.SetTimer(20000);
		return false;
	}

	Log(Logs::General, Logs::NATS, "connected to %s", connection.c_str());
	nats_timer.Disable();

	s = natsConnection_SubscribeSync(&channelMessageSub, conn, "world.channel_message.in");
	if (s != NATS_OK)
		Log(Logs::General, Logs::NATS, "world.channel_message.in: failed to subscribe: %s", nats_GetLastError(&s));

	s = natsConnection_SubscribeSync(&commandMessageSub, conn, "world.command_message.in");
	if (s != NATS_OK)
		Log(Logs::General, Logs::NATS, "world.command_message.in: failed to subscribe: %s", nats_GetLastError(&s));

	return true;
}


void NatsManager::Process()
{
	natsMsg *msg = NULL;
	if (!connect())
		return;
	s = NATS_OK;
	for (int count = 0; (s == NATS_OK) && count < 5; count++)
	{
		s = natsSubscription_NextMsg(&msg, channelMessageSub, 1);
		if (s != NATS_OK)
			break;

		pb::ChannelMessage* message = google::protobuf::Arena::CreateMessage<pb::ChannelMessage>(&the_arena);
		if (!message->ParseFromArray(natsMsg_GetData(msg), natsMsg_GetDataLength(msg))) {
			Log(Logs::General, Logs::NATS, "world.channel_message.in: failed to parse");
			natsMsg_Destroy(msg);
			continue;
		}

		GetChannelMessage(message, natsMsg_GetReply(msg));
	}

	s = NATS_OK;
	for (int count = 0; (s == NATS_OK) && count < 5; count++)
	{
		s = natsSubscription_NextMsg(&msg, commandMessageSub, 1);
		if (s != NATS_OK)
			break;

		pb::CommandMessage* message = google::protobuf::Arena::CreateMessage<pb::CommandMessage>(&the_arena);
		if (!message->ParseFromArray(natsMsg_GetData(msg), natsMsg_GetDataLength(msg))) {
			Log(Logs::General, Logs::NATS, "world.command_message.in: failed to parse");
			natsMsg_Destroy(msg);
			continue;
		}
		GetCommandMessage(message, natsMsg_GetReply(msg));
	}
}

void NatsManager::OnChannelMessage(ServerChannelMessage_Struct* msg) {
	if (!connect())
		return;

	pb::ChannelMessage* message = google::protobuf::Arena::CreateMessage<pb::ChannelMessage>(&the_arena);

	message->set_fromadmin(msg->fromadmin);
	message->set_deliverto(msg->deliverto);
	message->set_guilddbid(msg->guilddbid);
	message->set_noreply(msg->noreply);
	message->set_queued(msg->queued);
	message->set_number(static_cast<pb::MessageType>(msg->chan_num));
	message->set_message(msg->message);
	message->set_to(msg->to);
	message->set_language(msg->language);
	message->set_from(msg->from);
	SendChannelMessage(message);
	return;
}

void NatsManager::OnEmoteMessage(ServerEmoteMessage_Struct* msg) {
	if (!connect())
		return;
	pb::ChannelMessage* message = google::protobuf::Arena::CreateMessage<pb::ChannelMessage>(&the_arena);
	message->set_guilddbid(msg->guilddbid);
	message->set_minstatus(msg->minstatus);
	message->set_type(msg->type);
	message->set_message(msg->message);
	message->set_to(msg->to);
	message->set_is_emote(true);
	SendChannelMessage(message);
	return;
}

// SendAdminMessage will send an admin message to NATS
void NatsManager::SendAdminMessage(std::string adminMessage, const char* reply) {
	if (!connect())
		return;
	pb::ChannelMessage* message = google::protobuf::Arena::CreateMessage<pb::ChannelMessage>(&the_arena);

	message->set_message(adminMessage.c_str());

	size_t event_size = message->ByteSizeLong();
	void *event_buffer = malloc(event_size);
	if (!message->SerializeToArray(event_buffer, event_size)) {
		Log(Logs::General, Logs::NATS, "global.admin_message.out: failed to serialize message");
		return;
	}

	if (reply && strlen(reply) > 0)
		s = natsConnection_Publish(conn, reply, event_buffer, event_size);
	else
		s = natsConnection_Publish(conn, "global.admin_message.out", event_buffer, event_size);

	if (s != NATS_OK) {
		Log(Logs::General, Logs::NATS, "global.admin_message.out failed: %s", nats_GetLastError(&s));
		return;
	}
	Log(Logs::General, Logs::NATS, "global.admin_message.out: %s", adminMessage.c_str());
}


// SendCommandMessage will send a channel message to NATS
void NatsManager::SendCommandMessage(pb::CommandMessage* message, const char* reply) {
	if (!connect())
		return;

	size_t event_size = message->ByteSizeLong();
	void *event_buffer = malloc(event_size);
	if (!message->SerializeToArray(event_buffer, event_size)) {
		Log(Logs::General, Logs::NATS, "global.admin_message.out: failed to serialize message");
		return;
	}


	if (reply && strlen(reply) > 0)
		s = natsConnection_Publish(conn, reply, event_buffer, event_size);
	else
		s = natsConnection_Publish(conn, "world.command_message.out", event_buffer, event_size);

	if (s != NATS_OK) {
		Log(Logs::General, Logs::NATS, "world.command_message.out failed: %s", nats_GetLastError(&s));
		return;
	}

	Log(Logs::General, Logs::NATS, "world.command_message.in: %s (%d: %s)", message->command().c_str(), message->response_error(), message->response_message().c_str());
}

// GetCommandMessage is used to process a command message
void NatsManager::GetCommandMessage(pb::CommandMessage* message, const char* reply) {
	if (!connect())
		return;

	if (message->command().compare("who") == 0) {
		message->set_response_message(client_list.GetWhoAll());
		SendCommandMessage(message, reply);
		return;
	}

	if (message->command().compare("unlock") == 0) {
		WorldConfig::UnlockWorld();
		if (loginserverlist.Connected())
			loginserverlist.SendStatus();
		message->set_response_message("Server is now unlocked.");
		SendCommandMessage(message, reply);
		return;
	}

	if (message->command().compare("lock") == 0) {
		WorldConfig::LockWorld();
		if (loginserverlist.Connected())
			loginserverlist.SendStatus();
		message->set_response_message("Server is now locked.");
		SendCommandMessage(message, reply);
		return;
	}

	if (message->command().compare("setidentity") == 0) {
		if (message->params_size() < 2) {
			message->set_response_message("Usage: !setidentity <accountid> <name>.");
		}
		else {
			uint32 accountid = atoi(message->params(0).c_str());
			if (!database.SetIdentity(accountid, message->params(1).c_str())) {
				message->set_response_message("Failed to set identity, database step failed.");
			}
			else {
				message->set_response_message(StringFormat("Set identity of %i to %s.", accountid, message->params(1).c_str()));
			}
		}
		SendCommandMessage(message, reply);
		return;
	}

	if (message->command().compare("worldshutdown") == 0) {
		uint32 time = 0;
		uint32 interval = 0;

		if (message->params_size() == 2 && ((time = atoi(message->params(0).c_str()))>0) && ((interval = atoi(message->params(1).c_str()))>0)) {
			message->set_response_message(StringFormat("Sending shutdown packet now, World will shutdown in: %i minutes with an interval of: %i seconds", (time / 60), interval));
			zoneserver_list.WorldShutDown(time, interval);
			SendCommandMessage(message, reply);
			return;
		}
		else if (strcasecmp(message->params(0).c_str(), "now") == 0) {
			message->set_response_message("Sending shutdown packet now");
			zoneserver_list.WorldShutDown(0, 0);
			SendCommandMessage(message, reply);
			return;
		}
		else if (strcasecmp(message->params(0).c_str(), "disable") == 0) {
			message->set_response_message("Shutdown prevented, next time I may not be so forgiving...");
			zoneserver_list.SendEmoteMessage(0, 0, 0, 15, "<SYSTEMWIDE MESSAGE>:SYSTEM MSG:World shutdown aborted.");
			zoneserver_list.shutdowntimer->Disable();
			zoneserver_list.reminder->Disable();
			SendCommandMessage(message, reply);
			return;
		}
		message->set_response_error(pb::ERR_Request);
		message->set_response_message("worldshutdown - Shuts down the server and all zones.\n \
		Usage: worldshutdown now - Shuts down the server and all zones immediately.\n \
		Usage: worldshutdown disable - Stops the server from a previously scheduled shut down.\n \
		Usage: worldshutdown [timer] [interval] - Shuts down the server and all zones after [timer] seconds and sends warning every [interval] seconds\n");
		SendCommandMessage(message, reply);
		return;
	}

	message->set_response_error(pb::ERR_Request);
	message->set_response_message("Unknown command");
	SendCommandMessage(message, reply);
	return;
}

// GetChannelMessage is when a 3rd party app sends a channel message via NATS.
void NatsManager::GetChannelMessage(pb::ChannelMessage* message, const char* reply) {
	if (!connect())
		return;

	if (message->is_emote()) { //emote message
		zoneserver_list.SendEmoteMessage(message->to().c_str(), message->guilddbid(), message->minstatus(), message->type(), message->message().c_str());
		message->set_response_message("Success");
		SendChannelMessage(message, reply);
		return;
	}

	//normal broadcast
	char from[64];
	from[0] = '*';
	strcpy(&from[1], message->from().c_str());


	int channel = message->number();
	if (channel < 1 && message->guilddbid() < 1) {
		channel = MT_OOC; //default to ooc
		message->set_number(pb::OOC);
	}

	if (message->to().length() == 0) { //Send a world message
		zoneserver_list.SendChannelMessage(from, 0, channel, message->language(), message->message().c_str());
		message->set_response_message("Success");
		SendChannelMessage(message, reply);
		return;
	}


	//Send a tell	

	channel = 7; //tells are always echo
	message->set_number(static_cast<pb::MessageType>(7));
	ClientListEntry* cle = client_list.FindCharacter(message->to().c_str());
	if (cle == 0 || cle->Online() < CLE_Status_Zoning ||
		(cle->TellsOff() && ((cle->Anon() == 1 && message->fromadmin() < cle->Admin()) || message->fromadmin() < 80))) {
		message->set_response_error(pb::ERR_Failed);
		message->set_response_message("Player is offline");
		SendChannelMessage(message, reply);
		return;
	}

	if (cle->Online() == CLE_Status_Zoning) {
		if (cle->TellQueueFull()) {
			message->set_response_error(pb::ERR_Failed);
			message->set_response_message("Queue is full");
			SendChannelMessage(message, reply);
			return;
		}

		//This should succeed in going into a tell queue, since it doesn't return we have to detect above
		zoneserver_list.SendChannelMessage(from, message->to().c_str(), channel, message->language(), message->message().c_str());
		message->set_response_message("Player is zoning, tell is queued");
		SendChannelMessage(message, reply);
		return;
	}
	zoneserver_list.SendChannelMessage(from, message->to().c_str(), channel, message->language(), message->message().c_str());
	message->set_response_message("Success");
	SendChannelMessage(message, reply);
	return;
}


// SendChannelMessage will send a channel message to NATS
void NatsManager::SendChannelMessage(pb::ChannelMessage* message, const char* reply) {
	if (!connect())
		return;

	size_t event_size = message->ByteSizeLong();
	void *event_buffer = malloc(event_size);
	if (!message->SerializeToArray(event_buffer, event_size)) {
		Log(Logs::General, Logs::NATS, "global.admin_message.out: failed to serialize message");
		return;
	}

	if (reply) {
		s = natsConnection_Publish(conn, reply, event_buffer, event_size);
	}
	else {
		s = natsConnection_Publish(conn, "world.channel_message.out", event_buffer, event_size);
	}

	if (s != NATS_OK) {
		Log(Logs::General, Logs::NATS, "world.channel_message.out failed: %s", nats_GetLastError(&s));
		return;
	}

	if (reply)
		Log(Logs::General, Logs::NATS, "world.channel_message.in: %s (%d: %s)", message->message().c_str(), message->response_error(), message->response_message().c_str());
	else
		Log(Logs::General, Logs::NATS, "world.channel_message.out: %s", message->message().c_str());
}

void NatsManager::Load()
{
	if (!connect())
		return;

	return;
}
