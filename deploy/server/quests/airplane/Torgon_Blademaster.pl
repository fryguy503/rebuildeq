sub EVENT_SAY { 

  if($text=~/Hail/i){
    quest::say("Greetings, $name. Are you a [true warrior]?");
  }

  if($text=~/true warrior/i){
    quest::say("Then you shall be tested as one.  Choose.  Do you wish to be tested by Falorn or Ogog?");
  }

  if(($text=~/Falorn/i) && ($class eq "Warrior")){
    quest::say("I will summon him for you then.");
    quest::spawn2(71067,0,0,563.3,1392.4,-766.9,63.4);
    quest::depop();
  }
  elsif(($text=~/Ogog/i) && ($class eq "Warrior")){
    quest::say("I will summon him for you then.");
    quest::spawn2(71064,0,0,563.3,1392.4,-766.9,63.4);
    quest::depop();
  }
}


sub EVENT_ITEM {  
 

  if (plugin::check_handin(\%itemcount, 2193 => 1)) {
    quest::say("This shows your discipline.");
    return;
  }

  if (plugin::check_handin(\%itemcount, 5523 => 1)) {
    quest::say("This shows your wit.");
    return;
  }

  if (plugin::check_handin(\%itemcount, 14551 => 1)) {
    quest::say("This shows your desire.");
    return;
  }

  if (plugin::check_handin(\%itemcount, 4504 => 1)) {
    quest::say("This shows your dedication.");
    return;
  }

  if (plugin::check_handin(\%itemcount, 2346 => 1)) {
    quest::say("This shows your faith.");
    return;
  }

  if (plugin::check_handin(\%itemcount, 100001 => 1)) {
    quest::say("This shows your experience.");
    return;
  }

  plugin::return_items(\%itemcount);
}
#END of FILE Zone:airplane  ID:5039 -- Torgon_Blademaster 