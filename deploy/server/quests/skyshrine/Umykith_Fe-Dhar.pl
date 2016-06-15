#Zone: Skyshrine
#Short Name: skyshrine
#Zone ID: 114
#
#NPC Name: Umykith Fe`Dhar
#NPC ID: 114275

sub EVENT_SAY {
  if ($faction < 2) { #req ally CoV
    if($text=~/Hail/i) {
      quest::say("Hail! What news and stories have you from the New World? Perhaps if you are a bard you can spin me stories of those lands. Oh, I forget my manners. We shall exchange talk another time. You seek something, do you not? A new outfit perhaps?");
   }
    plugin::velious_armor_hail($text, $zoneid, $client->GetClass());    
  } else {
    quest::say("You must prove your dedication to the Claws of Veeshan before I will speak to you.");
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
          quest::faction(42,30); # CoV
          quest::faction(362,30); # Yelinak
          quest::faction(189,-60); # Kromzek
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

#END of FILE Zone: skyshrine ID:114275 -- Umykith Fe`Dhar