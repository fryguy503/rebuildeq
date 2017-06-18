sub EVENT_SAY {
	if($text=~/hail/i){
		if (quest::istaskactivityactive(307,6)) {
			quest::updatetaskactivity(307,6);    
		}
		quest::say("Hello, $name, my name is Vulis and I am responsible with the exchange of specialty items known as Artifacts. I barter for Artifacts, exchanging with a unique currency of Radiant Crystals. If you ever wish to part with any Artifacts you stumble upon, let me know.");
	}
 }