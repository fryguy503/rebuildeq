sub EVENT_SAY { 
  if ($faction == 1 || $client->GetGM()) {
    plugin::velious_armor_hail($text, $zoneid, $client->GetClass());
  } else {
    quest::say("You must prove your dedication before I will speak to you.");
  }
}

sub EVENT_ITEM {
  my $cash = $copper + $silver * 10 + $gold * 100 + $platinum * 1000;
  my @armor_list = plugin::velious_armor_list();
  my $classid = $client->GetClass();

  if ($faction != 1 && !$client->GetGM()) {
    quest::say("I do not know you well enough to entrust such an item to you, yet.");
    quest::givecash($copper, $silver, $gold, $platinum);
    plugin::return_items(\%itemcount);  
    return;
  }    

  for $x (0...6) {
    my $slot = $armor_list[$zoneid][$classid][$x]{slot};
    my $item = $armor_list[$zoneid][$classid][$x]{item};
    my $reward = $armor_list[$zoneid][$classid][$x]{reward};
    #quest::say("Looking for $slot in $item for reward $reward");    
    if ($cash >= (plugin::velious_pricing_by_slot($slot)*1000) && plugin::check_handin(\%itemcount, $item => 1)) {
      quest::summonitem($reward);
      quest::emote("smiles warmly as he hands you your reward.");
      quest::say("Well done, $name.");
      plugin::velious_faction($zoneid);
      return;       
    }
  }

  if ($cash < 200000) {
    quest::say("I have no interest in these items.");
    quest::givecash($copper, $silver, $gold, $platinum);
    plugin::return_items(\%itemcount);  
    return;
  }

  my $elunium = 100006;
  my $armor = 0;
  my $armorid = 0;
  my $gem = 0;
  my $minGem = 0;
  my $zeroGem = 101400;
  my $random = 0;
  
  if ($client->GetGM()) { quest::say("ClassID: $classid"); }
  
  
  if ($classid == 3 || $classid == 8 || $classid == 1 || $classid == 5 || $classid == 2) { # SS Plate    
    @armor_list = (24961, 24956, 24958, 24960, 24962, 24957, 24959);
    $minGem = 101401;
  } elsif ($classid == 4 || $classid == 9 || $classid == 10) { # SS Chain
    @armor_list = (24968, 24963, 24965, 24967, 24969, 24964, 24966);
    $minGem = 101411;
  } elsif ($classid == 6 || $classid == 7 || $classid == 10) { # SS Leather
    @armor_list = (24975, 24970, 24972, 24974, 24976, 24971, 24973);
    $minGem = 101421;
  } else { #Silk
    @armor_list = (24982, 24977, 24979, 24981,  24983,  24978,  24980);
    $minGem = 101431;
  }


  for $gemid ($minGem...$minGem+8) {
    if (%itemcount->{$gemid} && %itemcount->{$gemid} == 1) {
      $gem = $gemid;
    }
  }
  if (%itemcount->{$zeroGem} && %itemcount->{$zeroGem} == 1) {
    $gem = $zeroGem;
  }

  if ($client->GetGM()) { quest::say("Gem: $gem"); }

  if ($gem == 0) {
    quest::say("I need a valid veeshan gem to upgrade.");
    quest::givecash($copper, $silver, $gold, $platinum);
    plugin::return_items(\%itemcount);  
    return;
  }
  
  for (my $i = 0; $i < @armor_list; $i++) {
    if (defined %itemcount->{$armor_list[$i]} && %itemcount->{$armor_list[$i]} == 1) {
      $armor = $armor_list[$i];
    }
  }

  if ($client->GetGM()) { quest::say("armor: $armor"); }

  if ($armor == 0) {
    quest::say("I need an unadorned armor piece to upgrade.");
    quest::givecash($copper, $silver, $gold, $platinum);
    plugin::return_items(\%itemcount);  
    return;
  }

  if (!plugin::check_handin(\%itemcount, $gem => 1, $armor => 1, $elunium => 1)) { #if elunium, gem, armor (and cash above)
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
    ($gem == $minGem+9 && $random <= 7)
    ) {

    if ($gem == $zeroGem) { quest::summonitem($minGem); }
    else { quest::summonitem($gem+1); }
    
    plugin::velious_faction($zoneid);
    
    if ($gem >= $minGem+5) { quest::say("Oh, wow... I appear to have succeeded my attempt, $name!"); }
    else { quest::say("I have succeeded with your gem, $name!"); }

  } else {
    
    plugin::velious_faction($zoneid);
    quest::say("Oh, no... I appear to have failed my attempt, $name.");
    return;
  }  

  return;
} 
