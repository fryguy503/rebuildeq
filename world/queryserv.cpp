#include "../common/global_define.h"
#include "../common/eqemu_logsys.h"
#include "queryserv.h"
#include "world_config.h"
#include "clientlist.h"
#include "zonelist.h"
#include "cliententry.h"
#include "console.h"
#include "ucs.h"
#include "zoneserver.h"

#include "../common/md5.h"
#include "../common/packet_dump.h"

extern ClientList client_list;
extern ZSList zoneserver_list;

extern ConsoleList console_list;
extern volatile bool RunLoops;
extern UCSConnection UCSLink;
extern QueryServConnection QSLink;

QueryServConnection::QueryServConnection()
{
}

void QueryServConnection::AddConnection(std::shared_ptr<EQ::Net::ServertalkServerConnection> connection)
{
	//Set handlers
	connection->OnMessage(ServerOP_QueryServGeneric, std::bind(&QueryServConnection::HandleGenericMessage, this, std::placeholders::_1, std::placeholders::_2));
	connection->OnMessage(ServerOP_LFGuildUpdate, std::bind(&QueryServConnection::HandleLFGuildUpdateMessage, this, std::placeholders::_1, std::placeholders::_2));
	m_streams.insert(std::make_pair(connection->GetUUID(), connection));
}

void QueryServConnection::RemoveConnection(std::shared_ptr<EQ::Net::ServertalkServerConnection> connection)
{
	auto iter = m_streams.find(connection->GetUUID());
	if (iter != m_streams.end()) {
		m_streams.erase(iter);
	}
}

			case ServerOP_KeepAlive:
			{
				// ignore this
				break;
			}
			case ServerOP_ZAAuth:
			{
				Log.Out(Logs::Detail, Logs::QS_Server, "Got authentication from QueryServ when they are already authenticated.");
				break;
			}
			case ServerOP_QueryServGeneric:
			{
				uint32 ZoneID = pack->ReadUInt32();
				uint16 InstanceID = pack->ReadUInt32();
				zoneserver_list.SendPacket(ZoneID, InstanceID, pack);
				break;
			}
			case ServerOP_LFGuildUpdate:
			{
				zoneserver_list.SendPacket(pack);
				break;
			}
			default:
			{
				Log.Out(Logs::Detail, Logs::QS_Server, "Unknown ServerOPcode from QueryServ 0x%04x, size %d", pack->opcode, pack->size);
				DumpPacket(pack->pBuffer, pack->size);
				break;
			}
		}

void QueryServConnection::HandleLFGuildUpdateMessage(uint16_t opcode, EQ::Net::Packet &p) {
	ServerPacket pack(opcode, p);
	zoneserver_list.SendPacket(&pack);
}

bool QueryServConnection::SendPacket(ServerPacket* pack)
{
	for (auto &stream : m_streams) {
		stream.second->SendPacket(pack);
	}

	return true;
}
