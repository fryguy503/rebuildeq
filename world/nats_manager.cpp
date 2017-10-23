#include "nats_manager.h"
#include "nats.h"
#include "../common/eqemu_logsys.h";

NatsManager::NatsManager()
{
	//new timers, object initialization
}

NatsManager::~NatsManager()
{
	//safe_delete timers
}


void NatsManager::Process()
{
	//timer checks
}

void NatsManager::Save()
{
	return;
}

void NatsManager::Load()
{
	natsStatistics  *stats = NULL;
	natsOptions     *opts = NULL;
	int64_t         last = 0;
	natsStatus      s;
	int64_t			start = 0;

	int total = 2;
	char * subj = "test";
	char * txt = "Hello, World";

	Log(Logs::General, Logs::World_Server, "Sending %i messages to subject '%s'", total, subj);
	

	s = natsConnection_Connect(&conn, opts);
	if (s != NATS_OK) {
		Log(Logs::General, Logs::World_Server, "Nats status isn't OK, hmm.");
		return;
	}

	if (s == NATS_OK)
		s = natsStatistics_Create(&stats);

	if (s == NATS_OK)
		start = nats_Now();

	int count = 0;
	for (count = 0; (s == NATS_OK) && (count < total); count++)
	{
		s = natsConnection_PublishString(conn, subj, txt);
	}

	if (s == NATS_OK)
		s = natsConnection_FlushTimeout(conn, 1000);

	if (s == NATS_OK)
	{
		//printStats(STATS_OUT, conn, NULL, stats);
		Log(Logs::General, Logs::World_Server, "Sent %i %i %i", total, start);
	}
	else
	{
		Log(Logs::General, Logs::World_Server, "NATS error: %d - %s", s, natsStatus_GetText(s));
		nats_PrintLastErrorStack(stderr);
	}

	// Destroy all our objects to avoid report of memory leak
	natsStatistics_Destroy(stats);
	natsConnection_Destroy(conn);
	natsOptions_Destroy(opts);

	// To silence reports of memory still in used with valgrind
	nats_Close();

	return;
}
