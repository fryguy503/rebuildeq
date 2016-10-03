my $i = 0;

sub EVENT_SAY {
	if($text=~/hail/i) {
		$i++;
		$entity_list->GetMobID($mobid)->CastToNPC()->SpellEffect($i);
		quest::say($i);

  		if (int(rand(20)) == 1) {
  			quest::say("Me needs to [ " . quest::saylink("enchantz") . " ] traps for walrus...");			
  			return;
  		} else {
  			quest::say("Shh.. we hunting walrus...");
  			return;
  		}    
  	}
  	
  	if ($text=~/enchantz/i) {
  		quest::say("yes, we enchantz.. clams R yummy for clams wid it. We enchantz [ " . quest::saylink("udder stuff") . " ] too..");
  		return;
  	}

  	if ($text=~/udder stuff/i || $text=~/other stuff/i) {
  		quest::say("u know, like green things. clams. shrimp.. clams.. elfies.. orange things.. cowmeat.. caimen.. fuds.. mm.. me hungry now. Me miss [ " . quest::saylink("Oggok") . " ] some times.");
  		return;
  	}

  	if ($text=~/Oggok/i) {
  		quest::say("Oggok is da bashers home. We bash gud, we bash all night long. But, on second thoughts, tis a silly place.");
  		return;
  	}
}

sub EVENT_AGGRO {

	if (int(rand(100)) == 1) {
		quest::say("You in so big trouble now, hur hur hur! Get em big brother!");
		$newid = quest::encounterspawn(116609, $client->GetLevel(), $x+100, $y-100, $z, $h); #A killer rabbit
		$newmob = $entity_list->GetMobID($newid);
		$newnpc = $newmob->CastToNPC();
		$newnpc->TempName("Big_Brother");
		$newnpc->AddToHateList($client, 1);
		return;
	}

	if (int(rand(10)) == 1) {
		quest::say("$class basher time!");
		return;
	}

	if (int(rand(30)) == 1) {
		quest::say("you so in trouble now!");
		return;
	}

	if (int(rand(30)) == 1) {
		quest::say("Bash your head in time...");
		return;
	}

	
}

sub EVENT_ITEM {
	if(plugin::check_handin(\%itemcount, 16503 =>1)) { #enchanted bar
		quest::say("mez can enchant dis bar, me thinks.. watch dis..!");
		quest::summonitem(16507);
		$entity_list->GetMobID($mobid)->CastToNPC()->SpellEffect(22);
	}

	if(plugin::check_handin(\%itemcount, 13977 =>1)) { #carrot
		quest::say("mez can enchant dis orange thingie! magicals away!");
		quest::summonitem(100046);
		$entity_list->GetMobID($mobid)->CastToNPC()->SpellEffect(32);
	}

	if(plugin::check_handin(\%itemcount, 36206 =>1)) { #carrot 2
		quest::say("mmm.. meaty. letz see, does it blend?");
		$entity_list->GetMobID($mobid)->CastToNPC()->SpellEffect(32);
		quest::summonitem(100047);
	}

	plugin::return_items(\%itemcount);
}