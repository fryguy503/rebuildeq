#encounter_zombie 187000

my @group;
my @groupname;
my @enemies;
my $isEventFinished = 0;
my $waveCount = 0;


sub EVENT_SPAWN {
	@group = ();
	@groupname = ();
	@enemies = ();
	$isEventFinished = 0;
	$waveCount = 0;
	quest::settimer("start", 1);
	quest::settimer("eventendcheck", 3)
}


sub EVENT_TIMER {

	if ($timer eq "eventendcheck") { #See if event is ending
		#quest::say("Finishing ".$groupname[0]);
		#is event finished?
		if (!$isEventFinished) { return; }
		#see if all enemies are dead.
		foreach $z (@enemies) {
			$checkMob = $entity_list->GetMobID($newid);	
			if ($checkMob && !$checkMob->IsCorpse()) { return; }
		}

		$winnerList = "";
    	$dbh = plugin::LoadMysql();
		for ($i = 0; $i < 6; $i++) {
			my $char_id = $npc->GetEntityVariable("member$i");
			if ($char_id < 1) { next; }
	    	$sth = $dbh->prepare("UPDATE `character_custom` SET unclaimed_encounter_rewards = unclaimed_encounter_rewards + 1 WHERE character_id = ?");
	    	$sth->execute($char_id);
	    	$winnerList .= $groupname[$i].", ";
	    }
	    $winnerList = substr $winnerList, 0, -2;
	    quest::we(13, "$winnerList successfully stopped a zombie invasion in $zoneln!");
    	$dbh->disconnect();
    	#despawn
		quest::depop();
	}

	if ($timer eq "start") { #encounter init, set variables to an easier to handle group

		quest::stoptimer("start");
		#store group details
		for ($i = 0; $i < 6; $i++) {
			my $groupsize = scalar @group;
			$c = $entity_list->GetClientByCharID($npc->GetEntityVariable("member$i"));			
			if ($c) {
				$group[$groupsize] = $c;
				$groupname[$groupsize] = $c->GetCleanName();
			}
		}
		#quest::say("Setting ".$groupname[0]);
		#spawn first wave of enemies
		foreach $c (@group) {
			if (!$c) { next; }
			$c->Message(8, "A horde of zombies begin to emerge from the ground...");
			$c->PlayMP3("bowdraw.wav");

			$newid = quest::spawn2(22046, 0, 0, $c->GetX(), $c->GetY(), $c->GetZ(), $c->GetHeading());
			if (!$newid) { next; }

			$newmob = $entity_list->GetMobID($newid);			
			if (!$newmob) { next; }
			$newnpc = $newmob->CastToNPC();
			if (!$newnpc) { next; }

			#these should move to mob
			$newnpc->SpellEffect(13); #Earth rising up effect
			$newnpc->Stun(1000);
			#$newspawn->DoAnim(110); #sit
			
			#prep mob and add to local tracker
			$zindex = scalar @enemies;
			$newnpc->AddToHateList($c, 1);
			$enemies[$zindex] = $newmob->GetID();
			quest::settimer("nexthorde", 1);			
			#quest::settimer("nexthorde", quest::ChooseRandom(1,3,6,9,12,15,20));
			#quest::say("Done");
		}
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
		my $groupsize = scalar @group;
		my $randomClient = int(rand($groupsize));
		my $c = $group[$randomClient];
		#TODO Add enemy

		#make another wave happen, potentially.
		$nextDelay = quest::ChooseRandom(1,3,6,9,12,15,20);
		quest::settimer("nexthorde", ($nextDelay + $waveCount));
	}	

}