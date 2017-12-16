my $triggerdistance = 25; #trigger distance
my $spellid = 91; #spell to cast on trigger
my $activationtimer = 4; #seconds until trap activates
my $depoptimer = 30; #seconds until trap depops without activation

sub EVENT_SPAWN{
	quest::npcsize(3.5);
	$npc->SetRace(503); #bear trap
	$npc->SetBodyType(11); #notarget
	quest::settimer("activate", $activationtimer);
	quest::settimer("depop", $depoptimer);#in case the trap is never triggered
}

sub EVENT_TIMER{
	if($timer eq "trapcheck"){
		my @npclist = $entity_list->GetNPCList();
		my $npcsaffected = 0;
		foreach $othernpc(@npclist){ #iterate npc's, find npcs that are in range
			if ($othernpc->GetID() == $npc->GetID()){next;} #dont count the trap mob as an npc to cast on
			if ($othernpc->GetOwnerID() && $entity_list->GetClientByID($othernpc->GetOwnerID)) {next;} #dont cast on players pets
			$dist = $npc->CalculateDistance($othernpc->GetX(), $othernpc->GetY(), $othernpc->GetZ()); 
			if ($dist < $triggerdistance){
				$npc->SpellFinished($spellid, $othernpc);
				$npcsaffected++; #increment amount of npc's we cast on to depop trap
			}
		}
		if($npcsaffected > 0){ #will continue to check for npcs unless has been activated
			quest::stoptimer("trapcheck");
			quest::stoptimer("depop");
			quest::depop();
		}
	}
	
	if($timer eq"activate"){
		quest::settimer("trapcheck", 1);
		quest::stoptimer("activate");
	}
	
	if ($timer eq "depop"){
		quest::depop();
	}
}