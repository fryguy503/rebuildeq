<?php

class Item {
	public static function get_attributes(stdClass $item) {
		if (empty($item)) return $item;

		$item->classesString = Item::get_classes($item->classes);
		$item->racesString = Item::get_races($item->races);
		$item->slotsString = Item::get_slots($item->slots);
		$item->typeString = Item::get_type($item->itemtype);
		$item->sizeString = Item::get_sizes($item->size);
		$item->weight = sprintf("%.1f", $item->weight/10);
		$item->slotType = Item::get_slottype($item->slots);
		return $item;
	}

	public static function get_classes($classes) {

		$classString = "";
 		if (($classes & 1) == 1) $classString .= " WAR";
 		if (($classes & 2) == 2) $classString .= " CLR";
 		if (($classes & 4) == 4) $classString .= " PAL";
 		if (($classes & 8) == 8) $classString .= " RNG";
 		if (($classes & 16) == 16) $classString .= " SHD";
 		if (($classes & 32) == 32) $classString .= " DRU";
 		if (($classes & 64) == 64) $classString .= " MNK";
 		if (($classes & 128) == 128) $classString .= " BRD";
 		if (($classes & 256) == 256) $classString .= " ROG";
 		if (($classes & 512) == 512) $classString .= " SHM";
 		if (($classes & 1024) == 1024) $classString .= " NEC";
 		if (($classes & 2048) == 2048) $classString .= " WIZ";
 		if (($classes & 4096) == 4096) $classString .= " MAG";
 		if (($classes & 8192) == 8192) $classString .= " ENC";
 		if (($classes & 16384) == 16384) $classString .= " BST";
 		if (($classes & 32768) == 32768) $classString .= " BER";
 		if (($classes & 65535) == 65535) $classString = "ALL";
 		if (strlen($classString) == 0) $classString = "NONE";
		return $classString;
	}

	public static function get_races($race) {
		$raceString = "";
		if (($race & 1) == 1) $raceString .= " HUM";
		if (($race & 2) == 2) $raceString .= " BAR";
		if (($race & 4) == 4) $raceString .= " ERU";
		if (($race & 8) == 8) $raceString .= " WEF";
		if (($race & 16) == 16) $raceString .= " HEF";
		if (($race & 32) == 32) $raceString .= " DEF";
		if (($race & 64) == 64) $raceString .= " HLF";
		if (($race & 128) == 128) $raceString .= " DWF";
		if (($race & 256) == 256) $raceString .= " TRL";
		if (($race & 512) == 512) $raceString .= " OGR";
		if (($race & 1024) == 1024) $raceString .= " HFL";
		if (($race & 2048) == 2048) $raceString .= " GNM";
		if (($race & 4096) == 4096) $raceString .= " IKS";
		if (($race & 8192) == 8192) $raceString .= " VHS";
		if (($race & 16384) == 16384) $raceString .= " FRG";
		if (($race & 32768) == 32768) $raceString .= " DRK";
		if (($race & 65535) == 65535) $raceString = "ALL";
 		if (strlen($race) == 0) $raceString = "NONE";
		return $raceString;
	}

	public static function get_slottype($slots) {
		if (($slots & 8192) == 8192 ||  //primary
			($slots & 16384) == 16384 || //secondary
			($slots & 2048) == 2048) { //range
			return "Weapon";
		}
		if (($slots & 1) == 1 ||
			($slots & 4) == 4 ||
			($slots & 8) == 8 ||
			($slots & 16) == 16 ||
			($slots & 32) == 32 ||
			($slots & 64) == 64 ||
			($slots & 128) == 128 ||
			($slots & 256) == 256 ||
			($slots & 1536) == 1536 ||
			($slots & 4096) == 4096 ||
			($slots & 98304) == 98304 ||
			($slots & 131072) == 131072 ||
			($slots & 262144) == 262144 ||
			($slots & 524288) == 524288 ||
			($slots & 1048576) == 1048576) {
				return "Gear";
			}
		return "Item";
	}

	public static function get_slots($slots) {
		$slotString = "";
		if (($slots & 1) == 1) $slotString .= " Charm";
		if (($slots & 4) == 4) $slotString .= " Head";
		if (($slots & 8) == 8) $slotString .= " Face";
		if (($slots & 16) == 16) $slotString .= " Ears";
		if (($slots & 32) == 32) $slotString .= " Neck";
		if (($slots & 64) == 64) $slotString .= " Shoulders";
		if (($slots & 128) == 128) $slotString .= " Arms";
		if (($slots & 256) == 256) $slotString .= " Back";
		if (($slots & 1536) == 1536) $slotString .= " Bracers";
		if (($slots & 2048) == 2048) $slotString .= " Range";
		if (($slots & 4096) == 4096) $slotString .= " Hands";
		if (($slots & 8192) == 8192) $slotString .= " Primary";
		if (($slots & 16384) == 16384) $slotString .= " Secondary";
		if (($slots & 98304) == 98304) $slotString .= " Rings";
		if (($slots & 131072) == 131072) $slotString .= " Chest";
		if (($slots & 262144) == 262144) $slotString .= " Legs";
		if (($slots & 524288) == 524288) $slotString .= " Feet";
		if (($slots & 1048576) == 1048576) $slotString .= " Waist";
		if (($slots & 2097152) == 2097152) $slotString .= " Ammo";
		if (($slots & 4194304) == 4194304) $slotString .= " Powersource";
		if (strlen($slotString) == 0) $slotString = "NONE";
		return $slotString;
	}

	public static function get_sizes($size) {
		if ($size == 1) return "SMALL";
		if ($size == 2) return "MEDIUM";
		if ($size == 3) return "LARGE";
		if ($size == 4) return "GIANT";
		return "MEDIUM";
	}

	public static function get_type($type) {
		if ($type == "0") return "1HS";
		if ($type == "1") return "2HS";
		if ($type == "2") return "Piercing";
		if ($type == "3") return "1HB";
		if ($type == "4") return "2HB";
		if ($type == "5") return "Archery";
		if ($type == "6") return "Unused";
		if ($type == "7") return "Throwing";
		if ($type == "8") return "Shield";
		if ($type == "9") return "Unused";
		if ($type == "10") return "Armor";
		if ($type == "11") return "Tradeskill"; //Involves Tradeskills (Not sure how)";
		if ($type == "12") return "Lock Picking";
		if ($type == "13") return "Unused";
		if ($type == "14") return "Food"; // (Right Click to use)";
		if ($type == "15") return "Drink"; // (Right Click to use)";
		if ($type == "16") return "Light Source";
		if ($type == "17") return "Common"; // Inventory Item";
		if ($type == "18") return "Bind Wound";
		if ($type == "19") return "Thrown"; // Casting Items (Explosive potions etc)";
		if ($type == "20") return "Spell"; // / Song Sheets";
		if ($type == "21") return "Potions";
		if ($type == "22") return "Arrow"; //Fletched Arrows?...";
		if ($type == "23") return "Wind Instruments";
		if ($type == "24") return "Stringed Instruments";
		if ($type == "25") return "Brass Instruments";
		if ($type == "26") return "Drum Instruments";
		if ($type == "27") return "Ammo";
		if ($type == "28") return "Unused28";
		if ($type == "29") return "Jewlery"; // Items (As far as I can tell)";
		if ($type == "30") return "Unused30";
		if ($type == "31") return "Scroll"; //Usually Readable Notes and Scrolls *i beleive this to display [This note is Rolle Up/Unrolled]*";
		if ($type == "32") return "Book"; //Usually Readable Books *i beleive this to display [This Book is Closed/Open]*";
		if ($type == "33") return "Key";
		if ($type == "34") return "Item"; //Odd Items (Not sure what they are for)";
		if ($type == "35") return "2H Pierce";
		if ($type == "36") return "Fishing Poles";
		if ($type == "37") return "Fishing Bait";
		if ($type == "38") return "Alcoholic Beverages";
		if ($type == "39") return "Keys"; //More Keys";
		if ($type == "40") return "Compasses";
		if ($type == "41") return "Unused41";
		if ($type == "42") return "Poison";
		if ($type == "43") return "Unused43";
		if ($type == "44") return "Unused44";
		if ($type == "45") return "Hand to Hand";
		if ($type == "46") return "Unused46";
		if ($type == "47") return "Unused47";
		if ($type == "48") return "Unused48";
		if ($type == "49") return "Unused49";
		if ($type == "50") return "Unused50";
		if ($type == "51") return "Unused51";
		if ($type == "52") return "Charm";
		if ($type == "53") return "Dye";
		if ($type == "54") return "Augment";
		if ($type == "55") return "Augment Solvent";
		if ($type == "56") return "Augment Distiller";
		if ($type == "58") return "Fellowship Banner Material";
		if ($type == "60") return "Cultural Armor"; // Manuals, unsure how this works exactly.";
		if ($type == "63") return "Currency"; //New Curencies like Orum";
		return "Unknown";
	}
}