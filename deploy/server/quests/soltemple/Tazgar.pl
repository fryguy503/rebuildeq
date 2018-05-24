sub EVENT_SAY {
}

sub EVENT_ITEM {

#Begin experience bottle turn in code.
  my $task_id = 308;
  my $activity_id = 9;
  my $bottle_goal = 5;
  my $bottle_message = "Thank you for your potion of experience, $name.";
  my $bottle_task_active = quest::istaskactivityactive($task_id, $activity_id);
  my $bottles_previously_turned_in = quest::gettaskactivitydonecount($task_id, $activity_id);
  my $bottles_turned_in = 0;
  
  if ($item1 == 100001 && $item1_charges >= 1){
        $bottles_turned_in += $item1_charges;
  }
  if ($item2 == 100001 && $item2_charges >= 1){
		$bottles_turned_in += $item2_charges;
  }
  if ($item3 == 100001 && $item3_charges >= 1){
		$bottles_turned_in += $item3_charges;
  }   
  if ($item4 == 100001 && $item4_charges >= 1){
		$bottles_turned_in += $item4_charges;
  }
      
  my $bottle_new_total = $bottles_previously_turned_in + $bottles_turned_in;
  if($bottle_task_active == 1 && $bottle_new_total <= $bottle_goal) {
	if(plugin::check_handin(\%itemcount, 100001 => 1)) {
	  quest::say($bottle_message);
	  $client->Message(15,"You received credit for turning in ". $bottles_turned_in . " full experience bottle(s).");
	  quest::updatetaskactivity($task_id, $activity_id, $bottles_turned_in);
	  return;
	}
	if(plugin::check_handin(\%itemcount, 100001 => 2)) {
	  quest::say($bottle_message);
  	  $client->Message(15,"You received credit for turning in ". $bottles_turned_in . " full experience bottle(s).");
	  quest::updatetaskactivity($task_id, $activity_id, $bottles_turned_in);
	  return;
	}
	if(plugin::check_handin(\%itemcount, 100001 => 3)) {
	  quest::say($bottle_message);
	  $client->Message(15,"You received credit for turning in ". $bottles_turned_in . " full experience bottle(s).");
	  quest::updatetaskactivity($task_id, $activity_id, $bottles_turned_in);
	  return;
	}
	if(plugin::check_handin(\%itemcount, 100001 => 4)) {
	  quest::say($bottle_message);
	  $client->Message(15,"You received credit for turning in ". $bottles_turned_in . " full experience bottle(s).");
	  quest::updatetaskactivity($task_id, $activity_id, $bottles_turned_in);
	  return;
	}
  }
#End experience bottle turn in code.

  plugin::return_items(\%itemcount);
} 

# EOF zone: soltemple ID: 80022 NPC: Tazgar