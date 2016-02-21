#encounter_zombie 187000

my @group;
my @enemies;
my $isEventFinished = 0;
my $waveCount = 0;
my $winnerList;
my $noTargetTicker;

my $npc1 = 37056;
my $npc2 = 37065;
my $emotemsg = "Wandering Gypsies begin to engage you.";
my $spelleffect = 0;

sub EVENT_SPAWN {
	@group = ();
	@groupname = ();
	@enemies = ();
	$isEventFinished = 0;
	$waveCount = 0;
	$notargetTicker = 0;
	$winnerList = "";
	quest::settimer("start", 1);
	quest::settimer("eventendcheck", 3)
}


sub EVENT_TIMER {

	if ($timer eq "eventendcheck") { #See if event is ending		
		#is event finished?
		if (!$isEventFinished) { return; }
		#quest::say("update");
		#see if all enemies are dead.
		foreach $z (@enemies) {
			$checkMob = $entity_list->GetMobID($newid);	
			if ($checkMob && !$checkMob->IsCorpse()) { #if the mob is up

				if (!$checkMob->GetTarget()) { #if the mob has no target, do a depop counter
					$noTargetTicker++;
					if ($noTargetTicker > 300) {
						quest::depop();
						return;
					}
				} else { #has a target
					#TODO: add root
					#my $random = int(rand(10));
					#if($random == 0) {

					#}
				}

				return;
			}
		}

		#quest::say("inject!");
    	$dbh = plugin::LoadMysql();
    	foreach $c (@group) {
	    	$sth = $dbh->prepare("UPDATE `character_custom` SET unclaimed_encounter_rewards = unclaimed_encounter_rewards + 1, unclaimed_encounter_rewards_total = unclaimed_encounter_rewards_total + 1 WHERE character_id = ?");
	    	$sth->execute($c->CharacterID());	    	
	    }
	    quest::we(13, "$winnerList successfully stopped a zombie invasion in $zoneln!");
    	$dbh->disconnect();
    	#despawn
		quest::depop();
	}

	if ($timer eq "start") { #encounter init, set variables to an easier to handle group

		quest::stoptimer("start");

		$c = $entity_list->GetClientByCharID($npc->GetEntityVariable("client"));
		if (!$c) {
			quest::depop();
			return;			
		}
		@group = plugin::GetGroupMembers($c);

		$winnerList = "";
		#spawn first wave of enemies
		foreach $c (@group) {
			if (!$c) { next; }
			#quest::say($c->CharacterID());
			$c->Message(13, $emotemsg);
			$c->PlayMP3("bowdraw.wav");


			$newid = quest::encounterspawn(quest::ChooseRandom($npc1,$npc2), $c->GetX(), $c->GetY(), $c->GetZ(), $c->GetHeading());
			if (!$newid) { next; }

			$newmob = $entity_list->GetMobID($newid);			
			if (!$newmob) { next; }
			$newnpc = $newmob->CastToNPC();
			if (!$newnpc) { next; }

			if ($spelleffect > 0) {
				$newnpc->SpellEffect(13); #Earth rising up effect	
			}

			#$newspawn->DoAnim(110); #sit
			newnpc->TempName("a_gypsy");
			
			#prep mob and add to local tracker
			$zindex = scalar @enemies;
			$newnpc->AddToHateList($c, 1);
			$enemies[$zindex] = $newmob->GetID();
			#quest::settimer("nexthorde", 1);
			$winnerList .= $c->GetCleanName().", ";
		}

		quest::settimer("nexthorde", quest::ChooseRandom(1,3,6,9,12,15,20));
		$winnerList = substr $winnerList, 0, -2;
		$waveCount = 1;
		return;
	}

	if ($timer eq "nexthorde") {
		quest::stoptimer("nexthorde");		
		$waveCount++;
		#quest::say($waveCount);
		my $dice = int(rand(5 * $waveCount));
		#quest::say($dice);
		if ($dice >= 5) { #wave2 50%, wave3 33%, wave4 25%, etc
			$isEventFinished = 1;
			return;
		}


		$newc = $entity_list->GetClientByCharID($npc->GetEntityVariable("client"));
		if (!$newc) { #if spawning target is done, stop spawning adds.
			$isEventFinished = 1;
			return;
		}

		@group = plugin::GetGroupMembers($newc);

		my $groupsize = scalar @group;
		my $randomClient = int(rand($groupsize));		
		my $c = $group[$randomClient];

		$newid = quest::encounterspawn(quest::ChooseRandom(22046,34013), $c->GetX(), $c->GetY(), $c->GetZ(), $c->GetHeading());
		if (!$newid) { next; }

		$newmob = $entity_list->GetMobID($newid);			
		if (!$newmob) { next; }
		$newnpc = $newmob->CastToNPC();
		if (!$newnpc) { next; }		

		newnpc->TempName("a_gypsy");
		if ($spelleffect > 0) {
			$newnpc->SpellEffect(13); #Earth rising up effect	
		}
		#prep mob and add to local tracker
		$zindex = scalar @enemies;
		$newnpc->AddToHateList($c, 1);
		$enemies[$zindex] = $newmob->GetID();

		#make another wave happen, potentially.
		$nextDelay = quest::ChooseRandom(1,3,6,9,12,15,20);
		quest::settimer("nexthorde", ($nextDelay + $waveCount));
	}	

}