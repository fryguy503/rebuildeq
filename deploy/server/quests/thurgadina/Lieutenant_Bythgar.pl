sub EVENT_SAY { 
  my $classid = $client->GetClass();
  if ($faction <= 3 || $client->GetGM()) {
    plugin::velious_armor_hail($text, $zoneid, $classid);
  } else {
    quest::say("You must prove your dedication before I will speak to you.");
  }
}

sub EVENT_ITEM {
  my $classid = $client->GetClass();
  my $cash = $copper + $silver * 10 + $gold * 100 + $platinum * 1000;
  my $slot = 0;
  if ($faction > 3 && !$client->GetGM()) {
    quest::say("I do not know you well enough to entrust such an item to you, yet.");
    quest::givecash($copper, $silver, $gold, $platinum);
    plugin::return_items(\%itemcount);  
    return;
  }

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
  return;
} 
