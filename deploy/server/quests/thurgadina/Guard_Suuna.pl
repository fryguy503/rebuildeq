#located near bank

sub EVENT_SAY { 
	if ($faction > 6) { # Requires indiff+
		quest::say("I do not wish to speak to you.");
		return;
	}
	if($text=~/hail/i){
		quest::say("Do you wish to [ ". quest::saylink("bind origin")." ], or [ ". quest::saylink("bind affinity")." ] yourself here?");
	} elsif($text=~/bind origin/i) {
	    quest::say("Binding your origin.");
	    $client->SetStartZone(115, $client->GetX(), $client->GetY(), $client->GetZ()); 
	} elsif($text=~/bind affinity/i) {
	    quest::say("Binding your affinity.");
	    quest::selfcast(2049);
	}
 }
