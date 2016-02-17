sub EVENT_SAY { 
	my ($keyword, $spellid) = split / /, $text;
	
	if ($keyword eq "spell" && length $spellid > 0) {
		quest::say("Casting Spell: $spellid");
		#quest::sendspelleffect($spellid);
		$npc->SpellEffect($spellid);
	}

 }
