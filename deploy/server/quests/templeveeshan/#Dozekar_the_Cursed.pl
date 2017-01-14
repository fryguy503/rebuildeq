
sub EVENT_SPAWN {
  $SpawnX = $x;
  $SpawnY = $y;
  $SpawnZ = $z;
  $SpawnH = $h;
  quest::set_proximity($x - 50, $x + 106, $y - 113, $y + 122);
  quest::say("Spawn");
}

sub EVENT_COMBAT
{
  if($combat_state == 0)
  {
    #out of combat
    $npc->SetHP(1520000); #max hp
    quest::stoptimer("check_leash");
  }
  elsif($combat_state == 1)
  {
    #in combat
    quest::say("And so begins the test.");
    quest::settimer("CheckLeash", 1);
    quest::setnexthpevent(90);
    $hasAdds = 0;
    #my @add_list = (124019, 124069, 124065);
    #for (my $i = 0; $i < @add_list; $i++) {
    #  #quest::say($add_list[$i]);
    #  my $addID = $entity_list->GetMobByNpcTypeID($add_list[$i]);
    #  if (!$addID) continue;
    #  my $addnpc = $addID->CastToNPC();
    #  if ($!addnpc) continue;
    #  $addnpc->AddToHateList($client, 1);
    #  $hasAdds = 1;      
    #}
    
    if ($hasAdds) {
      quest::say("You are not worthy to face me alone, let us make this fight interesting, shall we, $name?");
    }
  }
}


sub EVENT_ENTER {
  quest::say("Hello, there, $name");
  $npc->AddToHateList($client, 1);
}

#sub EVENT_EXIT {
#  quest::say("ENOUGH, $name! Cowards will not be tolerated. Begone.");
#  quest::movepc(120, 695, 1365, -196.60);
#}

sub EVENT_TIMER {

  $leashedID = $entity_list->GetMobByNpcTypeID(124037);
  if ($timer eq "check_leash") {
    if (!$leashedID || $leashedID->IsCorpse()) { #if the mob isn't up      
      return;
    }

    if ($x > -1100 || $y > -950 || $y < -1200) {
      $leashedID->GMMove($SpawnX, $SpawnY, $SpawnZ, $SpawnH);
    }
    quest::settimer("check_leash",1);
  }
}

sub EVENT_AGGRO {
  quest::say("Aggro");
  my @hatelist = $npc->GetHateList();
  $playerCount = 0;
  foreach $hent (@hatelist) {
    if(!$hent) { 
      continue;
    }

    my $ent = $hent->GetEnt();
    if(!$ent) {
      continue;
    }
    if (!$enter->IsClient()) {
      continue;
    }

    $playerCount++;
    #my $ent_name = $h_ent->GetCleanName();
  }

  quest::say("Playercount: $player");
  if ($playerCount >= 7) {
    quest::say("You think you are clever, $name? Your actions will not be tolerated. Begone from this temple.");
    quest::movepc(120, 695, 1365, -196.60);
    return;
  }
}

sub EVENT_SLAY {
  quest::say("$name is not worthy to be in my presence!");
}

sub EVENT_HP {
  quest::say("Hp event $hpevent");
  if($hpevent == 90) {
    quest::emote("begins to murmur an incantation, and from the sky drakes begin to materialize.");
    $mob->SetInvul(1);
    quest::setnexthpevent(80);
    return;
  }

  if($hpevent == 80) {
    quest::say("Do you find me to be a fool? The trial commences.");
    $mob->SetInvul(1);
    quest::setnexthpevent(70);
    return;
  }

  elsif($hpevent == 51)
  {
    quest::setnexthpevent(26);
  }
  $num_tics = 0;
  quest::settimer("arcane_blast", 2);
}

sub EVENT_CAST_BEGIN {
  quest::say("Casting!");
}


sub EVENT_HATE_LIST {
  $otherName = $other->CleanName();
  quest::say("Hate List");
  if ($joined) {
    quest::say("$otherName dares to join the fight?");  
  }
  
}

sub EVENT_FEIGN_DEATH {
  $otherName = $other->CleanName();
  quest::say("Your petty attempt to deceive me will not go unnoticed, $otherName");
  return 1;
}


sub EVENT_DEATH_COMPLETE {
  quest::stoptimer("check_leash");
}