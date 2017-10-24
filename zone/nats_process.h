#include "nats.h"

#include "../common/global_define.h"
#include "../common/types.h"
//#include "../common/timer.h"


class Nats
{
public:
	Nats();
	~Nats();

	void Process(const char * zonename);
	void Unregister();
	void Load();
protected:
	natsConnection *conn = NULL;
	natsStatus      s;
	natsStatistics *stats = NULL;
	natsOptions *opts = NULL;
	natsSubscription *zoneSub = NULL;
	const char * subscribedZonename;
	//int testSubMax = 100;
};