sub EVENT_SAY { 
	if($text=~/hail/i){
		quest::say("Welcome to my beautiful haven in the tunnel linking between the Northern Desert of Ro and the East Commonlands. Would you like to hear my [ ". quest::saylink("story")." ] about how this place came to be?");
	} elsif($text=~/story/i) {
	    quest::say("A few years ago I set up shop here after being disgusted with the unfair taxes in Freeport. I had no bias of race or affinity, and slowly adventurers found me and this little cave to be a great place to sit back and barter without the pressures of the corrupt nearby town causing them strife. The bartering thrived, and this area grew to what you see today. Beautiful, isn't it?");
	}
}
