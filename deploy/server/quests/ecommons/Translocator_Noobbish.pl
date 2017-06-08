sub EVENT_SAY { 
	if ($ulevel > 20) {
		quest::say("You are too experienced for me to translocate. Strap on your running shoes, adventurer.");
	}elsif($text=~/hail/i){
		quest::say("Do you wish to visit one of the starting [ ". quest::saylink("cities")." ]?");
	} elsif($text=~/cities/i) {
        quest::say("As long as you are level 20 or under, I can translocate you to the following starting cities: [ ". quest::saylink("Ak’Anon")." ] [ ". quest::saylink("Cabilis")." ] [ ". quest::saylink("Erudin")." ] [ ". quest::saylink("Felwithe")." ] [ ". quest::saylink("Freeport")." ] [ ". quest::saylink("Grobb")." ] [ ". quest::saylink("Halas")." ] [ ". quest::saylink("Kaladim")." ] [ ". quest::saylink("Kelethin")." ] [ ". quest::saylink("Neriak")." ] [ ". quest::saylink("Oggok")." ] [ ". quest::saylink("Paineel")." ] [ ". quest::saylink("Qeynos")." ] [ ". quest::saylink("Rivervale")." ] [ ". quest::saylink("Surefall Glade")." ]");
	} elsif($text=~/Ak’Anon/i) { quest::selfcast("15892");
	}
}