
my @group = ();
my @enemies = ();
my @encounterstrings = (); #(message, sound, type)
my $winnerList = "";
my $noTargetTicker = 0;
my $triggerradius;

sub EVENT_SPAWN{

	$triggerradius = 15;
	$rarity = 10;
	plugin::SetProx($triggerradius, 5);
	if(!defined $qglobals{"encounteractivation"}){ #set to current time (active) if not yet defined
		quest::setglobal("encounteractivation", time, 3, F);
	}
	if(!defined $qglobals{"encountertoactivate"} or $qglobals{"encountertoactivate"} == 0){ #set to 1 if not yet defined, or left at 0 somehow
		quest::setglobal("encountertoactivate", 1, 3, F);
	}
}

sub EVENT_TIMER{
	if ($timer eq "eventendcheck") {
		#see if all enemies are dead.
		foreach $enemy (@enemies) {
			$checkMob = $entity_list->GetMobID($enemy);	
			if ($checkMob && !$checkMob->IsCorpse()) { #if the mob is up
				if (!$checkMob->GetTarget()) { #if the mob has no target, do a depop counter
					$noTargetTicker++;
					if ($noTargetTicker > 300) {
						#set next activation time
						$randomtime = time + quest::ChooseRandom(1100..2100);
						quest::setglobal("encounteractivation", $randomtime, 3, F);
						return;
					}
				} else { #has a target
				#Add?
				}
				return;
			}
		}
	#db reward
	plugin::encounterReward(\@group, $winnerList, $encounterstrings[2], $zoneln);
	#set next activation time
	$randomtime = time + quest::ChooseRandom(1100..2100);
	quest::setglobal("encounteractivation", $randomtime, 3, F);
	quest::setglobal("encountertoactivate", quest::ChooseRandom(1..$qglobals{"zoneEncounters"}), 3, F);
	#initialize without respawning
	@group = ();
	@enemies = ();
	$notargetTicker = 0;
	$winnerList = "";
	quest::stoptimer("eventendcheck");
	}
}

sub EVENT_ENTER{
	
	if(time < $qglobals{"encounteractivation"}){
		return
	}
	#set entity variables for all encounter mobs
	if(!defined $npc->GetEntityVariable("myencounter")){
		my $encounterCount = 0;
		my @nlist = $entity_list->GetNPCList();
		foreach my $n (@nlist){
			#change to applicable ID
			if($n->GetNPCTypeID() == $npc->GetNPCTypeID()){
			$encounterCount++;
			plugin::SEV($n, "myencounter", $encounterCount);
			}
		}
		#amount of encounter npcs in zone
		quest::setglobal("zoneEncounters", $encounterCount, 3, F); 
	}
	
	if($qglobals{"encountertoactivate"} == $npc->GetEntityVariable("myencounter")){
		#stop additional triggers
		quest::setglobal("encountertoactivate", 0, 3, F);
		
		$c = $client;
		@group = plugin::GetGroupMembers($c);
		@enemies = plugin::AreaEncounter($c, $zoneln, \@group, $triggerradius); #assign @enemies to do endcheck locally
		@encounterstrings = plugin::encounterStrings($zoneln);
	
		#compile winnerlist
		foreach $c (@group) {
			if (!$c) { next; }
			$c->Message(13, $encounterstrings[0]);
			if ($encounterstrings[1] ne "") { $c->PlayMP3($encounterstrings[1]); }
			$winnerList .= $c->GetCleanName().", ";
		}
		$winnerList = substr $winnerList, 0, -2;
		quest::settimer("eventendcheck", 3);
	}
}