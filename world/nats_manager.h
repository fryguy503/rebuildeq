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
protected:
	//add properties here
	natsConnection  *conn = NULL;
};

#endif