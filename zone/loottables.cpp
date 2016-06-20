/*	EQEMu: Everquest Server Emulator
	Copyright (C) 2001-2002 EQEMu Development Team (http://eqemu.org)

	This program is free software; you can redistribute it and/or modify
	it under the terms of the GNU General Public License as published by
	the Free Software Foundation; version 2 of the License.

	This program is distributed in the hope that it will be useful,
	but WITHOUT ANY WARRANTY except by those people which sell it, which
	are required to give you total support for your newly bought product;
	without even the implied warranty of MERCHANTABILITY or FITNESS FOR
	A PARTICULAR PURPOSE. See the GNU General Public License for more details.

	You should have received a copy of the GNU General Public License
	along with this program; if not, write to the Free Software
	Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
*/

#include "../common/global_define.h"
#include "../common/loottable.h"
#include "../common/misc_functions.h"
#include "../common/data_verification.h"

#include "client.h"
#include "entity.h"
#include "mob.h"
#include "npc.h"
#include "zonedb.h"

#include <iostream>
#include <stdlib.h>

#ifdef _WINDOWS
#define snprintf	_snprintf
#endif

// Queries the loottable: adds item & coin to the npc
void ZoneDatabase::AddLootTableToNPC(NPC* npc,uint32 loottable_id, ItemList* itemlist, uint32* copper, uint32* silver, uint32* gold, uint32* plat) {
	const LootTable_Struct* lts = nullptr;
	*copper = 0;
	*silver = 0;
	*gold = 0;
	*plat = 0;

	lts = database.GetLootTable(loottable_id);
	if (!lts)
		return;

	uint32 min_cash = lts->mincash;
	uint32 max_cash = lts->maxcash;
	if(min_cash > max_cash) {
		uint32 t = min_cash;
		min_cash = max_cash;
		max_cash = t;
	}

	uint32 cash = 0;
	if(max_cash > 0 && lts->avgcoin > 0 && EQEmu::ValueWithin(lts->avgcoin, min_cash, max_cash)) {
		float upper_chance = (float)(lts->avgcoin - min_cash) / (float)(max_cash - min_cash);
		float avg_cash_roll = (float)zone->random.Real(0.0, 1.0);

		if(avg_cash_roll < upper_chance) {
			cash = zone->random.Int(lts->avgcoin, max_cash);
		} else {
			cash = zone->random.Int(min_cash, lts->avgcoin);
		}
	} else {
		cash = zone->random.Int(min_cash, max_cash);
	}

	if(cash != 0) {
		*plat = cash / 1000;
		cash -= *plat * 1000;

		*gold = cash / 100;
		cash -= *gold * 100;

		*silver = cash / 10;
		cash -= *silver * 10;

		*copper = cash;
	}

	// Do items
	for (uint32 i=0; i<lts->NumEntries; i++) {
		for (uint32 k = 1; k <= lts->Entries[i].multiplier; k++) {
			uint8 droplimit = lts->Entries[i].droplimit;
			uint8 mindrop = lts->Entries[i].mindrop;

			//LootTable Entry probability
			float ltchance = 0.0f;
			ltchance = lts->Entries[i].probability;

			float drop_chance = 0.0f;
			if(ltchance > 0.0 && ltchance < 100.0) {
				drop_chance = (float)zone->random.Real(0.0, 100.0);
			}

			if (ltchance != 0.0 && (ltchance == 100.0 || drop_chance <= ltchance)) {
				AddLootDropToNPC(npc, lts->Entries[i].lootdrop_id, itemlist, droplimit, mindrop);
			}
		}
	}
}

// Called by AddLootTableToNPC
// maxdrops = size of the array npcd
void ZoneDatabase::AddLootDropToNPC(NPC* npc,uint32 lootdrop_id, ItemList* itemlist, uint8 droplimit, uint8 mindrop) {
	const LootDrop_Struct* lds = GetLootDrop(lootdrop_id);
	if (!lds) {
		return;
	}

	if(lds->NumEntries == 0)
		return;

	if(droplimit == 0 && mindrop == 0) {
		for(uint32 i = 0; i < lds->NumEntries; ++i) {
			int charges = lds->Entries[i].multiplier;
			for(int j = 0; j < charges; ++j) {
				if(zone->random.Real(0.0, 100.0) <= lds->Entries[i].chance) {
					const EQEmu::Item_Struct* dbitem = GetItem(lds->Entries[i].item_id);
					npc->AddLootDrop(dbitem, itemlist, lds->Entries[i].item_charges, lds->Entries[i].minlevel,
									lds->Entries[i].maxlevel, lds->Entries[i].equip_item > 0 ? true : false, false);
				}
			}
		}
		return;
	}

	if(lds->NumEntries > 100 && droplimit == 0) {
		droplimit = 10;
	}

	if(droplimit < mindrop) {
		droplimit = mindrop;
	}

	float roll_t = 0.0f;
	float roll_t_min = 0.0f;
	bool active_item_list = false;
	for(uint32 i = 0; i < lds->NumEntries; ++i) {
		const EQEmu::Item_Struct* db_item = GetItem(lds->Entries[i].item_id);
		if(db_item) {
			roll_t += lds->Entries[i].chance;
			active_item_list = true;
		}
	}

	roll_t_min = roll_t;
	roll_t = EQEmu::ClampLower(roll_t, 100.0f);

	if(!active_item_list) {
		return;
	}

	for(int i = 0; i < mindrop; ++i) {
		float roll = (float)zone->random.Real(0.0, roll_t_min);
		for(uint32 j = 0; j < lds->NumEntries; ++j) {
			const EQEmu::Item_Struct* db_item = GetItem(lds->Entries[j].item_id);
			if(db_item) {
				if(roll < lds->Entries[j].chance) {
					npc->AddLootDrop(db_item, itemlist, lds->Entries[j].item_charges, lds->Entries[j].minlevel,
									 lds->Entries[j].maxlevel, lds->Entries[j].equip_item > 0 ? true : false, false);

					int charges = (int)lds->Entries[i].multiplier;
					charges = EQEmu::ClampLower(charges, 1);

					for(int k = 1; k < charges; ++k) {
						float c_roll = (float)zone->random.Real(0.0, 100.0);
						if(c_roll <= lds->Entries[i].chance) {
							npc->AddLootDrop(db_item, itemlist, lds->Entries[j].item_charges, lds->Entries[j].minlevel,
											 lds->Entries[j].maxlevel, lds->Entries[j].equip_item > 0 ? true : false, false);
						}
					}

					j = lds->NumEntries;
					break;
				}
				else {
					roll -= lds->Entries[j].chance;
				}
			}
		}
	}

	for(int i = mindrop; i < droplimit; ++i) {
		float roll = (float)zone->random.Real(0.0, roll_t);
		for(uint32 j = 0; j < lds->NumEntries; ++j) {
			const EQEmu::Item_Struct* db_item = GetItem(lds->Entries[j].item_id);
			if(db_item) {
				if(roll < lds->Entries[j].chance) {
					npc->AddLootDrop(db_item, itemlist, lds->Entries[j].item_charges, lds->Entries[j].minlevel,
										lds->Entries[j].maxlevel, lds->Entries[j].equip_item > 0 ? true : false, false);

					int charges = (int)lds->Entries[i].multiplier;
					charges = EQEmu::ClampLower(charges, 1);

					for(int k = 1; k < charges; ++k) {
						float c_roll = (float)zone->random.Real(0.0, 100.0);
						if(c_roll <= lds->Entries[i].chance) {
							npc->AddLootDrop(db_item, itemlist, lds->Entries[j].item_charges, lds->Entries[j].minlevel,
											lds->Entries[j].maxlevel, lds->Entries[j].equip_item > 0 ? true : false, false);
						}
					}

					j = lds->NumEntries;
					break;
				}
				else {
					roll -= lds->Entries[j].chance;
				}
			}
		}
	} // We either ran out of items or reached our limit.

	npc->UpdateEquipmentLight();
	// no wearchange associated with this function..so, this should not be needed
	//if (npc->UpdateActiveLightValue())
	//	npc->SendAppearancePacket(AT_Light, npc->GetActiveLightValue());
}

//if itemlist is null, just send wear changes
void NPC::AddLootDrop(const EQEmu::Item_Struct *item2, ItemList* itemlist, int16 charges, uint8 minlevel, uint8 maxlevel, bool equipit, bool wearchange) {
	if(item2 == nullptr)
		return;

	//make sure we are doing something...
	if(!itemlist && !wearchange)
		return;

	auto item = new ServerLootItem_Struct;
#if EQDEBUG>=11
		Log.Out(Logs::General, Logs::None, "Adding drop to npc: %s, Item: %i", GetName(), item2->ID);
#endif

	EQApplicationPacket* outapp = nullptr;
	WearChange_Struct* wc = nullptr;
	if(wearchange) {
		outapp = new EQApplicationPacket(OP_WearChange, sizeof(WearChange_Struct));
		wc = (WearChange_Struct*)outapp->pBuffer;
		wc->spawn_id = GetID();
		wc->material=0;
	}

	item->item_id = item2->ID;
	item->charges = charges;
	item->aug_1 = 0;
	item->aug_2 = 0;
	item->aug_3 = 0;
	item->aug_4 = 0;
	item->aug_5 = 0;
	item->aug_6 = 0;
	item->attuned = 0;
	item->min_level = minlevel;
	item->max_level = maxlevel;

	if (equipit) {
		uint8 eslot = 0xFF;
		char newid[20];
		const EQEmu::Item_Struct* compitem = nullptr;
		bool found = false; // track if we found an empty slot we fit into
		int32 foundslot = -1; // for multi-slot items

		// Equip rules are as follows:
		// If the item has the NoPet flag set it will not be equipped.
		// An empty slot takes priority. The first empty one that an item can
		// fit into will be the one picked for the item.
		// AC is the primary choice for which item gets picked for a slot.
		// If AC is identical HP is considered next.
		// If an item can fit into multiple slots we'll pick the last one where
		// it is an improvement.

		if (!item2->NoPet) {
			for (int i = 0; !found && i < EQEmu::legacy::EQUIPMENT_SIZE; i++) {
				uint32 slots = (1 << i);
				if (item2->Slots & slots) {
					if(equipment[i])
					{
						compitem = database.GetItem(equipment[i]);
						if (item2->AC > compitem->AC ||
							(item2->AC == compitem->AC && item2->HP > compitem->HP))
						{
							// item would be an upgrade
							// check if we're multi-slot, if yes then we have to keep
							// looking in case any of the other slots we can fit into are empty.
							if (item2->Slots != slots) {
								foundslot = i;
							}
							else {
								equipment[i] = item2->ID;
								foundslot = i;
								found = true;
							}
						} // end if ac
					}
					else
					{
						equipment[i] = item2->ID;
						foundslot = i;
						found = true;
					}
				} // end if (slots)
			} // end for
		} // end if NoPet

		// Possible slot was found but not selected. Pick it now.
		if (!found && foundslot >= 0) {
			equipment[foundslot] = item2->ID;
			found = true;
		}

		// @merth: IDFile size has been increased, this needs to change
		uint16 emat;
		if(item2->Material <= 0
			|| item2->Slots & (1 << EQEmu::legacy::SlotPrimary | 1 << EQEmu::legacy::SlotSecondary)) {
			memset(newid, 0, sizeof(newid));
			for(int i=0;i<7;i++){
				if (!isalpha(item2->IDFile[i])){
					strn0cpy(newid, &item2->IDFile[i],6);
					i=8;
				}
			}

			emat = atoi(newid);
		} else {
			emat = item2->Material;
		}

		if (foundslot == EQEmu::legacy::SlotPrimary) {
			if (item2->Proc.Effect != 0)
				CastToMob()->AddProcToWeapon(item2->Proc.Effect, true);

			eslot = EQEmu::legacy::MaterialPrimary;
			if (item2->Damage > 0)
				SendAddPlayerState(PlayerState::PrimaryWeaponEquipped);
			if (item2->IsType2HWeapon())
				SetTwoHanderEquipped(true);
		}
		else if (foundslot == EQEmu::legacy::SlotSecondary
			&& (GetOwner() != nullptr || (CanThisClassDualWield() && zone->random.Roll(NPC_DW_CHANCE)) || (item2->Damage==0)) &&
			(item2->IsType1HWeapon() || item2->ItemType == EQEmu::item::ItemTypeShield))
		{
			if (item2->Proc.Effect!=0)
				CastToMob()->AddProcToWeapon(item2->Proc.Effect, true);

			eslot = EQEmu::legacy::MaterialSecondary;
			if (item2->Damage > 0)
				SendAddPlayerState(PlayerState::SecondaryWeaponEquipped);
		}
		else if (foundslot == EQEmu::legacy::SlotHead) {
			eslot = EQEmu::legacy::MaterialHead;
		}
		else if (foundslot == EQEmu::legacy::SlotChest) {
			eslot = EQEmu::legacy::MaterialChest;
		}
		else if (foundslot == EQEmu::legacy::SlotArms) {
			eslot = EQEmu::legacy::MaterialArms;
		}
		else if (foundslot == EQEmu::legacy::SlotWrist1 || foundslot == EQEmu::legacy::SlotWrist2) {
			eslot = EQEmu::legacy::MaterialWrist;
		}
		else if (foundslot == EQEmu::legacy::SlotHands) {
			eslot = EQEmu::legacy::MaterialHands;
		}
		else if (foundslot == EQEmu::legacy::SlotLegs) {
			eslot = EQEmu::legacy::MaterialLegs;
		}
		else if (foundslot == EQEmu::legacy::SlotFeet) {
			eslot = EQEmu::legacy::MaterialFeet;
		}

		/*
		what was this about???

		if (((npc->GetRace()==127) && (npc->CastToMob()->GetOwnerID()!=0)) && (item2->Slots==24576) || (item2->Slots==8192) || (item2->Slots==16384)){
			npc->d_melee_texture2=atoi(newid);
			wc->wear_slot_id=8;
			if (item2->Material >0)
				wc->material=item2->Material;
			else
				wc->material=atoi(newid);
			npc->AC+=item2->AC;
			npc->STR+=item2->STR;
			npc->INT+=item2->INT;
		}
		*/

		//if we found an open slot it goes in...
		if(eslot != 0xFF) {
			if(wearchange) {
				wc->wear_slot_id = eslot;
				wc->material = emat;
			}

		}
		if (found) {
			CalcBonuses(); // This is less than ideal for bulk adding of items
		}
		item->equip_slot = item2->Slots;
	}

	if(itemlist != nullptr)
		itemlist->push_back(item);
	else
		safe_delete(item);

	if(wearchange && outapp) {
		entity_list.QueueClients(this, outapp);
		safe_delete(outapp);
	}

	UpdateEquipmentLight();
	if (UpdateActiveLight())
		SendAppearancePacket(AT_Light, GetActiveLightType());
}

void NPC::AddItem(const EQEmu::Item_Struct* item, uint16 charges, bool equipitem) {
	//slot isnt needed, its determined from the item.
	AddLootDrop(item, &itemlist, charges, 1, 127, equipitem, equipitem);
}

void NPC::AddItem(uint32 itemid, uint16 charges, bool equipitem) {
	//slot isnt needed, its determined from the item.
	const EQEmu::Item_Struct * i = database.GetItem(itemid);
	if(i == nullptr)
		return;
	AddLootDrop(i, &itemlist, charges, 1, 127, equipitem, equipitem);
}

void NPC::AddLootTable() {
	if (npctype_id != 0) { // check if it's a GM spawn
		AddCardTable();
		AddTeleportTable();
		database.AddLootTableToNPC(this,loottable_id, &itemlist, &copper, &silver, &gold, &platinum);
	}
}

void NPC::AddLootTable(uint32 ldid) {
	if (npctype_id != 0) { // check if it's a GM spawn
		if (GetLevel() >= 55 && zone->random.Roll(1)) {
			AddItem(100006, 1, false); //elunium
		}
	  AddCardTable();
	  AddTeleportTable();
	  database.AddLootTableToNPC(this,ldid, &itemlist, &copper, &silver, &gold, &platinum);
	}
}

//Adds Card Drops to NPC
void NPC::AddCardTable() {
	if (npctype_id == 0) return;

	if ((GetBodyType() == BT_VeliousDragon) && zone->random.Int(1,200)) AddItem(100100, 1, false); //Dragon Card
	if ((GetBodyType() == BT_Insect) && zone->random.Int(1,200)) AddItem(100101, 1, false); //Insect Card
	if ((GetBodyType() == BT_Animal) && zone->random.Int(1,200)) AddItem(100102, 1, false); //Animal Card
	if ((GetBodyType() == BT_Construct) && zone->random.Int(1,200)) AddItem(100103, 1, false); //Construct Card
	if ((GetBodyType() == BT_Extraplanar) && zone->random.Int(1,200)) AddItem(100104, 1, false); //Extra Planar Card
	if ((GetBodyType() == BT_Giant || GetBodyType() == BT_RaidGiant || GetBodyType() == BT_Zek) && zone->random.Int(1,200)) AddItem(100105, 1, false); //Giant Card
	if ((GetBodyType() == BT_Humanoid) && zone->random.Int(1,200)) AddItem(100106, 1, false); //Humanoid Card
	if ((GetBodyType() == BT_Lycanthrope) && zone->random.Int(1,200)) AddItem(100107, 1, false); //Lycanthrope Card
	if ((GetBodyType() == BT_Magical) && zone->random.Int(1,200)) AddItem(100108, 1, false); //Magical Card 50mana
	if ((GetBodyType() == BT_Monster) && zone->random.Int(1,200)) AddItem(100109, 1, false); //Monster Card
	if ((GetBodyType() == BT_Plant) && zone->random.Int(1,200)) AddItem(100110, 1, false); //Plant Card
	if ((GetBodyType() == BT_Summoned || GetBodyType() == BT_Summoned2 || GetBodyType() == BT_Summoned3 || GetBodyType() == BT_SummonedUndead) && zone->random.Int(1,200)) AddItem(100111, 1, false); //Summoned Card
	if ((GetBodyType() == BT_Undead || GetBodyType() == BT_SummonedUndead || GetBodyType() == BT_Vampire) && zone->random.Int(1,200)) AddItem(100112, 1, false); //Undead Card
	if ((GetRace() == 39) && zone->random.Int(1,200)) AddItem(100113, 1, false); //Gnoll Card 50hp
	if ((GetRace() == 13) && zone->random.Int(1,200)) AddItem(100114, 1, false); //Aviak Card
	if ((GetRace() == 14) && zone->random.Int(1,200)) AddItem(100115, 1, false); //Werewolf Card
	if ((GetRace() == 38) && zone->random.Int(1,200)) AddItem(100116, 1, false); //Spider Card
	if ((GetRace() == 54) && zone->random.Int(1,200)) AddItem(100117, 1, false); //Orc Card 15ac	
	if ((GetRace() == 28 || GetRace() == 456) && zone->random.Int(1,200)) AddItem(100118, 1, false); //Fungus Card
	if ((GetRace() == 40) && zone->random.Int(1,200)) AddItem(100119, 1, false); //Goblin Card	
	if ((GetBodyType() == BT_Monster) && zone->random.Int(1,200)) AddItem(100120, 1, false); //Evil Eye Card
	if ((GetRace() == HUMAN) && zone->random.Int(1,200)) AddItem(100121, 1, false); //Human Card
	if ((GetRace() == BARBARIAN) && zone->random.Int(1,200)) AddItem(100122, 1, false); //Barbarian Card
	if ((GetRace() == ERUDITE) && zone->random.Int(1,200)) AddItem(100123, 1, false); //Erudite Card
	if ((GetRace() == WOOD_ELF) && zone->random.Int(1,200)) AddItem(100124, 1, false); //Wood Elf Card
	if ((GetRace() == HIGH_ELF) && zone->random.Int(1,200)) AddItem(100125, 1, false); //High Elf Card
	if ((GetRace() == DARK_ELF) && zone->random.Int(1,200)) AddItem(100126, 1, false); //Dark Elf Card
	if ((GetRace() == HALF_ELF) && zone->random.Int(1,200)) AddItem(100127, 1, false); //Half Elf Card
	if ((GetRace() == DWARF) && zone->random.Int(1,200)) AddItem(100128, 1, false); //Dwarf Card
	if ((GetRace() == TROLL) && zone->random.Int(1,200)) AddItem(100129, 1, false); //Troll Card
	if ((GetRace() == OGRE) && zone->random.Int(1,200)) AddItem(100130, 1, false); //Ogre Card
	if ((GetRace() == HALFLING) && zone->random.Int(1,200)) AddItem(100131, 1, false); //Halfling Card
	if ((GetRace() == GNOME) && zone->random.Int(1,200)) AddItem(100132, 1, false); //Gnome Card
	if ((GetRace() == FROGLOK || GetRace() == FROGLOK2) && zone->random.Int(1,200)) AddItem(100133, 1, false); //Froglok Card
	if ((GetRace() == INVISIBLE_MAN || GetRace() == DERVISH) && zone->random.Int(1,200)) AddItem(100134, 1, false); //Shadowed Man Card
	//(GetBodyType() == BT_Dragon || GetBodyType() == BT_Dragon3 ||  Wyvern Card?
	return;
}


void NPC::AddTeleportTable() {
	if (npctype_id == 0) return;

	if (GetZoneID() == 118 && zone->random.Roll(1)) AddItem(100008, 1, false); //GreatDivide
	if (GetZoneID() == 119 && zone->random.Roll(1)) AddItem(100009, 1, false); //Wakening
	if (GetZoneID() == 110 && zone->random.Roll(1)) AddItem(100010, 1, false); //Iceclad
	if (GetZoneID() == 117 && zone->random.Roll(1)) AddItem(100011, 1, false); //CobaltScar
	if (GetZoneID() == 91 && zone->random.Roll(1)) AddItem(100012, 1, false); //Skyfire
	if (GetZoneID() == 94 && zone->random.Roll(1)) AddItem(100013, 1, false); //Emerald Jungle
}