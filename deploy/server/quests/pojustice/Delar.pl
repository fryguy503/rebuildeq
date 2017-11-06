sub EVENT_SAY { 
	my $rc = 0;
	my $rcTotal = 0;
	my $prefix = "";
	my $classid = $client->GetClass();
	if (quest::istaskactive(314)) {
		if (quest::istaskactivityactive(314, 8)) {
			quest::updatetaskactivity(314, 8);
			quest::say("Oh, you're finally back! Want to hear the most ironic thing..? I had the key here, in my pocket, all this time! Thank you for your effort, however. Now simply talk to me about [ " . quest::saylink("heirlooms") . " ] and I'll help you out.");
			return;
		}

		quest::say("Hmm.. still haven't found my key, yet? Keep looking.. you are bound to find it!");
		return;		       
    }

	if ($text=~/help/i) {
		quest::say("You will help me? Very well, then.. Let us start with a simple task list, of sorts... let us repeat the places I have been as of late, and see if the key is there.");
		quest::assigntask(314);
		return;
	}
	if ($text=~/tov/i) {
		$prefix = "tov";
		$tmp_id = 0;		
		if ($text=~/$prefix head/i) {
			if ($classid == 3 || $classid == 8 || $classid == 1 || $classid == 5 || $classid == 2) {
				$tmp_id = 24961; #plate			
			}
			elsif ($classid == 4 || $classid == 9 || $classid == 10) {
				$tmp_id = 24968; #chain
			}
			elsif ($classid == 6 || $classid == 7) {
				$tmp_id = 24975; #leather
			}
			else {
				$tmp_id = 24982; #silk
			}
		}

		if ($text=~/$prefix chest/i) {
			if ($classid == 3 || $classid == 8 || $classid == 1 || $classid == 5 || $classid == 2) {
				$tmp_id = 24956; #plate			
			}
			elsif ($classid == 4 || $classid == 9 || $classid == 10) {
				$tmp_id = 24963; #chain
			}
			elsif ($classid == 6 || $classid == 7) {
				$tmp_id = 24970; #leather
			}
			else {
				$tmp_id = 24977; #silk
			}
		}
		if ($text=~/$prefix arm/i) {
			if ($classid == 3 || $classid == 8 || $classid == 1 || $classid == 5 || $classid == 2) {
				$tmp_id = 24958; #plate			
			}
			if ($classid == 4 || $classid == 9 || $classid == 10) {
				$tmp_id = 24965; #chain
			}
			if ($classid == 6 || $classid == 7) {
				$tmp_id = 24972; #leather
			}
			else {
				$tmp_id = 24979; #silk
			}
		}
		if ($text=~/$prefix wrist/i) {
			if ($classid == 3 || $classid == 8 || $classid == 1 || $classid == 5 || $classid == 2) {
				$tmp_id = 24960; #plate
			}
			if ($classid == 4 || $classid == 9 || $classid == 10) {
				$tmp_id = 24967; #chain
			}
			if ($classid == 6 || $classid == 7) {
				$tmp_id = 24974; #leather
			}
			else {
				$tmp_id = 24981; #silk
			}
		}
		if ($text=~/$prefix hand/i) {
			if ($classid == 3 || $classid == 8 || $classid == 1 || $classid == 5 || $classid == 2) {
				$tmp_id = 24962; #plate			
			}
			if ($classid == 4 || $classid == 9 || $classid == 10) {
				$tmp_id = 24969; #chain
			}
			if ($classid == 6 || $classid == 7) {
				$tmp_id = 24976; #leather
			}
			else {
				$tmp_id = 24983; #silk
			}
		}
		if ($text=~/$prefix leg/i) {
			if ($classid == 3 || $classid == 8 || $classid == 1 || $classid == 5 || $classid == 2) {
				$tmp_id = 24957; #plate			
			}
			if ($classid == 4 || $classid == 9 || $classid == 10) {
				$tmp_id = 24964; #chain
			}
			if ($classid == 6 || $classid == 7) {
				$tmp_id = 24971; #leather
			}
			else {
				$tmp_id = 24978; #silk
			}
		}
		if ($text=~/$prefix feet/i) {
			if ($classid == 3 || $classid == 8 || $classid == 1 || $classid == 5 || $classid == 2) {
				$tmp_id = 24959; #plate			
			}
			if ($classid == 4 || $classid == 9 || $classid == 10) {
				$tmp_id = 24966; #chain
			}
			if ($classid == 6 || $classid == 7) {
				$tmp_id = 24973; #leather
			}
			else {
				$tmp_id = 24980; #silk
			}
		}
		if ($tmp_id > 0) {
			$acct_id = $client->AccountID();

			if (!defined $qglobals{"$acct_id-$prefix-$tmp_id"} || $qglobals{"$acct_id-$prefix-$tmp_id"} < 1) {
				quest::say("You do not have any items stored that match that category. $acct_id-$prefix-$tmp_id");
				return;
			}			
			$count = $qglobals{"$acct_id-$prefix-$tmp_id"};
			quest::setglobal("$acct_id-$prefix-$tmp_id", $count-1, 2, "F");
			quest::summonitem($tmp_id);
			quest::say("Here is your heirloom item, $name");
		}

		quest::say("Pick a slot: [ ".quest::saylink("$prefix head")." ], [ ".quest::saylink("$prefix chest")." ], [ ".quest::saylink("$prefix arms")." ]. [ ".quest::saylink("$prefix wrist")." ], [ ".quest::saylink("$prefix hands")." ], [ ".quest::saylink("$prefix legs")." ], [ ".quest::saylink("$prefix feet")." ]");
		return;
	}

	if ($text=~/kael/i) {		
		$prefix = "kael";
		quest::say("Pick a slot: [ ".quest::saylink("$prefix head")." ], [ ".quest::saylink("$prefix chest")." ], [ ".quest::saylink("$prefix arms")." ]. [ ".quest::saylink("$prefix wrist")." ], [ ".quest::saylink("$prefix hands")." ], [ ".quest::saylink("$prefix legs")." ], [ ".quest::saylink("$prefix feet")." ]");
		return;
	}

	if ($text=~/radiant/i || $text=~/rc/i) {
		$rcTotal = 0;
		$tmp_id = 40903;
		if (defined $qglobals{"$acct_id-$prefix-$tmp_id"} && $qglobals{"$acct_id-$prefix-$tmp_id"} > 0) {
			$rcTotal = $qglobals{"$acct_id-$prefix-$tmp_id"}*250;
		}
		$prefix = "rc";
		quest::say("You currently have $rcTotal radiant crystals available. [ ".quest::saylink("claim radiant crystals")." ]");		
		return;
	}

	#if ($text=~/claim radiant/i || $text=~/rc/i) {
	#	$prefix = "rc";
	#	$rcTotal = 0;
	#	$tmp_id = 40903;
	#	if (defined $qglobals{"$acct_id-$prefix-$tmp_id"} && $qglobals{"$acct_id-$prefix-$tmp_id"} > 0) {
	#		$rcTotal = $qglobals{"$acct_id-$prefix-$tmp_id"}*250;
	#	}
	#	if ($rcTotal < 1) {
	#		quest::say("You do not have any radiant crystals to claim.");
	#		return;
	#	}
	#	$count = $qglobals{"$acct_id-$prefix-$tmp_id"};
	#	quest::setglobal("$acct_id-$prefix-$tmp_id", $count-1, 2, "F");
	#	quest::summonitem($tmp_id, 250);
	#	$rcTotal -= 250;
	#	quest::say("You claimed 250 radiant crystals. You have $rcTotal remaining. [ ".quest::saylink("claim radiant crystals")." ]");
	#	return;
	#}

	if ($text =~/interested/i) {
		quest::say("Well, you see.. unfortunately, I have lost the deposit box key to my chest, the chest with heirlooms.. alas.. I would ask for your [ ". quest::saylink("help") ." ], but I do not know you could be of use.");
		return;
	}
	if ($text=~/heirloom/i) {
		quest::say("Pick a category: [ ". quest::saylink("tov") . " ], [ " . quest::saylink("kael") . " ]. (Note this only works with unadorned and corroded items, completed items cannot be traded)."); #, [ " . quest::saylink("Radiant Crystals") . " ].");
		if (!quest::istaskcompleted(314)) {
			quest::say("Are you [ ". quest::saylink("interested") . " ] in learning how to deposit items to your heirloom?");
		}
		return;
	}

	if ($ulevel < 60) {
		quest::say("Oh yes, greetings. I am a keeper of [ ". quest::saylink("heirlooms")." ], passed down from generation to generation. I hold a fine collection of various trinkets, armor, and other gadgets that I adore so much.");
		return;
	}


    if (quest::istaskactive(501)) {
    	quest::say("I don't think you have proven yourself just yet... unless, you want to talk about [ " . quest::saylink("heirlooms") . " ].");
    	return;
    }

	if ($text=~/experience/i) {
		if (!quest::istaskcompleted(314)) {
			quest::say("First, help me with my [ " . quest::saylink("heirloom") . " ] challenge, then we can about experience.");
			return;
		}
		quest::say("You do not seem very experienced to me.. perhaps in due time, this will change. Perhaps... let's do a test, shall we?");
		quest::assigntask(501);
		return;
	}

	if ($text=~/limits/i) {
		quest::say("Let us test your limits, then. Do this task I have written down, and return to me when you feel yourself of enough [ ". quest::saylink("experience") . " ] to continue forth.");
		return;
	}


	if ($text=~/beyond consideration/i) {
		quest::say("You know of what I speak of, then? Perhaps, just perhaps you may be worthy to pass beyond your [ ". quest::saylink("limits") . " ] and defeat them one day..");
		return;
	}

	if ($text=~/secret/i) {
		quest::say("A secret indeed.. the secret to defeating the greatest of foes. You may have stumbled upon creatures who seem [ " . quest::saylink("beyond consideration") . " ] to attack, great powers, they take you down with ease.");
		return;
	}

	if ($text=~/learn/i) {
		quest::say("Well well, now, you see.. there is a world beyond 60. You may not know. Between [ " . quest::saylink("#feats") . " ], [ ". quest::saylink("#experience") . " ], and [ ". quest::saylink("secrets") . " ].. there is plenty to keep you busy.");		
		return;
	}
	quest::say("I see you have reached adulthood.. Care to [ ". quest::saylink("learn") . " ] listen of a story of the past? Or would you rather talk of [ " . quest::saylink("heirlooms") . " ] ?");
	return;
}


sub EVENT_ITEM {
	if (!quest::istaskcompleted(314)) {
		if(plugin::check_handin(\%itemcount, 10000001 => 1)) { #eat potions
			return;
		}
		
		quest::say("You cannot deposit into the [ ".quest::saylink("heirloom") ." ] chests until you finish my quest.");
		return;
	}

	$acct_id = $client->AccountID();
	$tmp_id = 0;
	#if(plugin::check_handin(\%itemcount, 40903 => 250)) {			
	#	$tmp_id = 40903;
	#	$prefix = "rc";
	#	$count = 0;
	#	if (defined $qglobals{"$acct_id-$prefix-$tmp_id"}) {
	#		$count = $qglobals{"$acct_id-$prefix-$tmp_id"};
	#	}
	#	quest::setglobal("$acct_id-$prefix-$tmp_id", $count+1, 2, "F");
	#	quest::say("Thank you for the stack of radiant crystals, $name.");
	#}

	if(plugin::check_handin(\%itemcount, 24961 => 1)) { #plate			
		$tmp_id = 24961;
		$prefix = "tov";
		$count = 0;
		if (defined $qglobals{"$acct_id-$prefix-$tmp_id"}) {
			$count = $qglobals{"$acct_id-$prefix-$tmp_id"};
		}
		quest::setglobal("$acct_id-$prefix-$tmp_id", $count+1, 2, "F");
		quest::say("Thank you for the item, $name.");
	}
	if(plugin::check_handin(\%itemcount, 24968 => 1)) { #chain
		$tmp_id = 24968;
		$prefix = "tov";
		$count = 0;
		if (defined $qglobals{"$acct_id-$prefix-$tmp_id"}) {
			$count = $qglobals{"$acct_id-$prefix-$tmp_id"};
		}
		quest::setglobal("$acct_id-$prefix-$tmp_id", $count+1, 2, "F");
		quest::say("Thank you for the item, $name.");
	}
	if(plugin::check_handin(\%itemcount, 24975 => 1)) {#leather
		$tmp_id = 24975;
		$prefix = "tov";
		$count = 0;
		if (defined $qglobals{"$acct_id-$prefix-$tmp_id"}) {
			$count = $qglobals{"$acct_id-$prefix-$tmp_id"};
		}
		quest::setglobal("$acct_id-$prefix-$tmp_id", $count+1, 2, "F");
		quest::say("Thank you for the item, $name.");
	}
	if(plugin::check_handin(\%itemcount, 24982 => 1)) { #silk
		$tmp_id = 24982;
		$prefix = "tov";
		$count = 0;
		if (defined $qglobals{"$acct_id-$prefix-$tmp_id"}) {
			$count = $qglobals{"$acct_id-$prefix-$tmp_id"};
		}
		quest::setglobal("$acct_id-$prefix-$tmp_id", $count+1, 2, "F");
		quest::say("Thank you for the item, $name.");
	}
	if(plugin::check_handin(\%itemcount, 24956 => 1)) { #plate			
		$tmp_id = 24956;
		$prefix = "tov";
		$count = 0;
		if (defined $qglobals{"$acct_id-$prefix-$tmp_id"}) {
			$count = $qglobals{"$acct_id-$prefix-$tmp_id"};
		}
		quest::setglobal("$acct_id-$prefix-$tmp_id", $count+1, 2, "F");
		quest::say("Thank you for the item, $name.");
	}
	if(plugin::check_handin(\%itemcount, 24963 => 1)) { #chain
		$tmp_id = 24963;
		$prefix = "tov";
		$count = 0;
		if (defined $qglobals{"$acct_id-$prefix-$tmp_id"}) {
			$count = $qglobals{"$acct_id-$prefix-$tmp_id"};
		}
		quest::setglobal("$acct_id-$prefix-$tmp_id", $count+1, 2, "F");
		quest::say("Thank you for the item, $name.");
	}
	if(plugin::check_handin(\%itemcount, 24970 => 1)) { #leather
		$tmp_id = 24970;
		$prefix = "tov";
		$count = 0;
		if (defined $qglobals{"$acct_id-$prefix-$tmp_id"}) {
			$count = $qglobals{"$acct_id-$prefix-$tmp_id"};
		}
		quest::setglobal("$acct_id-$prefix-$tmp_id", $count+1, 2, "F");
		quest::say("Thank you for the item, $name.");
	}
	if(plugin::check_handin(\%itemcount, 24977 => 1)) { #silk
		$tmp_id = 24977;
		$prefix = "tov";
		$count = 0;
		if (defined $qglobals{"$acct_id-$prefix-$tmp_id"}) {
			$count = $qglobals{"$acct_id-$prefix-$tmp_id"};
		}
		quest::setglobal("$acct_id-$prefix-$tmp_id", $count+1, 2, "F");
		quest::say("Thank you for the item, $name.");
	}
	if(plugin::check_handin(\%itemcount, 24958 => 1)) { #plate			
		$tmp_id = 24958;
		$prefix = "tov";
		$count = 0;
		if (defined $qglobals{"$acct_id-$prefix-$tmp_id"}) {
			$count = $qglobals{"$acct_id-$prefix-$tmp_id"};
		}
		quest::setglobal("$acct_id-$prefix-$tmp_id", $count+1, 2, "F");
		quest::say("Thank you for the item, $name.");
	}
	if(plugin::check_handin(\%itemcount, 24965 => 1)) { #chain
		$tmp_id = 24965;
		$prefix = "tov";
		$count = 0;
		if (defined $qglobals{"$acct_id-$prefix-$tmp_id"}) {
			$count = $qglobals{"$acct_id-$prefix-$tmp_id"};
		}
		quest::setglobal("$acct_id-$prefix-$tmp_id", $count+1, 2, "F");
		quest::say("Thank you for the item, $name.");
	}
	if(plugin::check_handin(\%itemcount, 24972 => 1)) { #leather
		$tmp_id = 24972;
		$prefix = "tov";
		$count = 0;
		if (defined $qglobals{"$acct_id-$prefix-$tmp_id"}) {
			$count = $qglobals{"$acct_id-$prefix-$tmp_id"};
		}
		quest::setglobal("$acct_id-$prefix-$tmp_id", $count+1, 2, "F");
		quest::say("Thank you for the item, $name.");
	}
	if(plugin::check_handin(\%itemcount, 24979 => 1)) { #silk
		$tmp_id = 24979;
		$prefix = "tov";
		$count = 0;
		if (defined $qglobals{"$acct_id-$prefix-$tmp_id"}) {
			$count = $qglobals{"$acct_id-$prefix-$tmp_id"};
		}
		quest::setglobal("$acct_id-$prefix-$tmp_id", $count+1, 2, "F");
		quest::say("Thank you for the item, $name.");
	}
	if(plugin::check_handin(\%itemcount, 24960 => 1)) { #plate			
		$tmp_id = 24960;
		$prefix = "tov";
		$count = 0;
		if (defined $qglobals{"$acct_id-$prefix-$tmp_id"}) {
			$count = $qglobals{"$acct_id-$prefix-$tmp_id"};
		}
		quest::setglobal("$acct_id-$prefix-$tmp_id", $count+1, 2, "F");
		quest::say("Thank you for the item, $name.");
	}
	if(plugin::check_handin(\%itemcount, 24967 => 1)) { #chain
		$tmp_id = 24967;
		$prefix = "tov";
		$count = 0;
		if (defined $qglobals{"$acct_id-$prefix-$tmp_id"}) {
			$count = $qglobals{"$acct_id-$prefix-$tmp_id"};
		}
		quest::setglobal("$acct_id-$prefix-$tmp_id", $count+1, 2, "F");
		quest::say("Thank you for the item, $name.");
	}
	if(plugin::check_handin(\%itemcount, 24974 => 1)) { #leather
		$tmp_id = 24974;
		$prefix = "tov";
		$count = 0;
		if (defined $qglobals{"$acct_id-$prefix-$tmp_id"}) {
			$count = $qglobals{"$acct_id-$prefix-$tmp_id"};
		}
		quest::setglobal("$acct_id-$prefix-$tmp_id", $count+1, 2, "F");
		quest::say("Thank you for the item, $name.");
	}
	if(plugin::check_handin(\%itemcount, 24981 => 1)) { #silk
		$tmp_id = 24981;
		$prefix = "tov";
		$count = 0;
		if (defined $qglobals{"$acct_id-$prefix-$tmp_id"}) {
			$count = $qglobals{"$acct_id-$prefix-$tmp_id"};
		}
		quest::setglobal("$acct_id-$prefix-$tmp_id", $count+1, 2, "F");
		quest::say("Thank you for the item, $name.");
	}
	if(plugin::check_handin(\%itemcount, 24962 => 1)) { #plate			
		$tmp_id = 24962;
		$prefix = "tov";
		$count = 0;
		if (defined $qglobals{"$acct_id-$prefix-$tmp_id"}) {
			$count = $qglobals{"$acct_id-$prefix-$tmp_id"};
		}
		quest::setglobal("$acct_id-$prefix-$tmp_id", $count+1, 2, "F");
		quest::say("Thank you for the item, $name.");
	}
	if(plugin::check_handin(\%itemcount, 24969 => 1)) { #chain
		$tmp_id = 24969;
		$prefix = "tov";
		$count = 0;
		if (defined $qglobals{"$acct_id-$prefix-$tmp_id"}) {
			$count = $qglobals{"$acct_id-$prefix-$tmp_id"};
		}
		quest::setglobal("$acct_id-$prefix-$tmp_id", $count+1, 2, "F");
		quest::say("Thank you for the item, $name.");
	}
	if(plugin::check_handin(\%itemcount, 24976 => 1)) { #leather
		$tmp_id = 24976;
		$prefix = "tov";
		$count = 0;
		if (defined $qglobals{"$acct_id-$prefix-$tmp_id"}) {
			$count = $qglobals{"$acct_id-$prefix-$tmp_id"};
		}
		quest::setglobal("$acct_id-$prefix-$tmp_id", $count+1, 2, "F");
		quest::say("Thank you for the item, $name.");
	}
	if(plugin::check_handin(\%itemcount, 24983 => 1)) { #silk
		$tmp_id = 24983;
		$prefix = "tov";
		$count = 0;
		if (defined $qglobals{"$acct_id-$prefix-$tmp_id"}) {
			$count = $qglobals{"$acct_id-$prefix-$tmp_id"};
		}
		quest::setglobal("$acct_id-$prefix-$tmp_id", $count+1, 2, "F");
		quest::say("Thank you for the item, $name.");
	}
	if(plugin::check_handin(\%itemcount, 24957 => 1)) { #plate			
		$tmp_id = 24957;
		$prefix = "tov";
		$count = 0;
		if (defined $qglobals{"$acct_id-$prefix-$tmp_id"}) {
			$count = $qglobals{"$acct_id-$prefix-$tmp_id"};
		}
		quest::setglobal("$acct_id-$prefix-$tmp_id", $count+1, 2, "F");
		quest::say("Thank you for the item, $name.");
	}
	if(plugin::check_handin(\%itemcount, 24964 => 1)) { #chain
		$tmp_id = 24964;
		$prefix = "tov";
		$count = 0;
		if (defined $qglobals{"$acct_id-$prefix-$tmp_id"}) {
			$count = $qglobals{"$acct_id-$prefix-$tmp_id"};
		}
		quest::setglobal("$acct_id-$prefix-$tmp_id", $count+1, 2, "F");
		quest::say("Thank you for the item, $name.");
	}
	if(plugin::check_handin(\%itemcount, 24971 => 1)) { #leather
		$tmp_id = 24971;
		$prefix = "tov";
		$count = 0;
		if (defined $qglobals{"$acct_id-$prefix-$tmp_id"}) {
			$count = $qglobals{"$acct_id-$prefix-$tmp_id"};
		}
		quest::setglobal("$acct_id-$prefix-$tmp_id", $count+1, 2, "F");
		quest::say("Thank you for the item, $name.");
	}
	if(plugin::check_handin(\%itemcount, 24978 => 1)) { #silk
		$tmp_id = 24978;
		$prefix = "tov";
		$count = 0;
		if (defined $qglobals{"$acct_id-$prefix-$tmp_id"}) {
			$count = $qglobals{"$acct_id-$prefix-$tmp_id"};
		}
		quest::setglobal("$acct_id-$prefix-$tmp_id", $count+1, 2, "F");
		quest::say("Thank you for the item, $name.");
	}
	if(plugin::check_handin(\%itemcount, 24959 => 1)) { #plate			
		$tmp_id = 24959;
		$prefix = "tov";
		$count = 0;
		if (defined $qglobals{"$acct_id-$prefix-$tmp_id"}) {
			$count = $qglobals{"$acct_id-$prefix-$tmp_id"};
		}
		quest::setglobal("$acct_id-$prefix-$tmp_id", $count+1, 2, "F");
		quest::say("Thank you for the item, $name.");
	}
	if(plugin::check_handin(\%itemcount, 24966 => 1)) { #chain
		$tmp_id = 24966;
		$prefix = "tov";
		$count = 0;
		if (defined $qglobals{"$acct_id-$prefix-$tmp_id"}) {
			$count = $qglobals{"$acct_id-$prefix-$tmp_id"};
		}
		quest::setglobal("$acct_id-$prefix-$tmp_id", $count+1, 2, "F");
		quest::say("Thank you for the item, $name.");
	}
	if(plugin::check_handin(\%itemcount, 24973 => 1)) { #leather
		$tmp_id = 24973;
		$prefix = "tov";
		$count = 0;
		if (defined $qglobals{"$acct_id-$prefix-$tmp_id"}) {
			$count = $qglobals{"$acct_id-$prefix-$tmp_id"};
		}
		quest::setglobal("$acct_id-$prefix-$tmp_id", $count+1, 2, "F");
		quest::say("Thank you for the item, $name.");
	}
	if(plugin::check_handin(\%itemcount, 24980 => 1)) { #silk
		$tmp_id = 24980;
		$prefix = "tov";
		$count = 0;
		if (defined $qglobals{"$acct_id-$prefix-$tmp_id"}) {
			$count = $qglobals{"$acct_id-$prefix-$tmp_id"};
		}
		quest::setglobal("$acct_id-$prefix-$tmp_id", $count+1, 2, "F");
		quest::say("Thank you for the item, $name.");
	}

  plugin::return_items(\%itemcount);  
}