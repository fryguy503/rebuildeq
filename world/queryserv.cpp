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
#include "../common/emu_tcp_connection.h"
#include "../common/packet_dump.h"

extern ClientList client_list;
extern ZSList zoneserver_list;

extern ConsoleList console_list;
extern volatile bool RunLoops;
extern UCSConnection UCSLink;
extern QueryServConnection QSLink;

QueryServConnection::QueryServConnection()
{
	Stream = 0;
	authenticated = false;
}

void QueryServConnection::SetConnection(EmuTCPConnection *inStream)
{
	if(Stream)
	{
		Log.Out(Logs::Detail, Logs::QS_Server, "Incoming QueryServ Connection while we were already connected to a QueryServ.");
		Stream->Disconnect();
	}

	Stream = inStream;

	authenticated = false;
}

bool QueryServConnection::Process()
{
	if (!Stream || !Stream->Connected())
		return false;

	ServerPacket *pack = 0;

	while((pack = Stream->PopPacket()))
	{
		if (!authenticated)
		{
			if (WorldConfig::get()->SharedKey.length() > 0)
			{
				if (pack->opcode == ServerOP_ZAAuth && pack->size == 16)
				{
					uint8 tmppass[16];

					MD5::Generate((const uchar*) WorldConfig::get()->SharedKey.c_str(), WorldConfig::get()->SharedKey.length(), tmppass);

					if (memcmp(pack->pBuffer, tmppass, 16) == 0)
						authenticated = true;
					else
					{
						struct in_addr in;
						in.s_addr = GetIP();
						Log.Out(Logs::Detail, Logs::QS_Server, "QueryServ authorization failed.");
						auto pack = new ServerPacket(ServerOP_ZAAuthFailed);
						SendPacket(pack);
						delete pack;
						Disconnect();
						return false;
					}
				}
				else
				{
					struct in_addr in;
					in.s_addr = GetIP();
					Log.Out(Logs::Detail, Logs::QS_Server, "QueryServ authorization failed.");
					auto pack = new ServerPacket(ServerOP_ZAAuthFailed);
					SendPacket(pack);
					delete pack;
					Disconnect();
					return false;
				}
			}
			else
			{
				Log.Out(Logs::Detail, Logs::QS_Server,"**WARNING** You have not configured a world shared key in your config file. You should add a <key>STRING</key> element to your <world> element to prevent unauthroized zone access.");
				authenticated = true;
			}
			delete pack;
			continue;
		}
		switch(pack->opcode)
		{
			case 0:
				break;

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
			case ServerOP_ChannelMessage: {
				if (pack->size < sizeof(ServerChannelMessage_Struct))
					break;
				ServerChannelMessage_Struct* scm = (ServerChannelMessage_Struct*)pack->pBuffer;
				
				if (scm->chan_num == 7 || scm->chan_num == 14) {
					if (scm->deliverto[0] == '*') {
						Console* con = 0;
						con = console_list.FindByAccountName(&scm->deliverto[1]);
						if (((!con) || (!con->SendChannelMessage(scm))) && (!scm->noreply))
							zoneserver_list.SendEmoteMessage(scm->from, 0, 0, 0, "%s is not online at this time.", scm->to);
						break;
					}
					ClientListEntry* cle = client_list.FindCharacter(scm->deliverto);
					if (cle == 0 || cle->Online() < CLE_Status_Zoning ||
						(cle->TellsOff() && ((cle->Anon() == 1 && scm->fromadmin < cle->Admin()) || scm->fromadmin < 80))) {
						if (!scm->noreply) {
							ClientListEntry* sender = client_list.FindCharacter(scm->from);
							if (!sender || !sender->Server())
								break;
							scm->noreply = true;
							scm->queued = 3; // offline
							strcpy(scm->deliverto, scm->from);
							// ideally this would be trimming off the message too, oh well
							sender->Server()->SendPacket(pack);
						}
					}
					else if (cle->Online() == CLE_Status_Zoning) {
						if (!scm->noreply) {
							ClientListEntry* sender = client_list.FindCharacter(scm->from);
							if (cle->TellQueueFull()) {
								if (!sender || !sender->Server())
									break;
								scm->noreply = true;
								scm->queued = 2; // queue full
								strcpy(scm->deliverto, scm->from);
								sender->Server()->SendPacket(pack);
							}
							else {
								size_t struct_size = sizeof(ServerChannelMessage_Struct) + strlen(scm->message) + 1;
								ServerChannelMessage_Struct *temp = (ServerChannelMessage_Struct *) new uchar[struct_size];
								memset(temp, 0, struct_size); // just in case, was seeing some corrupt messages, but it shouldn't happen
								memcpy(temp, scm, struct_size);
								temp->noreply = true;
								cle->PushToTellQueue(temp); // deallocation is handled in processing or deconstructor

								if (!sender || !sender->Server())
									break;
								scm->noreply = true;
								scm->queued = 1; // queued
								strcpy(scm->deliverto, scm->from);
								sender->Server()->SendPacket(pack);
							}
						}
					}
					else if (cle->Server() == 0) {
						if (!scm->noreply)
							zoneserver_list.SendEmoteMessage(scm->from, 0, 0, 0, "You told %s, '%s is not contactable at this time'", scm->to, scm->to);
					}
					else
						cle->Server()->SendPacket(pack);
				}
				else {
					if (scm->chan_num == 5 || scm->chan_num == 6 || scm->chan_num == 11) {
						console_list.SendChannelMessage(scm);
					}
					zoneserver_list.SendPacket(pack);
				}
				break;
			}
			default:
			{
				Log.Out(Logs::Detail, Logs::QS_Server, "Unknown ServerOPcode from QueryServ 0x%04x, size %d", pack->opcode, pack->size);
				DumpPacket(pack->pBuffer, pack->size);
				break;
			}
		}

		delete pack;
	}
	return(true);
}

bool QueryServConnection::SendPacket(ServerPacket* pack)
{
	if(!Stream)
		return false;

	return Stream->SendPacket(pack);
}

