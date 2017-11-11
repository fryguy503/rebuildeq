#::: Load pricing of velious based on slot provided, in platinum

#2 head
#7 arm
#9 || 10 wrist
#12 hand
#17 chest
#18 leg
#19 feet

sub velious_pricing_by_slot {
	my $price = 100;
	my $slot = shift;
	if ($slot == 2) { $price = 500; } #head
	elsif ($slot == 7) { $price = 500;} #arm
	elsif ($slot == 9 || $slot == 10) {$price = 500;} #wrist
	elsif ($slot == 12) {$price = 500;} #hand
	elsif ($slot == 17) {$price = 1500;} #chest
	elsif ($slot == 18) {$price = 1500;} #leg
	elsif ($slot == 19) {$price = 500;} #feet
	return $price;
}

sub velious_armor_hail {
	my $text = shift;
	my $zoneid = shift;
	my $classid = shift;
	my $location = "";
	my $armor_type = "";

	if($text=~/armor/i || $text=~/hail/i) {
        quest::say("Are you interested in armor that Velious has to offer? [ ".quest::saylink("head")."], [".quest::saylink("arms")."], [".quest::saylink("wrists")."], [".quest::saylink("hands")."], [".quest::saylink("chest")."], [".quest::saylink("legs")."], [".quest::saylink("feet")."], [".quest::saylink("gems")."]");
    } elsif($text=~/head/i || $text=~/arms/i || $text=~/wrists/i || $text=~/hands/i || $text=~/chest/i || $text=~/legs/i || $text=~/feet/i) {
       plugin::velious_armor_requirement($text, $zoneid, $classid);
    } elsif($text=~/gems/i) {
    	if ($zoneid == 115) { #Thurgadin
    		quest::say("Gem quests are available in Kael Drakkel and Skyshrine only.");
    		return;
    	} elsif ($zoneid == 113) { #kael
			$location = "the West Wing of the Temple of Veeshan";
			if ($classid == 3 || $classid == 8 || $classid == 1 || $classid == 5 || $classid == 2) {
				$armor_type = "n Ancient Tarnished Plate";			
			}
			elsif ($classid == 4 || $classid == 9 || $classid == 10) {
				$armor_type = "n Ancient Tarnished Chain";			
			}
			elsif ($classid == 6 || $classid == 7 || $classid == 10) {
				$armor_type = "n Ancient Leather";			
			}
			else {
				$armor_type = "n Ancient Silk";			
			}
		} elsif ($zoneid == 114) { #skyshrine
			$location = "the Halls of Testing in the Temple of Veeshan";
			if ($classid == 3 || $classid == 8 || $classid == 1 || $classid == 5 || $classid == 2) {
				$armor_type = "n Unadorned Plate";			
			}
			elsif ($classid == 4 || $classid == 9 || $classid == 10) {
				$armor_type = "n Unadorned Chain";			
			}
			elsif ($classid == 6 || $classid == 7 || $classid == 10) {
				$armor_type = "n Unadorned Leather";			
			}
			else {
				$armor_type = " Tattered Silk";			
			}
		}
		quest::say("Veeshan's Gems infuse armor from the Temple, and may be chiseled to perfection 10 total times. The first 4 times, while the gem is yellow and white are always successful. Beyond this point, the gem becomes red, and each chisel runs the risk of losing the gem (so proceed with caution). Found in $location, I require a$armor_type piece, Veeshan's Gem from Dozekar the Cursed (or a previously chiseled gem), an elunium found off creatures level 55+, and my fee of 200 platinum in order to attempt chiseling.");
    }
    return;
}


sub velious_armor_requirement {
	my $slot = shift;
	my $zoneid = shift;
	my $classid = shift;
	my $armor = "";
	my $armor_type = "";
	my $slotname = "";
	my $location = "";
	my $slotid = 0;

	if ($zoneid == 115) { #Thurgadin
		$location = "the Arena of Kael Drakkel";

		if ($classid == 3 || $classid == 8 || $classid == 1 || $classid == 5 || $classid == 2) {
			$armor_type = " Corroded Plate";
			if ($slot=~/head/i) {$slotname = "Helmet"; $slotid = 2; }
			elsif ($slot=~/arms/i) {$slotname = "Vambraces"; $slotid = 7; }
			elsif ($slot=~/wrists/i) {$slotname = "Bracer"; $slotid = 9; }
			elsif ($slot=~/hands/i) {$slotname = "Gauntlets"; $slotid = 12; }
			elsif ($slot=~/chest/i) { $slotname = "Breastplate"; $slotid = 17; } 
			elsif ($slot=~/legs/i) {$slotname = "Greaves"; $slotid = 18; }
			else {$slotname = "Boots"; $slotid = 19; }
		}
		elsif ($classid == 4 || $classid == 9 || $classid == 10) {
			$armor_type = " Corroded Chain";
			if ($slot=~/head/i) { $slotname = "Coif"; $slotid = 2; }
			elsif ($slot=~/arms/i) { $slotname = "Sleeves"; $slotid = 7; }
			elsif ($slot=~/wrists/i) { $slotname = "Bracer"; $slotid = 9; }
			elsif ($slot=~/hands/i) { $slotname = "Gauntlets"; $slotid = 12; }
			elsif ($slot=~/chest/i) { $slotname = "Tunic"; $slotid = 17; }
			elsif ($slot=~/legs/i) { $slotname = "Leggings"; $slotid = 18; }
			else { $slotname = "Boots"; $slotid = 19; }		
		}
		elsif ($classid == 6 || $classid == 7 || $classid == 10) {
			$armor_type = "n Eroded Leather";
			if ($slot=~/head/i) { $slotname = "Cap"; $slotid = 2;  }
			elsif ($slot=~/arms/i) { $slotname = "Sleeves"; $slotid = 7;  }
			elsif ($slot=~/wrists/i) { $slotname = "Braclet"; $slotid = 9;  }
			elsif ($slot=~/hands/i) { $slotname = "Gloves"; $slotid = 12;  }
			elsif ($slot=~/chest/i) { $slotname = "Tunic"; $slotid = 17;  }
			elsif ($slot=~/legs/i) { $slotname = "Leggings"; $slotid = 18;  }
			else { $slotname = "Boots"; $slotid = 19;  }
		}
		else {
			$armor_type = " Torn Enchanted Silk";
			if ($slot=~/head/i) { $slotname = "Turban"; $slotid = 2;  }
			elsif ($slot=~/arms/i) { $slotname = "Sleeves"; $slotid = 7;  }
			elsif ($slot=~/wrists/i) { $slotname = "Wristband"; $slotid = 9;  }
			elsif ($slot=~/hands/i) { $slotname = "Gloves"; $slotid = 12;  }
			elsif ($slot=~/chest/i) { $slotname = "Robe"; $slotid = 17;  }
			elsif ($slot=~/legs/i) { $slotname = "Pantaloons"; $slotid = 18;  }
			else { $slotname = "Boots"; $slotid = 19;  }
		}

	}
	elsif ($zoneid == 113) { #kael
		$location = "the West Wing of the Temple of Veeshan";
		if ($classid == 3 || $classid == 8 || $classid == 1 || $classid == 5 || $classid == 2) {
			$armor_type = "n Ancient Tarnished Plate";
			if ($slot=~/head/i) { $slotname = "Helmet"; $slotid = 2;  }
			elsif ($slot=~/arms/i) { $slotname = "Vambraces"; $slotid = 7;  }
			elsif ($slot=~/wrists/i) { $slotname = "Bracer"; $slotid = 9;  }
			elsif ($slot=~/hands/i) { $slotname = "Gauntlets"; $slotid = 12;  }
			elsif ($slot=~/chest/i) { $slotname = "Breastplate"; $slotid = 17;  }
			elsif ($slot=~/legs/i) { $slotname = "Greaves"; $slotid = 18;  }
			else { $slotname = "Boots"; $slotid = 19;  }
		}
		elsif ($classid == 4 || $classid == 9 || $classid == 10) {
			$armor_type = "n Ancient Tarnished Chain";
			if ($slot=~/head/i) { $slotname = "Coif"; $slotid = 2;  }
			elsif ($slot=~/arms/i) { $slotname = "Sleeves"; $slotid = 7;  }
			elsif ($slot=~/wrists/i) { $slotname = "Bracer"; $slotid = 9;  }
			elsif ($slot=~/hands/i) { $slotname = "Gauntlets"; $slotid = 12;  }
			elsif ($slot=~/chest/i) { $slotname = "Tunic"; $slotid = 17;  }
			elsif ($slot=~/legs/i) { $slotname = "Leggings"; $slotid = 18;  }
			else { $slotname = "Boots"; $slotid = 19;  }
		}
		elsif ($classid == 6 || $classid == 7 || $classid == 10) {
			$armor_type = "n Ancient Leather";
			if ($slot=~/head/i) { $slotname = "Cap"; $slotid = 2;  }
			elsif ($slot=~/arms/i) { $slotname = "Sleeves"; $slotid = 7;  }
			elsif ($slot=~/wrists/i) { $slotname = "Braclet"; $slotid = 9;  }
			elsif ($slot=~/hands/i) { $slotname = "Gloves"; $slotid = 12;  }
			elsif ($slot=~/chest/i) { $slotname = "Tunic"; $slotid = 17;  }
			elsif ($slot=~/legs/i) { $slotname = "Leggings"; $slotid = 18;  }
			else { $slotname = "Boots"; $slotid = 19;  }
		}
		else {
			$armor_type = "n Ancient Silk";
			if ($slot=~/head/i) { $slotname = "Turban"; $slotid = 2;  }
			elsif ($slot=~/arms/i) { $slotname = "Sleeves"; $slotid = 7;  }
			elsif ($slot=~/wrists/i) { $slotname = "Wristband"; $slotid = 9;  }
			elsif ($slot=~/hands/i) { $slotname = "Gloves"; $slotid = 12;  }
			elsif ($slot=~/chest/i) { $slotname = "Robe"; $slotid = 17;  }
			elsif ($slot=~/legs/i) { $slotname = "Pantaloons"; $slotid = 18;  }
			else { $slotname = "Boots"; $slotid = 19;  }
		}
	}
	elsif ($zoneid == 114) { #skyshrine
		$location = "the Halls of Testing in the Temple of Veeshan";
		if ($classid == 3 || $classid == 8 || $classid == 1 || $classid == 5 || $classid == 2) {
			$armor_type = "n Unadorned Plate";
			if ($slot=~/head/i) { $slotname = "Helmet"; $slotid = 2;  }
			elsif ($slot=~/arms/i) { $slotname = "Vambraces"; $slotid = 7;  }
			elsif ($slot=~/wrists/i) { $slotname = "Bracer"; $slotid = 9;  }
			elsif ($slot=~/hands/i) { $slotname = "Gauntlets"; $slotid = 12;  }
			elsif ($slot=~/chest/i) { $slotname = "Breastplate"; $slotid = 17;  }
			elsif ($slot=~/legs/i) { $slotname = "Greaves"; $slotid = 18;  }
			else { $slotname = "Boots"; $slotid = 19;  }
		}
		elsif ($classid == 4 || $classid == 9 || $classid == 10) {
			$armor_type = "n Unadorned Chain";
			if ($slot=~/head/i) { $slotname = "Coif"; $slotid = 2;  }
			elsif ($slot=~/arms/i) { $slotname = "Sleeves"; $slotid = 7;  }
			elsif ($slot=~/wrists/i) { $slotname = "Bracer"; $slotid = 9;  }
			elsif ($slot=~/hands/i) { $slotname = "Gauntlets"; $slotid = 12;  }
			elsif ($slot=~/chest/i) { $slotname = "Tunic"; $slotid = 17;  }
			elsif ($slot=~/legs/i) { $slotname = "Leggings"; $slotid = 18;  }
			else { $slotname = "Boots"; $slotid = 19;  }
		}
		elsif ($classid == 6 || $classid == 7 || $classid == 10) {
			$armor_type = "n Unadorned Leather";
			if ($slot=~/head/i) { $slotname = "Cap"; $slotid = 2;  }
			elsif ($slot=~/arms/i) { $slotname = "Sleeves"; $slotid = 7;  }
			elsif ($slot=~/wrists/i) { $slotname = "Braclet"; $slotid = 9;  }
			elsif ($slot=~/hands/i) { $slotname = "Gloves"; $slotid = 12;  }
			elsif ($slot=~/chest/i) { $slotname = "Tunic"; $slotid = 17;  }
			elsif ($slot=~/legs/i) { $slotname = "Leggings"; $slotid = 18;  }
			else { $slotname = "Boots"; $slotid = 19;  }
		}
		else {
			$armor_type = " Tattered Silk";
			if ($slot=~/head/i) { $slotname = "Turban"; $slotid = 2;  }
			elsif ($slot=~/arms/i) { $slotname = "Sleeves"; $slotid = 7;  }
			elsif ($slot=~/wrists/i) { $slotname = "Wristband"; $slotid = 9;  }
			elsif ($slot=~/hands/i) { $slotname = "Gloves"; $slotid = 12;  }
			elsif ($slot=~/chest/i) { $slotname = "Robe"; $slotid = 17;  }
			elsif ($slot=~/legs/i) { $slotname = "Pantaloons"; $slotid = 18;  }
			else { $slotname = "Boots"; $slotid = 19;  }
		}
	}
	$price = plugin::velious_pricing_by_slot($slotid);
	quest::say("Found in $location, I require a$armor_type $slotname and my fee of $price platinum to craft this item.");
}

sub velious_faction {
	$zoneid = shift;
	quest::exp(175000);
	if ($zoneid == 114) { #SS
		quest::faction(42,30); # CoV
        quest::faction(362,30); # Yelinak
        quest::faction(189,-60); # Kromzek
	} elsif ($zoneid == 114) { #kael
        quest::faction(179,20); # King Tormax
        quest::faction(189,20); # Kromzek
        quest::faction(42,-20); # Claws of Veeshan
        quest::faction(49,-60); # Coldain
	} else { #Thurg
		quest::faction(49,20); # coldain
		quest::faction(67,20); # Dain Frostreaver IV
		quest::faction(188,-60); # Kromrif
		quest::faction(189,-60); # Kromzek
	}
 
}

sub velious_slot_by_item {

	$itemid = shift;
	$zoneid = shift;
	$classid = shift;
	#quest::say("by_item: $itemid, $zoneid, $classid");

	###KAEL###
	if ($zoneid == 113) { #kael
		if ($classid == 3) { #paladin
			if ($itemid == 24905) { return 2; } #cap
			if ($itemid == 24900) { return 17; } #bp
			if ($itemid == 24902) { return 7; } #sleeves
			if ($itemid == 24904) { return 9; } #wrist
			if ($itemid == 24906) { return 12; } #gloves
			if ($itemid == 24901) { return 18; } #legs
			if ($itemid == 24903) { return 19; } #boots
			return 0;
		}
		if ($classid == 8) { #bard
			if ($itemid == 24905) { return 2; } #cap		
			if ($itemid == 24900) { return 17; } #bp
			if ($itemid == 24902) { return 7; } #sleeves
			if ($itemid == 24904) { return 9; } #wrist
			if ($itemid == 24906) { return 12; } #gloves
			if ($itemid == 24901) { return 18; } #legs
			if ($itemid == 24903) { return 19; } #boots
			return 0;
		}
		if ($classid == 7) { #monk
			if ($itemid == 24919) { return 2; } #cap		
			if ($itemid == 24914) { return 17; } #bp
			if ($itemid == 24916) { return 7; } #sleeves
			if ($itemid == 24918) { return 9; } #wrist
			if ($itemid == 24920) { return 12; } #gloves
			if ($itemid == 24915) { return 18; } #legs
			if ($itemid == 24917) { return 19; } #boots
			return 0;
		}
		if ($classid == 4) { #ranger
			if ($itemid == 24912) { return 2; } #cap
			if ($itemid == 24907) { return 17; } #bp
			if ($itemid == 24909) { return 7; } #sleeves
			if ($itemid == 24911) { return 9; } #wrist
			if ($itemid == 24913) { return 12; } #gloves
			if ($itemid == 24908) { return 18; } #legs
			if ($itemid == 24910) { return 19; } #boots
			return 0;
		}
		if ($classid == 6) { #druid
			if ($itemid == 24919) { return 2; } #cap		
			if ($itemid == 24914) { return 17; } #bp
			if ($itemid == 24916) { return 7; } #sleeves
			if ($itemid == 24918) { return 9; } #wrist
			if ($itemid == 24920) { return 12; } #gloves
			if ($itemid == 24915) { return 18; } #legs
			if ($itemid == 24917) { return 19; } #boots
		}
		if ($classid == 9) { #rogue
			if ($itemid == 24912) { return 2; } #cap
			if ($itemid == 24907) { return 17; } #bp
			if ($itemid == 24909) { return 7; } #sleeves
			if ($itemid == 24911) { return 9; } #wrist
			if ($itemid == 24913) { return 12; } #gloves
			if ($itemid == 24908) { return 18; } #legs
			if ($itemid == 24910) { return 19; } #boots			
		}
		if ($classid == 1) { #warrior
			if ($itemid == 24905) { return 2; } #cap		
			if ($itemid == 24900) { return 17; } #bp
			if ($itemid == 24902) { return 7; } #sleeves
			if ($itemid == 24904) { return 9; } #wrist
			if ($itemid == 24906) { return 12; } #gloves
			if ($itemid == 24901) { return 18; } #legs
			if ($itemid == 24903) { return 19; } #boots		
		}
		if ($classid == 14) { #enchanter
			if ($itemid == 24926) { return 2; } #cap		
			if ($itemid == 24921) { return 17; } #bp
			if ($itemid == 24923) { return 7; } #sleeves
			if ($itemid == 24925) { return 9; } #wrist
			if ($itemid == 24927) { return 12; } #gloves
			if ($itemid == 24922) { return 18; } #legs
			if ($itemid == 24924) { return 19; } #boots
		}
		if ($classid == 13) { #kael mjeldor felstorm magician silk
			if ($itemid == 24926) { return 2; } #cap		
			if ($itemid == 24921) { return 17; } #bp
			if ($itemid == 24923) { return 7; } #sleeves
			if ($itemid == 24925) { return 9; } #wrist
			if ($itemid == 24927) { return 12; } #gloves
			if ($itemid == 24922) { return 18; } #legs
			if ($itemid == 24924) { return 19; } #boots
		}

		if ($classid == 11) { #kael bjarorm mjlorn necro silk
			if ($itemid == 24926) { return 2; } #cap		
			if ($itemid == 24921) { return 17; } #bp
			if ($itemid == 24923) { return 7; } #sleeves
			if ($itemid == 24925) { return 9; } #wrist
			if ($itemid == 24927) { return 12; } #gloves
			if ($itemid == 24922) { return 18; } #legs
			if ($itemid == 24924) { return 19; } #boots
		}
		#kael nerik wolfsoul beastlord leather
		#kael regbor vallgerthon berserker chain
		if ($classid == 12) { #kael ulkar jollkarek wizard silk
			if ($itemid == 24926) { return 2; } #cap		
			if ($itemid == 24921) { return 17; } #bp
			if ($itemid == 24923) { return 7; } #sleeves
			if ($itemid == 24925) { return 9; } #wrist
			if ($itemid == 24927) { return 12; } #gloves
			if ($itemid == 24922) { return 18; } #legs
			if ($itemid == 24924) { return 19; } #boots
		}
		if ($classid == 5) { #kael veldern blackhammer shadowknight plate
			if ($itemid == 24905) { return 2; } #cap		
			if ($itemid == 24900) { return 17; } #bp
			if ($itemid == 24902) { return 7; } #sleeves
			if ($itemid == 24904) { return 9; } #wrist
			if ($itemid == 24906) { return 12; } #gloves
			if ($itemid == 24901) { return 18; } #legs
			if ($itemid == 24903) { return 19; } #boots
		}
		if ($classid == 2) { #kael vylleam vyaeltor cleric plate
			if ($itemid == 24905) { return 2; } #cap		
			if ($itemid == 24900) { return 17; } #bp
			if ($itemid == 24902) { return 7; } #sleeves
			if ($itemid == 24904) { return 9; } #wrist
			if ($itemid == 24906) { return 12; } #gloves
			if ($itemid == 24901) { return 18; } #legs
			if ($itemid == 24903) { return 19; } #boots
		}
		if ($classid == 10) { #kael yeeldan spiritcaller shaman chain
			if ($itemid == 24912) { return 2; } #cap
			if ($itemid == 24907) { return 17; } #bp
			if ($itemid == 24909) { return 7; } #sleeves
			if ($itemid == 24911) { return 9; } #wrist
			if ($itemid == 24913) { return 12; } #gloves
			if ($itemid == 24908) { return 18; } #legs
			if ($itemid == 24910) { return 19; } #boots
		
		}
		return 0;
	}

	###SKYSHRINE###
	if ($zoneid == 114) {
		if ($classid == 11) { #skyshrine abudan fe-dhar necro silk
			if ($itemid == 24982) { return 2; } #cap
			if ($itemid == 24977) { return 17; } #bp
			if ($itemid == 24979) { return 7; } #sleeves
			if ($itemid == 24981) { return 9; } #wrist
			if ($itemid == 24983) { return 12; } #gloves
			if ($itemid == 24978) { return 18; } #legs
			if ($itemid == 24980) { return 19; } #boots
		
		}
		if ($classid == 3) { #skyshrine adwetram fe-dhar paladin plate
			if ($itemid == 24961) { return 2; } #cap
			if ($itemid == 24956) { return 17; } #bp
			if ($itemid == 24958) { return 7; } #sleeves
			if ($itemid == 24960) { return 9; } #wrist
			if ($itemid == 24962) { return 12; } #gloves
			if ($itemid == 24957) { return 18; } #legs
			if ($itemid == 24959) { return 19; } #boots
		
		}
		if ($classid == 10) { #skyshrine asteinnon fe-dhar shaman chain
			if ($itemid == 24968) { return 2; } #cap
			if ($itemid == 24963) { return 17; } #bp
			if ($itemid == 24965) { return 7; } #sleeves
			if ($itemid == 24967) { return 9; } #wrist
			if ($itemid == 24969) { return 12; } #gloves
			if ($itemid == 24964) { return 18; } #legs
			if ($itemid == 24966) { return 19; } #boots
		
		}
		if ($classid == 9) { #skyshrine crendeatha fe-dhar rogue chain
			if ($itemid == 24968) { return 2; } #cap
			if ($itemid == 24963) { return 17; } #bp
			if ($itemid == 24965) { return 7; } #sleeves
			if ($itemid == 24967) { return 9; } #wrist
			if ($itemid == 24969) { return 12; } #gloves
			if ($itemid == 24964) { return 18; } #legs
			if ($itemid == 24966) { return 19; } #boots
		
		}
		if ($classid == 12) { #skyshrine elaend fe-dhar wizard silk
			if ($itemid == 24982) { return 2; } #cap
			if ($itemid == 24977) { return 17; } #bp
			if ($itemid == 24979) { return 7; } #sleeves
			if ($itemid == 24981) { return 9; } #wrist
			if ($itemid == 24983) { return 12; } #gloves
			if ($itemid == 24978) { return 18; } #legs
			if ($itemid == 24980) { return 19; } #boots
		
		}
		if ($classid == 2) { #skyshrine fardonad fe-dhar cleric plate
			if ($itemid == 24961) { return 2; } #cap
			if ($itemid == 24956) { return 17; } #bp
			if ($itemid == 24958) { return 7; } #sleeves
			if ($itemid == 24960) { return 9; } #wrist
			if ($itemid == 24962) { return 12; } #gloves
			if ($itemid == 24957) { return 18; } #legs
			if ($itemid == 24959) { return 19; } #boots
		
		}
		if ($classid == 1) { #skyshrine jendavudd fe-dhar warrior plate
			if ($itemid == 24961) { return 2; } #cap
			if ($itemid == 24956) { return 17; } #bp
			if ($itemid == 24958) { return 7; } #sleeves
			if ($itemid == 24960) { return 9; } #wrist
			if ($itemid == 24962) { return 12; } #gloves
			if ($itemid == 24957) { return 18; } #legs
			if ($itemid == 24959) { return 19; } #boots
		
		}
		if ($classid == 7) { #skyshrine komawin fe-dhar monk leather
			if ($itemid == 24975) { return 2; } #cap
			if ($itemid == 24970) { return 17; } #bp
			if ($itemid == 24972) { return 7; } #sleeves
			if ($itemid == 24974) { return 9; } #wrist
			if ($itemid == 24976) { return 12; } #gloves
			if ($itemid == 24971) { return 18; } #legs
			if ($itemid == 24973) { return 19; } #boots
		
		#skyshrine larquin fe-dhar beastlord leather
		
		}
		if ($classid == 14) { #skyshrine lothieder fe-dhar enchanter silk
			if ($itemid == 24982) { return 2; } #cap
			if ($itemid == 24977) { return 17; } #bp
			if ($itemid == 24979) { return 7; } #sleeves
			if ($itemid == 24981) { return 9; } #wrist
			if ($itemid == 24983) { return 12; } #gloves
			if ($itemid == 24978) { return 18; } #legs
			if ($itemid == 24980) { return 19; } #boots
		
		}
		if ($classid == 4) { #skyshrine nalelin fe-dhar ranger chain
			if ($itemid == 24968) { return 2; } #cap
			if ($itemid == 24963) { return 17; } #bp
			if ($itemid == 24965) { return 7; } #sleeves
			if ($itemid == 24967) { return 9; } #wrist
			if ($itemid == 24969) { return 12; } #gloves
			if ($itemid == 24964) { return 18; } #legs
			if ($itemid == 24966) { return 19; } #boots
		
		}
		if ($classid == 13) { #skyshrine ocoenydd fe-dhar magician silk
			if ($itemid == 24982) { return 2; } #cap
			if ($itemid == 24977) { return 17; } #bp
			if ($itemid == 24979) { return 7; } #sleeves
			if ($itemid == 24981) { return 9; } #wrist
			if ($itemid == 24983) { return 12; } #gloves
			if ($itemid == 24978) { return 18; } #legs
			if ($itemid == 24980) { return 19; } #boots
		
		}
		if ($classid == 5) { #skyshrine onerind fe-dhar shadowknight plate
			if ($itemid == 24961) { return 2; } #cap
			if ($itemid == 24956) { return 17; } #bp
			if ($itemid == 24958) { return 7; } #sleeves
			if ($itemid == 24960) { return 9; } #wrist
			if ($itemid == 24962) { return 12; } #gloves
			if ($itemid == 24957) { return 18; } #legs
			if ($itemid == 24959) { return 19; } #boots
		
		}
		if ($classid == 6) { #skyshrine qynydd fe-dhar druid leather
			if ($itemid == 24975) { return 2; } #cap
			if ($itemid == 24970) { return 17; } #bp
			if ($itemid == 24972) { return 7; } #sleeves
			if ($itemid == 24974) { return 9; } #wrist
			if ($itemid == 24976) { return 12; } #gloves
			if ($itemid == 24971) { return 18; } #legs
			if ($itemid == 24973) { return 19; } #boots		
		}

		#skyshrine roagar fe-dhar berserker chain
		if ($classid == 8) { #skyshrine umykith fe-dhar bard plate
			if ($itemid == 24961) { return 2; } #cap
			if ($itemid == 24956) { return 17; } #bp
			if ($itemid == 24958) { return 7; } #sleeves
			if ($itemid == 24960) { return 9; } #wrist
			if ($itemid == 24962) { return 12; } #gloves
			if ($itemid == 24957) { return 18; } #legs
			if ($itemid == 24959) { return 19; } #boots
		}
		return 0;
	}
	###THURGADIN###
	if ($zoneid == 115) {
		if ($classid == 4) { #thurgadin argash ranger chain
			if ($itemid == 24940) { return 2; } #cap
			if ($itemid == 24935) { return 17; } #bp
			if ($itemid == 24937) { return 7; } #sleeves
			if ($itemid == 24939) { return 9; } #wrist
			if ($itemid == 24941) { return 12; } #gloves
			if ($itemid == 24936) { return 18; } #legs
			if ($itemid == 24938) { return 19; } #boots
		
		}
		if ($classid == 3) { #thurgadin battlepriest daragor paladin plate
			if ($itemid == 24933) { return 2; } #cap
			if ($itemid == 24928) { return 17; } #bp
			if ($itemid == 24930) { return 7; } #sleeves
			if ($itemid == 24932) { return 9; } #wrist
			if ($itemid == 24934) { return 12; } #gloves
			if ($itemid == 24929) { return 18; } #legs
			if ($itemid == 24931) { return 19; } #boots
		
		}
		if ($classid == 1) { #thurgadin captain njall warrior plate
			if ($itemid == 24933) { return 2; } #cap
			if ($itemid == 24928) { return 17; } #bp
			if ($itemid == 24930) { return 7; } #sleeves
			if ($itemid == 24932) { return 9; } #wrist
			if ($itemid == 24934) { return 12; } #gloves
			if ($itemid == 24929) { return 18; } #legs
			if ($itemid == 24931) { return 19; } #boots
		
		}
		if ($classid == 6) { #thurgadin cobi frostbeard druid leather
			if ($itemid == 24942) { return 2; } #cap
			if ($itemid == 24944) { return 17; } #bp
			if ($itemid == 24943) { return 7; } #sleeves
			if ($itemid == 24948) { return 9; } #wrist
			if ($itemid == 24947) { return 12; } #gloves
			if ($itemid == 24946) { return 18; } #legs
			if ($itemid == 24945) { return 19; } #boots
		
		}
		if ($classid == 5) { #thurgadin dalgrim underbelly shadowknight plate
			if ($itemid == 24933) { return 2; } #cap
			if ($itemid == 24928) { return 17; } #bp
			if ($itemid == 24930) { return 7; } #sleeves
			if ($itemid == 24932) { return 9; } #wrist
			if ($itemid == 24934) { return 12; } #gloves
			if ($itemid == 24929) { return 18; } #legs
			if ($itemid == 24931) { return 19; } #boots
		
		}
		if ($classid == 9) { #thurgadin foreman felspar rogue chain
			if ($itemid == 24940) { return 2; } #cap
			if ($itemid == 24935) { return 17; } #bp
			if ($itemid == 24937) { return 7; } #sleeves
			if ($itemid == 24939) { return 9; } #wrist
			if ($itemid == 24941) { return 12; } #gloves
			if ($itemid == 24936) { return 18; } #legs
			if ($itemid == 24938) { return 19; } #boots
		
		#thurgadin glatigi berserker chain
		}
		if ($classid == 13) { #thurgadin kyla frostbeard magician silk
			if ($itemid == 24954) { return 2; } #cap
			if ($itemid == 24949) { return 17; } #bp
			if ($itemid == 24951) { return 7; } #sleeves
			if ($itemid == 24953) { return 9; } #wrist
			if ($itemid == 24955) { return 12; } #gloves
			if ($itemid == 24950) { return 18; } #legs
			if ($itemid == 24952) { return 19; } #boots
		
		}
		if ($classid == 8) { #thurgadin leifur bard plate
			if ($itemid == 24933) { return 2; } #cap
			if ($itemid == 24928) { return 17; } #bp
			if ($itemid == 24930) { return 7; } #sleeves
			if ($itemid == 24932) { return 9; } #wrist
			if ($itemid == 24934) { return 12; } #gloves
			if ($itemid == 24929) { return 18; } #legs
			if ($itemid == 24931) { return 19; } #boots
		
		}
		if ($classid == 14) { #thurgadin lorekeeper brita enchanter silk
			if ($itemid == 24954) { return 2; } #cap
			if ($itemid == 24949) { return 17; } #bp
			if ($itemid == 24951) { return 7; } #sleeves
			if ($itemid == 24953) { return 9; } #wrist
			if ($itemid == 24955) { return 12; } #gloves
			if ($itemid == 24950) { return 18; } #legs
			if ($itemid == 24952) { return 19; } #boots
		
		}
		if ($classid == 7) { #thurgadin lorekeeper einar monk leather
			if ($itemid == 24942) { return 2; } #cap
			if ($itemid == 24944) { return 17; } #bp
			if ($itemid == 24943) { return 7; } #sleeves
			if ($itemid == 24948) { return 9; } #wrist
			if ($itemid == 24947) { return 12; } #gloves
			if ($itemid == 24946) { return 18; } #legs
			if ($itemid == 24945) { return 19; } #boots
		
		}
		if ($classid == 11) { #thurgadin lorekeeper zorik necromancer silk
			if ($itemid == 24954) { return 2; } #cap
			if ($itemid == 24949) { return 17; } #bp
			if ($itemid == 24951) { return 7; } #sleeves
			if ($itemid == 24953) { return 9; } #wrist
			if ($itemid == 24955) { return 12; } #gloves
			if ($itemid == 24950) { return 18; } #legs
			if ($itemid == 24952) { return 19; } #boots

		}
		if ($classid == 12) { #thurgadin mauren frostbeard wizard silk
			if ($itemid == 24954) { return 2; } #cap
			if ($itemid == 24949) { return 17; } #bp
			if ($itemid == 24951) { return 7; } #sleeves
			if ($itemid == 24953) { return 9; } #wrist
			if ($itemid == 24955) { return 12; } #gloves
			if ($itemid == 24950) { return 18; } #legs
			if ($itemid == 24952) { return 19; } #boots
		
		}
		if ($classid == 2) { #thurgadin loremaster dorinan cleric plate
			if ($itemid == 24933) { return 2; } #cap
			if ($itemid == 24928) { return 17; } #bp
			if ($itemid == 24930) { return 7; } #sleeves
			if ($itemid == 24932) { return 9; } #wrist
			if ($itemid == 24934) { return 12; } #gloves
			if ($itemid == 24929) { return 18; } #legs
			if ($itemid == 24931) { return 19; } #boots
		
		#thurgadin pearce icefang beastlord leather

		}
		if ($classid == 10) { #thurgadin terman underbelly shaman chain
			if ($itemid == 24940) { return 2; } #cap
			if ($itemid == 24935) { return 17; } #bp
			if ($itemid == 24937) { return 7; } #sleeves
			if ($itemid == 24939) { return 9; } #wrist
			if ($itemid == 24941) { return 12; } #gloves
			if ($itemid == 24936) { return 18; } #legs
			if ($itemid == 24938) { return 19; } #boots
		}
		return 0;
	}
	return 0;
}

# Gets the minimum value item id of gem to turn in for said armor
sub velious_gem_by_armor {
	$itemid = shift;
	$zoneid = shift;
	$classid = shift;
	if ($zoneid == 114) { #skyshrine
		if ($classid == 3 || $classid == 8 || $classid == 1 || $classid == 5 || $classid == 2) { # SS Plate
			if ($itemid == 24961 || $itemid == 24956 || $itemid == 24958 || $itemid == 24960 || $itemid == 24962 || $itemid == 24957 || $itemid == 24959) {
				return 101401; #mingem
			}
			return 0;
		}
		if ($classid == 4 || $classid == 9 || $classid == 10) { # SS Chain		
			if ($itemid == 24968 || $itemid == 24963 || $itemid == 24965 || $itemid == 24967 || $itemid == 24969 || $itemid == 24964 || $itemid == 24966) {
				return 101411; #mingem
			}
			return 0;
		}
		if ($classid == 6 || $classid == 7 || $classid == 10) { # SS Leather
	 		if ($itemid == 24975 || $itemid == 24970 || $itemid == 24972 || $itemid == 24974 || $itemid == 24976 || $itemid == 24971 || $itemid == 24973) {
	 			return 101421; #mingem
	 		}
	 		return 0;
		}
		#silk
		if ($itemid == 24982 || $itemid == 24977 || $itemid == 24979 || $itemid == 24981 ||  $itemid == 24983 ||  $itemid == 24978 ||  $itemid == 24980) {
			return 101431; #mingem
		}
		return 0;
	}
	return 0;
}

sub velious_reward_by_item {
	$itemid = shift;
	$zoneid = shift;
	$classid = shift;
	#quest::say("by_item: $itemid, $zoneid, $classid");

	###KAEL###
	if ($zoneid == 113) { #kael
		if ($classid == 3) { #paladin
			if ($itemid == 24905) { return 25370; } #cap
			if ($itemid == 24900) { return 25371; } #bp
			if ($itemid == 24902) { return 25372; } #sleeves
			if ($itemid == 24904) { return 25373; } #wrist
			if ($itemid == 24906) { return 25374; } #gloves
			if ($itemid == 24901) { return 25375; } #legs
			if ($itemid == 24903) { return 25376; } #boots
			return 0;
		}
		if ($classid == 8) { #bard
			if ($itemid == 24905) { return 25384; } #cap		
			if ($itemid == 24900) { return 25385; } #bp
			if ($itemid == 24902) { return 25386; } #sleeves
			if ($itemid == 24904) { return 25387; } #wrist
			if ($itemid == 24906) { return 25388; } #gloves
			if ($itemid == 24901) { return 25389; } #legs
			if ($itemid == 24903) { return 25390; } #boots
			return 0;
		}
		if ($classid == 7) { #monk
			if ($itemid == 24919) { return 25440; } #cap		
			if ($itemid == 24914) { return 25441; } #bp
			if ($itemid == 24916) { return 25442; } #sleeves
			if ($itemid == 24918) { return 25443; } #wrist
			if ($itemid == 24920) { return 25444; } #gloves
			if ($itemid == 24915) { return 25445; } #legs
			if ($itemid == 24917) { return 25446; } #boots
			return 0;
		}
		if ($classid == 4) { #ranger
			if ($itemid == 24912) { return 25363; } #cap
			if ($itemid == 24907) { return 25364; } #bp
			if ($itemid == 24909) { return 253635; } #sleeves
			if ($itemid == 24911) { return 25366; } #wrist
			if ($itemid == 24913) { return 25367; } #gloves
			if ($itemid == 24908) { return 25368; } #legs
			if ($itemid == 24910) { return 25369; } #boots
			return 0;
		}
		if ($classid == 6) { #druid
			if ($itemid == 24919) { return 25398; } #cap		
			if ($itemid == 24914) { return 25399; } #bp
			if ($itemid == 24916) { return 25400; } #sleeves
			if ($itemid == 24918) { return 25401; } #wrist
			if ($itemid == 24920) { return 25402; } #gloves
			if ($itemid == 24915) { return 25403; } #legs
			if ($itemid == 24917) { return 25404; } #boots
		}
		if ($classid == 9) { #rogue
			if ($itemid == 24912) { return 25377; } #cap
			if ($itemid == 24907) { return 25378; } #bp
			if ($itemid == 24909) { return 25379; } #sleeves
			if ($itemid == 24911) { return 25380; } #wrist
			if ($itemid == 24913) { return 25381; } #gloves
			if ($itemid == 24908) { return 25382; } #legs
			if ($itemid == 24910) { return 25383; } #boots			
		}
		if ($classid == 1) { #warrior
			if ($itemid == 24905) { return 25433; } #cap		
			if ($itemid == 24900) { return 25434; } #bp
			if ($itemid == 24902) { return 25435; } #sleeves
			if ($itemid == 24904) { return 25436; } #wrist
			if ($itemid == 24906) { return 25437; } #gloves
			if ($itemid == 24901) { return 25438; } #legs
			if ($itemid == 24903) { return 25439; } #boots		
		}
		if ($classid == 14) { #enchanter
			if ($itemid == 24926) { return 25426; } #cap		
			if ($itemid == 24921) { return 25427; } #bp
			if ($itemid == 24923) { return 25428; } #sleeves
			if ($itemid == 24925) { return 25429; } #wrist
			if ($itemid == 24927) { return 25430; } #gloves
			if ($itemid == 24922) { return 25431; } #legs
			if ($itemid == 24924) { return 25432; } #boots
		}
		if ($classid == 13) { #kael mjeldor felstorm magician silk
			if ($itemid == 24926) { return 25419; } #cap		
			if ($itemid == 24921) { return 25420; } #bp
			if ($itemid == 24923) { return 25421; } #sleeves
			if ($itemid == 24925) { return 25422; } #wrist
			if ($itemid == 24927) { return 25423; } #gloves
			if ($itemid == 24922) { return 25424; } #legs
			if ($itemid == 24924) { return 25425; } #boots
		}

		if ($classid == 11) { #kael bjarorm mjlorn necro silk
			if ($itemid == 24926) { return 25412; } #cap		
			if ($itemid == 24921) { return 25413; } #bp
			if ($itemid == 24923) { return 25414; } #sleeves
			if ($itemid == 24925) { return 25415; } #wrist
			if ($itemid == 24927) { return 25416; } #gloves
			if ($itemid == 24922) { return 25417; } #legs
			if ($itemid == 24924) { return 25418; } #boots
		}
		#kael nerik wolfsoul beastlord leather
		#kael regbor vallgerthon berserker chain
		if ($classid == 12) { #kael ulkar jollkarek wizard silk
			if ($itemid == 24926) { return 25405; } #cap		
			if ($itemid == 24921) { return 25406; } #bp
			if ($itemid == 24923) { return 25407; } #sleeves
			if ($itemid == 24925) { return 25408; } #wrist
			if ($itemid == 24927) { return 25409; } #gloves
			if ($itemid == 24922) { return 25410; } #legs
			if ($itemid == 24924) { return 25411; } #boots
		}
		if ($classid == 5) { #kael veldern blackhammer shadowknight plate
			if ($itemid == 24905) { return 25349; } #cap		
			if ($itemid == 24900) { return 25350; } #bp
			if ($itemid == 24902) { return 25351; } #sleeves
			if ($itemid == 24904) { return 25352; } #wrist
			if ($itemid == 24906) { return 25353; } #gloves
			if ($itemid == 24901) { return 25354; } #legs
			if ($itemid == 24903) { return 25355; } #boots
		}
		if ($classid == 2) { #kael vylleam vyaeltor cleric plate
			if ($itemid == 24905) { return 25391; } #cap		
			if ($itemid == 24900) { return 25392; } #bp
			if ($itemid == 24902) { return 25393; } #sleeves
			if ($itemid == 24904) { return 25394; } #wrist
			if ($itemid == 24906) { return 25395; } #gloves
			if ($itemid == 24901) { return 25396; } #legs
			if ($itemid == 24903) { return 25397; } #boots
		}
		if ($classid == 10) { #kael yeeldan spiritcaller shaman chain
			if ($itemid == 24912) { return 25356; } #cap
			if ($itemid == 24907) { return 25357; } #bp
			if ($itemid == 24909) { return 25358; } #sleeves
			if ($itemid == 24911) { return 25359; } #wrist
			if ($itemid == 24913) { return 25360; } #gloves
			if ($itemid == 24908) { return 25361; } #legs
			if ($itemid == 24910) { return 25362; } #boots
		
		}
		return 0;
	}

	###SKYSHRINE###
	if ($zoneid == 114) {
		if ($classid == 11) { #skyshrine abudan fe-dhar necro silk
			if ($itemid == 24982) { return 31161; } #cap
			if ($itemid == 24977) { return 31162; } #bp
			if ($itemid == 24979) { return 31163; } #sleeves
			if ($itemid == 24981) { return 31164; } #wrist
			if ($itemid == 24983) { return 31165; } #gloves
			if ($itemid == 24978) { return 31166; } #legs
			if ($itemid == 24980) { return 31167; } #boots
		
		}
		if ($classid == 3) { #skyshrine adwetram fe-dhar paladin plate
			if ($itemid == 24961) { return 31119; } #cap
			if ($itemid == 24956) { return 31120; } #bp
			if ($itemid == 24958) { return 31121; } #sleeves
			if ($itemid == 24960) { return 31122; } #wrist
			if ($itemid == 24962) { return 31123; } #gloves
			if ($itemid == 24957) { return 31124; } #legs
			if ($itemid == 24959) { return 31125; } #boots
		
		}
		if ($classid == 10) { #skyshrine asteinnon fe-dhar shaman chain
			if ($itemid == 24968) { return 31105; } #cap
			if ($itemid == 24963) { return 31106; } #bp
			if ($itemid == 24965) { return 31107; } #sleeves
			if ($itemid == 24967) { return 31108; } #wrist
			if ($itemid == 24969) { return 31109; } #gloves
			if ($itemid == 24964) { return 31110; } #legs
			if ($itemid == 24966) { return 31111; } #boots
		
		}
		if ($classid == 9) { #skyshrine crendeatha fe-dhar rogue chain
			if ($itemid == 24968) { return 31126; } #cap
			if ($itemid == 24963) { return 31127; } #bp
			if ($itemid == 24965) { return 31128; } #sleeves
			if ($itemid == 24967) { return 31129; } #wrist
			if ($itemid == 24969) { return 31130; } #gloves
			if ($itemid == 24964) { return 31131; } #legs
			if ($itemid == 24966) { return 31132; } #boots
		
		}
		if ($classid == 12) { #skyshrine elaend fe-dhar wizard silk
			if ($itemid == 24982) { return 31154; } #cap
			if ($itemid == 24977) { return 31155; } #bp
			if ($itemid == 24979) { return 31156; } #sleeves
			if ($itemid == 24981) { return 31157; } #wrist
			if ($itemid == 24983) { return 31158; } #gloves
			if ($itemid == 24978) { return 31159; } #legs
			if ($itemid == 24980) { return 31160; } #boots
		
		}
		if ($classid == 2) { #skyshrine fardonad fe-dhar cleric plate
			if ($itemid == 24961) { return 31140; } #cap
			if ($itemid == 24956) { return 31141; } #bp
			if ($itemid == 24958) { return 31142; } #sleeves
			if ($itemid == 24960) { return 31143; } #wrist
			if ($itemid == 24962) { return 31144; } #gloves
			if ($itemid == 24957) { return 31145; } #legs
			if ($itemid == 24959) { return 31146; } #boots
		
		}
		if ($classid == 1) { #skyshrine jendavudd fe-dhar warrior plate
			if ($itemid == 24961) { return 31182; } #cap
			if ($itemid == 24956) { return 31183; } #bp
			if ($itemid == 24958) { return 31184; } #sleeves
			if ($itemid == 24960) { return 31185; } #wrist
			if ($itemid == 24962) { return 31186; } #gloves
			if ($itemid == 24957) { return 31187; } #legs
			if ($itemid == 24959) { return 31188; } #boots
		
		}
		if ($classid == 7) { #skyshrine komawin fe-dhar monk leather
			if ($itemid == 24975) { return 31189; } #cap
			if ($itemid == 24970) { return 31190; } #bp
			if ($itemid == 24972) { return 31191; } #sleeves
			if ($itemid == 24974) { return 31192; } #wrist
			if ($itemid == 24976) { return 31193; } #gloves
			if ($itemid == 24971) { return 31194; } #legs
			if ($itemid == 24973) { return 31195; } #boots
		
		#skyshrine larquin fe-dhar beastlord leather
		
		}
		if ($classid == 14) { #skyshrine lothieder fe-dhar enchanter silk
			if ($itemid == 24982) { return 31175; } #cap
			if ($itemid == 24977) { return 31176; } #bp
			if ($itemid == 24979) { return 31177; } #sleeves
			if ($itemid == 24981) { return 31178; } #wrist
			if ($itemid == 24983) { return 31179; } #gloves
			if ($itemid == 24978) { return 31180; } #legs
			if ($itemid == 24980) { return 31181; } #boots
		
		}
		if ($classid == 4) { #skyshrine nalelin fe-dhar ranger chain
			if ($itemid == 24968) { return 31112; } #cap
			if ($itemid == 24963) { return 31113; } #bp
			if ($itemid == 24965) { return 31114; } #sleeves
			if ($itemid == 24967) { return 31115; } #wrist
			if ($itemid == 24969) { return 31116; } #gloves
			if ($itemid == 24964) { return 31117; } #legs
			if ($itemid == 24966) { return 31118; } #boots
		
		}
		if ($classid == 13) { #skyshrine ocoenydd fe-dhar magician silk
			if ($itemid == 24982) { return 31168; } #cap
			if ($itemid == 24977) { return 31169; } #bp
			if ($itemid == 24979) { return 31170; } #sleeves
			if ($itemid == 24981) { return 31171; } #wrist
			if ($itemid == 24983) { return 31172; } #gloves
			if ($itemid == 24978) { return 31173; } #legs
			if ($itemid == 24980) { return 31174; } #boots
		
		}
		if ($classid == 5) { #skyshrine onerind fe-dhar shadowknight plate
			if ($itemid == 24961) { return 31098; } #cap
			if ($itemid == 24956) { return 31099; } #bp
			if ($itemid == 24958) { return 31100; } #sleeves
			if ($itemid == 24960) { return 31101; } #wrist
			if ($itemid == 24962) { return 31102; } #gloves
			if ($itemid == 24957) { return 31103; } #legs
			if ($itemid == 24959) { return 31104; } #boots
		
		}
		if ($classid == 6) { #skyshrine qynydd fe-dhar druid leather
			if ($itemid == 24975) { return 31147; } #cap
			if ($itemid == 24970) { return 31148; } #bp
			if ($itemid == 24972) { return 31149; } #sleeves
			if ($itemid == 24974) { return 31150; } #wrist
			if ($itemid == 24976) { return 31151; } #gloves
			if ($itemid == 24971) { return 31152; } #legs
			if ($itemid == 24973) { return 31153; } #boots		
		}

		#skyshrine roagar fe-dhar berserker chain
		if ($classid == 8) { #skyshrine umykith fe-dhar bard plate
			if ($itemid == 24961) { return 31133; } #cap
			if ($itemid == 24956) { return 31134; } #bp
			if ($itemid == 24958) { return 31135; } #sleeves
			if ($itemid == 24960) { return 31136; } #wrist
			if ($itemid == 24962) { return 31137; } #gloves
			if ($itemid == 24957) { return 31138; } #legs
			if ($itemid == 24959) { return 31139; } #boots
		}
		return 0;
	}
	###THURGADIN###
	if ($zoneid == 115) {
		if ($classid == 4) { #thurgadin argash ranger chain
			if ($itemid == 24940) { return 31014; } #cap
			if ($itemid == 24935) { return 31015; } #bp
			if ($itemid == 24937) { return 31016; } #sleeves
			if ($itemid == 24939) { return 31017; } #wrist
			if ($itemid == 24941) { return 31018; } #gloves
			if ($itemid == 24936) { return 31019; } #legs
			if ($itemid == 24938) { return 31020; } #boots
		
		}
		if ($classid == 3) { #thurgadin battlepriest daragor paladin plate
			if ($itemid == 24933) { return 31021; } #cap
			if ($itemid == 24928) { return 31022; } #bp
			if ($itemid == 24930) { return 31023; } #sleeves
			if ($itemid == 24932) { return 31024; } #wrist
			if ($itemid == 24934) { return 31025; } #gloves
			if ($itemid == 24929) { return 31026; } #legs
			if ($itemid == 24931) { return 31027; } #boots
		
		}
		if ($classid == 1) { #thurgadin captain njall warrior plate
			if ($itemid == 24933) { return 31085; } #cap
			if ($itemid == 24928) { return 31086; } #bp
			if ($itemid == 24930) { return 31087; } #sleeves
			if ($itemid == 24932) { return 31088; } #wrist
			if ($itemid == 24934) { return 31089; } #gloves
			if ($itemid == 24929) { return 31090; } #legs
			if ($itemid == 24931) { return 31091; } #boots
		
		}
		if ($classid == 6) { #thurgadin cobi frostbeard druid leather
			if ($itemid == 24942) { return 31050; } #cap
			if ($itemid == 24944) { return 31051; } #bp
			if ($itemid == 24943) { return 31052; } #sleeves
			if ($itemid == 24948) { return 31053; } #wrist
			if ($itemid == 24947) { return 31054; } #gloves
			if ($itemid == 24946) { return 31055; } #legs
			if ($itemid == 24945) { return 31056; } #boots
		
		}
		if ($classid == 5) { #thurgadin dalgrim underbelly shadowknight plate
			if ($itemid == 24933) { return 31000; } #cap
			if ($itemid == 24928) { return 31001; } #bp
			if ($itemid == 24930) { return 31002; } #sleeves
			if ($itemid == 24932) { return 31003; } #wrist
			if ($itemid == 24934) { return 31004; } #gloves
			if ($itemid == 24929) { return 31005; } #legs
			if ($itemid == 24931) { return 31006; } #boots
		
		}
		if ($classid == 9) { #thurgadin foreman felspar rogue chain
			if ($itemid == 24940) { return 31028; } #cap
			if ($itemid == 24935) { return 31029; } #bp
			if ($itemid == 24937) { return 31030; } #sleeves
			if ($itemid == 24939) { return 31031; } #wrist
			if ($itemid == 24941) { return 31032; } #gloves
			if ($itemid == 24936) { return 31033; } #legs
			if ($itemid == 24938) { return 31034; } #boots
		
		#thurgadin glatigi berserker chain
		}
		if ($classid == 13) { #thurgadin kyla frostbeard magician silk
			if ($itemid == 24954) { return 31070; } #cap
			if ($itemid == 24949) { return 31071; } #bp
			if ($itemid == 24951) { return 31072; } #sleeves
			if ($itemid == 24953) { return 31073; } #wrist
			if ($itemid == 24955) { return 31074; } #gloves
			if ($itemid == 24950) { return 31075; } #legs
			if ($itemid == 24952) { return 31076; } #boots
		
		}
		if ($classid == 8) { #thurgadin leifur bard plate
			if ($itemid == 24933) { return 31035; } #cap
			if ($itemid == 24928) { return 31036; } #bp
			if ($itemid == 24930) { return 31037; } #sleeves
			if ($itemid == 24932) { return 31038; } #wrist
			if ($itemid == 24934) { return 31039; } #gloves
			if ($itemid == 24929) { return 31040; } #legs
			if ($itemid == 24931) { return 31041; } #boots
		
		}
		if ($classid == 14) { #thurgadin lorekeeper brita enchanter silk
			if ($itemid == 24954) { return 31077; } #cap
			if ($itemid == 24949) { return 31078; } #bp
			if ($itemid == 24951) { return 31079; } #sleeves
			if ($itemid == 24953) { return 31080; } #wrist
			if ($itemid == 24955) { return 31081; } #gloves
			if ($itemid == 24950) { return 31082; } #legs
			if ($itemid == 24952) { return 31083; } #boots
		
		}
		if ($classid == 7) { #thurgadin lorekeeper einar monk leather
			if ($itemid == 24942) { return 31092; } #cap
			if ($itemid == 24944) { return 31093; } #bp
			if ($itemid == 24943) { return 31094; } #sleeves
			if ($itemid == 24948) { return 31095; } #wrist
			if ($itemid == 24947) { return 31096; } #gloves
			if ($itemid == 24946) { return 31097; } #legs
			if ($itemid == 24945) { return 31098; } #boots
		
		}
		if ($classid == 11) { #thurgadin lorekeeper zorik necromancer silk
			if ($itemid == 24954) { return 31063; } #cap
			if ($itemid == 24949) { return 31064; } #bp
			if ($itemid == 24951) { return 31065; } #sleeves
			if ($itemid == 24953) { return 31066; } #wrist
			if ($itemid == 24955) { return 31067; } #gloves
			if ($itemid == 24950) { return 31068; } #legs
			if ($itemid == 24952) { return 31069; } #boots

		}
		if ($classid == 12) { #thurgadin mauren frostbeard wizard silk
			if ($itemid == 24954) { return 31056; } #cap
			if ($itemid == 24949) { return 31057; } #bp
			if ($itemid == 24951) { return 31058; } #sleeves
			if ($itemid == 24953) { return 31059; } #wrist
			if ($itemid == 24955) { return 31060; } #gloves
			if ($itemid == 24950) { return 31061; } #legs
			if ($itemid == 24952) { return 31062; } #boots
		
		}
		if ($classid == 2) { #thurgadin loremaster dorinan cleric plate
			if ($itemid == 24933) { return 31042; } #cap
			if ($itemid == 24928) { return 31043; } #bp
			if ($itemid == 24930) { return 31044; } #sleeves
			if ($itemid == 24932) { return 31045; } #wrist
			if ($itemid == 24934) { return 31046; } #gloves
			if ($itemid == 24929) { return 31047; } #legs
			if ($itemid == 24931) { return 31048; } #boots
		
		#thurgadin pearce icefang beastlord leather

		}
		if ($classid == 10) { #thurgadin terman underbelly shaman chain
			if ($itemid == 24940) { return 31007; } #cap
			if ($itemid == 24935) { return 31008; } #bp
			if ($itemid == 24937) { return 31009; } #sleeves
			if ($itemid == 24939) { return 31010; } #wrist
			if ($itemid == 24941) { return 31011; } #gloves
			if ($itemid == 24936) { return 31012; } #legs
			if ($itemid == 24938) { return 31013; } #boots
		}
		return 0;
	}
	return 0;
}

