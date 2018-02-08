#include "nats.h"
#include "zone_config.h"
#include "../common/eqemu_logsys.h"
#include "nats_manager.h"
#include "../common/proto/message.pb.h"
#include "../common/string_util.h"

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
	natsMsg *msg = NULL;
	for (int count = 0; (s == NATS_OK) && count < 100; count++)
	{
		s = natsSubscription_NextMsg(&msg, zoneSub, 1);
		if (s != NATS_OK) break;
		Log(Logs::General, Logs::Zone_Server, "Got Message '%s'", natsMsg_GetData(msg));
		natsMsg_Destroy(msg);
	}
}

void NatsManager::Unregister()
{
	if (zoneSub != NULL) {
		s = natsSubscription_Unsubscribe(zoneSub);
		if (s != NATS_OK) {
			Log(Logs::General, Logs::Zone_Server, "Unsubscribe failed: %s", nats_GetLastError(&s));
			return;
		}
		zoneSub = NULL;
		Log(Logs::General, Logs::Zone_Server, "NATS Unsubscribed");
	}
	else {
		Log(Logs::General, Logs::Zone_Server, "Unsubscribe failed: Not subscribed");
	}
	return;
}

void NatsManager::ZoneSubscribe(const char* zonename) {
	if (subscribedZonename == zonename) return;
	if (!conn) return;
	if (zoneSub != NULL) {
		s = natsSubscription_Unsubscribe(zoneSub);
	}
	if (s != NATS_OK) Log(Logs::General, Logs::Zone_Server, "Failed to unsubscribe from zone: %s", nats_GetLastError(&s));
	subscribedZonename = zonename;
	Log(Logs::General, Logs::Zone_Server, "Subscribed to %s", zonename);

	s = natsConnection_SubscribeSync(&zoneSub, conn, zonename);
	// For maximum performance, set no limit on the number of pending messages.
	if (s == NATS_OK) s = natsSubscription_SetPendingLimits(zoneSub, -1, -1);
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

void NatsManager::Load()
{
	s = natsConnection_ConnectTo(&conn, StringFormat("nats://%s:%d", zoneConfig->NATSHost.c_str(), zoneConfig->NATSPort).c_str());
	if (s != NATS_OK) {
		Log(Logs::General, Logs::Zone_Server, "Nats status isn't OK: %s", nats_GetLastError(&s));
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
		Log(Logs::General, Logs::Zone_Server, "Failed to serialize dailygain to string");
		return;
	}
	s = natsConnection_PublishString(conn, "DailyGain", pubMessage.c_str());
	if (s != NATS_OK) Log(Logs::General, Logs::Zone_Server, "Failed to send DailyGain: %s", nats_GetLastError(&s));	
}
