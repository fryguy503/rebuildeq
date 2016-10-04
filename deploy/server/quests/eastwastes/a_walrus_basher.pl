sub EVENT_SAY {
	if($text=~/hail/i) {
  		if (int(rand(20)) == 1) {
  			quest::say("Me needs to [ " . quest::saylink("enchantz") . " ] traps for walrus...");			
  			return;
  		} else {
  			quest::say("Shh.. we hunting walrus...");
  			return;
  		}    
  	}

  	if ($text=~/walrus/i) {
  		quest::say("da walrus r yummy. Giants like dem too. We eats them lots, you should too. It's good!");
  		return;
  	}
  	
  	if ($text=~/enchantz/i) {
  		quest::say("yes, we enchantz.. enchanted clams R yummy for trap walrus wid it. We enchantz [ " . quest::saylink("udder stuff") . " ] too..");
  		return;
  	}

  	if ($text=~/udder stuff/i || $text=~/other stuff/i) {
  		quest::say("u know, like green things. clams. shrimp.. elfies.. orange things.. cowmeat.. caimen.. clams.. fuds.. mm.. me hungry now. Me miss [ " . quest::saylink("Oggok") . " ] some times.");
  		return;
  	}

  	if ($text=~/oggok/i) {
  		quest::say("Oggok is da [ ". quest::saylink("bashers") . " ] home. We bash gud, we bash all night long. But, on second thoughts, tis a silly place.");
  		return;
  	}

  	if ($text=~/bashers/i) {
  		quest::say("Bashers r da best! Nobody stronger than they. we be favorite of [" . quest::saylink("Rallos Zek") . " ], and be da great warrior ever. More stronger than all.");
  		return;
  	}

  	if ($text=~/rallos zek/i) {
  		quest::say("Rallos Zek is strong. u know, he talks about his creaturez a lot. He likes to tell us chapter stories and chapters about stuffs. We calls it the [ " . quest::saylink("Doctrine") . " ].");
  		return;
  	}

  	if ($text=~/doctrine/i) {
  		quest::say("Doctrine, u know.. oh wait.. uh oh... I was not to tell secrets.. but, it's ok, da first chapter is wid us. All Us Ogres keep it secret. Shh. You don't know this though.");
  		return;
  	}

  	if ($text=~/know/i) {
  		quest::say("You know nothing, we know everything, hur hur.. be rallos zek, be strong.");
  		return;
  	}

  	if ($race=~/ogre/i) {
  		quest::say("Hey! You ogres too! Come hunt, we kill lots of walrus. It's fun. You bash. They smash. Weeee!");
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