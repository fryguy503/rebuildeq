sub EVENT_SAY { 
	if($text=~/hail/i){
		quest::say("Do you wish to [ ". quest::saylink("bind origin")." ], or [ ". quest::saylink("bind affinity")." ] yourself here? This is a good place to attune yourself with how thick the [ ".quest::saylink("winds")."] are.");
	} elsif($text=~/bind origin/i) {
        if (quest::istaskactivityactive(307,2)) {
            quest::updatetaskactivity(307,2);    
        }
	    quest::say("Binding your origin.");
	    $client->SetStartZone(22, $client->GetX(), $client->GetY(), $client->GetZ()); 
	} elsif($text=~/bind affinity/i) {
	    quest::say("Binding your affinity.");
	    quest::selfcast(2049);
	} elsif($text=~/wind/i) {
		quest::say("Yes, the winds! You may not feel it at first but you're bathed in it. When Shadowrest was cracked open it washed Norrath in a miasma of memories. These ether winds form particularly strong in places that have deep history. This is what we attune to when we bind, we reach into your essence and find the core string at the base of your mortal coil. With a delicate touch and the right pluck we can attune you to that miasma.");
	}
}