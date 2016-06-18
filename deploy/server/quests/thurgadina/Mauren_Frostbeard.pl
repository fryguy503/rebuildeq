sub EVENT_SAY { 
  if ($faction <= 3) {     
    plugin::velious_armor_hail($text, $zoneid, $client->GetClass());
  } else {
    quest::say("You must prove your dedication before I will speak to you.");
  }
}

sub EVENT_ITEM {
  if ($faction <= 3) {
    my $cash = $copper + $silver * 10 + $gold * 100 + $platinum * 1000;
    my @armor_list = plugin::velious_armor_list();
    my $classid = $client->GetClass();

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
    quest::say("These items are not what I am looking for.");
  } else {    
    quest::say("I do not know you well enough to entrust such an item to you, yet.");
  }
  quest::givecash($copper, $silver, $gold, $platinum);
  plugin::return_items(\%itemcount);  
  return;

} 
