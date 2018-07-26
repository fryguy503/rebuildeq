/*	EQEMu:  Everquest Server Emulator

Copyright (C) 2001-2016 EQEMu Development Team (http://eqemulator.net)

This program is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; version 2 of the License.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY except by those people which sell it, which
are required to give you total support for your newly bought product;
without even the implied warranty of MERCHANTABILITY or FITNESS FOR
A PARTICULAR PURPOSE.  See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
*/

#include "emu_constants.h"
#include <cstring>

const char* EQEmu::bug::CategoryIDToCategoryName(CategoryID category_id) {
    switch (category_id) {
        case catVideo:
            return "Video";
        case catAudio:
            return "Audio";
        case catPathing:
            return "Pathing";
        case catQuest:
            return "Quest";
        case catTradeskills:
            return "Tradeskills";
        case catSpellStacking:
            return "Spell stacking";
        case catDoorsPortals:
            return "Doors/Portals";
        case catItems:
            return "Items";
        case catNPC:
            return "NPC";
        case catDialogs:
            return "Dialogs";
        case catLoNTCG:
            return "LoN - TCG";
        case catMercenaries:
            return "Mercenaries";
        case catOther:
        default:
            return "Other";
    }
}

EQEmu::bug::CategoryID EQEmu::bug::CategoryNameToCategoryID(const char* category_name) {
    if (!category_name)
        return catOther;

    if (!strcmp(category_name, "Video"))
        return catVideo;
    if (!strcmp(category_name, "Audio"))
        return catAudio;
    if (!strcmp(category_name, "Pathing"))
        return catPathing;
    if (!strcmp(category_name, "Quest"))
        return catQuest;
    if (!strcmp(category_name, "Tradeskills"))
        return catTradeskills;
    if (!strcmp(category_name, "Spell stacking"))
        return catSpellStacking;
    if (!strcmp(category_name, "Doors/Portals"))
        return catDoorsPortals;
    if (!strcmp(category_name, "Items"))
        return catItems;
    if (!strcmp(category_name, "NPC"))
        return catNPC;
    if (!strcmp(category_name, "Dialogs"))
        return catDialogs;
    if (!strcmp(category_name, "LoN - TCG"))
        return catLoNTCG;
    if (!strcmp(category_name, "Mercenaries"))
        return catMercenaries;

    return catOther;
}