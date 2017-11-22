#encounter_zombie 187000

my @group;
my @enemies;
my $isEventFinished = 0;
my $waveCount = 0;
my $winnerList;
my $noTargetTicker;

my $encounterMessage = "Griffins begin to swoop down.";
my $encounterSound = "";
my $encounterType = "a flock of griffins";
my $spelleffect = 0;
my $commonNpcID = 13002;
my $rareNpcID = 15041;
my $rareName = "An_enraged_griffin";
my $isRare = 0;
my $rarity = 10; #chance of rare spawn
my $npcName1 = "a_griffon";
my $npcName2 = "a_griffawn";
my $npcName3 = "a_griffin";

sub EVENT_SPAWN {
	@group = ();
	@groupname = ();
	@enemies = ();
	$isEventFinished = 0;
	$waveCount = 0;
	$notargetTicker = 0;
	$winnerList = "";
	quest::settimer("start", 1);
	quest::settimer("eventendcheck", 3);
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

    	$dbh = plugin::LoadMysql();
    	if (!$dbh) {
    		quest::say("Failed to load MySQL... Tell Shin wtfm8! $winnerList");
    		return;
    	}
    	foreach $c (@group) {
	    	$sth = $dbh->prepare("UPDATE `account_custom` SET unclaimed_encounter_rewards = unclaimed_encounter_rewards + 1, unclaimed_encounter_rewards_total = unclaimed_encounter_rewards_total + 1 WHERE account_id = ?");
	    	$sth->execute($c->AccountID());	    	
	    }
	    if ($isRare == 1) {
			quest::we(13, "$winnerList successfully stopped $encounterType in $zoneln!");
	    } else {
	    	quest::we(13, "$winnerList successfully stopped $encounterType in $zoneln!");
		}
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

		#is it rare or not?
		$isRare = 0;
		my $random = int(rand(100));
		if ($random <= $rarity) {
			$npcid = $rareNpcID;
			$isRare = 1;
		} else {
			$npcid = $commonNpcID;
			$isRare = 0;
		}
		$isRareSpawned = 0;


		#spawn first wave of enemies
		foreach $c (@group) {
			if (!$c) { next; }
			#quest::say($c->CharacterID());
			$c->Message(13, $encounterMessage);
			if ($encounterSound ne "") { $c->PlayMP3($encounterSound); }
			$winnerList .= $c->GetCleanName().", ";

			if ($isRareSpawned == 1) { next; }

			$npclevel = $c->GetLevel();
			if ($isRare == 1) {
				$groupsize = scalar @group;
				$npclevel += $groupsize;
				$isRareSpawned = 1;
			}

			#add enemy
			$newid = quest::encounterspawn($npcid, $npclevel, $c->GetX(), $c->GetY(), $c->GetZ(), $c->GetHeading());
			if (!$newid) { next; }

			$newmob = $entity_list->GetMobID($newid);			
			if (!$newmob) { next; }
			$newnpc = $newmob->CastToNPC();
			if (!$newnpc) { next; }

			if ($isRare == 0) { $newnpc->TempName(quest::ChooseRandom($npcName1, $npcName2, $npcName3)); }
			if ($spelleffect > 0 ) { $newnpc->SpellEffect($spelleffect); }
			
			#prep mob and add to local tracker
			$zindex = scalar @enemies;
			$newnpc->AddToHateList($c, 1);
			$enemies[$zindex] = $newmob->GetID();
			#quest::settimer("nexthorde", 1);
		}
		
		
		$winnerList = substr $winnerList, 0, -2;
		$waveCount = 1;
		if ($isRare == 1) {	
			$isEventFinished = 1;
		} else {
			quest::settimer("nexthorde", 3);
		}
		return;
	}

	if ($timer eq "nexthorde") {
		quest::stoptimer("nexthorde");
		$waveCount++;

		my $dice = int(rand(5 * $waveCount));

		if ($dice >= 5) { #wave2 50%, wave3 33%, wave4 25%, etc
			$isEventFinished = 1;
			return;
		}

		if ($waveCount > 3) {
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

		my $level = $c->GetLevel() - quest::ChooseRandom(0,5);
		if ($level < 1) {
			$level = 1;
		}

		$newid = quest::encounterspawn($commonNpcID, $level, $c->GetX(), $c->GetY(), $c->GetZ(), $c->GetHeading());
		if (!$newid) { next; }

		$newmob = $entity_list->GetMobID($newid);			
		if (!$newmob) { next; }
		$newnpc = $newmob->CastToNPC();
		if (!$newnpc) { next; }		
		if ($isRare == 0) { $newnpc->TempName(quest::ChooseRandom($npcName1, $npcName2, $npcName3)); }
		if ($spelleffect > 0 ) { $newnpc->SpellEffect($spelleffect); }

		#prep mob and add to local tracker
		$zindex = scalar @enemies;
		$newnpc->AddToHateList($c, 1);
		$enemies[$zindex] = $newmob->GetID();

		#make another wave happen, potentially.
		$nextDelay = 3;
		quest::settimer("nexthorde", ($nextDelay + $waveCount));
	}	

}