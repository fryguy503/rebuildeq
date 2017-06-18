sub EVENT_SAY { 

	if ($text=~/brave/i) {
		quest::say("There are mysteries scattered across Norrath yet to be found. In due time, they will be revealed. (This quest line is not yet available)");
		return;
	}

	#later, once the quest is in, let's add a check for a flag to override the level lock.
	if ($ulevel > 20) {
		quest::say("You are too experienced for me to translocate. Strap on your running shoes, adventurer. That is, of course, unless you feel [ ".quest::saylink("brave enough to unlock my powers") ." ]...");
		return;
	}
			
	if ($text=~/cities/i) {
        quest::say("As long as you are level 20 or under, I can translocate you to the following starting cities:");
		quest::say("[ ". quest::saylink("Ak’Anon")." ] [ ". quest::saylink("Cabilis")." ] [ ". quest::saylink("Erudin")." ] [ ". quest::saylink("Felwithe")." ] [ ". quest::saylink("Freeport")." ] [ ". quest::saylink("Grobb")." ] [ ". quest::saylink("Halas")." ] [ ". quest::saylink("Kaladim")." ]");
		quest::say("[ ". quest::saylink("Kelethin")." ] [ ". quest::saylink("Neriak")." ] [ ". quest::saylink("Oggok")." ] [ ". quest::saylink("Paineel")." ] [ ". quest::saylink("Qeynos")." ] [ ". quest::saylink("Rivervale")." ] [ ". quest::saylink("Surefall Glade")." ]");
		return;
	}

	if ($text=~/Ak’Anon/i) { quest::movepc(55, -41.32, 50.36, 3.75); return; }
	if ($text=~/Cabilis/i) { quest::movepc(106, -400.98, 1371.57, 3.75); return; }
	if ($text=~/Erudin/i) { quest::movepc(24, -338.00, 75.00, 23.75); return; }
	if ($text=~/Felwithe/i) { quest::movepc(61, 165.94, -35.10, 3.75); return; }
	if ($text=~/Freeport/i) { quest::movepc(9, 195.73, 613.85, -32.78); return; }
	if ($text=~/Grobb/i) { quest::movepc(52, -4.66, -100.90, 3.75); return; }
	if ($text=~/Halas/i) { quest::movepc(29, 5.17, -488.39, 1.75); return; }
	if ($text=~/Kaladim/i) { quest::movepc(60, 0.99, -51.43, 3.75); return; }
	if ($text=~/Kelethin/i) { quest::movepc(54, 10.00, -20.00, -0.09); return; }
	if ($text=~/Neriak/i) { quest::movepc(40, 157.00, -3.00, 31.75); return; }
	if ($text=~/Oggok/i) { quest::movepc(49, -99.00, -345.00, 3.75); return; }
	if ($text=~/Paineel/i) { quest::movepc(75, 200.00, 800.00, 3.39); return; }
	if ($text=~/Qeynos/i) { quest::movepc(2, 87.66, 1337.03, 3.75); return; }
	if ($text=~/Rivervale/i) { quest::movepc(19, 76.45, -0.22, 3.75); return; }
	if ($text=~/Surefall Glade/i) { quest::movepc(3, 154.53, -107.49, 3.75); return; }	
	quest::say("Ahhh, yes. The history of Norrath is most intriguing, with bloodshed spattered throughout time itself. I hold the staff to teleport adventurers to their towns of birth. Do you wish to visit one of the starting [ ". quest::saylink("cities")." ]?");
}
