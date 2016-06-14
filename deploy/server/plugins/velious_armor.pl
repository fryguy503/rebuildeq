#::: Load pricing of velious based on slot provided, in platinum

#2 head
#7 arm
#9 || 10 wrist
#12 hand
#17 chest
#18 leg
#19 feet

sub VeliousPricingBySlot {
	my $price = 100;
	my $slot = shift;
	if ($slot == 2) $price = 500; #head
	else if ($slot == 7) $price = 700; #arm
	else if ($slot == 9 || $slot == 10) $price = 300; #wrist
	else if ($slot == 12) $price = 500; #hand
	else if ($slot == 17) $price = 1500; #chest
	else if ($slot == 18) $price = 1500; #leg
	else if ($slot == 19) $price = 500; #feet
	return $price;
}

sub VeliousArmorHail {
	return "Are you interested in armor that Velious has to offer? [ ".quest::saylink("head")."], [".quest::saylink("arms")."], [".quest::saylink("wrists")."], [".quest::saylink("hands")."], [".quest::saylink("chest")."], [".quest::saylink("legs")."], [".quest::saylink("boots")."]";
}

sub VeliousArmorRequirement {
	my $slot = shift;
	my $zoneid = shift;
	my $class = shift;
	my $armor = "";
	my $armor_type = "";
	my $slotname = "";
	my $location = "";
	if ($zoneid == 115) { #Thurgadin
		$location = "the Arena of Kael Drakkel"
		if ($class == 3 || $class == 8 || $class == 1 || $class == 5 || $class == 2) {
			$armor_type = " Corroded Plate";
			if ($slot == "head") $slotname = "Helmet";
			elsif ($slot == "arms") $slotname = "Vambraces";
			elsif ($slot == "wrists") $slotname = "Bracer";
			elsif ($slot == "hands") $slotname = "Gauntlets";
			elsif ($slot == "chest") { $armor_type = " Corroded"; $slotname = "Breastplate"; } 
			elsif ($slot == "legs") $slotname = "Greaves";
			else $slotname = "Boots";
		}
		elsif ($class == 4 || $class == 9 || $class == 10) {
			$armor_type = " Corroded Chain";
			if ($slot == "head") $slotname = "Coif";
			elsif ($slot == "arms") $slotname = "Sleeves";
			elsif ($slot == "wrists") $slotname = "Bracer";
			elsif ($slot == "hands") $slotname = "Gauntlets";
			elsif ($slot == "chest") $slotname = "Tunic";
			elsif ($slot == "legs") $slotname = "Leggings";
			else $slotname = "Boots";
		}
		elsif ($class == 6 || $class == 7 || $class == 10) {
			$armor_type = "n Eroded Leather";
			if ($slot == "head") $slotname = "Cap";
			elsif ($slot == "arms") $slotname = "Sleeves";
			elsif ($slot == "wrists") $slotname = "Braclet";
			elsif ($slot == "hands") $slotname = "Gloves";
			elsif ($slot == "chest") $slotname = "Tunic";
			elsif ($slot == "legs") $slotname = "Leggings";
			else $slotname = "Boots";
		}
		else {
			$armor_type = " Torn Enchanted Silk";
			if ($slot == "head") $slotname = "Turban";
			elsif ($slot == "arms") $slotname = "Sleeves";
			elsif ($slot == "wrists") $slotname = "Wristband";
			elsif ($slot == "hands") $slotname = "Gloves";
			elsif ($slot == "chest") $slotname = "Robe";
			elsif ($slot == "legs") $slotname = "Pantaloons";
			else $slotname = "Boots";
		}
	}

	if ($zoneid == 113) { #kael
		$location = "the West Wing of the Temple of Veeshan"
		if ($class == 3 || $class == 8 || $class == 1 || $class == 5 || $class == 2) {
			$armor_type = "n Ancient Tarnished Plate";
			if ($slot == "head") $slotname = "Helmet";
			elsif ($slot == "arms") $slotname = "Vambraces";
			elsif ($slot == "wrists") $slotname = "Bracer";
			elsif ($slot == "hands") $slotname = "Gauntlets";
			elsif ($slot == "chest") { $armor_type = " Corroded"; $slotname = "Breastplate"; } 
			elsif ($slot == "legs") $slotname = "Greaves";
			else $slotname = "Boots";
		}
		elsif ($class == 4 || $class == 9 || $class == 10) {
			$armor_type = "n Ancient Tarnished Chain";
			if ($slot == "head") $slotname = "Coif";
			elsif ($slot == "arms") $slotname = "Sleeves";
			elsif ($slot == "wrists") $slotname = "Bracer";
			elsif ($slot == "hands") $slotname = "Gauntlets";
			elsif ($slot == "chest") $slotname = "Tunic";
			elsif ($slot == "legs") $slotname = "Leggings";
			else $slotname = "Boots";
		}
		elsif ($class == 6 || $class == 7 || $class == 10) {
			$armor_type = "n Ancient Leather";
			if ($slot == "head") $slotname = "Cap";
			elsif ($slot == "arms") $slotname = "Sleeves";
			elsif ($slot == "wrists") $slotname = "Braclet";
			elsif ($slot == "hands") $slotname = "Gloves";
			elsif ($slot == "chest") $slotname = "Tunic";
			elsif ($slot == "legs") $slotname = "Leggings";
			else $slotname = "Boots";
		}
		else {
			$armor_type = "n Ancient Silk";
			if ($slot == "head") $slotname = "Turban";
			elsif ($slot == "arms") $slotname = "Sleeves";
			elsif ($slot == "wrists") $slotname = "Wristband";
			elsif ($slot == "hands") $slotname = "Gloves";
			elsif ($slot == "chest") $slotname = "Robe";
			elsif ($slot == "legs") $slotname = "Pantaloons";
			else $slotname = "Boots";
		}
	}

	if ($zoneid == 114) { #skyshrine
		$location = "the Halls of Testing in the Temple of Veeshan"
		if ($class == 3 || $class == 8 || $class == 1 || $class == 5 || $class == 2) {
			$armor_type = "n Unadorned Plate";
			if ($slot == "head") $slotname = "Helmet";
			elsif ($slot == "arms") $slotname = "Vambraces";
			elsif ($slot == "wrists") $slotname = "Bracer";
			elsif ($slot == "hands") $slotname = "Gauntlets";
			elsif ($slot == "chest") { $armor_type = " Corroded"; $slotname = "Breastplate"; } 
			elsif ($slot == "legs") $slotname = "Greaves";
			else $slotname = "Boots";
		}
		elsif ($class == 4 || $class == 9 || $class == 10) {
			$armor_type = "n Unadorned Chain";
			if ($slot == "head") $slotname = "Coif";
			elsif ($slot == "arms") $slotname = "Sleeves";
			elsif ($slot == "wrists") $slotname = "Bracer";
			elsif ($slot == "hands") $slotname = "Gauntlets";
			elsif ($slot == "chest") $slotname = "Tunic";
			elsif ($slot == "legs") $slotname = "Leggings";
			else $slotname = "Boots";
		}
		elsif ($class == 6 || $class == 7 || $class == 10) {
			$armor_type = "n Unadorned Leather";
			if ($slot == "head") $slotname = "Cap";
			elsif ($slot == "arms") $slotname = "Sleeves";
			elsif ($slot == "wrists") $slotname = "Braclet";
			elsif ($slot == "hands") $slotname = "Gloves";
			elsif ($slot == "chest") $slotname = "Tunic";
			elsif ($slot == "legs") $slotname = "Leggings";
			else $slotname = "Boots";
		}
		else {
			$armor_type = " Tattered Silk";
			if ($slot == "head") $slotname = "Turban";
			elsif ($slot == "arms") $slotname = "Sleeves";
			elsif ($slot == "wrists") $slotname = "Wristband";
			elsif ($slot == "hands") $slotname = "Gloves";
			elsif ($slot == "chest") $slotname = "Robe";
			elsif ($slot == "legs") $slotname = "Pantaloons";
			else $slotname = "Boots";
		}
	}
	$price = plugin::VeliousPricingBySlot($slot);
	return "Found in $location, I require a$armor $slotname and my fee of $price platinum to craft this item.";
}

#Pass zoneid, get the slot of what handin was successful.
sub DoVeliousArmorHandin {
	my $zoneid = shift;
	my $cash = shift;
	my $class = shift;

	my %armor_list;
	###KAEL###
	$armor_list{113}{3} = ( #kael barlek stonefist paladin plate
		("slot" => 2, "item" => 24905, "reward" => 25370), #cap		
		("slot" => 17, "item" => 24900, "reward" => 25371), #bp
		("slot" => 7, "item" => 24902, "reward" => 25372), #sleeves
		("slot" => 9, "item" => 24904, "reward" => 25373), #wrist
		("slot" => 12, "item" => 24906, "reward" => 25374), #gloves
		("slot" => 18, "item" => 24901, "reward" => 25375), #legs
		("slot" => 19, "item" => 24903, "reward" => 25376), #boots
	);
	$armor_list{113}{8} = ( #kael bygloirn omorden bard plate
		("slot" => 2, "item" => 24905, "reward" => 25384), #cap		
		("slot" => 17, "item" => 24900, "reward" => 25385), #bp
		("slot" => 7, "item" => 24902, "reward" => 25386), #sleeves
		("slot" => 9, "item" => 24904, "reward" => 25387), #wrist
		("slot" => 12, "item" => 24906, "reward" => 25388), #gloves
		("slot" => 18, "item" => 24901, "reward" => 25389), #legs
		("slot" => 19, "item" => 24903, "reward" => 25390), #boots
	);
	$armor_list{113}{7} = ( #kael dagron stonecutter monk leather
		("slot" => 2, "item" => 24919, "reward" => 25440), #cap		
		("slot" => 17, "item" => 24914, "reward" => 25441), #bp
		("slot" => 7, "item" => 24916, "reward" => 25442), #sleeves
		("slot" => 9, "item" => 24918, "reward" => 25443), #wrist
		("slot" => 12, "item" => 24920, "reward" => 25444), #gloves
		("slot" => 18, "item" => 24915, "reward" => 25445), #legs
		("slot" => 19, "item" => 24917, "reward" => 25446), #boots
	);
	$armor_list{113}{4} = ( #kael gragek mjlorkigar ranger chain
		("slot" => 2, "item" => 24912, "reward" => 25363), #cap
		("slot" => 17, "item" => 24907, "reward" => 25364), #bp
		("slot" => 7, "item" => 24909, "reward" => 253635), #sleeves
		("slot" => 9, "item" => 24911, "reward" => 25366), #wrist
		("slot" => 12, "item" => 24913, "reward" => 25367), #gloves
		("slot" => 18, "item" => 24908, "reward" => 25368), #legs
		("slot" => 19, "item" => 24910, "reward" => 25369), #boots
	);
	$armor_list{113}{6} = ( #kael jaglorm ygorr druid leather
		("slot" => 2, "item" => 24919, "reward" => 25398), #cap		
		("slot" => 17, "item" => 24914, "reward" => 25399), #bp
		("slot" => 7, "item" => 24916, "reward" => 25400), #sleeves
		("slot" => 9, "item" => 24918, "reward" => 25401), #wrist
		("slot" => 12, "item" => 24920, "reward" => 25402), #gloves
		("slot" => 18, "item" => 24915, "reward" => 25403), #legs
		("slot" => 19, "item" => 24917, "reward" => 25404), #boots
	);
	$armor_list{113}{9} = ( #kael kelenek bluadfeth rogue chain
		("slot" => 2, "item" => 24912, "reward" => 25377), #cap
		("slot" => 17, "item" => 24907, "reward" => 25378), #bp
		("slot" => 7, "item" => 24909, "reward" => 25379), #sleeves
		("slot" => 9, "item" => 24911, "reward" => 25380), #wrist
		("slot" => 12, "item" => 24913, "reward" => 25381), #gloves
		("slot" => 18, "item" => 24908, "reward" => 25382), #legs
		("slot" => 19, "item" => 24910, "reward" => 25383), #boots
	);
	$armor_list{113}{1} = ( #kael kragek thunderforge warrior plate
		("slot" => 2, "item" => 24905, "reward" => 25433), #cap		
		("slot" => 17, "item" => 24900, "reward" => 25434), #bp
		("slot" => 7, "item" => 24902, "reward" => 25435), #sleeves
		("slot" => 9, "item" => 24904, "reward" => 25436), #wrist
		("slot" => 12, "item" => 24906, "reward" => 25437), #gloves
		("slot" => 18, "item" => 24901, "reward" => 25438), #legs
		("slot" => 19, "item" => 24903, "reward" => 25439), #boots
	);
	$armor_list{113}{13} = ( #kael mjeldor felstorm magician silk
		("slot" => 2, "item" => 24926, "reward" => 25419), #cap		
		("slot" => 17, "item" => 24921, "reward" => 25420), #bp
		("slot" => 7, "item" => 24923, "reward" => 25421), #sleeves
		("slot" => 9, "item" => 24925, "reward" => 25422), #wrist
		("slot" => 12, "item" => 24927, "reward" => 25423), #gloves
		("slot" => 18, "item" => 24922, "reward" => 25424), #legs
		("slot" => 19, "item" => 24924, "reward" => 25425), #boots
	);
	#kael nerik wolfsoul beastlord leather
	#kael regbor vallgerthon berserker chain
	$armor_list{113}{14} = ( #kael stoem lekbar enchanter silk
		("slot" => 2, "item" => 24926, "reward" => 25426), #cap		
		("slot" => 17, "item" => 24921, "reward" => 25427), #bp
		("slot" => 7, "item" => 24923, "reward" => 25428), #sleeves
		("slot" => 9, "item" => 24925, "reward" => 25429), #wrist
		("slot" => 12, "item" => 24927, "reward" => 25430), #gloves
		("slot" => 18, "item" => 24922, "reward" => 25431), #legs
		("slot" => 19, "item" => 24924, "reward" => 25432), #boots
	);
	$armor_list{113}{12} = ( #kael ulkar jollkarek wziard silk
		("slot" => 2, "item" => 24926, "reward" => 25405), #cap		
		("slot" => 17, "item" => 24921, "reward" => 25406), #bp
		("slot" => 7, "item" => 24923, "reward" => 25407), #sleeves
		("slot" => 9, "item" => 24925, "reward" => 25408), #wrist
		("slot" => 12, "item" => 24927, "reward" => 25409), #gloves
		("slot" => 18, "item" => 24922, "reward" => 25410), #legs
		("slot" => 19, "item" => 24924, "reward" => 25411), #boots
	);
	$armor_list{113}{5} = ( #kael veldern blackhammer shadowknight plate
		("slot" => 2, "item" => 24905, "reward" => 25349), #cap		
		("slot" => 17, "item" => 24900, "reward" => 25350), #bp
		("slot" => 7, "item" => 24902, "reward" => 25351), #sleeves
		("slot" => 9, "item" => 24904, "reward" => 25352), #wrist
		("slot" => 12, "item" => 24906, "reward" => 25353), #gloves
		("slot" => 18, "item" => 24901, "reward" => 25354), #legs
		("slot" => 19, "item" => 24903, "reward" => 25355), #boots
	);
	$armor_list{113}{2} = ( #kael vylleam vyaeltor cleric plate
		("slot" => 2, "item" => 24905, "reward" => 25391), #cap		
		("slot" => 17, "item" => 24900, "reward" => 25392), #bp
		("slot" => 7, "item" => 24902, "reward" => 25393), #sleeves
		("slot" => 9, "item" => 24904, "reward" => 25394), #wrist
		("slot" => 12, "item" => 24906, "reward" => 25395), #gloves
		("slot" => 18, "item" => 24901, "reward" => 25396), #legs
		("slot" => 19, "item" => 24903, "reward" => 25397), #boots
	);
	$armor_list{113}{10} = ( #kael yeeldan spiritcaller shaman chain
		("slot" => 2, "item" => 24912, "reward" => 25356), #cap
		("slot" => 17, "item" => 24907, "reward" => 25357), #bp
		("slot" => 7, "item" => 24909, "reward" => 25358), #sleeves
		("slot" => 9, "item" => 24911, "reward" => 25359), #wrist
		("slot" => 12, "item" => 24913, "reward" => 25360), #gloves
		("slot" => 18, "item" => 24908, "reward" => 25361), #legs
		("slot" => 19, "item" => 24910, "reward" => 25362), #boots
	);
	###SKYSHRINE###
	$armor_list{114}{11} = ( #skyshrine abudan fe-dhar necro silk
		("slot" => 2, "item" => 24982, "reward" => 31161), #cap
		("slot" => 17, "item" => 24977, "reward" => 31162), #bp
		("slot" => 7, "item" => 24979, "reward" => 31163), #sleeves
		("slot" => 9, "item" => 24981, "reward" => 31164), #wrist
		("slot" => 12, "item" => 24983, "reward" => 31165), #gloves
		("slot" => 18, "item" => 24978, "reward" => 31166), #legs
		("slot" => 19, "item" => 24980, "reward" => 31167), #boots
	);
	$armor_list{114}{3} = ( #skyshrine adwetram fe-dhar paladin plate
		("slot" => 2, "item" => 24961, "reward" => 31119), #cap
		("slot" => 17, "item" => 24956, "reward" => 31120), #bp
		("slot" => 7, "item" => 24958, "reward" => 31121), #sleeves
		("slot" => 9, "item" => 24960, "reward" => 31122), #wrist
		("slot" => 12, "item" => 24962, "reward" => 31123), #gloves
		("slot" => 18, "item" => 24957, "reward" => 31124), #legs
		("slot" => 19, "item" => 24959, "reward" => 31125), #boots
	);
	$armor_list{114}{10} = ( #skyshrine asteinnon fe-dhar shaman chain
		("slot" => 2, "item" => 24968, "reward" => 31105), #cap
		("slot" => 17, "item" => 24963, "reward" => 31106), #bp
		("slot" => 7, "item" => 24965, "reward" => 31107), #sleeves
		("slot" => 9, "item" => 24967, "reward" => 31108), #wrist
		("slot" => 12, "item" => 24969, "reward" => 31109), #gloves
		("slot" => 18, "item" => 24964, "reward" => 31110), #legs
		("slot" => 19, "item" => 24966, "reward" => 31111), #boots
	);
	$armor_list{114}{9} = ( #skyshrine crendeatha fe-dhar rogue chain
		("slot" => 2, "item" => 24968, "reward" => 31126), #cap
		("slot" => 17, "item" => 24963, "reward" => 31127), #bp
		("slot" => 7, "item" => 24965, "reward" => 31128), #sleeves
		("slot" => 9, "item" => 24967, "reward" => 31129), #wrist
		("slot" => 12, "item" => 24969, "reward" => 31130), #gloves
		("slot" => 18, "item" => 24964, "reward" => 31131), #legs
		("slot" => 19, "item" => 24966, "reward" => 31132), #boots
	);
	$armor_list{114}{12} = ( #skyshrine elaend fe-dhar wizard silk
		("slot" => 2, "item" => 24982, "reward" => 31154), #cap
		("slot" => 17, "item" => 24977, "reward" => 31155), #bp
		("slot" => 7, "item" => 24979, "reward" => 31156), #sleeves
		("slot" => 9, "item" => 24981, "reward" => 31157), #wrist
		("slot" => 12, "item" => 24983, "reward" => 31158), #gloves
		("slot" => 18, "item" => 24978, "reward" => 31159), #legs
		("slot" => 19, "item" => 24980, "reward" => 31160), #boots
	);
	$armor_list{114}{2} = ( #skyshrine fardonad fe-dhar cleric plate
		("slot" => 2, "item" => 24961, "reward" => 31140), #cap
		("slot" => 17, "item" => 24956, "reward" => 31141), #bp
		("slot" => 7, "item" => 24958, "reward" => 31142), #sleeves
		("slot" => 9, "item" => 24960, "reward" => 31143), #wrist
		("slot" => 12, "item" => 24962, "reward" => 31144), #gloves
		("slot" => 18, "item" => 24957, "reward" => 31145), #legs
		("slot" => 19, "item" => 24959, "reward" => 31146), #boots
	);
	$armor_list{114}{1} = ( #skyshrine jendavudd fe-dhar warrior plate
		("slot" => 2, "item" => 24961, "reward" => 31182), #cap
		("slot" => 17, "item" => 24956, "reward" => 31183), #bp
		("slot" => 7, "item" => 24958, "reward" => 31184), #sleeves
		("slot" => 9, "item" => 24960, "reward" => 31185), #wrist
		("slot" => 12, "item" => 24962, "reward" => 31186), #gloves
		("slot" => 18, "item" => 24957, "reward" => 31187), #legs
		("slot" => 19, "item" => 24959, "reward" => 31188), #boots
	);
	$armor_list{114}{7} = ( #skyshrine komawin fe-dhar monk leather
		("slot" => 2, "item" => 24975, "reward" => 31189), #cap
		("slot" => 17, "item" => 24970, "reward" => 31190), #bp
		("slot" => 7, "item" => 24972, "reward" => 31191), #sleeves
		("slot" => 9, "item" => 24974, "reward" => 31192), #wrist
		("slot" => 12, "item" => 24976, "reward" => 31193), #gloves
		("slot" => 18, "item" => 24971, "reward" => 31194), #legs
		("slot" => 19, "item" => 24973, "reward" => 31195), #boots
	);
	#skyshrine larquin fe-dhar beastlord leather
	$armor_list{114}{14} = ( #skyshrine lothieder fe-dhar enchanter silk
		("slot" => 2, "item" => 24982, "reward" => 31175), #cap
		("slot" => 17, "item" => 24977, "reward" => 31176), #bp
		("slot" => 7, "item" => 24979, "reward" => 31177), #sleeves
		("slot" => 9, "item" => 24981, "reward" => 31178), #wrist
		("slot" => 12, "item" => 24983, "reward" => 31179), #gloves
		("slot" => 18, "item" => 24978, "reward" => 31180), #legs
		("slot" => 19, "item" => 24980, "reward" => 31181), #boots
	);
	$armor_list{114}{4} = ( #skyshrine nalelin fe-dhar ranger chain
		("slot" => 2, "item" => 24968, "reward" => 31112), #cap
		("slot" => 17, "item" => 24963, "reward" => 31113), #bp
		("slot" => 7, "item" => 24965, "reward" => 31114), #sleeves
		("slot" => 9, "item" => 24967, "reward" => 31115), #wrist
		("slot" => 12, "item" => 24969, "reward" => 31116), #gloves
		("slot" => 18, "item" => 24964, "reward" => 31117), #legs
		("slot" => 19, "item" => 24966, "reward" => 31118), #boots
	);
	$armor_list{114}{13} = ( #skyshrine ocoenydd fe-dhar magician silk
		("slot" => 2, "item" => 24982, "reward" => 31168), #cap
		("slot" => 17, "item" => 24977, "reward" => 31169), #bp
		("slot" => 7, "item" => 24979, "reward" => 31170), #sleeves
		("slot" => 9, "item" => 24981, "reward" => 31171), #wrist
		("slot" => 12, "item" => 24983, "reward" => 31172), #gloves
		("slot" => 18, "item" => 24978, "reward" => 31173), #legs
		("slot" => 19, "item" => 24980, "reward" => 31174), #boots
	);
	$armor_list{114}{5} = ( #skyshrine onerind fe-dhar shadowknight plate
		("slot" => 2, "item" => 24961, "reward" => 31098), #cap
		("slot" => 17, "item" => 24956, "reward" => 31099), #bp
		("slot" => 7, "item" => 24958, "reward" => 31100), #sleeves
		("slot" => 9, "item" => 24960, "reward" => 31101), #wrist
		("slot" => 12, "item" => 24962, "reward" => 31102), #gloves
		("slot" => 18, "item" => 24957, "reward" => 31103), #legs
		("slot" => 19, "item" => 24959, "reward" => 31104), #boots
	);
	$armor_list{114}{6} = ( #skyshrine qynydd fe-dhar druid leather
		("slot" => 2, "item" => 24975, "reward" => 31147), #cap
		("slot" => 17, "item" => 24970, "reward" => 31148), #bp
		("slot" => 7, "item" => 24972, "reward" => 31149), #sleeves
		("slot" => 9, "item" => 24974, "reward" => 31150), #wrist
		("slot" => 12, "item" => 24976, "reward" => 31151), #gloves
		("slot" => 18, "item" => 24971, "reward" => 31152), #legs
		("slot" => 19, "item" => 24973, "reward" => 31153), #boots
	);
	#skyshrine roagar fe-dhar berserker chain
	$armor_list{114}{8} = ( #skyshrine umykith fe-dhar bard plate
		("slot" => 2, "item" => 24961, "reward" => 31133), #cap
		("slot" => 17, "item" => 24956, "reward" => 31134), #bp
		("slot" => 7, "item" => 24958, "reward" => 31135), #sleeves
		("slot" => 9, "item" => 24960, "reward" => 31136), #wrist
		("slot" => 12, "item" => 24962, "reward" => 31137), #gloves
		("slot" => 18, "item" => 24957, "reward" => 31138), #legs
		("slot" => 19, "item" => 24959, "reward" => 31139), #boots
	);
	###THURGADIN###
	$armor_list{115}{4} = ( #thurgadin argash ranger chain
		("slot" => 2, "item" => 24940, "reward" => 31014), #cap
		("slot" => 17, "item" => 24935, "reward" => 31015), #bp
		("slot" => 7, "item" => 24937, "reward" => 31016), #sleeves
		("slot" => 9, "item" => 24939, "reward" => 31017), #wrist
		("slot" => 12, "item" => 24941, "reward" => 31018), #gloves
		("slot" => 18, "item" => 24946, "reward" => 31019), #legs
		("slot" => 19, "item" => 24938, "reward" => 31020), #boots
	);
	$armor_list{115}{3} = ( #thurgadin battlepriest daragor paladin plate
		("slot" => 2, "item" => 24933, "reward" => 31021), #cap
		("slot" => 17, "item" => 24928, "reward" => 31022), #bp
		("slot" => 7, "item" => 24930, "reward" => 31023), #sleeves
		("slot" => 9, "item" => 24932, "reward" => 31024), #wrist
		("slot" => 12, "item" => 24934, "reward" => 31025), #gloves
		("slot" => 18, "item" => 24929, "reward" => 31026), #legs
		("slot" => 19, "item" => 24931, "reward" => 31027), #boots
	);
	$armor_list{115}{1} = ( #thurgadin captain njall warrior plate
		("slot" => 2, "item" => 24933, "reward" => 31085), #cap
		("slot" => 17, "item" => 24928, "reward" => 31086), #bp
		("slot" => 7, "item" => 24930, "reward" => 31087), #sleeves
		("slot" => 9, "item" => 24932, "reward" => 31088), #wrist
		("slot" => 12, "item" => 24934, "reward" => 31089), #gloves
		("slot" => 18, "item" => 24929, "reward" => 31090), #legs
		("slot" => 19, "item" => 24931, "reward" => 31091), #boots
	);
	$armor_list{115}{6} = ( #thurgadin cobi frostbeard druid leather
		("slot" => 2, "item" => 24942, "reward" => 31050), #cap
		("slot" => 17, "item" => 24944, "reward" => 31051), #bp
		("slot" => 7, "item" => 24943, "reward" => 31052), #sleeves
		("slot" => 9, "item" => 24948, "reward" => 31053), #wrist
		("slot" => 12, "item" => 24947, "reward" => 31054), #gloves
		("slot" => 18, "item" => 24946, "reward" => 31055), #legs
		("slot" => 19, "item" => 24945, "reward" => 31056), #boots
	);
	$armor_list{115}{11} = ( #thurgadin dalgrim underbelly shadowknight plate
		("slot" => 2, "item" => 24933, "reward" => 31000), #cap
		("slot" => 17, "item" => 24928, "reward" => 31001), #bp
		("slot" => 7, "item" => 24930, "reward" => 31002), #sleeves
		("slot" => 9, "item" => 24932, "reward" => 31003), #wrist
		("slot" => 12, "item" => 24934, "reward" => 31004), #gloves
		("slot" => 18, "item" => 24929, "reward" => 31005), #legs
		("slot" => 19, "item" => 24931, "reward" => 31006), #boots
	);
	$armor_list{115}{9} = ( #thurgadin foreman felspar rogue chain
		("slot" => 2, "item" => 24940, "reward" => 31028), #cap
		("slot" => 17, "item" => 24935, "reward" => 31029), #bp
		("slot" => 7, "item" => 24937, "reward" => 31030), #sleeves
		("slot" => 9, "item" => 24939, "reward" => 31031), #wrist
		("slot" => 12, "item" => 24941, "reward" => 31032), #gloves
		("slot" => 18, "item" => 24946, "reward" => 31033), #legs
		("slot" => 19, "item" => 24938, "reward" => 31034), #boots
	);
	#thurgadin glatigi berserker chain
	$armor_list{115}{13} = ( #thurgadin kyla frostbeard magician silk
		("slot" => 2, "item" => 24933, "reward" => 31070), #cap
		("slot" => 17, "item" => 24928, "reward" => 31071), #bp
		("slot" => 7, "item" => 24930, "reward" => 31072), #sleeves
		("slot" => 9, "item" => 24932, "reward" => 31073), #wrist
		("slot" => 12, "item" => 24934, "reward" => 31074), #gloves
		("slot" => 18, "item" => 24929, "reward" => 31075), #legs
		("slot" => 19, "item" => 24931, "reward" => 31076), #boots
	);
	$armor_list{115}{8} = ( #thurgadin leifur bard plate
		("slot" => 2, "item" => 24933, "reward" => 31036), #cap
		("slot" => 17, "item" => 24928, "reward" => 31037), #bp
		("slot" => 7, "item" => 24930, "reward" => 31038), #sleeves
		("slot" => 9, "item" => 24932, "reward" => 31039), #wrist
		("slot" => 12, "item" => 24934, "reward" => 31040), #gloves
		("slot" => 18, "item" => 24929, "reward" => 31041), #legs
		("slot" => 19, "item" => 24931, "reward" => 31042), #boots
	);
	$armor_list{115}{14} = ( #thurgadin lorekeeper brita enchanter silk
		("slot" => 2, "item" => 24933, "reward" => 31077), #cap
		("slot" => 17, "item" => 24928, "reward" => 31078), #bp
		("slot" => 7, "item" => 24930, "reward" => 31079), #sleeves
		("slot" => 9, "item" => 24932, "reward" => 31080), #wrist
		("slot" => 12, "item" => 24934, "reward" => 31081), #gloves
		("slot" => 18, "item" => 24929, "reward" => 31082), #legs
		("slot" => 19, "item" => 24931, "reward" => 31083), #boots
	);
	$armor_list{115}{7} = ( #thurgadin lorekeeper einar monk leather
		("slot" => 2, "item" => 24942, "reward" => 31092), #cap
		("slot" => 17, "item" => 24944, "reward" => 31093), #bp
		("slot" => 7, "item" => 24943, "reward" => 31094), #sleeves
		("slot" => 9, "item" => 24948, "reward" => 31095), #wrist
		("slot" => 12, "item" => 24947, "reward" => 31096), #gloves
		("slot" => 18, "item" => 24946, "reward" => 31097), #legs
		("slot" => 19, "item" => 24945, "reward" => 31098), #boots
	);
	$armor_list{115}{11} = ( #thurgadin lorekeeper zorik necromancer silk
		("slot" => 2, "item" => 24933, "reward" => 31063), #cap
		("slot" => 17, "item" => 24928, "reward" => 31064), #bp
		("slot" => 7, "item" => 24930, "reward" => 31065), #sleeves
		("slot" => 9, "item" => 24932, "reward" => 31066), #wrist
		("slot" => 12, "item" => 24934, "reward" => 31067), #gloves
		("slot" => 18, "item" => 24929, "reward" => 31068), #legs
		("slot" => 19, "item" => 24931, "reward" => 31069), #boots
	);
	$armor_list{115}{2} = ( #thurgadin loremaster dorinan cleric plate
		("slot" => 2, "item" => 24933, "reward" => 31043), #cap
		("slot" => 17, "item" => 24928, "reward" => 31044), #bp
		("slot" => 7, "item" => 24930, "reward" => 31045), #sleeves
		("slot" => 9, "item" => 24932, "reward" => 31046), #wrist
		("slot" => 12, "item" => 24934, "reward" => 31047), #gloves
		("slot" => 18, "item" => 24929, "reward" => 31048), #legs
		("slot" => 19, "item" => 24931, "reward" => 31049), #boots
	);
	#thurgadin pearce icefang beastlord leather
	$armor_list{115}{10} = ( #thurgadin terman underbelly shaman chain
		("slot" => 2, "item" => 24940, "reward" => 31008), #cap
		("slot" => 17, "item" => 24935, "reward" => 31009), #bp
		("slot" => 7, "item" => 24937, "reward" => 31010), #sleeves
		("slot" => 9, "item" => 24939, "reward" => 31011), #wrist
		("slot" => 12, "item" => 24941, "reward" => 31012), #gloves
		("slot" => 18, "item" => 24946, "reward" => 31013), #legs
		("slot" => 19, "item" => 24938, "reward" => 31014), #boots
	);
	foreach my $key (keys %{ $armor_list{$zoneid}{$class} }) {
		if (plugin::check_handin(\%itemcount,$armor_list{$zoneid}{$key}{item}) => 1 && $cash >= (plugin::VeliousPricingBySlot($armor_list{$zoneid}{$key}{slot})*1000) {
			quest::summonitem($armor_list{$zoneid}{$key}{reward});
			return 1;
		}
	}
	return 0;
}