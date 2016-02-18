#encounter_zombie 187000

my @group;
my @enemies;
my $isEventFinished = 0;
my $waveCount = 0;

sub EVENT_SPAWN {	
	quest::settimer("start", 1);
	quest::settimer("eventendcheck", 3)
}


sub EVENT_TIMER {

	if ($timer eq "eventendcheck") { #See if event is ending
		#is event finished?
		if (!$isEventFinished) { return; }
		#see if all enemies are dead.
		foreach $z (@enemies) {
			if ($z && !$z->IsDead()) { next; }
		}
		#give out reward.

		#Bye!
		quest::depop();
	}

	if ($timer eq "start") { #encounter init, set variables to an easier to handle group
		quest::stoptimer("start");
		#store group details
		for ($i = 0; $i < 6; $i++) {
			my $groupsize = scalar @group;
			quest::say($i);
			$c = $entity_list->GetClientByCharID($npc->GetEntityVariable("member$i"));			
			if ($c) {
				$group[$groupsize] = $c;
			}
		}
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
			$newnpc->Stun(1);
			#$newspawn->DoAnim(110); #sit
			
			#prep mob and add to local tracker
			$zindex = scalar @enemies;	
			$newnpc->AddToHateList($c, 1);
			$enemies[$zindex] = $newspawn;
			quest::settimer("nexthorde", quest::ChooseRandom(1,3,6,9,12,15,20));
		}
		$waveCount = 1;
		return;
	}

	if ($timer eq "nexthorde") {
		quest::stoptimer("nexthode");
		$waveCount++;
		if (int(rand(5 * waveCount)) > 5) { #wave2 50%, wave3 33%, wave4 25%, etc
			$isEventFinished = 1;
			return;
		}
		my $groupsize = scalar @group;
		my $randomClient = int(rand($groupsize));
		my $c = $group[$randomClient];
		#TODO Add enemy

		#make another wave happen, potentially.
		quest::settimer("nexthorde", quest::ChooseRandom(1,3,6,9,12,15,20));
	}	

}