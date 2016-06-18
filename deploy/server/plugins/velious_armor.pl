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
	if($text=~/armor/i || $text=~/hail/i) {
        quest::say("Are you interested in armor that Velious has to offer? [ ".quest::saylink("head")."], [".quest::saylink("arms")."], [".quest::saylink("wrists")."], [".quest::saylink("hands")."], [".quest::saylink("chest")."], [".quest::saylink("legs")."], [".quest::saylink("feet")."]");
    } elsif($text=~/head/i || $text=~/arms/i || $text=~/wrists/i || $text=~/hands/i || $text=~/chest/i || $text=~/legs/i || $text=~/feet/i) {
       plugin::velious_armor_requirement($text, $zoneid, $classid);
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
			elsif ($slot=~/chest/i) { $armor_type = " Corroded"; $slotname = "Breastplate"; $slotid = 17; } 
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
			elsif ($slot=~/chest/i) { $armor_type = " Corroded"; $slotname = "Breastplate"; $slotid = 17;  }
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
			elsif ($slot=~/chest/i) { $armor_type = " Corroded"; $slotname = "Breastplate"; $slotid = 17;  }
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

sub velious_armor_list {
	my @armor_list;
	###KAEL###
 
	$tmp_zone = 113;
	$tmp_class = 3;
	#kael barlek stonefist paladin plate
	$armor_list[$tmp_zone][$tmp_class][0] = {slot => 2, item => 24905, reward => 25370}; #cap		
	$armor_list[$tmp_zone][$tmp_class][1] = {slot => 17, item => 24900, reward => 25371}; #bp
	$armor_list[$tmp_zone][$tmp_class][2] = {slot => 7, item => 24902, reward => 25372}; #sleeves
	$armor_list[$tmp_zone][$tmp_class][3] = {slot => 9, item => 24904, reward => 25373}; #wrist
	$armor_list[$tmp_zone][$tmp_class][4] = {slot => 12, item => 24906, reward => 25374}; #gloves
	$armor_list[$tmp_zone][$tmp_class][5] = {slot => 18, item => 24901, reward => 25375}; #legs
	$armor_list[$tmp_zone][$tmp_class][6] = {slot => 19, item => 24903, reward => 25376}; #boots

	$tmp_class = 8;
	#kael bygloirn omorden bard plate
	$armor_list[$tmp_zone][$tmp_class][0] = {slot => 2, item => 24905, reward => 25384}; #cap		
	$armor_list[$tmp_zone][$tmp_class][1] = {slot => 17, item => 24900, reward => 25385}; #bp
	$armor_list[$tmp_zone][$tmp_class][2] = {slot => 7, item => 24902, reward => 25386}; #sleeves
	$armor_list[$tmp_zone][$tmp_class][3] = {slot => 9, item => 24904, reward => 25387}; #wrist
	$armor_list[$tmp_zone][$tmp_class][4] = {slot => 12, item => 24906, reward => 25388}; #gloves
	$armor_list[$tmp_zone][$tmp_class][5] = {slot => 18, item => 24901, reward => 25389}; #legs
	$armor_list[$tmp_zone][$tmp_class][6] = {slot => 19, item => 24903, reward => 25390}; #boots
	
	$tmp_class = 7;
	#kael dagron stonecutter monk leather
	$armor_list[$tmp_zone][$tmp_class][0] = {slot => 2, item => 24919, reward => 25440}; #cap		
	$armor_list[$tmp_zone][$tmp_class][1] = {slot => 17, item => 24914, reward => 25441}; #bp
	$armor_list[$tmp_zone][$tmp_class][2] = {slot => 7, item => 24916, reward => 25442}; #sleeves
	$armor_list[$tmp_zone][$tmp_class][3] = {slot => 9, item => 24918, reward => 25443}; #wrist
	$armor_list[$tmp_zone][$tmp_class][4] = {slot => 12, item => 24920, reward => 25444}; #gloves
	$armor_list[$tmp_zone][$tmp_class][5] = {slot => 18, item => 24915, reward => 25445}; #legs
	$armor_list[$tmp_zone][$tmp_class][6] = {slot => 19, item => 24917, reward => 25446}; #boots
	
	$tmp_class = 4;
	#kael gragek mjlorkigar ranger chain
	$armor_list[$tmp_zone][$tmp_class][0] = {slot => 2, item => 24912, reward => 25363}; #cap
	$armor_list[$tmp_zone][$tmp_class][1] = {slot => 17, item => 24907, reward => 25364}; #bp
	$armor_list[$tmp_zone][$tmp_class][2] = {slot => 7, item => 24909, reward => 253635}; #sleeves
	$armor_list[$tmp_zone][$tmp_class][3] = {slot => 9, item => 24911, reward => 25366}; #wrist
	$armor_list[$tmp_zone][$tmp_class][4] = {slot => 12, item => 24913, reward => 25367}; #gloves
	$armor_list[$tmp_zone][$tmp_class][5] = {slot => 18, item => 24908, reward => 25368}; #legs
	$armor_list[$tmp_zone][$tmp_class][6] = {slot => 19, item => 24910, reward => 25369}; #boots
	
	$tmp_class = 6;
	#kael jaglorm ygorr druid leather
	$armor_list[$tmp_zone][$tmp_class][0] = {slot => 2, item => 24919, reward => 25398}; #cap		
	$armor_list[$tmp_zone][$tmp_class][1] = {slot => 17, item => 24914, reward => 25399}; #bp
	$armor_list[$tmp_zone][$tmp_class][2] = {slot => 7, item => 24916, reward => 25400}; #sleeves
	$armor_list[$tmp_zone][$tmp_class][3] = {slot => 9, item => 24918, reward => 25401}; #wrist
	$armor_list[$tmp_zone][$tmp_class][4] = {slot => 12, item => 24920, reward => 25402}; #gloves
	$armor_list[$tmp_zone][$tmp_class][5] = {slot => 18, item => 24915, reward => 25403}; #legs
	$armor_list[$tmp_zone][$tmp_class][6] = {slot => 19, item => 24917, reward => 25404}; #boots
	
	$tmp_class = 9;
	#kael kelenek bluadfeth rogue chain
	$armor_list[$tmp_zone][$tmp_class][0] = {slot => 2, item => 24912, reward => 25377}; #cap
	$armor_list[$tmp_zone][$tmp_class][1] = {slot => 17, item => 24907, reward => 25378}; #bp
	$armor_list[$tmp_zone][$tmp_class][2] = {slot => 7, item => 24909, reward => 25379}; #sleeves
	$armor_list[$tmp_zone][$tmp_class][3] = {slot => 9, item => 24911, reward => 25380}; #wrist
	$armor_list[$tmp_zone][$tmp_class][4] = {slot => 12, item => 24913, reward => 25381}; #gloves
	$armor_list[$tmp_zone][$tmp_class][5] = {slot => 18, item => 24908, reward => 25382}; #legs
	$armor_list[$tmp_zone][$tmp_class][6] = {slot => 19, item => 24910, reward => 25383}; #boots
	
	$tmp_class = 1;
	#kael kragek thunderforge warrior plate
	$armor_list[$tmp_zone][$tmp_class][0] = {slot => 2, item => 24905, reward => 25433}; #cap		
	$armor_list[$tmp_zone][$tmp_class][1] = {slot => 17, item => 24900, reward => 25434}; #bp
	$armor_list[$tmp_zone][$tmp_class][2] = {slot => 7, item => 24902, reward => 25435}; #sleeves
	$armor_list[$tmp_zone][$tmp_class][3] = {slot => 9, item => 24904, reward => 25436}; #wrist
	$armor_list[$tmp_zone][$tmp_class][4] = {slot => 12, item => 24906, reward => 25437}; #gloves
	$armor_list[$tmp_zone][$tmp_class][5] = {slot => 18, item => 24901, reward => 25438}; #legs
	$armor_list[$tmp_zone][$tmp_class][6] = {slot => 19, item => 24903, reward => 25439}; #boots
	
	$tmp_class = 13;
	#kael mjeldor felstorm magician silk
	$armor_list[$tmp_zone][$tmp_class][0] = {slot => 2, item => 24926, reward => 25419}; #cap		
	$armor_list[$tmp_zone][$tmp_class][1] = {slot => 17, item => 24921, reward => 25420}; #bp
	$armor_list[$tmp_zone][$tmp_class][2] = {slot => 7, item => 24923, reward => 25421}; #sleeves
	$armor_list[$tmp_zone][$tmp_class][3] = {slot => 9, item => 24925, reward => 25422}; #wrist
	$armor_list[$tmp_zone][$tmp_class][4] = {slot => 12, item => 24927, reward => 25423}; #gloves
	$armor_list[$tmp_zone][$tmp_class][5] = {slot => 18, item => 24922, reward => 25424}; #legs
	$armor_list[$tmp_zone][$tmp_class][6] = {slot => 19, item => 24924, reward => 25425}; #boots

	$tmp_class = 11;
	#kael bjarorm mjlorn necro silk
	$armor_list[$tmp_zone][$tmp_class][0] = {slot => 2, item => 24926, reward => 25412}; #cap		
	$armor_list[$tmp_zone][$tmp_class][1] = {slot => 17, item => 24921, reward => 25413}; #bp
	$armor_list[$tmp_zone][$tmp_class][2] = {slot => 7, item => 24923, reward => 25414}; #sleeves
	$armor_list[$tmp_zone][$tmp_class][3] = {slot => 9, item => 24925, reward => 25415}; #wrist
	$armor_list[$tmp_zone][$tmp_class][4] = {slot => 12, item => 24927, reward => 25416}; #gloves
	$armor_list[$tmp_zone][$tmp_class][5] = {slot => 18, item => 24922, reward => 25417}; #legs
	$armor_list[$tmp_zone][$tmp_class][6] = {slot => 19, item => 24924, reward => 25418}; #boots
	
	#kael nerik wolfsoul beastlord leather
	#kael regbor vallgerthon berserker chain
	$tmp_class = 14;
	#kael stoem lekbar enchanter silk
	$armor_list[$tmp_zone][$tmp_class][0] = {slot => 2, item => 24926, reward => 25426}; #cap		
	$armor_list[$tmp_zone][$tmp_class][1] = {slot => 17, item => 24921, reward => 25427}; #bp
	$armor_list[$tmp_zone][$tmp_class][2] = {slot => 7, item => 24923, reward => 25428}; #sleeves
	$armor_list[$tmp_zone][$tmp_class][3] = {slot => 9, item => 24925, reward => 25429}; #wrist
	$armor_list[$tmp_zone][$tmp_class][4] = {slot => 12, item => 24927, reward => 25430}; #gloves
	$armor_list[$tmp_zone][$tmp_class][5] = {slot => 18, item => 24922, reward => 25431}; #legs
	$armor_list[$tmp_zone][$tmp_class][6] = {slot => 19, item => 24924, reward => 25432}; #boots
	
	$tmp_class = 12;
	#kael ulkar jollkarek wizard silk
	$armor_list[$tmp_zone][$tmp_class][0] = {slot => 2, item => 24926, reward => 25405}; #cap		
	$armor_list[$tmp_zone][$tmp_class][1] = {slot => 17, item => 24921, reward => 25406}; #bp
	$armor_list[$tmp_zone][$tmp_class][2] = {slot => 7, item => 24923, reward => 25407}; #sleeves
	$armor_list[$tmp_zone][$tmp_class][3] = {slot => 9, item => 24925, reward => 25408}; #wrist
	$armor_list[$tmp_zone][$tmp_class][4] = {slot => 12, item => 24927, reward => 25409}; #gloves
	$armor_list[$tmp_zone][$tmp_class][5] = {slot => 18, item => 24922, reward => 25410}; #legs
	$armor_list[$tmp_zone][$tmp_class][6] = {slot => 19, item => 24924, reward => 25411}; #boots
	
	$tmp_class = 5;
	#kael veldern blackhammer shadowknight plate
	$armor_list[$tmp_zone][$tmp_class][0] = {slot => 2, item => 24905, reward => 25349}; #cap		
	$armor_list[$tmp_zone][$tmp_class][1] = {slot => 17, item => 24900, reward => 25350}; #bp
	$armor_list[$tmp_zone][$tmp_class][2] = {slot => 7, item => 24902, reward => 25351}; #sleeves
	$armor_list[$tmp_zone][$tmp_class][3] = {slot => 9, item => 24904, reward => 25352}; #wrist
	$armor_list[$tmp_zone][$tmp_class][4] = {slot => 12, item => 24906, reward => 25353}; #gloves
	$armor_list[$tmp_zone][$tmp_class][5] = {slot => 18, item => 24901, reward => 25354}; #legs
	$armor_list[$tmp_zone][$tmp_class][6] = {slot => 19, item => 24903, reward => 25355}; #boots
	
	$tmp_class = 2;
	#kael vylleam vyaeltor cleric plate
	$armor_list[$tmp_zone][$tmp_class][0] = {slot => 2, item => 24905, reward => 25391}; #cap		
	$armor_list[$tmp_zone][$tmp_class][1] = {slot => 17, item => 24900, reward => 25392}; #bp
	$armor_list[$tmp_zone][$tmp_class][2] = {slot => 7, item => 24902, reward => 25393}; #sleeves
	$armor_list[$tmp_zone][$tmp_class][3] = {slot => 9, item => 24904, reward => 25394}; #wrist
	$armor_list[$tmp_zone][$tmp_class][4] = {slot => 12, item => 24906, reward => 25395}; #gloves
	$armor_list[$tmp_zone][$tmp_class][5] = {slot => 18, item => 24901, reward => 25396}; #legs
	$armor_list[$tmp_zone][$tmp_class][6] = {slot => 19, item => 24903, reward => 25397}; #boots
	
	$tmp_class = 10;
	#kael yeeldan spiritcaller shaman chain
	$armor_list[$tmp_zone][$tmp_class][0] = {slot => 2, item => 24912, reward => 25356}; #cap
	$armor_list[$tmp_zone][$tmp_class][1] = {slot => 17, item => 24907, reward => 25357}; #bp
	$armor_list[$tmp_zone][$tmp_class][2] = {slot => 7, item => 24909, reward => 25358}; #sleeves
	$armor_list[$tmp_zone][$tmp_class][3] = {slot => 9, item => 24911, reward => 25359}; #wrist
	$armor_list[$tmp_zone][$tmp_class][4] = {slot => 12, item => 24913, reward => 25360}; #gloves
	$armor_list[$tmp_zone][$tmp_class][5] = {slot => 18, item => 24908, reward => 25361}; #legs
	$armor_list[$tmp_zone][$tmp_class][6] = {slot => 19, item => 24910, reward => 25362}; #boots
	
	###SKYSHRINE###
	$tmp_zone = 114;
	$tmp_class = 11;
	#skyshrine abudan fe-dhar necro silk
	$armor_list[$tmp_zone][$tmp_class][0] = {slot => 2, item => 24982, reward => 31161}; #cap
	$armor_list[$tmp_zone][$tmp_class][1] = {slot => 17, item => 24977, reward => 31162}; #bp
	$armor_list[$tmp_zone][$tmp_class][2] = {slot => 7, item => 24979, reward => 31163}; #sleeves
	$armor_list[$tmp_zone][$tmp_class][3] = {slot => 9, item => 24981, reward => 31164}; #wrist
	$armor_list[$tmp_zone][$tmp_class][4] = {slot => 12, item => 24983, reward => 31165}; #gloves
	$armor_list[$tmp_zone][$tmp_class][5] = {slot => 18, item => 24978, reward => 31166}; #legs
	$armor_list[$tmp_zone][$tmp_class][6] = {slot => 19, item => 24980, reward => 31167}; #boots
	
	$tmp_class = 3;
	#skyshrine adwetram fe-dhar paladin plate
	$armor_list[$tmp_zone][$tmp_class][0] = {slot => 2, item => 24961, reward => 31119}; #cap
	$armor_list[$tmp_zone][$tmp_class][1] = {slot => 17, item => 24956, reward => 31120}; #bp
	$armor_list[$tmp_zone][$tmp_class][2] = {slot => 7, item => 24958, reward => 31121}; #sleeves
	$armor_list[$tmp_zone][$tmp_class][3] = {slot => 9, item => 24960, reward => 31122}; #wrist
	$armor_list[$tmp_zone][$tmp_class][4] = {slot => 12, item => 24962, reward => 31123}; #gloves
	$armor_list[$tmp_zone][$tmp_class][5] = {slot => 18, item => 24957, reward => 31124}; #legs
	$armor_list[$tmp_zone][$tmp_class][6] = {slot => 19, item => 24959, reward => 31125}; #boots
	
	$tmp_class = 10;
	#skyshrine asteinnon fe-dhar shaman chain
	$armor_list[$tmp_zone][$tmp_class][0] = {slot => 2, item => 24968, reward => 31105}; #cap
	$armor_list[$tmp_zone][$tmp_class][1] = {slot => 17, item => 24963, reward => 31106}; #bp
	$armor_list[$tmp_zone][$tmp_class][2] = {slot => 7, item => 24965, reward => 31107}; #sleeves
	$armor_list[$tmp_zone][$tmp_class][3] = {slot => 9, item => 24967, reward => 31108}; #wrist
	$armor_list[$tmp_zone][$tmp_class][4] = {slot => 12, item => 24969, reward => 31109}; #gloves
	$armor_list[$tmp_zone][$tmp_class][5] = {slot => 18, item => 24964, reward => 31110}; #legs
	$armor_list[$tmp_zone][$tmp_class][6] = {slot => 19, item => 24966, reward => 31111}; #boots
	
	$tmp_class = 9;
	#skyshrine crendeatha fe-dhar rogue chain
	$armor_list[$tmp_zone][$tmp_class][0] = {slot => 2, item => 24968, reward => 31126}; #cap
	$armor_list[$tmp_zone][$tmp_class][1] = {slot => 17, item => 24963, reward => 31127}; #bp
	$armor_list[$tmp_zone][$tmp_class][2] = {slot => 7, item => 24965, reward => 31128}; #sleeves
	$armor_list[$tmp_zone][$tmp_class][3] = {slot => 9, item => 24967, reward => 31129}; #wrist
	$armor_list[$tmp_zone][$tmp_class][4] = {slot => 12, item => 24969, reward => 31130}; #gloves
	$armor_list[$tmp_zone][$tmp_class][5] = {slot => 18, item => 24964, reward => 31131}; #legs
	$armor_list[$tmp_zone][$tmp_class][6] = {slot => 19, item => 24966, reward => 31132}; #boots
	
	$tmp_class = 12;
	#skyshrine elaend fe-dhar wizard silk
	$armor_list[$tmp_zone][$tmp_class][0] = {slot => 2, item => 24982, reward => 31154}; #cap
	$armor_list[$tmp_zone][$tmp_class][1] = {slot => 17, item => 24977, reward => 31155}; #bp
	$armor_list[$tmp_zone][$tmp_class][2] = {slot => 7, item => 24979, reward => 31156}; #sleeves
	$armor_list[$tmp_zone][$tmp_class][3] = {slot => 9, item => 24981, reward => 31157}; #wrist
	$armor_list[$tmp_zone][$tmp_class][4] = {slot => 12, item => 24983, reward => 31158}; #gloves
	$armor_list[$tmp_zone][$tmp_class][5] = {slot => 18, item => 24978, reward => 31159}; #legs
	$armor_list[$tmp_zone][$tmp_class][6] = {slot => 19, item => 24980, reward => 31160}; #boots
	
	$tmp_class = 2;
	#skyshrine fardonad fe-dhar cleric plate
	$armor_list[$tmp_zone][$tmp_class][0] = {slot => 2, item => 24961, reward => 31140}; #cap
	$armor_list[$tmp_zone][$tmp_class][1] = {slot => 17, item => 24956, reward => 31141}; #bp
	$armor_list[$tmp_zone][$tmp_class][2] = {slot => 7, item => 24958, reward => 31142}; #sleeves
	$armor_list[$tmp_zone][$tmp_class][3] = {slot => 9, item => 24960, reward => 31143}; #wrist
	$armor_list[$tmp_zone][$tmp_class][4] = {slot => 12, item => 24962, reward => 31144}; #gloves
	$armor_list[$tmp_zone][$tmp_class][5] = {slot => 18, item => 24957, reward => 31145}; #legs
	$armor_list[$tmp_zone][$tmp_class][6] = {slot => 19, item => 24959, reward => 31146}; #boots
	
	$tmp_class = 1;
	#skyshrine jendavudd fe-dhar warrior plate
	$armor_list[$tmp_zone][$tmp_class][0] = {slot => 2, item => 24961, reward => 31182}; #cap
	$armor_list[$tmp_zone][$tmp_class][1] = {slot => 17, item => 24956, reward => 31183}; #bp
	$armor_list[$tmp_zone][$tmp_class][2] = {slot => 7, item => 24958, reward => 31184}; #sleeves
	$armor_list[$tmp_zone][$tmp_class][3] = {slot => 9, item => 24960, reward => 31185}; #wrist
	$armor_list[$tmp_zone][$tmp_class][4] = {slot => 12, item => 24962, reward => 31186}; #gloves
	$armor_list[$tmp_zone][$tmp_class][5] = {slot => 18, item => 24957, reward => 31187}; #legs
	$armor_list[$tmp_zone][$tmp_class][6] = {slot => 19, item => 24959, reward => 31188}; #boots
	
	$tmp_class = 7;
	#skyshrine komawin fe-dhar monk leather
	$armor_list[$tmp_zone][$tmp_class][0] = {slot => 2, item => 24975, reward => 31189}; #cap
	$armor_list[$tmp_zone][$tmp_class][1] = {slot => 17, item => 24970, reward => 31190}; #bp
	$armor_list[$tmp_zone][$tmp_class][2] = {slot => 7, item => 24972, reward => 31191}; #sleeves
	$armor_list[$tmp_zone][$tmp_class][3] = {slot => 9, item => 24974, reward => 31192}; #wrist
	$armor_list[$tmp_zone][$tmp_class][4] = {slot => 12, item => 24976, reward => 31193}; #gloves
	$armor_list[$tmp_zone][$tmp_class][5] = {slot => 18, item => 24971, reward => 31194}; #legs
	$armor_list[$tmp_zone][$tmp_class][6] = {slot => 19, item => 24973, reward => 31195}; #boots
	
	#skyshrine larquin fe-dhar beastlord leather
	
	$tmp_class = 14;
	#skyshrine lothieder fe-dhar enchanter silk
	$armor_list[$tmp_zone][$tmp_class][0] = {slot => 2, item => 24982, reward => 31175}; #cap
	$armor_list[$tmp_zone][$tmp_class][1] = {slot => 17, item => 24977, reward => 31176}; #bp
	$armor_list[$tmp_zone][$tmp_class][2] = {slot => 7, item => 24979, reward => 31177}; #sleeves
	$armor_list[$tmp_zone][$tmp_class][3] = {slot => 9, item => 24981, reward => 31178}; #wrist
	$armor_list[$tmp_zone][$tmp_class][4] = {slot => 12, item => 24983, reward => 31179}; #gloves
	$armor_list[$tmp_zone][$tmp_class][5] = {slot => 18, item => 24978, reward => 31180}; #legs
	$armor_list[$tmp_zone][$tmp_class][6] = {slot => 19, item => 24980, reward => 31181}; #boots
	
	$tmp_class = 4;
	#skyshrine nalelin fe-dhar ranger chain
	$armor_list[$tmp_zone][$tmp_class][0] = {slot => 2, item => 24968, reward => 31112}; #cap
	$armor_list[$tmp_zone][$tmp_class][1] = {slot => 17, item => 24963, reward => 31113}; #bp
	$armor_list[$tmp_zone][$tmp_class][2] = {slot => 7, item => 24965, reward => 31114}; #sleeves
	$armor_list[$tmp_zone][$tmp_class][3] = {slot => 9, item => 24967, reward => 31115}; #wrist
	$armor_list[$tmp_zone][$tmp_class][4] = {slot => 12, item => 24969, reward => 31116}; #gloves
	$armor_list[$tmp_zone][$tmp_class][5] = {slot => 18, item => 24964, reward => 31117}; #legs
	$armor_list[$tmp_zone][$tmp_class][6] = {slot => 19, item => 24966, reward => 31118}; #boots
	
	$tmp_class = 13;
	#skyshrine ocoenydd fe-dhar magician silk
	$armor_list[$tmp_zone][$tmp_class][0] = {slot => 2, item => 24982, reward => 31168}; #cap
	$armor_list[$tmp_zone][$tmp_class][1] = {slot => 17, item => 24977, reward => 31169}; #bp
	$armor_list[$tmp_zone][$tmp_class][2] = {slot => 7, item => 24979, reward => 31170}; #sleeves
	$armor_list[$tmp_zone][$tmp_class][3] = {slot => 9, item => 24981, reward => 31171}; #wrist
	$armor_list[$tmp_zone][$tmp_class][4] = {slot => 12, item => 24983, reward => 31172}; #gloves
	$armor_list[$tmp_zone][$tmp_class][5] = {slot => 18, item => 24978, reward => 31173}; #legs
	$armor_list[$tmp_zone][$tmp_class][6] = {slot => 19, item => 24980, reward => 31174}; #boots
	
	$tmp_class = 5;
	#skyshrine onerind fe-dhar shadowknight plate
	$armor_list[$tmp_zone][$tmp_class][0] = {slot => 2, item => 24961, reward => 31098}; #cap
	$armor_list[$tmp_zone][$tmp_class][1] = {slot => 17, item => 24956, reward => 31099}; #bp
	$armor_list[$tmp_zone][$tmp_class][2] = {slot => 7, item => 24958, reward => 31100}; #sleeves
	$armor_list[$tmp_zone][$tmp_class][3] = {slot => 9, item => 24960, reward => 31101}; #wrist
	$armor_list[$tmp_zone][$tmp_class][4] = {slot => 12, item => 24962, reward => 31102}; #gloves
	$armor_list[$tmp_zone][$tmp_class][5] = {slot => 18, item => 24957, reward => 31103}; #legs
	$armor_list[$tmp_zone][$tmp_class][6] = {slot => 19, item => 24959, reward => 31104}; #boots
	
	$tmp_class = 6;
	#skyshrine qynydd fe-dhar druid leather
	$armor_list[$tmp_zone][$tmp_class][0] = {slot => 2, item => 24975, reward => 31147}; #cap
	$armor_list[$tmp_zone][$tmp_class][1] = {slot => 17, item => 24970, reward => 31148}; #bp
	$armor_list[$tmp_zone][$tmp_class][2] = {slot => 7, item => 24972, reward => 31149}; #sleeves
	$armor_list[$tmp_zone][$tmp_class][3] = {slot => 9, item => 24974, reward => 31150}; #wrist
	$armor_list[$tmp_zone][$tmp_class][4] = {slot => 12, item => 24976, reward => 31151}; #gloves
	$armor_list[$tmp_zone][$tmp_class][5] = {slot => 18, item => 24971, reward => 31152}; #legs
	$armor_list[$tmp_zone][$tmp_class][6] = {slot => 19, item => 24973, reward => 31153}; #boots
	
	#skyshrine roagar fe-dhar berserker chain
	$tmp_class = 8;
	#skyshrine umykith fe-dhar bard plate
	$armor_list[$tmp_zone][$tmp_class][0] = {slot => 2, item => 24961, reward => 31133}; #cap
	$armor_list[$tmp_zone][$tmp_class][1] = {slot => 17, item => 24956, reward => 31134}; #bp
	$armor_list[$tmp_zone][$tmp_class][2] = {slot => 7, item => 24958, reward => 31135}; #sleeves
	$armor_list[$tmp_zone][$tmp_class][3] = {slot => 9, item => 24960, reward => 31136}; #wrist
	$armor_list[$tmp_zone][$tmp_class][4] = {slot => 12, item => 24962, reward => 31137}; #gloves
	$armor_list[$tmp_zone][$tmp_class][5] = {slot => 18, item => 24957, reward => 31138}; #legs
	$armor_list[$tmp_zone][$tmp_class][6] = {slot => 19, item => 24959, reward => 31139}; #boots
	
	###THURGADIN###
	$tmp_zone = 115;
	$tmp_class = 4;
	#thurgadin argash ranger chain
	$armor_list[$tmp_zone][$tmp_class][0] = {slot => 2, item => 24940, reward => 31014}; #cap
	$armor_list[$tmp_zone][$tmp_class][1] = {slot => 17, item => 24935, reward => 31015}; #bp
	$armor_list[$tmp_zone][$tmp_class][2] = {slot => 7, item => 24937, reward => 31016}; #sleeves
	$armor_list[$tmp_zone][$tmp_class][3] = {slot => 9, item => 24939, reward => 31017}; #wrist
	$armor_list[$tmp_zone][$tmp_class][4] = {slot => 12, item => 24941, reward => 31018}; #gloves
	$armor_list[$tmp_zone][$tmp_class][5] = {slot => 18, item => 24946, reward => 31019}; #legs
	$armor_list[$tmp_zone][$tmp_class][6] = {slot => 19, item => 24938, reward => 31020}; #boots
	
	$tmp_class = 3;
	#thurgadin battlepriest daragor paladin plate
	$armor_list[$tmp_zone][$tmp_class][0] = {slot => 2, item => 24933, reward => 31021}; #cap
	$armor_list[$tmp_zone][$tmp_class][1] = {slot => 17, item => 24928, reward => 31022}; #bp
	$armor_list[$tmp_zone][$tmp_class][2] = {slot => 7, item => 24930, reward => 31023}; #sleeves
	$armor_list[$tmp_zone][$tmp_class][3] = {slot => 9, item => 24932, reward => 31024}; #wrist
	$armor_list[$tmp_zone][$tmp_class][4] = {slot => 12, item => 24934, reward => 31025}; #gloves
	$armor_list[$tmp_zone][$tmp_class][5] = {slot => 18, item => 24929, reward => 31026}; #legs
	$armor_list[$tmp_zone][$tmp_class][6] = {slot => 19, item => 24931, reward => 31027}; #boots
	
	$tmp_class = 1;
	#thurgadin captain njall warrior plate
	$armor_list[$tmp_zone][$tmp_class][0] = {slot => 2, item => 24933, reward => 31085}; #cap
	$armor_list[$tmp_zone][$tmp_class][1] = {slot => 17, item => 24928, reward => 31086}; #bp
	$armor_list[$tmp_zone][$tmp_class][2] = {slot => 7, item => 24930, reward => 31087}; #sleeves
	$armor_list[$tmp_zone][$tmp_class][3] = {slot => 9, item => 24932, reward => 31088}; #wrist
	$armor_list[$tmp_zone][$tmp_class][4] = {slot => 12, item => 24934, reward => 31089}; #gloves
	$armor_list[$tmp_zone][$tmp_class][5] = {slot => 18, item => 24929, reward => 31090}; #legs
	$armor_list[$tmp_zone][$tmp_class][6] = {slot => 19, item => 24931, reward => 31091}; #boots
	
	$tmp_class = 6;
	#thurgadin cobi frostbeard druid leather
	$armor_list[$tmp_zone][$tmp_class][0] = {slot => 2, item => 24942, reward => 31050}; #cap
	$armor_list[$tmp_zone][$tmp_class][1] = {slot => 17, item => 24944, reward => 31051}; #bp
	$armor_list[$tmp_zone][$tmp_class][2] = {slot => 7, item => 24943, reward => 31052}; #sleeves
	$armor_list[$tmp_zone][$tmp_class][3] = {slot => 9, item => 24948, reward => 31053}; #wrist
	$armor_list[$tmp_zone][$tmp_class][4] = {slot => 12, item => 24947, reward => 31054}; #gloves
	$armor_list[$tmp_zone][$tmp_class][5] = {slot => 18, item => 24946, reward => 31055}; #legs
	$armor_list[$tmp_zone][$tmp_class][6] = {slot => 19, item => 24945, reward => 31056}; #boots
	
	$tmp_class = 5;
	#thurgadin dalgrim underbelly shadowknight plate
	$armor_list[$tmp_zone][$tmp_class][0] = {slot => 2, item => 24933, reward => 31000}; #cap
	$armor_list[$tmp_zone][$tmp_class][1] = {slot => 17, item => 24928, reward => 31001}; #bp
	$armor_list[$tmp_zone][$tmp_class][2] = {slot => 7, item => 24930, reward => 31002}; #sleeves
	$armor_list[$tmp_zone][$tmp_class][3] = {slot => 9, item => 24932, reward => 31003}; #wrist
	$armor_list[$tmp_zone][$tmp_class][4] = {slot => 12, item => 24934, reward => 31004}; #gloves
	$armor_list[$tmp_zone][$tmp_class][5] = {slot => 18, item => 24929, reward => 31005}; #legs
	$armor_list[$tmp_zone][$tmp_class][6] = {slot => 19, item => 24931, reward => 31006}; #boots
	
	$tmp_class = 9;
	#thurgadin foreman felspar rogue chain
	$armor_list[$tmp_zone][$tmp_class][0] = {slot => 2, item => 24940, reward => 31028}; #cap
	$armor_list[$tmp_zone][$tmp_class][1] = {slot => 17, item => 24935, reward => 31029}; #bp
	$armor_list[$tmp_zone][$tmp_class][2] = {slot => 7, item => 24937, reward => 31030}; #sleeves
	$armor_list[$tmp_zone][$tmp_class][3] = {slot => 9, item => 24939, reward => 31031}; #wrist
	$armor_list[$tmp_zone][$tmp_class][4] = {slot => 12, item => 24941, reward => 31032}; #gloves
	$armor_list[$tmp_zone][$tmp_class][5] = {slot => 18, item => 24946, reward => 31033}; #legs
	$armor_list[$tmp_zone][$tmp_class][6] = {slot => 19, item => 24938, reward => 31034}; #boots
	
	#thurgadin glatigi berserker chain
	$tmp_class = 13;
	#thurgadin kyla frostbeard magician silk
	$armor_list[$tmp_zone][$tmp_class][0] = {slot => 2, item => 24933, reward => 31070}; #cap
	$armor_list[$tmp_zone][$tmp_class][1] = {slot => 17, item => 24928, reward => 31071}; #bp
	$armor_list[$tmp_zone][$tmp_class][2] = {slot => 7, item => 24930, reward => 31072}; #sleeves
	$armor_list[$tmp_zone][$tmp_class][3] = {slot => 9, item => 24932, reward => 31073}; #wrist
	$armor_list[$tmp_zone][$tmp_class][4] = {slot => 12, item => 24934, reward => 31074}; #gloves
	$armor_list[$tmp_zone][$tmp_class][5] = {slot => 18, item => 24929, reward => 31075}; #legs
	$armor_list[$tmp_zone][$tmp_class][6] = {slot => 19, item => 24931, reward => 31076}; #boots
	
	$tmp_class = 8;
	#thurgadin leifur bard plate
	$armor_list[$tmp_zone][$tmp_class][0] = {slot => 2, item => 24933, reward => 31036}; #cap
	$armor_list[$tmp_zone][$tmp_class][1] = {slot => 17, item => 24928, reward => 31037}; #bp
	$armor_list[$tmp_zone][$tmp_class][2] = {slot => 7, item => 24930, reward => 31038}; #sleeves
	$armor_list[$tmp_zone][$tmp_class][3] = {slot => 9, item => 24932, reward => 31039}; #wrist
	$armor_list[$tmp_zone][$tmp_class][4] = {slot => 12, item => 24934, reward => 31040}; #gloves
	$armor_list[$tmp_zone][$tmp_class][5] = {slot => 18, item => 24929, reward => 31041}; #legs
	$armor_list[$tmp_zone][$tmp_class][6] = {slot => 19, item => 24931, reward => 31042}; #boots
	
	$tmp_class = 14;
	#thurgadin lorekeeper brita enchanter silk
	$armor_list[$tmp_zone][$tmp_class][0] = {slot => 2, item => 24933, reward => 31077}; #cap
	$armor_list[$tmp_zone][$tmp_class][1] = {slot => 17, item => 24928, reward => 31078}; #bp
	$armor_list[$tmp_zone][$tmp_class][2] = {slot => 7, item => 24930, reward => 31079}; #sleeves
	$armor_list[$tmp_zone][$tmp_class][3] = {slot => 9, item => 24932, reward => 31080}; #wrist
	$armor_list[$tmp_zone][$tmp_class][4] = {slot => 12, item => 24934, reward => 31081}; #gloves
	$armor_list[$tmp_zone][$tmp_class][5] = {slot => 18, item => 24929, reward => 31082}; #legs
	$armor_list[$tmp_zone][$tmp_class][6] = {slot => 19, item => 24931, reward => 31083}; #boots
	
	$tmp_class = 7;
	#thurgadin lorekeeper einar monk leather
	$armor_list[$tmp_zone][$tmp_class][0] = {slot => 2, item => 24942, reward => 31092}; #cap
	$armor_list[$tmp_zone][$tmp_class][1] = {slot => 17, item => 24944, reward => 31093}; #bp
	$armor_list[$tmp_zone][$tmp_class][2] = {slot => 7, item => 24943, reward => 31094}; #sleeves
	$armor_list[$tmp_zone][$tmp_class][3] = {slot => 9, item => 24948, reward => 31095}; #wrist
	$armor_list[$tmp_zone][$tmp_class][4] = {slot => 12, item => 24947, reward => 31096}; #gloves
	$armor_list[$tmp_zone][$tmp_class][5] = {slot => 18, item => 24946, reward => 31097}; #legs
	$armor_list[$tmp_zone][$tmp_class][6] = {slot => 19, item => 24945, reward => 31098}; #boots
	
	$tmp_class = 11;
	#thurgadin lorekeeper zorik necromancer silk
	$armor_list[$tmp_zone][$tmp_class][0] = {slot => 2, item => 24933, reward => 31063}; #cap
	$armor_list[$tmp_zone][$tmp_class][1] = {slot => 17, item => 24928, reward => 31064}; #bp
	$armor_list[$tmp_zone][$tmp_class][2] = {slot => 7, item => 24930, reward => 31065}; #sleeves
	$armor_list[$tmp_zone][$tmp_class][3] = {slot => 9, item => 24932, reward => 31066}; #wrist
	$armor_list[$tmp_zone][$tmp_class][4] = {slot => 12, item => 24934, reward => 31067}; #gloves
	$armor_list[$tmp_zone][$tmp_class][5] = {slot => 18, item => 24929, reward => 31068}; #legs
	$armor_list[$tmp_zone][$tmp_class][6] = {slot => 19, item => 24931, reward => 31069}; #boots

	$tmp_class = 12;
	#thurgadin mauren frostbeard wizard silk
	$armor_list[$tmp_zone][$tmp_class][0] = {slot => 2, item => 24933, reward => 31056}; #cap
	$armor_list[$tmp_zone][$tmp_class][1] = {slot => 17, item => 24928, reward => 31057}; #bp
	$armor_list[$tmp_zone][$tmp_class][2] = {slot => 7, item => 24930, reward => 31058}; #sleeves
	$armor_list[$tmp_zone][$tmp_class][3] = {slot => 9, item => 24932, reward => 31059}; #wrist
	$armor_list[$tmp_zone][$tmp_class][4] = {slot => 12, item => 24934, reward => 31060}; #gloves
	$armor_list[$tmp_zone][$tmp_class][5] = {slot => 18, item => 24929, reward => 31061}; #legs
	$armor_list[$tmp_zone][$tmp_class][6] = {slot => 19, item => 24931, reward => 31062}; #boots
	
	$tmp_class = 2;
	#thurgadin loremaster dorinan cleric plate
	$armor_list[$tmp_zone][$tmp_class][0] = {slot => 2, item => 24933, reward => 31043}; #cap
	$armor_list[$tmp_zone][$tmp_class][1] = {slot => 17, item => 24928, reward => 31044}; #bp
	$armor_list[$tmp_zone][$tmp_class][2] = {slot => 7, item => 24930, reward => 31045}; #sleeves
	$armor_list[$tmp_zone][$tmp_class][3] = {slot => 9, item => 24932, reward => 31046}; #wrist
	$armor_list[$tmp_zone][$tmp_class][4] = {slot => 12, item => 24934, reward => 31047}; #gloves
	$armor_list[$tmp_zone][$tmp_class][5] = {slot => 18, item => 24929, reward => 31048}; #legs
	$armor_list[$tmp_zone][$tmp_class][6] = {slot => 19, item => 24931, reward => 31049}; #boots
	
	#thurgadin pearce icefang beastlord leather

	$tmp_class = 10;
	#thurgadin terman underbelly shaman chain
	$armor_list[$tmp_zone][$tmp_class][0] = {slot => 2, item => 24940, reward => 31008}; #cap
	$armor_list[$tmp_zone][$tmp_class][1] = {slot => 17, item => 24935, reward => 31009}; #bp
	$armor_list[$tmp_zone][$tmp_class][2] = {slot => 7, item => 24937, reward => 31010}; #sleeves
	$armor_list[$tmp_zone][$tmp_class][3] = {slot => 9, item => 24939, reward => 31011}; #wrist
	$armor_list[$tmp_zone][$tmp_class][4] = {slot => 12, item => 24941, reward => 31012}; #gloves
	$armor_list[$tmp_zone][$tmp_class][5] = {slot => 18, item => 24946, reward => 31013}; #legs
	$armor_list[$tmp_zone][$tmp_class][6] = {slot => 19, item => 24938, reward => 31014}; #boots
	return @armor_list;
}