sub EVENT_ITEM {
	 if (!quest::istaskactivityactive(301,5)) {
	 	plugin::return_items(\%itemcount);
	 	return;
    }
    
	if(plugin::check_handin(\%itemcount, 13977 =>1)) { #carrot
		quest::emote("enjoys the treat.");
		return;		
	}

	if(plugin::check_handin(\%itemcount, 36206 =>1)) { #carrot 2
		quest::emote("enjoyed the treat.");
		return;
	}

	if(!$entity_list->IsMobSpawnedByNpcTypeID(116610) && plugin::check_handin(\%itemcount, 100046 =>1)) { # Enchanted Carrot
		quest::emote("eyes begin to glow red as it grows sharp, crude fangs...");

		$newid = quest::encounterspawn(116610, $client->GetLevel(), $x, $y, $z, $h); #A killer rabbit
		if (!$newid) { 
			quest::emote("looks confused at his transformation.");
			return; 
		}

		$newmob = $entity_list->GetMobID($newid);			
		if (!$newmob) { 
			quest::emote("is not quite sure what just happened.");
			return;
		}

		$newnpc = $newmob->CastToNPC();
		if (!$newnpc) { 
			quest::emote("is lost for words.");
			return;
		}

		$newnpc->AddToHateList($client, 1);
		quest::depop();
		return;
	}

  plugin::return_items(\%itemcount);
}