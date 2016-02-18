#encounter_zombie 187000

my @group;

sub EVENT_SPAWN {	
	quest::settimer("start", 1);
}

sub EVENT_SAY {
	
	foreach $c (@group) {
		if (!$c) {
			next;
		}
		$c->Message(8, "A horde of zombies begin to emerge from the ground...");
		$c->PlayMP3("bowdraw.wav");
		$newid = quest::spawn2(22046, 0, 0, $c->GetX(), $c->GetY(), $c->GetZ(), $c->GetHeading());
		$newspawn = $entity_list->GetMobID($newid)->CastToNPC();		
		quest::say($newspawn);
		
		#quest::pause(1);
		if ($newspawn) {
			$newspawn->SpellEffect(13); #Earth rising up effect
			$newspawn->DoAnim(110); #sit
			$newspawn->Stun(1);
		#	$newspawn->AddToHateList($c, 1);
		}
	}
	#quest::say($group[0]->CleanName());
	#$group[0]->CastToClient()->Message(0,"SPLAT! Your victim is covered in a warm gooey squash pie.");

	#plugin::MessageGroup($group[0]);

	#$clientid = $npc->GetEntityVariable("member0");
	#quest::say("Getting client $clientid");
	#$newclient = $entity_list->GetClientByID($clientid);	
	#quest::say($newclient->GetClass());
}

sub EVENT_TIMER {

	if ($timer eq "start") { #encounter init, set variables to an easier to handle group
		quest::stoptimer("start");
		for ($i = 0; $i < 6; $i++) {
			quest::say($i);
			$group[$i] = $entity_list->GetClientByCharID($npc->GetEntityVariable("member$i"));			
		}
		return;
	}
}