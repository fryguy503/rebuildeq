sub EVENT_SPAWN {
	$entity_list->GetMobID($mobid)->CastToNPC()->SpellEffect(53);
	quest::settimer("attack", 6);
}

sub EVENT_SAY {
	#if ($entity_list->GetMobID($mobid)->GetTarget()) return;
	$entity_list->GetMobID($mobid)->CastToNPC()->SpellEffect(53);
	quest::attack($client->GetName());
	quest::settimer("attack", 6);
}

sub EVENT_TIMER {
	if ($timer eq "attack") {
		quest::say("attacktimer");
		#pick any client and "aggro" them so we can get the instance id
		my $rClient = $entity_list->GetRandomClient($x,$y,$z, 1000);
		if ($rClient) {
			quest::emote("finds ". $Client->GetName()." to be it's next meal!");
			quest::doanim(1);
			quest::attack($rClient->GetName());
			$newnpc->SpellEffect(53);
			$rClient->Stun(6);
		}
	}
}