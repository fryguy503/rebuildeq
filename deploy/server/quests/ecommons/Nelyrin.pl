sub EVENT_SAY { 
	if ($ulevel > 20) {
		quest::say("You are too experienced for me to translocate. Strap on your running shoes, adventurer.");
	} elsif($text=~/hail/i){
		quest::say("Do you wish to visit one of the starting [ ". quest::saylink("cities")." ]?");
	} elsif($text=~/cities/i) {
        quest::say("As long as you are level 20 or under, I can translocate you to the following starting cities:");
		quest::say("[ ". quest::saylink("Ak’Anon")." ] [ ". quest::saylink("Cabilis")." ] [ ". quest::saylink("Erudin")." ] [ ". quest::saylink("Felwithe")." ] [ ". quest::saylink("Freeport")." ] [ ". quest::saylink("Grobb")." ] [ ". quest::saylink("Halas")." ] [ ". quest::saylink("Kaladim")." ]");
		quest::say("[ ". quest::saylink("Kelethin")." ] [ ". quest::saylink("Neriak")." ] [ ". quest::saylink("Oggok")." ] [ ". quest::saylink("Paineel")." ] [ ". quest::saylink("Qeynos")." ] [ ". quest::saylink("Rivervale")." ] [ ". quest::saylink("Surefall Glade")." ]");
	} elsif($text=~/Ak’Anon/i) { quest::movepc(55, -41.32, 50.36, 3.75);
	} elsif($text=~/Cabilis/i) { quest::movepc(106, -400.98, 1371.57, 3.75);
	} elsif($text=~/Erudin/i) { quest::movepc(24, -338.00, 75.00, 23.75);
	} elsif($text=~/Felwithe/i) { quest::movepc(61, 165.94, -35.10, 3.75);
	} elsif($text=~/Freeport/i) { quest::movepc(9, 195.73, 613.85, -32.78);
	} elsif($text=~/Grobb/i) { quest::movepc(52, -4.66, -100.90, 3.75);
	} elsif($text=~/Halas/i) { quest::movepc(29, 5.17, -488.39, 1.75);
	} elsif($text=~/Kaladim/i) { quest::movepc(60, 0.99, -51.43, 3.75);
	} elsif($text=~/Kelethin/i) { quest::movepc(54, 10.00, -20.00, -0.09);
	} elsif($text=~/Neriak/i) { quest::movepc(40, 157.00, -3.00, 31.75);
	} elsif($text=~/Oggok/i) { quest::movepc(49, -99.00, -345.00, 3.75);
	} elsif($text=~/Paineel/i) { quest::movepc(75, 200.00, 800.00, 3.39);
	} elsif($text=~/Qeynos/i) { quest::movepc(2, 87.66, 1337.03, 3.75);
	} elsif($text=~/Rivervale/i) { quest::movepc(19, 76.45, -0.22, 3.75);
	} elsif($text=~/Surefall Glade/i) { quest::movepc(3, 154.53, -107.49, 3.75);
	}
}