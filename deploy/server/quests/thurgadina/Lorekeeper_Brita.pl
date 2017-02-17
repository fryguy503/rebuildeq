sub EVENT_SAY { 
  if ($faction <= 3) {     
    plugin::velious_armor_hail($text, $zoneid, $client->GetClass());
  } else {
    quest::say("You must prove your dedication before I will speak to you.");
  }
}

sub EVENT_ITEM {

	if(plugin::check_handin(\%itemcount, 1427 => 1, 1417 => 1)) {
		quest::say("Ohh, that's better. I get so touchy when I'm hungry. I should probably go apologize to Derrin for being snappy. Please return this to Mordin for me.");
		quest::summonitem(1424);
		quest::exp(150000);
		quest::faction(49,20); # coldain
		quest::faction(67,20); # Dain Frostreaver IV
		quest::faction(188,-60); # Kromrif
		quest::faction(189,-60); # Kromzek
		return;
	}
	elsif (plugin::check_handin(\%itemcount, 1427 => 1)) {
		quest::say("Ohh, that's better. I get so touchy when I'm hungry. I should probably go apologize to Derrin for being snappy.");
		quest::exp(5000);
		return;
	}

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
