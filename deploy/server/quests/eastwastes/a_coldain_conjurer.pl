sub EVENT_SAY {
    if ($text=~/remain/i) {
        quest::say("The snow dervishes have a frozen core to empower them. When killed, their core will at times be in good shape, and if you can give me 4, I can finish my conjuration.");
        return;
    }
    if ($text=~/discover/i) {
        quest::say("I've collected many reagents from this land, and know a method to create a construct that could very well turn the tide against Kael Drakkel. Only one reagent ".quest::saylink("remains")." to finish my creation.");
        return;
    }
    if ($text=~/secret/i) {
        quest::say("You see.. I have mastered the art of conjuration. It is forbidden for Coldain to research the matter, but I did, and I [".quest::saylink("discovered")."] a breakthrough.");
        return;
    }
    if ($text=~/wrong/i || $text=~/nervous/i) {
        quest::say("Shh.. Don't talk too loudly. I have a [".quest::saylink("secret")."] I have to share with you...");
        return;
    }
    quest::emote("Looks around nervously.");
}

sub EVENT_ITEM {
  if (plugin::check_handin(\%itemcount, 100084 => 4)) { #hand a frozen core
    quest::emote("Snatches the cores from your hands and begins immediately working on his creation...");
    quest::say("It's alive!! It's alive!");
    quest::depop();
    quest::spawn2(116661, 0, 0, $x, $y, $z, $h);

    # Factions: +Coldain, +Dain Frostreaver IV, -Kromrif, -Kromzek
    quest::faction(49, 30);
    quest::faction(67, 30);
    quest::faction(188, -30);
    quest::faction(189, -30);
    return;
  }
  plugin::return_items(\%itemcount);
}