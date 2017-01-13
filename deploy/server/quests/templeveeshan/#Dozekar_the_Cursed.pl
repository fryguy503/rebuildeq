sub EVENT_SPAWN {
  $SpawnX = $x;
  $SpawnY = $y;
  $SpawnZ = $z;
  $SpawnH = $h;
}

sub EVENT_TIMER {

  $LeashedID = $entity_list->GetMobByNpcTypeID(124037);
  if ($timer eq "CheckLeash") {
    if (!$LeashedID || $LeashedID->IsCorpse()) { #if the mob isn't up      
      return;
    }

    if ($x > -1100 || $y > -950 || $y < -1200) {
      $LeashedID->GMMove($SpawnX, $SpawnY, $SpawnZ, $SpawnH);
    }
    quest::settimer("CheckLeash",1);
  }
}

sub EVENT_AGGRO {
  quest::settimer("CheckLeash", 1);
}

sub EVENT_DEATH_COMPLETE {
  quest::stoptimer("CheckLeash");
}