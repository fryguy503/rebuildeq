#include "entity.h"
#include "mob.h"
#include "event_codes.h"
#include "nats.h"
#include "zone_config.h"
#include "nats_manager.h"

#include "../common/eqemu_logsys.h"
#include "../common/string_util.h"
#include "../common/proto/message.pb.h"

const ZoneConfig *zoneConfig;

NatsManager::NatsManager()
{
	//new timers, object initialization

	zoneConfig = ZoneConfig::get();
}

NatsManager::~NatsManager()
{
	// Destroy all our objects to avoid report of memory leak
	natsConnection_Destroy(conn);
	natsOptions_Destroy(opts);

	// To silence reports of memory still in used with valgrind
	nats_Close();
}

void NatsManager::Process()
{
	if (zoneSub == NULL) {
		return;
	}
	
	natsMsg *msg = NULL;

	s = NATS_OK;

	for (int count = 0; (s == NATS_OK) && count < 100; count++)
	{
		s = natsSubscription_NextMsg(&msg, zoneSub, 1);
		if (s != NATS_OK) break;
		Log(Logs::General, Logs::Zone_Server, "NATS got message '%s'", natsMsg_GetData(msg));
		natsMsg_Destroy(msg);
	}
}

//Unregister is called when a zone is being put to sleep.
void NatsManager::Unregister()
{
	if (zoneSub == NULL) {
		return;
	}
	s = natsSubscription_Unsubscribe(zoneSub);
	zoneSub = NULL;	
	if (s != NATS_OK) {
		Log(Logs::General, Logs::Zone_Server, "NATS unsubscribe from %s failed: %s", subscribedZonename.c_str(), nats_GetLastError(&s));
		subscribedZonename.clear();
		return;
	}
	Log(Logs::General, Logs::Zone_Server, "NATS unsubscribed from %s", subscribedZonename.c_str());	
	subscribedZonename.clear();
	return;
}

void NatsManager::ZoneSubscribe(const char* zonename) {
	if (strcmp(subscribedZonename.c_str(), zonename) == 0) return;
	if (!conn) return;
	if (zoneSub != NULL) {
		s = natsSubscription_Unsubscribe(zoneSub);
		if (s != NATS_OK) {
			Log(Logs::General, Logs::Zone_Server, "NATS failed to unsubscribe from previous zone: %s", nats_GetLastError(&s));
		}
	}
	
	subscribedZonename = std::string(zonename);
	
	s = natsConnection_SubscribeSync(&zoneSub, conn, subscribedZonename.c_str());
	if (s != NATS_OK) {
		Log(Logs::General, Logs::Zone_Server, "NATS failed to subscribe to zone %s", subscribedZonename.c_str());
		return;
	}	
	s = natsSubscription_SetPendingLimits(zoneSub, -1, -1);	
	if (s != NATS_OK) {
		Log(Logs::General, Logs::Zone_Server, "NATS failed to set pending limits while subscribed to zone %s", subscribedZonename.c_str());
		return;
	}
	Log(Logs::General, Logs::Zone_Server, "NATS subscribed to %s", subscribedZonename.c_str());
}


void NatsManager::SendAdminMessage(std::string adminMessage) {
	if (!conn) {
		Log(Logs::General, Logs::Zone_Server, "NATS Send channel message failed, no connection to NATS");
		return;
	}

	eqproto::ChannelMessage message;
	message.set_message(adminMessage.c_str());
	std::string pubMessage;
	if (!message.SerializeToString(&pubMessage)) {
		Log(Logs::General, Logs::Zone_Server, "NATS Failed to serialize message to string");
		return;
	}
	s = natsConnection_PublishString(conn, "NATS AdminMessage", pubMessage.c_str());
	if (s != NATS_OK) {
		Log(Logs::General, Logs::Zone_Server, "NATS Failed to SendAdminMessage");
	}
	Log(Logs::General, Logs::Zone_Server, "NATS AdminMessage: %s", adminMessage.c_str());
}


void NatsManager::Load()
{
	s = natsConnection_ConnectTo(&conn, StringFormat("nats://%s:%d", zoneConfig->NATSHost.c_str(), zoneConfig->NATSPort).c_str());
	if (s != NATS_OK) {
		Log(Logs::General, Logs::Zone_Server, "NATS failed to load: %s", nats_GetLastError(&s));
		conn = NULL;
		return;
	}


	Log(Logs::General, Logs::Zone_Server, "NATS Connected.");
	return;
}

void NatsManager::DailyGain(int account_id, int character_id, const char* identity, int levels_gained, int experience_gained, int money_earned)
{	
	if (!conn) return;
	eqproto::DailyGain daily;
	daily.set_account_id(account_id);
	daily.set_character_id(character_id);
	daily.set_identity(identity);
	daily.set_levels_gained(levels_gained);
	daily.set_experience_gained(experience_gained);
	daily.set_money_earned(money_earned);
	std::string pubMessage;
	if (!daily.SerializeToString(&pubMessage)) {
		Log(Logs::General, Logs::Zone_Server, "NATS failed to serialize dailygain to string");
		return;
	}

	s = natsConnection_PublishString(conn, "DailyGain", pubMessage.c_str());
	if (s != NATS_OK) Log(Logs::General, Logs::Zone_Server, "NATS failed to send DailyGain: %s", nats_GetLastError(&s));	
}


void NatsManager::OnEntityEvent(QuestEventID evt, Entity *ent) {

	if (!conn) {
		Log(Logs::General, Logs::World_Server, "OnChannelMessage failed, no connection to NATS");
		return;
	}

	eqproto::EntityEvent event;
	event.set_event(int(evt));

	eqproto::Entity entity;
	entity.set_id(ent->GetID());
	entity.set_name(ent->GetName());

	if (ent->IsClient()) {
		entity.set_type(1);
	}
	else if (ent->IsNPC()) {
		entity.set_type(2);
	}
	if (ent->IsMob()) {
		auto mob = ent->CastToMob();
		entity.set_hp(mob->GetHP());
		entity.set_level(mob->GetLevel());
		entity.set_name(mob->GetName());
	}

	event.set_allocated_entity(&entity);
	
	std::string pubMessage;
	bool isSerialized = event.SerializeToString(&pubMessage);
	event.release_entity();
	if (!isSerialized) {
		Log(Logs::General, Logs::Zone_Server, "NATS Failed to serialize message to string");		
		return;
	}
	s = natsConnection_PublishString(conn, "EntityEvent", pubMessage.c_str());
	if (s != NATS_OK) {
		Log(Logs::General, Logs::Zone_Server, "NATS Failed to send EntityEvent");
	}
	return;
}
