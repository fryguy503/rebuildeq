# Quest for Captain_Njall in Thurgadina - Warrior Velious Armor (Champion's) 
# Kiladiveus - created Sub EVENT_SAY and Sub EVENT_ITEM for quest. Used Faction requirement method. 

sub EVENT_SAY { 
  if ($faction <= 3) { # Require Warmly and greater faction    
    if($text=~/Hail/i){
      quest::say("Well met, $race! I am Captain Njall, commander of the city gaurds here in Thurgadin. If ye seek ta join our ranks, I welcome ye with open arms and have an offer to make if you are interested. If ye seek to be our enemy, I hope ye can run swifter than my archers arrows.");
    }
    plugin::velious_armor_hail($text, $zoneid, $client->GetClass());    
  } else {
    quest::say("You must prove your dedication before I will speak to you.");
  }
}

sub EVENT_ITEM {
  if ($faction == 1) { #req ally CoV 

    my $cash = $copper + $silver * 10 + $gold * 100 + $platinum * 1000;
    my @armor_list = plugin::velious_armor_list();
    my $classid = $client->GetClass();

    for $x (0...6) {
      $slot = $armor_list[$zoneid][$classid][$x]{slot};
      $item = $armor_list[$zoneid][$classid][$x]{item};
      $reward = $armor_list[$zoneid][$classid][$x]{reward};
      quest::say("Looking for $slot in $item for reward $reward");    
      if ($cash >= (plugin::velious_pricing_by_slot($slot)*1000) && plugin::check_handin(\%itemcount, $item => 1)) {
          quest::summonitem($reward);
          quest::emote("smiles warmly as he hands you your reward.");
          quest::say("Well done, $name.");
          quest::exp(175000);
          quest::faction(179,20); # King Tormax
          quest::faction(189,20); # Kromzek
          quest::faction(42,-20); # Claws of Veeshan
          quest::faction(49,-60); # Coldain
          return;       
      }
    }
    quest::say("These items are not what I am looking for.");
  } else {    
    quest::say("I do not know you well enough to entrust such an item to you, yet.");
  }
  quest::givecash($copper, $silver, $gold, $platinum);
  plugin::return_items(\%itemcount);  
  return;
} 


#END of FILE Zone:thurgadina  ID:115114 -- Captain_Njall 
 
