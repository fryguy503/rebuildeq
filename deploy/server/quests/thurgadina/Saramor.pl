sub EVENT_SAY {
	if ($text=~/special/i) {
        quest::say("Find me a pure frozen core and hand it to me, we'll see from there.");
        return;
    }    
    if ($text=~/smile/i) {
        quest::say("I'm smiling at you. I wanted to tell you about ".quest::saylink("something special")." I have to offer.");
        return;
    }    
    quest::emote("winks at you with a smile.");
}

sub EVENT_ITEM {
  if (plugin::check_handin(\%itemcount, 100085 => 4)) { #hand a pure frozen core
    quest::emote("looks left and right, then takes the pure frozen core from your hands.")
    quest::say("Nobody saw this transaction, do you hear me?.");
    quest::summonitem(100086);
    
    # Factions: +Coldain, +Dain Frostreaver IV, -Kromrif, -Kromzek
    quest::faction(49, 30);
    quest::faction(67, 30);
    quest::faction(188, -30);
    quest::faction(189, -30);
  }
}

sub EVENT_SIGNAL {
	if($signal==1) {
		quest::say("Blasphemer!");
	}
	if($signal==2) {
		quest::say("Get him boys!");
	}
	if($signal==3) {
		quest::SetRunning(1);
		quest::start(6);
	}
	if($signal==4) {
		quest::say("Well, don't ya just keep us in suspense now. What in the world was it?");
		quest::signalwith(115011,4,8000);
		quest::signalwith(115187,4,8000);
	}
}

sub EVENT_WAYPOINT_ARRIVE {
	if($wp==4) {
		quest::SetRunning(0);
	}
	if($wp==9) {
		quest::stop();
		quest::say("So good to see you, Rumagur. I hope you're feelin better today.");
		quest::signalwith(115011,3,8000);
		quest::signalwith(115187,3,8000);
	}
}

