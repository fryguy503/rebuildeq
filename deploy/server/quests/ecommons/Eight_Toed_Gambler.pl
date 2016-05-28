################## SPEECH CODE ##################

sub EVENT_SAY {
	if ($qglobals{"roll"}> 0 &&  $qglobals{"bet"} > 0) {
		if($text =~ /Hail/i) {
			quest::say("[ ". quest::saylink("first")." ], [ ". quest::saylink("second")." ], [ ". quest::saylink("third")." ], [ ". quest::saylink("fourth")." ], [ ". quest::saylink("fifth")." ], [ ". quest::saylink("sixth")." ]");
			return;
		} elsif ($text =~ /first/i) {
			$bet = 1;			
		}  elsif ($text =~ /second/i) {
			$bet = 2;			
		}  elsif ($text =~ /third/i) {
			$bet = 3;	
		}  elsif ($text =~ /fourth/i) {
			$bet = 4;	
		}  elsif ($text =~ /fifth/i) {
			$bet = 5;	
		}  elsif ($text =~ /sixth/i) {
			$bet = 6;	
		}

		if ($bet > 0 && $bet == $qglobals{"roll"}) {
			$cash = $qglobals{"bet"} * 10;
			quest::say("You won! Congrats, I'll give you 10 times your money");
			$copper = ($cash % 10);
			$cash -= $copper;
			$silver = ($cash % 100)/10;
			$cash -= $silver;
			$gold = ($cash % 1000)/100;
			$cash -= $gold;
			$platinum = ($cash % 10000)/1000;
			
			#quest::say("$platinum p $gold g $silver s $copper c");
			quest::givecash($copper, $silver, $gold, $platinum); #Return money;
			quest::setglobal("roll", 0, 0, "F");
			quest::setglobal("bet", 0, 0, "F");
		} else {
			quest::say("Nope, wrong one.. Better luck next time.");
			quest::setglobal("roll", 0, 0, "F");
			quest::setglobal("bet", 0, 0, "F");
		}
		return;
	}

	quest::say("The game is simple, my friend.. I shuffle these cups with a ball under one, and you try to guess which has it. Hand me money to get started.");
	

}

################### ITEM CODE ##################

sub EVENT_ITEM {
	plugin::return_items(\%itemcount);

	if ($qglobals{"roll"}> 0 &&  $qglobals{"bet"} > 0) {
		quest::say("You still have a bet going on");
		return;
	}
	
	#quest::say("You gave me $platinum $gold $silver $copper");
	my $cash = $copper + $silver * 10 + $gold * 100 + $platinum * 1000;	
	#quest::say("That's $cash total money");	

	if ($cash < 1) {
		quest::say("I only accept money");
		return;
	}
	quest::setglobal("roll", quest::ChooseRandom(1,2,3,4,5,6), 0, "F");
	quest::setglobal("bet", $cash, 0, "F");
	#quest::say("Bets are in!");
	#quest::emote("shuffles the cups on the wooden box");
	quest::say("[ ". quest::saylink("first")." ], [ ". quest::saylink("second")." ], [ ". quest::saylink("third")." ], [ ". quest::saylink("fourth")." ], [ ". quest::saylink("fifth")." ], [ ". quest::saylink("sixth")." ]");
}

#EOF -- ZONE: ecommons -- NAME: Bubar -- ID: 22033


