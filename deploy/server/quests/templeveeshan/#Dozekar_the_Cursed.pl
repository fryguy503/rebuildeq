sub EVENT_SPAWN {
  quest::setnexthpevent(80);
}

sub EVENT_HP {
  if($hpevent == 80) {
    quest::signal(999251,0);
    quest::signal(999255,0);
    quest::setnexthpevent(60);
  }
  if($hpevent == 60) {
    quest::signal(999252,0);
    quest::signal(999256,0);
    quest::setnexthpevent(40);
  }
  if($hpevent == 40) {
    quest::signal(999253,0);
    quest::signal(999254,0);
    quest::signal(999257,0);
    quest::signal(999258,0);
  }
}