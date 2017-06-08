sub EVENT_SAY { 
	if ($ulevel > 20) {
		quest::say("You are too experienced for me to translocate. Strap on your running shoes, adventurer.");
	}elsif($text=~/hail/i){
		quest::say("Do you wish to visit one of the starting [ ". quest::saylink("cities")." ]?");
	} elsif($text=~/cities/i) {
        quest::say("As long as you are level 20 or under, I can translocate you to the following starting cities:");
		quest::say("[ ". quest::saylink("Ak’Anon")." ] [ ". quest::saylink("Cabilis")." ] [ ". quest::saylink("Erudin")." ] [ ". quest::saylink("Felwithe")." ] [ ". quest::saylink("Freeport")." ] [ ". quest::saylink("Grobb")." ] [ ". quest::saylink("Halas")." ] [ ". quest::saylink("Kaladim")." ]");
		quest::say("[ ". quest::saylink("Kelethin")." ] [ ". quest::saylink("Neriak")." ] [ ". quest::saylink("Oggok")." ] [ ". quest::saylink("Paineel")." ] [ ". quest::saylink("Qeynos")." ] [ ". quest::saylink("Rivervale")." ] [ ". quest::saylink("Surefall Glade")." ]");
	} elsif($text=~/Ak’Anon/i) { quest::selfcast("15892");
	} elsif($text=~/Cabilis/i) { quest::selfcast("2064");
	} elsif($text=~/Erudin/i) { quest::selfcast("2290");
	} elsif($text=~/Felwithe/i) { quest::selfcast("543"); #not working, gfay wiz is closest
	} elsif($text=~/Freeport/i) { quest::selfcast("547"); #not working, nro wiz is closest
	} elsif($text=~/Grobb/i) { quest::selfcast("535"); #not working, sro druid closest
	} elsif($text=~/Halas/i) { quest::selfcast("4180"); #not working, everfrost is closest
	} elsif($text=~/Kaladim/i) { quest::selfcast("2280"); #not working, butcher docks is closest
	} elsif($text=~/Kelethin/i) { quest::selfcast("543"); #not working, gfay wiz is closest
	} elsif($text=~/Neriak/i) { quest::selfcast("545"); #not working, nek wiz is closest
	} elsif($text=~/Oggok/i) { quest::selfcast("536"); #not working, feerrott druid is closest
	} elsif($text=~/Paineel/i) { quest::selfcast("541"); #no paineel port, tox wiz is closest
	} elsif($text=~/Qeynos/i) { quest::selfcast("2021"); #not working, surefall glade druid is closest
	} elsif($text=~/Rivervale/i) { quest::selfcast("538"); #not working, misty druid is closest
	} elsif($text=~/Surefall Glade/i) { quest::selfcast("2021");
	}
}