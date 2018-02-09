#include "entity.h"
#include "mob.h"
#include "event_codes.h"
#include "nats.h"
#include "zone_config.h"
#include "nats_manager.h"

#include "../common/opcodemgr.h"
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

//Unregister is called when a zone is being put to sleep or being swapped
void NatsManager::Unregister()
{
	if (zoneAdminMessageSub != NULL) {
		s = natsSubscription_Unsubscribe(zoneAdminMessageSub);
		zoneAdminMessageSub = NULL;
		if (s != NATS_OK) Log(Logs::General, Logs::Zone_Server, "NATS unsubscribe from zoneAdminMessageSub failed: %s", nats_GetLastError(&s));
	}

	if (zoneChannelMessageSub != NULL) {
		s = natsSubscription_Unsubscribe(zoneChannelMessageSub);
		zoneChannelMessageSub = NULL;
		if (s != NATS_OK) Log(Logs::General, Logs::Zone_Server, "NATS unsubscribe from zoneChannelMessageSub failed: %s", nats_GetLastError(&s));
	}

	if (zoneEntityEventSubscribeAllSub != NULL) {
		s = natsSubscription_Unsubscribe(zoneEntityEventSubscribeAllSub);
		zoneEntityEventSubscribeAllSub = NULL;
		if (s != NATS_OK) Log(Logs::General, Logs::Zone_Server, "NATS unsubscribe from zoneEntityEventSubscribeAllSub failed: %s", nats_GetLastError(&s));
	}
	if (zoneEntityEventSubscribeSub != NULL) {
		s = natsSubscription_Unsubscribe(zoneEntityEventSubscribeSub);
		zoneEntityEventSubscribeSub = NULL;
		if (s != NATS_OK) Log(Logs::General, Logs::Zone_Server, "NATS unsubscribe from zoneEntityEventSubscribeSub failed: %s", nats_GetLastError(&s));
	}

	if (zoneEntityEventListSub != NULL) {
		s = natsSubscription_Unsubscribe(zoneEntityEventListSub);
		zoneEntityEventListSub = NULL;
		if (s != NATS_OK) Log(Logs::General, Logs::Zone_Server, "NATS unsubscribe from zoneEntityEventListSub failed: %s", nats_GetLastError(&s));
	}

	if (zoneEntityEventSub != NULL) {
		s = natsSubscription_Unsubscribe(zoneEntityEventSub);
		zoneEntityEventSub = NULL;
		if (s != NATS_OK) Log(Logs::General, Logs::Zone_Server, "NATS unsubscribe from zoneEntityEventSub failed: %s", nats_GetLastError(&s));
	}

	Log(Logs::General, Logs::Zone_Server, "NATS unsubscribed from %s", subscribedZonename.c_str());	
	subscribedZonename.clear();
	return;
}

void NatsManager::ZoneSubscribe(const char* zonename) {
	if (strcmp(subscribedZonename.c_str(), zonename) == 0) return;
	if (!conn) return;
	Unregister();
	
	subscribedZonename = std::string(zonename);
	
	s = natsConnection_SubscribeSync(&zoneChannelMessageSub, conn,  StringFormat("zone.%s.channel_message", subscribedZonename.c_str()).c_str());
	if (s != NATS_OK) Log(Logs::General, Logs::Zone_Server, "NATS failed to subscribe to zoneChannelMessageSub %s", nats_GetLastError(&s));
	s = natsSubscription_SetPendingLimits(zoneChannelMessageSub, -1, -1);
	if (s != NATS_OK) Log(Logs::General, Logs::Zone_Server, "NATS failed to set pending limits to zoneChannelMessageSub %s", nats_GetLastError(&s));

	s = natsConnection_SubscribeSync(&zoneAdminMessageSub, conn, StringFormat("zone.%s.channel_message", subscribedZonename.c_str()).c_str());
	if (s != NATS_OK) Log(Logs::General, Logs::Zone_Server, "NATS failed to subscribe to zoneAdminMessageSub %s", nats_GetLastError(&s));
	s = natsSubscription_SetPendingLimits(zoneAdminMessageSub, -1, -1);
	if (s != NATS_OK) Log(Logs::General, Logs::Zone_Server, "NATS failed to set pending limits to zoneAdminMessageSub %s", nats_GetLastError(&s));

	s = natsConnection_SubscribeSync(&zoneEntityEventSubscribeAllSub, conn, StringFormat("zone.%s.entity.event_subscribe.all", subscribedZonename.c_str()).c_str());
	if (s != NATS_OK) Log(Logs::General, Logs::Zone_Server, "NATS failed to subscribe to zoneEntityEventSubscribeAllSub %s", nats_GetLastError(&s));
	s = natsSubscription_SetPendingLimits(zoneEntityEventSubscribeAllSub, -1, -1);
	if (s != NATS_OK) Log(Logs::General, Logs::Zone_Server, "NATS failed to set pending limits to zoneEntityEventSubscribeAllSub %s", nats_GetLastError(&s));

	s = natsConnection_SubscribeSync(&zoneEntityEventSubscribeAllSub, conn, StringFormat("zone.%s.entity.event_subscribe.all", subscribedZonename.c_str()).c_str());
	if (s != NATS_OK) Log(Logs::General, Logs::Zone_Server, "NATS failed to subscribe to zoneEntityEventSubscribeAllSub %s", nats_GetLastError(&s));
	s = natsSubscription_SetPendingLimits(zoneEntityEventSubscribeAllSub, -1, -1);
	if (s != NATS_OK) Log(Logs::General, Logs::Zone_Server, "NATS failed to set pending limits to zoneEntityEventSubscribeAllSub %s", nats_GetLastError(&s));

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

	s = natsConnection_SubscribeSync(&zoneSub, conn, "zone");
	if (s != NATS_OK) {
		Log(Logs::General, Logs::Zone_Server, "NATS failed to subscribe to zone: %s", nats_GetLastError(&s));
		return;
	}
	s = natsSubscription_SetPendingLimits(zoneSub, -1, -1);
	if (s != NATS_OK) {
		Log(Logs::General, Logs::Zone_Server, "NATS failed to set pending limits while subscribed to zone %s", nats_GetLastError(&s));
		return;
	}

	s = natsConnection_SubscribeSync(&adminMessageSub, conn, "zone.admin_message");
	if (s != NATS_OK) {
		Log(Logs::General, Logs::Zone_Server, "NATS failed to subscribe to admin message: %s", nats_GetLastError(&s));
		return;
	}
	s = natsSubscription_SetPendingLimits(adminMessageSub, -1, -1);
	if (s != NATS_OK) {
		Log(Logs::General, Logs::Zone_Server, "NATS failed to set pending limits while subscribed to admin message: %s", nats_GetLastError(&s));
		return;
	}

	s = natsConnection_SubscribeSync(&channelMessageSub, conn, "zone.channel_message");
	if (s != NATS_OK) {
		Log(Logs::General, Logs::Zone_Server, "NATS failed to subscribe to channel message: %s", nats_GetLastError(&s));
		return;
	}
	s = natsSubscription_SetPendingLimits(channelMessageSub, -1, -1);
	if (s != NATS_OK) {
		Log(Logs::General, Logs::Zone_Server, "NATS failed to set pending limits while subscribed to channel message: %s", nats_GetLastError(&s));
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


void NatsManager::OnEntityEvent(const EmuOpcode op, Entity *ent, Entity *target) {
	if (ent == NULL) return;
	if (!isEntityEventAllEnabled && !isEntitySubscribed(ent->GetID())) {
		return;
	}


	if (!conn) {
		Log(Logs::General, Logs::Zone_Server, "OnChannelMessage failed, no connection to NATS");
		return;
	}

	eqproto::EntityEvent event;
	event.set_op(eqproto::OpCode(op));
	eqproto::Entity entity;
	entity.set_id(ent->GetID());
	entity.set_name(ent->GetName());

	if (ent->IsClient()) {
		entity.set_type(1);
	}
	else if (ent->IsNPC()) {
		entity.set_type(2);
	}

	auto position = eqproto::Position();
	if (ent->IsMob()) {
		auto mob = ent->CastToMob();
		entity.set_hp(mob->GetHP());
		entity.set_level(mob->GetLevel());
		entity.set_name(mob->GetName());
		position.set_x(mob->GetX());
		position.set_y(mob->GetY());
		position.set_z(mob->GetZ());
		position.set_h(mob->GetHeading());
		entity.set_race(mob->GetRace());
		entity.set_class_(mob->GetClass());		
	}

	auto targetEntity = eqproto::Entity();
	auto targetPosition = eqproto::Position();
	if (target != NULL && target->IsMob()) {
		if (target->IsClient()) {
			targetEntity.set_type(1);
		}
		else if (target->IsNPC()) {
			targetEntity.set_type(2);
		}
		auto mob = target->CastToMob();
		targetEntity.set_hp(mob->GetHP());
		targetEntity.set_level(mob->GetLevel());
		targetEntity.set_name(mob->GetName());
		targetPosition.set_x(mob->GetX());
		targetPosition.set_y(mob->GetY());
		targetPosition.set_z(mob->GetZ());
		targetPosition.set_h(mob->GetHeading());
		targetEntity.set_race(mob->GetRace());
		targetEntity.set_class_(mob->GetClass());
	}
	
	entity.set_allocated_position(&position);
	targetEntity.set_allocated_position(&targetPosition);
	event.set_allocated_entity(&entity);
	event.set_allocated_target(&targetEntity);

	
	std::string pubMessage;
	bool isSerialized = event.SerializeToString(&pubMessage);	
	if (!isSerialized) Log(Logs::General, Logs::Zone_Server, "NATS Failed to serialize message to string");
	Log(Logs::General, Logs::Zone_Server, "NATS Event: %d", op);
	
	s = natsConnection_Publish(conn, StringFormat("zone.%s.entity.event.%d", subscribedZonename.c_str(), ent->GetID()).c_str(), (const void*)pubMessage.c_str(), pubMessage.length());
	if (s != NATS_OK) Log(Logs::General, Logs::Zone_Server, "NATS Failed to send EntityEvent");
	entity.release_name();
	targetEntity.release_name();
	entity.release_position();
	targetEntity.release_position();
	event.release_entity();
	event.release_target();
	return;
}

bool NatsManager::isEntitySubscribed(const uint16 ID) {
	return false;
}