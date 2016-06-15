#Zone: Kael Drakkal
#Short Name: kael
#Zone ID: 113
#
#NPC Name: Veldern Blackhammer
#NPC ID: 113162

sub EVENT_SAY {
  if ($faction == 1) { #requires ally Kromzek faction
    if ($text=~/hail/i) {
      quest::emote("looks around.");
      quest::doanim(12);
      quest::say("Who dares address me? Oh, it is a $race. Only a shadowknight may address me and proceed further. Are you a shadowknight? Speak, oaf! Otherwise take your prattle elsewhere.");
    }
    plugin::velious_armor_hail($text, $zoneid, $client->GetClass());    
  } else {
    quest::say("You must prove your dedication to Kael Drakkal and the Kromzek clan before I will speak to you.");
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

#END of FILE Zone: kael ID:113162 -- Veldern_Blackhammer

