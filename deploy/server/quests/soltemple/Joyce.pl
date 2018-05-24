# Magician Quests

sub EVENT_SAY {
  if($text=~/hail/i) {   
    quest::say("I am Joyce of the Temple of Solusek Ro. I am the guardian of four of the items of the elementalist. If you are a magician, ask me about the [Robe of the Elements], the [Clay Bracelet], the [Earthen Boots] or the [Circlet of Mist]");
  }
  if($text=~/circlet of mist/i) {
    quest::say("The Circlet of Mist is a beautiful hoop that would look good atop your head. It produces a fine gleam, and is known to increase your mental power. Are you [interested in the circlet]?");
  }
  if($text=~/interested in the circlet/i) {
    quest::say("I will be needing the proper components to craft the circlet of mist. I will be needing a Globe of Mist which can be found on festering hags, a Water Ring from a Tidal Lord in Dagnor's Cauldron, a Ring of Evoluoy from an alligator in Feerrott, and a Sapphire, I will craft it for you.");
  }
  if($text=~/clay bracelet/i) {
    quest::say("The clay bracelet is a wonderful piece of jewelry to wear on your wrist. It provides fine protection, enhances your resistance to magic, and lets you call forth a mystic eye to help you in your travels. Are you [interested in the bracelet]?");
  }
  if($text=~/interested in the bracelet/i) {
    quest::say("I will make you a clay bracelet, but you will need to bring me the proper components. I will need each of the four runes of clay. Three of them can be found in the Rathe Mountains, held by gnomish necromancers. The fourth one is somewhere in the Ocean of Tears, held by a goblin headmaster. Bring me these four components, and I will make you a clay bracelet.");
  }
  if($text=~/earthen boots/i) {
    quest::say("Earthen Boots are a fine adornment for the feet of any Magician. They have a wonderful brown color, and are known to enhance the stamina of any Magician who wears them. As an added bonus, animals do not tend to notice those who wear Earthen Boots. Are you [interested in the boots]?");
  }
  if($text=~/interested in the boots/i) {
    quest::say("I will make you a pair of earthen boots, but you will need to retrieve for me the proper components to craft these. I will be needing a Stone Marker which can be found on a Glyphed Guard in Castle Mistmoore, a Heart of Stone from a Stone Skeleton, a pair of Soiled Boots which can be found on a froglok Tonta Knight in Guk, and a Cats Eye Agate. Bring me these items and I will craft your earthen boots.");
  }
  if($text=~/robe of the elements/i) {
    quest::say("The Robe of the Elements is a fine cloak for a Magician. It provides protection from the elements, protection from melee attacks and aids the Magician with her focus. Are you [interested in the robe]?");
  }
  if($text=~/interested in the robe/i) {
    quest::say("I will make for you the Robe of the Elements, but I will be needing the proper components. I will be needing a fire goblin skin, a frost goblin skin, a Twice-Woven Cloak which can be found on Faerie Guards in the Faydark, and a scroll of elemental armor. Return to me with these items and I will craft your robe.");
  }
}

sub EVENT_ITEM {  
  
  #Begin experience bottle turn in code.
  my $task_id = 301;
  my $activity_id = 4;
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
  
  #circlet
  if($itemcount{10545} && $itemcount{10547} && $itemcount{10034} && $itemcount{10546} == 1) {
    quest::say("You have done well. You are truly a powerful magician. Here is your Circlet of Mist.");
    quest::summonitem(2358);
    quest::faction("320","15");
    quest::faction("291","-15");
	return;
  }
  #bracelet
  if($itemcount{10539} && $itemcount{10542} && $itemcount{10540} && $itemcount{10541} == 1) {    
    quest::say("One, two, three.. all four runes of clay! I knew you looked competent. I am very impressed! Please take the Clay Bracelet that you have earned.");
    quest::summonitem(2359);
    quest::faction("320","15");
    quest::faction("291","-15");
	return;
  }
  #boots
  if($itemcount{10543} && $itemcount{10026} && $itemcount{10544} && $itemcount{2363} == 1) {
    quest::say("You have done well. You are truly a powerful magician. Here are your EarthenBoots.");
    quest::summonitem(2357);
    quest::faction("320","15");
    quest::faction("291","-15");
	return;
  }
  #robe
  if($itemcount{2361} && $itemcount{2362} && $itemcount{15109} && $itemcount{2360} == 1) {
    quest::say("You have done well. You are truly a powerful magician. Here is your Robe of the Elements.");
    quest::summonitem(1356);
    quest::faction("320","15");
    quest::faction("291","-15");
	return;
  }
  if(plugin::check_handin(\%itemcount, 2359 => 1)) {
	  quest::say("Thank you for the Clay Bracelet, $name. With this I shall create a means for you to better control your minions. Now, about those other ingredients...");
	  quest::updatetaskactivity($task_id, 3, 1);
	  return;
	}
  
  
  plugin::return_items(\%itemcount);

}

# Quest edited by mystic414

