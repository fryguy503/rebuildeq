sub EVENT_SAY { 
	if($text=~/hail/i){
		quest::say("Greetings ${name}. Insert Lore Dialog Here. You may wish to [ ". quest::saylink("Bind")." ] your origin here.");
	} elsif($text=~/bind/i) {
	    quest::say("Binding your origin.");
	    $client->SetStartZone(22, $client->GetX(), $client->GetY(), $client->GetZ()); 
	}
 }
