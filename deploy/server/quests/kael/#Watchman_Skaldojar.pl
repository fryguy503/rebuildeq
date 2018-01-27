sub EVENT_SAY { 
  my $classid = $client->GetClass();
  plugin::velious_armor_hail($text, $zoneid, $classid);
  
}

sub EVENT_ITEM {
  my $classid = $client->GetClass();
  my $cash = $copper + $silver * 10 + $gold * 100 + $platinum * 1000;
  my $slot = 0;
 

  #armor turn in
  foreach my $req (keys %itemcount) { #iterate turned in items
    if ($client->GetGM()) { quest::say("Req: $req, $zoneid, $classid"); }
    if ($req < 1) { next; }
    $reward = plugin::velious_reward_by_item($req, $zoneid, $classid);
    if ($client->GetGM()) { quest::say("RewardRet: $reward"); }
    if ($reward < 1) { next; }
    $slot = plugin::velious_slot_by_item($req, $zoneid, $classid);
    if ($slot < 1) { next; }  

    if ($cash >= (plugin::velious_pricing_by_slot($slot)*1000) && plugin::check_handin(\%itemcount, $req => 1)) {
      quest::summonitem($reward);
      quest::emote("smiles warmly as he hands you your reward.");
      quest::say("Well done, $name.");
      return;
    }
  }

  #gem turn in

  if ($cash < 200000) {
    quest::say("Not enough platinum for gem turn in");
    quest::givecash($copper, $silver, $gold, $platinum);
    plugin::return_items(\%itemcount);
    return;
  }

  if ($faction != 1 && !$client->GetGM()) {
    quest::say("I do not know you well enough to do gem interaction with you, yet. I will give you armor rewards, however.");
    quest::givecash($copper, $silver, $gold, $platinum);
    plugin::return_items(\%itemcount);  
    return;
  }
  if ($level < 60) {
    quest::say("You must be level 60 before you can turn in gems.");
    quest::givecash($copper, $silver, $gold, $platinum);
    plugin::return_items(\%itemcount);  
    return;
  }

  my $elunium = 100006;
  my $armorid = 0;
  my $gem = 0;
  my $minGem = 0;
  my $zeroGem = 101400;
  my $random = 0;
  
  if ($client->GetGM()) { quest::say("ClassID: $classid"); }  

  foreach my $req (keys %itemcount) { #iterate turned in items
    if ($req < 1) { next; }
    if ($client->GetGM()) { quest::say("Req: $req, $zoneid, $classid"); }
    if ($client->GetGM()) { quest::say("RewardRet: $reward"); }
    $minGem = plugin::velious_gem_by_armor($req, $zoneid, $classid);
    if ($minGem < 1) { next; }
    $armorid = $req;
    last;
  }

  if ($minGem < 1) {
    quest::givecash($copper, $silver, $gold, $platinum);
    plugin::return_items(\%itemcount);
    return;
  }  

  foreach my $req (keys %itemcount) { #iterate turned in items
    if ($req < 1) { next; }
    if ($req == $minGem ||
      $req == $minGem+1 ||
      $req == $minGem+2 ||
      $req == $minGem+3 ||
      $req == $minGem+4 ||
      $req == $minGem+5 ||
      $req == $minGem+6 ||
      $req == $minGem+7 ||
      $req == $minGem+8 ||
      $req == $zeroGem) {
      $gem = $req;
      last;
    }    
  }
  if ($gem < 1) {
    quest::say("I need a valid veeshan gem to upgrade.");
    quest::givecash($copper, $silver, $gold, $platinum);
    plugin::return_items(\%itemcount);  
    return;
  }

  if ($client->GetGM()) { quest::say("Gem: $gem"); }
  
  if ($client->GetGM()) { quest::say("armorid: $armorid"); }

  if ($armorid < 1) {
    quest::say("I need an unadorned armor piece to upgrade.");
    quest::givecash($copper, $silver, $gold, $platinum);
    plugin::return_items(\%itemcount);  
    return;
  }

  if (!plugin::check_handin(\%itemcount, $gem => 1, $armorid => 1, $elunium => 1)) { #if elunium, gem, armor (and cash above)
    quest::say("I need an a piece of elunium to upgrade.");
    quest::givecash($copper, $silver, $gold, $platinum);
    plugin::return_items(\%itemcount);
    return;
  }

  $random = int(rand(100))+1;

  if ($client->GetGM()) { quest::say("Rolled $random, gem is $gem"); }

  if ($gem <= $minGem+4 || $gem == $zeroGem || 
    ($gem == $minGem+5 && $random <= 60) ||
    ($gem == $minGem+6 && $random <= 40) ||
    ($gem == $minGem+7 && $random <= 20) ||
    ($gem == $minGem+8 && $random <= 9) ||
    ($gem == $minGem+9 && $random <= 4)
    ) {

    if ($gem == $zeroGem) { quest::summonitem($minGem); }
    else { quest::summonitem($gem+1); }
        
    if ($gem >= $minGem+5) { quest::say("Oh, wow... I appear to have succeeded my attempt, $name!"); }
    else { quest::say("I have succeeded with your gem, $name!"); }

  } else {
    
    quest::say("Oh, no... I appear to have failed my attempt, $name.");
    return;
  }  
  return;
} 
