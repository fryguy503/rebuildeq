/*	EQEMu: Everquest Server Emulator
	Copyright (C) 2001-2003 EQEMu Development Team (http://eqemulator.net)

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
#include "../common/features.h"
#include "../common/rulesys.h"
#include "../common/string_util.h"

#include "client.h"
#include "groups.h"
#include "mob.h"
#include "raids.h"

#include "queryserv.h"
#include "quest_parser_collection.h"
#include "string_ids.h"

#ifdef BOTS
#include "bot.h"
#endif

extern QueryServ* QServ;


static uint32 MaxBankedGroupLeadershipPoints(int Level)
{
	if(Level < 35)
		return 4;

	if(Level < 51)
		return 6;

	return 8;
}

static uint32 MaxBankedRaidLeadershipPoints(int Level)
{
	if(Level < 45)
		return 6;

	if(Level < 55)
		return 8;

	return 10;
}

uint32 Client::CalcEXP(uint8 conlevel) {

	uint32 in_add_exp = EXP_FORMULA;


	if((XPRate != 0))
		in_add_exp = static_cast<uint32>(in_add_exp * (static_cast<float>(XPRate) / 100.0f));

	float totalmod = 1.0;
	float zemmod = 1.0;
	//get modifiers
	if(RuleR(Character, ExpMultiplier) >= 0){
		totalmod *= RuleR(Character, ExpMultiplier);
	}

	if(zone->newzone_data.zone_exp_multiplier >= 0){
		zemmod *= zone->newzone_data.zone_exp_multiplier;
	}

	if(RuleB(Character,UseRaceClassExpBonuses))
	{
		if(GetBaseRace() == HALFLING){
			totalmod *= 1.05;
		}

		if(GetClass() == ROGUE || GetClass() == WARRIOR){
			totalmod *= 1.05;
		}
	}

	if(zone->IsHotzone())
	{
		totalmod += RuleR(Zone, HotZoneBonus);
	}

	in_add_exp = uint32(float(in_add_exp) * totalmod * zemmod);

	if(RuleB(Character,UseXPConScaling))
	{
		if (conlevel != 0xFF) {
			switch (conlevel)
			{
			case CON_GREEN:
				in_add_exp = 0;
				return 0;
			case CON_LIGHTBLUE:
				in_add_exp = in_add_exp * RuleI(Character, LightBlueModifier)/100;
				break;
			case CON_BLUE:
				in_add_exp = in_add_exp * RuleI(Character, BlueModifier)/100;
				break;
			case CON_WHITE:
				in_add_exp = in_add_exp * RuleI(Character, WhiteModifier)/100;
				break;
			case CON_YELLOW:
				in_add_exp = in_add_exp * RuleI(Character, YellowModifier)/100;
				break;
			case CON_RED:
				in_add_exp = in_add_exp * RuleI(Character, RedModifier)/100;
				break;
			}
		}
	}

	float aatotalmod = 1.0;
	if(zone->newzone_data.zone_exp_multiplier >= 0){
		aatotalmod *= zone->newzone_data.zone_exp_multiplier;
	}



	if(RuleB(Character,UseRaceClassExpBonuses))
	{
		if(GetBaseRace() == HALFLING){
			aatotalmod *= 1.05;
		}

		if(GetClass() == ROGUE || GetClass() == WARRIOR){
			aatotalmod *= 1.05;
		}
	}

	if(RuleB(Zone, LevelBasedEXPMods)){
		if(zone->level_exp_mod[GetLevel()].ExpMod){
			in_add_exp *= zone->level_exp_mod[GetLevel()].ExpMod;
		}
	}

	return in_add_exp;
}

void Client::AddEXP(uint32 in_add_exp, uint8 conlevel, bool resexp) {

	this->EVENT_ITEM_ScriptStopReturn();

	uint32 add_exp = in_add_exp;

	if(!resexp && (XPRate != 0))
		add_exp = static_cast<uint32>(in_add_exp * (static_cast<float>(XPRate) / 100.0f));

	if (m_epp.perAA<0 || m_epp.perAA>100)
		m_epp.perAA=0;	// stop exploit with sanity check

	uint32 add_aaxp;
	if(resexp) {
		add_aaxp = 0;
	} else {

		//figure out how much of this goes to AAs
		add_aaxp = add_exp * m_epp.perAA / 100;
		//take that amount away from regular exp
		add_exp -= add_aaxp;

		float totalmod = 1.0;
		float zemmod = 1.0;
		//get modifiers
		if(RuleR(Character, ExpMultiplier) >= 0){
			totalmod *= RuleR(Character, ExpMultiplier);
		}

		if(zone->newzone_data.zone_exp_multiplier >= 0){
			zemmod *= zone->newzone_data.zone_exp_multiplier;
		}

		if(RuleB(Character,UseRaceClassExpBonuses))
		{
			if(GetBaseRace() == HALFLING){
				totalmod *= 1.05;
			}

			if(GetClass() == ROGUE || GetClass() == WARRIOR){
				totalmod *= 1.05;
			}
		}

		if(zone->IsHotzone())
		{
			totalmod += RuleR(Zone, HotZoneBonus);
		}

		add_exp = uint32(float(add_exp) * totalmod * zemmod);

		if(RuleB(Character,UseXPConScaling))
		{
			if (conlevel != 0xFF && !resexp) {
				switch (conlevel)
				{
					case CON_GREEN:
						add_exp = 0;
						add_aaxp = 0;
						return;
					case CON_LIGHTBLUE:
							add_exp = add_exp * RuleI(Character, LightBlueModifier)/100;
							add_aaxp = add_aaxp * RuleI(Character, LightBlueModifier)/100;
						break;
					case CON_BLUE:
							add_exp = add_exp * RuleI(Character, BlueModifier)/100;
							add_aaxp = add_aaxp * RuleI(Character, BlueModifier)/100;
						break;
					case CON_WHITE:
							add_exp = add_exp * RuleI(Character, WhiteModifier)/100;
							add_aaxp = add_aaxp * RuleI(Character, WhiteModifier)/100;
						break;
					case CON_YELLOW:
							add_exp = add_exp * RuleI(Character, YellowModifier)/100;
							add_aaxp = add_aaxp * RuleI(Character, YellowModifier)/100;
						break;
					case CON_RED:
							add_exp = add_exp * RuleI(Character, RedModifier)/100;
							add_aaxp = add_aaxp * RuleI(Character, RedModifier)/100;
						break;
				}
			}
		}

		if (IsLeadershipEXPOn() && (conlevel == CON_BLUE || conlevel == CON_WHITE || conlevel == CON_YELLOW || conlevel == CON_RED)) {
			add_exp = static_cast<uint32>(static_cast<float>(add_exp) * 0.8f);

			if (GetGroup()) {
				if (m_pp.group_leadership_points < MaxBankedGroupLeadershipPoints(GetLevel())
						&& RuleI(Character, KillsPerGroupLeadershipAA) > 0) {
					uint32 exp = GROUP_EXP_PER_POINT / RuleI(Character, KillsPerGroupLeadershipAA);
					Client *mentoree = GetGroup()->GetMentoree();
					if (GetGroup()->GetMentorPercent() && mentoree &&
							mentoree->GetGroupPoints() < MaxBankedGroupLeadershipPoints(mentoree->GetLevel())) {
						uint32 mentor_exp = exp * (GetGroup()->GetMentorPercent() / 100.0f);
						exp -= mentor_exp;
						mentoree->AddLeadershipEXP(mentor_exp, 0); // ends up rounded down
						mentoree->Message_StringID(MT_Leadership, GAIN_GROUP_LEADERSHIP_EXP);
					}
					if (exp > 0) { // possible if you mentor 100% to the other client
						AddLeadershipEXP(exp, 0); // ends up rounded up if mentored, no idea how live actually does it
						Message_StringID(MT_Leadership, GAIN_GROUP_LEADERSHIP_EXP);
					}
				} else {
					Message_StringID(MT_Leadership, MAX_GROUP_LEADERSHIP_POINTS);
				}
			} else {
				Raid *raid = GetRaid();
				// Raid leaders CAN NOT gain group AA XP, other group leaders can though!
				if (raid->IsLeader(this)) {
					if (m_pp.raid_leadership_points < MaxBankedRaidLeadershipPoints(GetLevel())
							&& RuleI(Character, KillsPerRaidLeadershipAA) > 0) {
						AddLeadershipEXP(0, RAID_EXP_PER_POINT / RuleI(Character, KillsPerRaidLeadershipAA));
						Message_StringID(MT_Leadership, GAIN_RAID_LEADERSHIP_EXP);
					} else {
						Message_StringID(MT_Leadership, MAX_RAID_LEADERSHIP_POINTS);
					}
				} else {
					if (m_pp.group_leadership_points < MaxBankedGroupLeadershipPoints(GetLevel())
							&& RuleI(Character, KillsPerGroupLeadershipAA) > 0) {
						uint32 group_id = raid->GetGroup(this);
						uint32 exp = GROUP_EXP_PER_POINT / RuleI(Character, KillsPerGroupLeadershipAA);
						Client *mentoree = raid->GetMentoree(group_id);
						if (raid->GetMentorPercent(group_id) && mentoree &&
								mentoree->GetGroupPoints() < MaxBankedGroupLeadershipPoints(mentoree->GetLevel())) {
							uint32 mentor_exp = exp * (raid->GetMentorPercent(group_id) / 100.0f);
							exp -= mentor_exp;
							mentoree->AddLeadershipEXP(mentor_exp, 0);
							mentoree->Message_StringID(MT_Leadership, GAIN_GROUP_LEADERSHIP_EXP);
						}
						if (exp > 0) {
							AddLeadershipEXP(exp, 0);
							Message_StringID(MT_Leadership, GAIN_GROUP_LEADERSHIP_EXP);
						}
					} else {
						Message_StringID(MT_Leadership, MAX_GROUP_LEADERSHIP_POINTS);
					}
				}
			}

		}

	}	//end !resexp

	float aatotalmod = 1.0;
	if(zone->newzone_data.zone_exp_multiplier >= 0){
		aatotalmod *= zone->newzone_data.zone_exp_multiplier;
	}



	if(RuleB(Character,UseRaceClassExpBonuses))
	{
		if(GetBaseRace() == HALFLING){
			aatotalmod *= 1.05;
		}

		if(GetClass() == ROGUE || GetClass() == WARRIOR){
			aatotalmod *= 1.05;
		}
	}

	if(RuleB(Zone, LevelBasedEXPMods)){
		if(zone->level_exp_mod[GetLevel()].ExpMod){
			add_exp *= zone->level_exp_mod[GetLevel()].ExpMod;
			add_aaxp *= zone->level_exp_mod[GetLevel()].AAExpMod;
		}
	}

	uint32 exp = GetEXP() + add_exp;

	uint32 aaexp = (uint32)(RuleR(Character, AAExpMultiplier) * add_aaxp * aatotalmod);
	uint32 had_aaexp = GetAAXP();
	aaexp += had_aaexp;
	if(aaexp < had_aaexp)
		aaexp = had_aaexp;	//watch for wrap

	SetEXP(exp, aaexp, resexp);
}

void Client::SetEXP(uint32 set_exp, uint32 set_aaxp, bool isrezzexp) {
	Log.Out(Logs::Detail, Logs::None, "Attempting to Set Exp for %s (XP: %u, AAXP: %u, Rez: %s)", this->GetCleanName(), set_exp, set_aaxp, isrezzexp ? "true" : "false");
	//max_AAXP = GetEXPForLevel(52) - GetEXPForLevel(51);	//GetEXPForLevel() doesn't depend on class/race, just level, so it shouldn't change between Clients
	max_AAXP = RuleI(AA, ExpPerPoint);	//this may be redundant since we're doing this in Client::FinishConnState2()
	if (max_AAXP == 0 || GetEXPForLevel(GetLevel()) == 0xFFFFFFFF) {
		Message(13, "Error in Client::SetEXP. EXP not set.");
		return; // Must be invalid class/race
	}
	uint32 i = 0;
	uint32 membercount = 0;
	if(GetGroup())
	{
		for (i = 0; i < MAX_GROUP_MEMBERS; i++) {
			if (GetGroup()->members[i] != nullptr) {
				membercount++;
			}
		}
	}

	if ((set_exp + set_aaxp) > (m_pp.exp+m_pp.expAA)) {
		i = set_exp - m_pp.exp;
		if (isrezzexp) {
			//this->Message_StringID(MT_Experience, REZ_REGAIN);
			Message(15, "You regain %i experience from resurrection.", i);
		}
		else {
			if(membercount > 1) {
				Message(15, "You have gained %i party experience!", i);
				//this->Message_StringID(MT_Experience, GAIN_GROUPXP);
			}
			else if(IsRaidGrouped()) {
				//Message_StringID(MT_Experience, GAIN_RAIDEXP);
				Message(15, "You have gained %i raid experience!", i);
			}
			else {
				//this->Message_StringID(MT_Experience, GAIN_XP);
				Message(15, "You have gained %i experience!", i);
			}
		}
	}
	else if((set_exp + set_aaxp) < (m_pp.exp+m_pp.expAA)){ //only loss message if you lose exp, no message if you gained/lost nothing.
		i = set_exp - m_pp.exp;
		Message(15, "You have lost %i experience.", (-i));
	}

	//check_level represents the level we should be when we have
	//this ammount of exp (once these loops complete)
	uint16 check_level = GetLevel()+1;
	//see if we gained any levels
	bool level_increase = true;
	int8 level_count = 0;

	while (set_exp >= GetEXPForLevel(check_level)) {
		check_level++;
		if (check_level > 127) {	//hard level cap
			check_level = 127;
			break;
		}
		level_count++;

		if(GetMercID())
			UpdateMercLevel();
	}
	//see if we lost any levels
	while (set_exp < GetEXPForLevel(check_level-1)) {
		check_level--;
		if (check_level < 2) {	//hard level minimum
			check_level = 2;
			break;
		}
		level_increase = false;
		if(GetMercID())
			UpdateMercLevel();
	}
	check_level--;


	//see if we gained any AAs
	if (set_aaxp >= max_AAXP) {
		/*
			Note: AA exp is stored differently than normal exp.
			Exp points are only stored in m_pp.expAA until you
			gain a full AA point, once you gain it, a point is
			added to m_pp.aapoints and the ammount needed to gain
			that point is subtracted from m_pp.expAA

			then, once they spend an AA point, it is subtracted from
			m_pp.aapoints. In theory it then goes into m_pp.aapoints_spent,
			but im not sure if we have that in the right spot.
		*/
		//record how many points we have
		uint32 last_unspentAA = m_pp.aapoints;

		//figure out how many AA points we get from the exp were setting
		m_pp.aapoints = set_aaxp / max_AAXP;
		Log.Out(Logs::Detail, Logs::None, "Calculating additional AA Points from AAXP for %s: %u / %u = %.1f points", this->GetCleanName(), set_aaxp, max_AAXP, (float)set_aaxp / (float)max_AAXP);

		//get remainder exp points, set in PP below
		set_aaxp = set_aaxp - (max_AAXP * m_pp.aapoints);

		//add in how many points we had
		m_pp.aapoints += last_unspentAA;
		//set_aaxp = m_pp.expAA % max_AAXP;

		//figure out how many points were actually gained
		/*uint32 gained = m_pp.aapoints - last_unspentAA;*/	//unused

		//Message(15, "You have gained %d skill points!!", m_pp.aapoints - last_unspentAA);
		char val1[20]={0};
		Message_StringID(MT_Experience, GAIN_ABILITY_POINT,ConvertArray(m_pp.aapoints, val1),m_pp.aapoints == 1 ? "" : "(s)");	//You have gained an ability point! You now have %1 ability point%2.
		
		/* QS: PlayerLogAARate */
		if (RuleB(QueryServ, PlayerLogAARate)){
			int add_points = (m_pp.aapoints - last_unspentAA);
			std::string query = StringFormat("INSERT INTO `qs_player_aa_rate_hourly` (char_id, aa_count, hour_time) VALUES (%i, %i, UNIX_TIMESTAMP() - MOD(UNIX_TIMESTAMP(), 3600)) ON DUPLICATE KEY UPDATE `aa_count` = `aa_count` + %i", this->CharacterID(), add_points, add_points);
			QServ->SendQuery(query.c_str());
		}

		//Message(15, "You now have %d skill points available to spend.", m_pp.aapoints);
	}

	uint8 maxlevel = RuleI(Character, MaxExpLevel) + 1;

	if(maxlevel <= 1)
		maxlevel = RuleI(Character, MaxLevel) + 1;

	if(check_level > maxlevel) {
		check_level = maxlevel;

		if(RuleB(Character, KeepLevelOverMax)) {
			set_exp = GetEXPForLevel(GetLevel()+1);
		}
		else {
			set_exp = GetEXPForLevel(maxlevel);
		}
	}

	if(RuleB(Character, PerCharacterQglobalMaxLevel)){
		uint32 MaxLevel = GetCharMaxLevelFromQGlobal();
		if(MaxLevel){
			if(GetLevel() >= MaxLevel){
				uint32 expneeded = GetEXPForLevel(MaxLevel);
				if(set_exp > expneeded) {
					set_exp = expneeded;
				}
			}
		}
	}

	if ((GetLevel() != check_level) && !(check_level >= maxlevel)) {
		char val1[20]={0};
		if (level_increase)
		{
			if (level_count == 1)
				Message_StringID(MT_Experience, GAIN_LEVEL, ConvertArray(check_level, val1));
			else
				Message(15, "Welcome to level %i!", check_level);

			if (check_level == RuleI(Character, DeathItemLossLevel))
				Message_StringID(15, CORPSE_ITEM_LOST);

			if (check_level == RuleI(Character, DeathExpLossLevel))
				Message_StringID(15, CORPSE_EXP_LOST);
		}
		else
			Message_StringID(MT_Experience, LOSE_LEVEL, ConvertArray(check_level, val1));

#ifdef BOTS
		uint8 myoldlevel = GetLevel();
#endif

		SetLevel(check_level);

#ifdef BOTS
		if(RuleB(Bots, BotLevelsWithOwner))
			// hack way of doing this..but, least invasive... (same criteria as gain level for sendlvlapp)
			Bot::LevelBotWithClient(this, GetLevel(), (myoldlevel==check_level-1));
#endif
	}

	//If were at max level then stop gaining experience if we make it to the cap
	if(GetLevel() == maxlevel - 1){
		uint32 expneeded = GetEXPForLevel(maxlevel);
		if(set_exp > expneeded) {
			set_exp = expneeded;
		}
	}

	//set the client's EXP and AAEXP
	m_pp.exp = set_exp;
	m_pp.expAA = set_aaxp;

	if (GetLevel() < 51) {
		m_epp.perAA = 0;	// turn off aa exp if they drop below 51
	} else
		SendAlternateAdvancementStats();	//otherwise, send them an AA update

	//send the expdata in any case so the xp bar isnt stuck after leveling
	uint32 tmpxp1 = GetEXPForLevel(GetLevel()+1);
	uint32 tmpxp2 = GetEXPForLevel(GetLevel());
	// Quag: crash bug fix... Divide by zero when tmpxp1 and 2 equalled each other, most likely the error case from GetEXPForLevel() (invalid class, etc)
	if (tmpxp1 != tmpxp2 && tmpxp1 != 0xFFFFFFFF && tmpxp2 != 0xFFFFFFFF) {
		EQApplicationPacket* outapp = new EQApplicationPacket(OP_ExpUpdate, sizeof(ExpUpdate_Struct));
		ExpUpdate_Struct* eu = (ExpUpdate_Struct*)outapp->pBuffer;
		float tmpxp = (float) ( (float) set_exp-tmpxp2 ) / ( (float) tmpxp1-tmpxp2 );
		eu->exp = (uint32)(330.0f * tmpxp);
		FastQueuePacket(&outapp);
	}

	if (admin>=100 && GetGM()) {
		char val1[20]={0};
		char val2[20]={0};
		char val3[20]={0};
		Message_StringID(MT_Experience, GM_GAINXP,ConvertArray(set_aaxp,val1),ConvertArray(set_exp,val2),ConvertArray(GetEXPForLevel(GetLevel()+1),val3));	//[GM] You have gained %1 AXP and %2 EXP (%3).
		//Message(15, "[GM] You now have %d / %d EXP and %d / %d AA exp.", set_exp, GetEXPForLevel(GetLevel()+1), set_aaxp, max_AAXP);
	}
}

void Client::SetLevel(uint8 set_level, bool command)
{
	if (GetEXPForLevel(set_level) == 0xFFFFFFFF) {
		Log.Out(Logs::General, Logs::Error, "Client::SetLevel() GetEXPForLevel(%i) = 0xFFFFFFFF", set_level);
		return;
	}

	EQApplicationPacket* outapp = new EQApplicationPacket(OP_LevelUpdate, sizeof(LevelUpdate_Struct));
	LevelUpdate_Struct* lu = (LevelUpdate_Struct*)outapp->pBuffer;
	lu->level = set_level;
	if(m_pp.level2 != 0)
		lu->level_old = m_pp.level2;
	else
		lu->level_old = level;

	level = set_level;

	if(IsRaidGrouped()) {
		Raid *r = this->GetRaid();
		if(r){
			r->UpdateLevel(GetName(), set_level);
		}
	}
	if(set_level > m_pp.level2) {
		if(m_pp.level2 == 0)
			m_pp.points += 5;
		else
			m_pp.points += (5 * (set_level - m_pp.level2));

		m_pp.level2 = set_level;
	}
	if(set_level > m_pp.level) {
		parse->EventPlayer(EVENT_LEVEL_UP, this, "", 0);
		/* QS: PlayerLogLevels */
		if (RuleB(QueryServ, PlayerLogLevels)){
			std::string event_desc = StringFormat("Leveled UP :: to Level:%i from Level:%i in zoneid:%i instid:%i", set_level, m_pp.level, this->GetZoneID(), this->GetInstanceID());
			QServ->PlayerLogEvent(Player_Log_Levels, this->CharacterID(), event_desc); 
		}
	}
	else if (set_level < m_pp.level){
		/* QS: PlayerLogLevels */
		if (RuleB(QueryServ, PlayerLogLevels)){
			std::string event_desc = StringFormat("Leveled DOWN :: to Level:%i from Level:%i in zoneid:%i instid:%i", set_level, m_pp.level, this->GetZoneID(), this->GetInstanceID());
			QServ->PlayerLogEvent(Player_Log_Levels, this->CharacterID(), event_desc);
		}
	}

	m_pp.level = set_level;
	if (command){
		m_pp.exp = GetEXPForLevel(set_level);
		Message(15, "Welcome to level %i!", set_level);
		lu->exp = 0;
	}
	else {
		float tmpxp = (float) ( (float) m_pp.exp - GetEXPForLevel( GetLevel() )) / ( (float) GetEXPForLevel(GetLevel()+1) - GetEXPForLevel(GetLevel()));
		lu->exp = (uint32)(330.0f * tmpxp);
	}
	QueuePacket(outapp);
	safe_delete(outapp);
	this->SendAppearancePacket(AT_WhoLevel, set_level); // who level change

	Log.Out(Logs::General, Logs::Normal, "Setting Level for %s to %i", GetName(), set_level);

	CalcBonuses();

	if(!RuleB(Character, HealOnLevel)) {
		int mhp = CalcMaxHP();
		if(GetHP() > mhp)
			SetHP(mhp);
	}
	else {
		SetHP(CalcMaxHP()); // Why not, lets give them a free heal
	}

	uint16 book_slot, curspell, spellCount, abilityCount;
	//Scribe New Spells and Disciplines
	for (curspell = 0, book_slot = this->GetNextAvailableSpellBookSlot(), spellCount = 0; curspell < SPDAT_RECORDS && book_slot < MAX_PP_SPELLBOOK; curspell++, book_slot = this->GetNextAvailableSpellBookSlot(book_slot))
	{
		if (
				spells[curspell].classes[WARRIOR] != 0 && // check if spell exists
				spells[curspell].classes[this->GetPP().class_ - 1] <= set_level &&	//maximum level
				spells[curspell].classes[this->GetPP().class_ - 1] >= 1 &&	//minimum level
				spells[curspell].skill != 52
			) {
			//Whitelisted spells
			if (this->GetClass() == BARD && curspell != 744 && curspell != 3567 && curspell != 743 && curspell != 1748 && curspell != 4210 && curspell != 707 && curspell != 730 && curspell != 703 && curspell != 1764 && curspell != 3566 && curspell != 1747 && curspell != 742 && curspell != 704 && curspell != 3681 && curspell != 3682 && curspell != 7 && curspell != 2609 && curspell != 1759 && curspell != 1448 && curspell != 723 && curspell != 1287 && curspell != 1763 && curspell != 1765 && curspell != 2608 && curspell != 2607 && curspell != 714 && curspell != 709 && curspell != 711 && curspell != 710 && curspell != 745 && curspell != 708 && curspell != 2604 && curspell != 1760 && curspell != 716 && curspell != 713 && curspell != 715 && curspell != 712 && curspell != 1452 && curspell != 2610 && curspell != 1762 && curspell != 1760 && curspell != 1757 && curspell != 2606 && curspell != 747 && curspell != 1449 && curspell != 749 && curspell != 702 && curspell != 740 && curspell != 701 && curspell != 734 && curspell != 700 && curspell != 719 && curspell != 1749 && curspell != 718 && curspell != 748 && curspell != 2603 && curspell != 729 && curspell != 2602 && curspell != 737 && curspell != 2601 && curspell != 4586 && curspell != 4587 && curspell != 4585 && curspell != 1750 && curspell != 2605 && curspell != 4395 && curspell != 717 && curspell != 1752 && curspell != 1450 && curspell != 1755 && curspell != 739 && curspell != 4084 && curspell != 4086 && curspell != 4083 && curspell != 4085 && curspell != 721 && curspell != 735 && curspell != 728 && curspell != 750 && curspell != 725 && curspell != 726 && curspell != 727 && curspell != 1197 && curspell != 1100 && curspell != 1753 && curspell != 1754 && curspell != 868 && curspell != 741 && curspell != 724 && curspell != 1756 && curspell != 706 && curspell != 2936 && curspell != 1761 && curspell != 736 && curspell != 1451 && curspell != 1758 && curspell != 1751 && curspell != 746 && curspell != 738 && curspell != 705 && curspell != 1758 && curspell != 1751 && curspell != 738 && curspell != 720) {
				continue;				
			} else if (this->GetClass() == CLERIC && curspell != 11 && curspell != 14 && curspell != 200 && curspell != 201 && curspell != 202 && curspell != 203 && curspell != 205 && curspell != 207 && curspell != 208 && curspell != 209 && curspell != 210 && curspell != 215 && curspell != 216 && curspell != 211 && curspell != 212 && curspell != 17 && curspell != 213 && curspell != 218 && curspell != 36 && curspell != 501 && curspell != 560 && curspell != 227 && curspell != 229 && curspell != 2501 && curspell != 219 && curspell != 223 && curspell != 230 && curspell != 224 && curspell != 4056 && curspell != 50 && curspell != 221 && curspell != 231 && curspell != 12 && curspell != 35 && curspell != 226 && curspell != 235 && curspell != 485 && curspell != 2168 && curspell != 232 && curspell != 234 && curspell != 225 && curspell != 233 && curspell != 48 && curspell != 16 && curspell != 3575 && curspell != 368 && curspell != 47 && curspell != 123 && curspell != 228 && curspell != 43 && curspell != 248 && curspell != 89 && curspell != 2169 && curspell != 2502 && curspell != 413 && curspell != 15 && curspell != 37 && curspell != 4088 && curspell != 126 && curspell != 128 && curspell != 486 && curspell != 2170 && curspell != 244 && curspell != 95 && curspell != 117 && curspell != 4057 && curspell != 18 && curspell != 2503 && curspell != 414 && curspell != 59 && curspell != 131 && curspell != 391 && curspell != 663 && curspell != 52 && curspell != 96 && curspell != 130 && curspell != 2175 && curspell != 329 && curspell != 135 && curspell != 62 && curspell != 9 && curspell != 124 && curspell != 487 && curspell != 504 && curspell != 2171 && curspell != 312 && curspell != 480 && curspell != 53 && curspell != 60 && curspell != 662 && curspell != 134 && curspell != 1445 && curspell != 405 && curspell != 19 && curspell != 3576 && curspell != 127 && curspell != 45 && curspell != 63 && curspell != 115 && curspell != 1443 && curspell != 388 && curspell != 2946 && curspell != 49 && curspell != 61 && curspell != 13 && curspell != 2504 && curspell != 415 && curspell != 3692 && curspell != 4089 && curspell != 675 && curspell != 44 && curspell != 488 && curspell != 2172 && curspell != 314 && curspell != 118 && curspell != 64 && curspell != 1444 && curspell != 406 && curspell != 672 && curspell != 136 && curspell != 20 && curspell != 4053 && curspell != 125 && curspell != 132 && curspell != 392 && curspell != 664 && curspell != 1411 && curspell != 97 && curspell != 2505 && curspell != 416 && curspell != 6902 && curspell != 1518 && curspell != 1532 && curspell != 1547 && curspell != 1726 && curspell != 3693 && curspell != 1520 && curspell != 1533 && curspell != 1536 && curspell != 1538 && curspell != 1542 && curspell != 21398 && curspell != 2506 && curspell != 1519 && curspell != 1526 && curspell != 1534 && curspell != 1535 && curspell != 1543 && curspell != 1721 && curspell != 21400 && curspell != 2507 && curspell != 2880 && curspell != 4090 && curspell != 1446 && curspell != 1528 && curspell != 1539 && curspell != 1541 && curspell != 8928 && curspell != 116 && curspell != 133 && curspell != 1524 && curspell != 1548 && curspell != 2181 && curspell != 2326 && curspell != 2508 && curspell != 6989 && curspell != 1521 && curspell != 1527 && curspell != 1537 && curspell != 1540 && curspell != 6903 && curspell != 1525 && curspell != 1544 && curspell != 1774 && curspell != 21399 && curspell != 2182 && curspell != 2509 && curspell != 3135 && curspell != 1522 && curspell != 1545 && curspell != 2462 && curspell != 6977 && curspell != 1447 && curspell != 1523 && curspell != 1530 && curspell != 1546 && curspell != 2109 && curspell != 2122 && curspell != 2180 && curspell != 2510 && curspell != 2893 && curspell != 3136) {
				continue;
			} else if (this->GetClass() == DRUID && curspell != 200 && curspell != 224 && curspell != 237 && curspell != 238 && curspell != 239 && curspell != 240 && curspell != 241 && curspell != 242 && curspell != 2591 && curspell != 26 && curspell != 93 && curspell != 248 && curspell != 249 && curspell != 253 && curspell != 92 && curspell != 213 && curspell != 247 && curspell != 252 && curspell != 203 && curspell != 250 && curspell != 36 && curspell != 254 && curspell != 258 && curspell != 86 && curspell != 256 && curspell != 268 && curspell != 515 && curspell != 255 && curspell != 4056 && curspell != 91 && curspell != 17 && curspell != 225 && curspell != 2511 && curspell != 257 && curspell != 211 && curspell != 264 && curspell != 278 && curspell != 234 && curspell != 50 && curspell != 262 && curspell != 35 && curspell != 245 && curspell != 663 && curspell != 80 && curspell != 261 && curspell != 263 && curspell != 2021 && curspell != 513 && curspell != 514 && curspell != 530 && curspell != 419 && curspell != 520 && curspell != 532 && curspell != 273 && curspell != 3583 && curspell != 516 && curspell != 531 && curspell != 533 && curspell != 139 && curspell != 2183 && curspell != 34 && curspell != 48 && curspell != 12 && curspell != 226 && curspell != 227 && curspell != 2512 && curspell != 3794 && curspell != 425 && curspell != 535 && curspell != 60 && curspell != 220 && curspell != 405 && curspell != 537 && curspell != 76 && curspell != 143 && curspell != 27 && curspell != 534 && curspell != 536 && curspell != 115 && curspell != 260 && curspell != 4057 && curspell != 1326 && curspell != 421 && curspell != 99 && curspell != 538 && curspell != 550 && curspell != 552 && curspell != 553 && curspell != 78 && curspell != 2020 && curspell != 424 && curspell != 512 && curspell != 607 && curspell != 129 && curspell != 2513 && curspell != 517 && curspell != 551 && curspell != 217 && curspell != 3792 && curspell != 753 && curspell != 95 && curspell != 96 && curspell != 15 && curspell != 3601 && curspell != 1439 && curspell != 4054 && curspell != 426 && curspell != 554 && curspell != 61 && curspell != 1433 && curspell != 406 && curspell != 418 && curspell != 557 && curspell != 1434 && curspell != 259 && curspell != 25904 && curspell != 555 && curspell != 556 && curspell != 608 && curspell != 141 && curspell != 1517 && curspell != 2029 && curspell != 25689 && curspell != 25698 && curspell != 664 && curspell != 144 && curspell != 228 && curspell != 25899 && curspell != 429 && curspell != 169 && curspell != 25690 && curspell != 25900 && curspell != 25903 && curspell != 4055 && curspell != 428 && curspell != 2030 && curspell != 3580 && curspell != 422 && curspell != 490 && curspell != 558 && curspell != 1437 && curspell != 1737 && curspell != 28 && curspell != 432 && curspell != 518 && curspell != 1438 && curspell != 2946 && curspell != 57 && curspell != 609 && curspell != 137 && curspell != 1736 && curspell != 2031 && curspell != 2514 && curspell != 25695 && curspell != 25902 && curspell != 1398 && curspell != 25694 && curspell != 25901 && curspell != 427 && curspell != 665 && curspell != 1285 && curspell != 140 && curspell != 610 && curspell != 1436 && curspell != 1440 && curspell != 145 && curspell != 25696 && curspell != 116 && curspell != 142 && curspell != 1740 && curspell != 25906 && curspell != 49 && curspell != 25693 && curspell != 3834 && curspell != 430 && curspell != 62 && curspell != 63 && curspell != 138 && curspell != 25699 && curspell != 3579 && curspell != 77 && curspell != 420 && curspell != 423 && curspell != 611 && curspell != 29 && curspell != 356 && curspell != 519 && curspell != 1435 && curspell != 1542 && curspell != 433 && curspell != 671 && curspell != 1727 && curspell != 2515 && curspell != 4104 && curspell != 64 && curspell != 2881 && curspell != 2894 && curspell != 5571 && curspell != 1550 && curspell != 1551 && curspell != 9 && curspell != 1552 && curspell != 1553 && curspell != 1566 && curspell != 1600 && curspell != 24771 && curspell != 2516 && curspell != 3693 && curspell != 4058 && curspell != 1554 && curspell != 1555 && curspell != 1601 && curspell != 1562 && curspell != 1568 && curspell != 1602 && curspell != 1603 && curspell != 21400 && curspell != 2517 && curspell != 2880 && curspell != 1290 && curspell != 1475 && curspell != 1526 && curspell != 1529 && curspell != 1556 && curspell != 1557 && curspell != 1605 && curspell != 4105 && curspell != 8929 && curspell != 1558 && curspell != 1604 && curspell != 1719 && curspell != 1725 && curspell != 2518 && curspell != 1559 && curspell != 1567 && curspell != 1767 && curspell != 6998 && curspell != 1560 && curspell != 1569 && curspell != 1606 && curspell != 21398 && curspell != 21399 && curspell != 2179 && curspell != 2519 && curspell != 1561 && curspell != 1564 && curspell != 1607 && curspell != 2188 && curspell != 4589 && curspell != 1291 && curspell != 1442 && curspell != 1531 && curspell != 1563 && curspell != 1565 && curspell != 1608 && curspell != 2125 && curspell != 2126 && curspell != 2520 && curspell != 2877 && curspell != 2887) {
				continue;
			} else if (this->GetClass() == ENCHANTER && curspell != 208 && curspell != 285 && curspell != 286 && curspell != 288 && curspell != 289 && curspell != 331 && curspell != 40 && curspell != 41 && curspell != 292 && curspell != 676 && curspell != 681 && curspell != 229 && curspell != 290 && curspell != 293 && curspell != 291 && curspell != 294 && curspell != 36 && curspell != 42 && curspell != 297 && curspell != 299 && curspell != 230 && curspell != 246 && curspell != 501 && curspell != 80 && curspell != 295 && curspell != 296 && curspell != 3991 && curspell != 48 && curspell != 667 && curspell != 1359 && curspell != 298 && curspell != 3986 && curspell != 500 && curspell != 302 && curspell != 303 && curspell != 645 && curspell != 682 && curspell != 276 && curspell != 301 && curspell != 650 && curspell != 2561 && curspell != 300 && curspell != 390 && curspell != 4010 && curspell != 521 && curspell != 7988 && curspell != 35 && curspell != 86 && curspell != 187 && curspell != 481 && curspell != 235 && curspell != 683 && curspell != 697 && curspell != 261 && curspell != 39 && curspell != 281 && curspell != 304 && curspell != 306 && curspell != 307 && curspell != 309 && curspell != 7674 && curspell != 7675 && curspell != 7676 && curspell != 7677 && curspell != 228 && curspell != 2562 && curspell != 651 && curspell != 684 && curspell != 47 && curspell != 489 && curspell != 677 && curspell != 179 && curspell != 21 && curspell != 3583 && curspell != 173 && curspell != 177 && curspell != 84 && curspell != 170 && curspell != 350 && curspell != 24 && curspell != 482 && curspell != 685 && curspell != 182 && curspell != 185 && curspell != 4256 && curspell != 65 && curspell != 131 && curspell != 162 && curspell != 191 && curspell != 174 && curspell != 2563 && curspell != 408 && curspell != 450 && curspell != 46 && curspell != 652 && curspell != 10 && curspell != 49 && curspell != 619 && curspell != 4073 && curspell != 686 && curspell != 188 && curspell != 3585 && curspell != 74 && curspell != 646 && curspell != 66 && curspell != 687 && curspell != 407 && curspell != 71 && curspell != 483 && curspell != 1408 && curspell != 180 && curspell != 127 && curspell != 175 && curspell != 45 && curspell != 192 && curspell != 2564 && curspell != 73 && curspell != 183 && curspell != 64 && curspell != 653 && curspell != 688 && curspell != 1407 && curspell != 648 && curspell != 132 && curspell != 171 && curspell != 1474 && curspell != 163 && curspell != 484 && curspell != 67 && curspell != 186 && curspell != 33 && curspell != 678 && curspell != 689 && curspell != 1694 && curspell != 181 && curspell != 25 && curspell != 31003 && curspell != 1285 && curspell != 178 && curspell != 4099 && curspell != 673 && curspell != 3696 && curspell != 4074 && curspell != 133 && curspell != 194 && curspell != 184 && curspell != 193 && curspell != 647 && curspell != 172 && curspell != 176 && curspell != 190 && curspell != 195 && curspell != 654 && curspell != 690 && curspell != 72 && curspell != 1406 && curspell != 1686 && curspell != 1687 && curspell != 1541 && curspell != 2881 && curspell != 2894 && curspell != 1689 && curspell != 1690 && curspell != 1693 && curspell != 1696 && curspell != 2566 && curspell != 3697 && curspell != 4077 && curspell != 1592 && curspell != 1697 && curspell != 1705 && curspell != 1708 && curspell != 1610 && curspell != 1691 && curspell != 1698 && curspell != 2567 && curspell != 1409 && curspell != 1699 && curspell != 1714 && curspell != 1715 && curspell != 1723 && curspell != 4075 && curspell != 8931 && curspell != 1527 && curspell != 1695 && curspell != 1700 && curspell != 1701 && curspell != 1729 && curspell != 2568 && curspell != 1688 && curspell != 1702 && curspell != 1711 && curspell != 1712 && curspell != 6983 && curspell != 1633 && curspell != 1709 && curspell != 1713 && curspell != 2016 && curspell != 2569 && curspell != 4100 && curspell != 1692 && curspell != 1703 && curspell != 1410 && curspell != 1704 && curspell != 1707 && curspell != 1710 && curspell != 2120 && curspell != 2121 && curspell != 2570 && curspell != 2895) {
				continue;
			} else if (this->GetClass() == MAGICIAN && curspell != 211 && curspell != 288 && curspell != 310 && curspell != 311 && curspell != 313 && curspell != 331 && curspell != 50 && curspell != 93 && curspell != 2230 && curspell != 315 && curspell != 318 && curspell != 232 && curspell != 316 && curspell != 321 && curspell != 317 && curspell != 36 && curspell != 94 && curspell != 246 && curspell != 322 && curspell != 58 && curspell != 323 && curspell != 325 && curspell != 398 && curspell != 1504 && curspell != 324 && curspell != 332 && curspell != 399 && curspell != 2233 && curspell != 400 && curspell != 42 && curspell != 613 && curspell != 248 && curspell != 319 && curspell != 397 && curspell != 2242 && curspell != 330 && curspell != 402 && curspell != 48 && curspell != 2531 && curspell != 327 && curspell != 403 && curspell != 328 && curspell != 35 && curspell != 404 && curspell != 333 && curspell != 401 && curspell != 336 && curspell != 614 && curspell != 100 && curspell != 320 && curspell != 334 && curspell != 395 && curspell != 2239 && curspell != 309 && curspell != 396 && curspell != 80 && curspell != 2532 && curspell != 335 && curspell != 4 && curspell != 83 && curspell != 1505 && curspell != 497 && curspell != 663 && curspell != 68 && curspell != 108 && curspell != 3583 && curspell != 411 && curspell != 498 && curspell != 101 && curspell != 102 && curspell != 2236 && curspell != 4027 && curspell != 499 && curspell != 2231 && curspell != 496 && curspell != 55 && curspell != 110 && curspell != 189 && curspell != 56 && curspell != 570 && curspell != 113 && curspell != 571 && curspell != 572 && curspell != 615 && curspell != 65 && curspell != 115 && curspell != 2533 && curspell != 569 && curspell != 81 && curspell != 409 && curspell != 574 && curspell != 617 && curspell != 1286 && curspell != 2234 && curspell != 575 && curspell != 479 && curspell != 576 && curspell != 664 && curspell != 103 && curspell != 106 && curspell != 573 && curspell != 1400 && curspell != 2243 && curspell != 618 && curspell != 7678 && curspell != 120 && curspell != 1401 && curspell != 621 && curspell != 49 && curspell != 622 && curspell != 66 && curspell != 616 && curspell != 623 && curspell != 69 && curspell != 3584 && curspell != 620 && curspell != 104 && curspell != 121 && curspell != 1285 && curspell != 625 && curspell != 105 && curspell != 2240 && curspell != 626 && curspell != 2534 && curspell != 627 && curspell != 680 && curspell != 122 && curspell != 624 && curspell != 109 && curspell != 114 && curspell != 629 && curspell != 82 && curspell != 2237 && curspell != 4082 && curspell != 4099 && curspell != 630 && curspell != 1403 && curspell != 631 && curspell != 67 && curspell != 111 && curspell != 1503 && curspell != 3699 && curspell != 4028 && curspell != 628 && curspell != 1944 && curspell != 412 && curspell != 4079 && curspell != 632 && curspell != 107 && curspell != 634 && curspell != 70 && curspell != 116 && curspell != 2535 && curspell != 635 && curspell != 410 && curspell != 633 && curspell != 1402 && curspell != 2232 && curspell != 112 && curspell != 1659 && curspell != 1671 && curspell != 1680 && curspell != 2235 && curspell != 1660 && curspell != 1666 && curspell != 1673 && curspell != 1681 && curspell != 2244 && curspell != 2536 && curspell != 3700 && curspell != 1526 && curspell != 1668 && curspell != 1674 && curspell != 1682 && curspell != 2241 && curspell != 1610 && curspell != 1661 && curspell != 1672 && curspell != 1683 && curspell != 2238 && curspell != 2537 && curspell != 2879 && curspell != 3582 && curspell != 4011 && curspell != 4029 && curspell != 5133 && curspell != 1405 && curspell != 1472 && curspell != 1662 && curspell != 1684 && curspell != 1770 && curspell != 1771 && curspell != 8933 && curspell != 1529 && curspell != 1667 && curspell != 1679 && curspell != 1685 && curspell != 2538 && curspell != 3188 && curspell != 1663 && curspell != 1675 && curspell != 1720 && curspell != 1577 && curspell != 1670 && curspell != 1677 && curspell != 2539 && curspell != 4080 && curspell != 4100 && curspell != 1284 && curspell != 1664 && curspell != 1665 && curspell != 1678 && curspell != 1936 && curspell != 1394 && curspell != 1404 && curspell != 1531 && curspell != 1669 && curspell != 1676 && curspell != 1772 && curspell != 2118 && curspell != 2119 && curspell != 2540 && curspell != 2896 && curspell != 4078) {
				continue;
			} else if (this->GetClass() == MONK && curspell != 5225 && curspell != 25060 && curspell != 4721 && curspell != 4585 && curspell != 4614 && curspell != 4587 && curspell != 4683 && curspell != 4510 && curspell != 4511 && curspell != 4509 && curspell != 4502 && curspell != 8923 && curspell != 4512 && curspell != 4513 && curspell != 4684 && curspell != 4507 && curspell != 4508) {
				continue;
			} else if (this->GetClass() == NECROMANCER && curspell != 221 && curspell != 235 && curspell != 288 && curspell != 331 && curspell != 338 && curspell != 340 && curspell != 341 && curspell != 342 && curspell != 343 && curspell != 229 && curspell != 347 && curspell != 225 && curspell != 346 && curspell != 502 && curspell != 344 && curspell != 348 && curspell != 36 && curspell != 491 && curspell != 352 && curspell != 354 && curspell != 218 && curspell != 357 && curspell != 641 && curspell != 353 && curspell != 359 && curspell != 522 && curspell != 246 && curspell != 351 && curspell != 358 && curspell != 1509 && curspell != 361 && curspell != 363 && curspell != 1511 && curspell != 209 && curspell != 360 && curspell != 226 && curspell != 2541 && curspell != 355 && curspell != 2213 && curspell != 35 && curspell != 362 && curspell != 445 && curspell != 213 && curspell != 367 && curspell != 236 && curspell != 364 && curspell != 365 && curspell != 371 && curspell != 48 && curspell != 309 && curspell != 366 && curspell != 368 && curspell != 369 && curspell != 492 && curspell != 1510 && curspell != 2542 && curspell != 196 && curspell != 642 && curspell != 698 && curspell != 233 && curspell != 3583 && curspell != 370 && curspell != 199 && curspell != 413 && curspell != 440 && curspell != 446 && curspell != 1512 && curspell != 1514 && curspell != 204 && curspell != 478 && curspell != 387 && curspell != 549 && curspell != 90 && curspell != 448 && curspell != 449 && curspell != 493 && curspell != 61 && curspell != 65 && curspell != 59 && curspell != 699 && curspell != 444 && curspell != 524 && curspell != 2543 && curspell != 414 && curspell != 452 && curspell != 117 && curspell != 451 && curspell != 441 && curspell != 454 && curspell != 127 && curspell != 197 && curspell != 63 && curspell != 643 && curspell != 1415 && curspell != 393 && curspell != 455 && curspell != 494 && curspell != 66 && curspell != 230 && curspell != 435 && curspell != 3 && curspell != 31 && curspell != 661 && curspell != 1412 && curspell != 415 && curspell != 96 && curspell != 1513 && curspell != 49 && curspell != 2544 && curspell != 662 && curspell != 4096 && curspell != 442 && curspell != 525 && curspell != 1285 && curspell != 1508 && curspell != 457 && curspell != 67 && curspell != 2014 && curspell != 559 && curspell != 1413 && curspell != 1515 && curspell != 394 && curspell != 4099 && curspell != 495 && curspell != 694 && curspell != 1391 && curspell != 3702 && curspell != 118 && curspell != 133 && curspell != 2545 && curspell != 198 && curspell != 453 && curspell != 6 && curspell != 443 && curspell != 447 && curspell != 644 && curspell != 3571 && curspell != 4079 && curspell != 456 && curspell != 1411 && curspell != 436 && curspell != 1532 && curspell != 1620 && curspell != 1768 && curspell != 1609 && curspell != 1630 && curspell != 1716 && curspell != 2546 && curspell != 32 && curspell != 3685 && curspell != 131 && curspell != 1526 && curspell != 1621 && curspell != 1733 && curspell != 32397 && curspell != 1610 && curspell != 1613 && curspell != 1624 && curspell != 1717 && curspell != 2547 && curspell != 3572 && curspell != 4097 && curspell != 1414 && curspell != 1614 && curspell != 1625 && curspell != 1626 && curspell != 1734 && curspell != 2015 && curspell != 8934 && curspell != 1527 && curspell != 1611 && curspell != 1615 && curspell != 1622 && curspell != 1718 && curspell != 2548 && curspell != 6992 && curspell != 1528 && curspell != 1616 && curspell != 1773 && curspell != 6980 && curspell != 132 && curspell != 1612 && curspell != 1617 && curspell != 2549 && curspell != 4080 && curspell != 4100 && curspell != 1618 && curspell != 1619 && curspell != 1623 && curspell != 1393 && curspell != 1416 && curspell != 1460 && curspell != 1530 && curspell != 1629 && curspell != 1735 && curspell != 2115 && curspell != 2550 && curspell != 2885) {
				continue;
			} else if (this->GetClass() == PALADIN && curspell != 5011 && curspell != 201 && curspell != 221 && curspell != 203 && curspell != 200 && curspell != 2581 && curspell != 202 && curspell != 209 && curspell != 210 && curspell != 208 && curspell != 213 && curspell != 17 && curspell != 2582 && curspell != 218 && curspell != 223 && curspell != 11 && curspell != 234 && curspell != 235 && curspell != 215 && curspell != 230 && curspell != 4056 && curspell != 219 && curspell != 227 && curspell != 2168 && curspell != 37 && curspell != 485 && curspell != 501 && curspell != 2583 && curspell != 12 && curspell != 216 && curspell != 228 && curspell != 2169 && curspell != 233 && curspell != 368 && curspell != 2170 && curspell != 48 && curspell != 486 && curspell != 4057 && curspell != 95 && curspell != 2584 && curspell != 15 && curspell != 1453 && curspell != 89 && curspell != 226 && curspell != 43 && curspell != 18 && curspell != 3577 && curspell != 391 && curspell != 123 && curspell != 47 && curspell != 2585 && curspell != 3683 && curspell != 2946 && curspell != 693 && curspell != 117 && curspell != 487 && curspell != 2586 && curspell != 312 && curspell != 19 && curspell != 207 && curspell != 2171 && curspell != 3578 && curspell != 45 && curspell != 1454 && curspell != 63 && curspell != 4585 && curspell != 124 && curspell != 3684 && curspell != 504 && curspell != 1288 && curspell != 3975 && curspell != 131 && curspell != 2587 && curspell != 4587 && curspell != 662 && curspell != 1455 && curspell != 1743 && curspell != 2172 && curspell != 4064 && curspell != 4500 && curspell != 64 && curspell != 8925 && curspell != 2588 && curspell != 44 && curspell != 7004 && curspell != 96 && curspell != 9 && curspell != 2589 && curspell != 4065 && curspell != 488 && curspell != 49 && curspell != 1283 && curspell != 392 && curspell != 4590 && curspell != 1456 && curspell != 1534 && curspell != 20 && curspell != 21400 && curspell != 2590 && curspell != 2880 && curspell != 314 && curspell != 4518) {
				continue;
			} else if (this->GetClass() == RANGER && curspell != 5011 && curspell != 51 && curspell != 239 && curspell != 240 && curspell != 2591 && curspell != 242 && curspell != 26 && curspell != 200 && curspell != 224 && curspell != 237 && curspell != 2592 && curspell != 269 && curspell != 203 && curspell != 515 && curspell != 247 && curspell != 92 && curspell != 249 && curspell != 252 && curspell != 241 && curspell != 248 && curspell != 254 && curspell != 500 && curspell != 225 && curspell != 91 && curspell != 86 && curspell != 17 && curspell != 263 && curspell != 213 && curspell != 250 && curspell != 256 && curspell != 264 && curspell != 268 && curspell != 655 && curspell != 278 && curspell != 2593 && curspell != 3565 && curspell != 48 && curspell != 516 && curspell != 513 && curspell != 80 && curspell != 115 && curspell != 517 && curspell != 261 && curspell != 1461 && curspell != 2594 && curspell != 419 && curspell != 12 && curspell != 421 && curspell != 3564 && curspell != 3601 && curspell != 3687 && curspell != 4054 && curspell != 518 && curspell != 129 && curspell != 78 && curspell != 76 && curspell != 60 && curspell != 34 && curspell != 2595 && curspell != 425 && curspell != 4055 && curspell != 691 && curspell != 1462 && curspell != 1741 && curspell != 40809 && curspell != 1397 && curspell != 4585 && curspell != 512 && curspell != 5571 && curspell != 2596 && curspell != 3688 && curspell != 57 && curspell != 430 && curspell != 259 && curspell != 2597 && curspell != 422 && curspell != 4587 && curspell != 1296 && curspell != 145 && curspell != 1463 && curspell != 4111 && curspell != 4506 && curspell != 61 && curspell != 2598 && curspell != 426 && curspell != 539 && curspell != 15 && curspell != 2599 && curspell != 4059 && curspell != 432 && curspell != 49 && curspell != 1740 && curspell != 423 && curspell != 1464 && curspell != 2600 && curspell != 4519 && curspell != 490 && curspell != 519) {
				continue;
			}
			if (book_slot == -1) {	//no more book slots
				this->Message(13, "Unable to scribe spell %s (%u) to spellbook: no more spell book slots available.", spells[curspell].name, curspell);
				break;
			}
			if (!IsDiscipline(curspell) && !this->HasSpellScribed(curspell)) {	//isn't a discipline & we don't already have it scribed
				this->ScribeSpell(curspell, book_slot);
				spellCount++;
			}
			if (IsDiscipline(curspell)) {
				//we may want to come up with a function like Client::GetNextAvailableSpellBookSlot() to help speed this up a little
				for (int r = 0; r < MAX_PP_DISCIPLINES; r++) {
					if (this->GetPP().disciplines.values[r] == curspell) { //Already learned
						break;
					}
					else if (this->GetPP().disciplines.values[r] == 0) {
						this->GetPP().disciplines.values[r] = curspell;
						database.SaveCharacterDisc(this->CharacterID(), r, curspell);
						this->SendDisciplineUpdate();
						abilityCount++;	//success counter
						break;
					}	//if we get to this point, there's already a discipline in this slot, so we continue onto the next slot
				}
			}
		}
	}

	if (spellCount > 0) {
		this->Message(0, "You have learned %u new spells!", spellCount);
	}
	if (abilityCount > 0) {
		this->Message(0, "You have learned %u new disciplines!", abilityCount);
	}
	
	DoTributeUpdate();
	SendHPUpdate();
	SetMana(CalcMaxMana());
	UpdateWho();

	UpdateMercLevel();

	Save();
}

// Note: The client calculates exp separately, we cant change this function
// Add: You can set the values you want now, client will be always sync :) - Merkur
uint32 Client::GetEXPForLevel(uint16 check_level)
{

	uint16 check_levelm1 = check_level-1;
	float mod;
	if (check_level < 31)
		mod = 1.0;
	else if (check_level < 36)
		mod = 1.1;
	else if (check_level < 41)
		mod = 1.2;
	else if (check_level < 46)
		mod = 1.3;
	else if (check_level < 52)
		mod = 1.4;
	else if (check_level < 53)
		mod = 1.5;
	else if (check_level < 54)
		mod = 1.6;
	else if (check_level < 55)
		mod = 1.7;
	else if (check_level < 56)
		mod = 1.9;
	else if (check_level < 57)
		mod = 2.1;
	else if (check_level < 58)
		mod = 2.3;
	else if (check_level < 59)
		mod = 2.5;
	else if (check_level < 60)
		mod = 2.7;
	else if (check_level < 61)
		mod = 3.0;
	else
		mod = 3.1;

	float base = (check_levelm1)*(check_levelm1)*(check_levelm1);

	mod *= 1000;

	uint32 finalxp = uint32(base * mod);

	if(RuleB(Character,UseOldRaceExpPenalties))
	{
		float racemod = 1.0;
		if(GetBaseRace() == TROLL || GetBaseRace() == IKSAR) {
			racemod = 1.2;
		} else if(GetBaseRace() == OGRE) {
			racemod = 1.15;
		} else if(GetBaseRace() == BARBARIAN) {
			racemod = 1.05;
		} else if(GetBaseRace() == HALFLING) {
			racemod = 0.95;
		}

		finalxp = uint32(finalxp * racemod);
	}

	if(RuleB(Character,UseOldClassExpPenalties))
	{
		float classmod = 1.0;
		if(GetClass() == PALADIN || GetClass() == SHADOWKNIGHT || GetClass() == RANGER || GetClass() == BARD) {
			classmod = 1.4;
		} else if(GetClass() == MONK) {
			classmod = 1.2;
		} else if(GetClass() == WIZARD || GetClass() == ENCHANTER || GetClass() == MAGICIAN || GetClass() == NECROMANCER) {
			classmod = 1.1;
		} else if(GetClass() == ROGUE) {
			classmod = 0.91;
		} else if(GetClass() == WARRIOR) {
			classmod = 0.9;
		}

		finalxp = uint32(finalxp * classmod);
	}

	finalxp = mod_client_xp_for_level(finalxp, check_level);

	return finalxp;
}

void Client::AddLevelBasedExp(uint8 exp_percentage, uint8 max_level) { 
	if (exp_percentage > 100) { exp_percentage = 100; } 
	if (!max_level || GetLevel() < max_level) { max_level = GetLevel(); } 
	uint32 newexp = GetEXP() + ((GetEXPForLevel(max_level + 1) - GetEXPForLevel(max_level)) * exp_percentage / 100); 
	SetEXP(newexp, GetAAXP());
}

void Group::SplitExp(uint32 exp, Mob* other) {
	if( other->CastToNPC()->MerchantType != 0 ) // Ensure NPC isn't a merchant
		return;

	if(other->GetOwner() && other->GetOwner()->IsClient()) // Ensure owner isn't pc
		return;

	unsigned int i;
	uint32 groupexp = exp;
	uint8 membercount = 0;
	uint8 maxlevel = 1;

	for (i = 0; i < MAX_GROUP_MEMBERS; i++) {
		if (members[i] != nullptr) {
			if(members[i]->GetLevel() > maxlevel)
				maxlevel = members[i]->GetLevel();

			membercount++;
		}
	}

	float groupmod;
	if (membercount > 1 && membercount < 6)
		groupmod = 1 + .2*(membercount - 1); //2members=1.2exp, 3=1.4, 4=1.6, 5=1.8
	else if (membercount == 6)
		groupmod = 2.16;
	else
		groupmod = 1.0;
	if(membercount > 1 &&  membercount <= 6)
		groupexp += (uint32)((float)exp * groupmod * (RuleR(Character, GroupExpMultiplier)));

	int conlevel = Mob::GetLevelCon(maxlevel, other->GetLevel());
	if(conlevel == CON_GREEN)
		return;	//no exp for greenies...

	if (membercount == 0)
		return;

	for (i = 0; i < MAX_GROUP_MEMBERS; i++) {
		if (members[i] != nullptr && members[i]->IsClient()) // If Group Member is Client
		{
			Client *cmember = members[i]->CastToClient();
			// add exp + exp cap
			int16 diff = cmember->GetLevel() - maxlevel;
			int16 maxdiff = -(cmember->GetLevel()*15/10 - cmember->GetLevel());
				if(maxdiff > -5)
					maxdiff = -5;
			if (diff >= (maxdiff)) { /*Instead of person who killed the mob, the person who has the highest level in the group*/
				uint32 tmp = (cmember->GetLevel()+3) * (cmember->GetLevel()+3) * 75 * 35 / 10;
				uint32 tmp2 = groupexp / membercount;
				cmember->AddEXP( tmp < tmp2 ? tmp : tmp2, conlevel );
			}
		}
	}
}

void Raid::SplitExp(uint32 exp, Mob* other) {
	if( other->CastToNPC()->MerchantType != 0 ) // Ensure NPC isn't a merchant
		return;

	if(other->GetOwner() && other->GetOwner()->IsClient()) // Ensure owner isn't pc
		return;

	uint32 groupexp = exp;
	uint8 membercount = 0;
	uint8 maxlevel = 1;

	for (int i = 0; i < MAX_RAID_MEMBERS; i++) {
		if (members[i].member != nullptr) {
			if(members[i].member->GetLevel() > maxlevel)
				maxlevel = members[i].member->GetLevel();

			membercount++;
		}
	}

	groupexp = (uint32)((float)groupexp * (1.0f-(RuleR(Character, RaidExpMultiplier))));

	int conlevel = Mob::GetLevelCon(maxlevel, other->GetLevel());
	if(conlevel == CON_GREEN)
		return;	//no exp for greenies...

	if (membercount == 0)
		return;

	for (unsigned int x = 0; x < MAX_RAID_MEMBERS; x++) {
		if (members[x].member != nullptr) // If Group Member is Client
		{
			Client *cmember = members[x].member;
			// add exp + exp cap
			int16 diff = cmember->GetLevel() - maxlevel;
			int16 maxdiff = -(cmember->GetLevel()*15/10 - cmember->GetLevel());
			if(maxdiff > -5)
				maxdiff = -5;
			if (diff >= (maxdiff)) { /*Instead of person who killed the mob, the person who has the highest level in the group*/
				uint32 tmp = (cmember->GetLevel()+3) * (cmember->GetLevel()+3) * 75 * 35 / 10;
				uint32 tmp2 = (groupexp / membercount) + 1;
				cmember->AddEXP( tmp < tmp2 ? tmp : tmp2, conlevel );
			}
		}
	}
}

void Client::SetLeadershipEXP(uint32 group_exp, uint32 raid_exp) {
	while(group_exp >= GROUP_EXP_PER_POINT) {
		group_exp -= GROUP_EXP_PER_POINT;
		m_pp.group_leadership_points++;
		Message_StringID(MT_Leadership, GAIN_GROUP_LEADERSHIP_POINT);
	}
	while(raid_exp >= RAID_EXP_PER_POINT) {
		raid_exp -= RAID_EXP_PER_POINT;
		m_pp.raid_leadership_points++;
		Message_StringID(MT_Leadership, GAIN_RAID_LEADERSHIP_POINT);
	}

	m_pp.group_leadership_exp = group_exp;
	m_pp.raid_leadership_exp = raid_exp;

	SendLeadershipEXPUpdate();
}

void Client::AddLeadershipEXP(uint32 group_exp, uint32 raid_exp) {
	SetLeadershipEXP(GetGroupEXP() + group_exp, GetRaidEXP() + raid_exp);
}

void Client::SendLeadershipEXPUpdate() {
	EQApplicationPacket* outapp = new EQApplicationPacket(OP_LeadershipExpUpdate, sizeof(LeadershipExpUpdate_Struct));
	LeadershipExpUpdate_Struct* eu = (LeadershipExpUpdate_Struct *) outapp->pBuffer;

	eu->group_leadership_exp = m_pp.group_leadership_exp;
	eu->group_leadership_points = m_pp.group_leadership_points;
	eu->raid_leadership_exp = m_pp.raid_leadership_exp;
	eu->raid_leadership_points = m_pp.raid_leadership_points;

	FastQueuePacket(&outapp);
}

uint32 Client::GetCharMaxLevelFromQGlobal() {
	QGlobalCache *char_c = nullptr;
	char_c = this->GetQGlobals();

	std::list<QGlobal> globalMap;
	uint32 ntype = 0;

	if(char_c) {
		QGlobalCache::Combine(globalMap, char_c->GetBucket(), ntype, this->CharacterID(), zone->GetZoneID());
	}

	std::list<QGlobal>::iterator iter = globalMap.begin();
	uint32 gcount = 0;
	while(iter != globalMap.end()) {
		if((*iter).name.compare("CharMaxLevel") == 0){
			return atoi((*iter).value.c_str());
		} 
		++iter;
		++gcount;
	}

	return false;
}
