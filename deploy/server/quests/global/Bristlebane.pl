#encounter_zombie 187000

my @group;
my $winners;
my @riddles = { 
	"How do you divide the sea in half?" => "sea saw",
	"I lay in your room every morning. I travel with you every day. I echo beside you every night. What am I?" => "watch",
	"Forward I mean something past, backward I am now. What am I?" => "won",
	"I am a pet; I do not live, but I produce any sound you tells me. I obeys your commands, yet I am not easy to be commanded. What am I?" => "trumpet",
	"Remove some and I will give you trouble. What am I?" => "troublesome",
	"When does lunch come after dinner?" => "dictionary",
	"What is made of wood but no saw on earth is sharp enough to cut?" => "sawdust",
	"I can't be bought but can be stolen with a glance, I'm worthless to one but priceless to two. What am I?" => "love",
	"What do you call a ghost without a host?" => "g",
	"I only live where there is light, yet if light touched me I die. What am I?" => "shadow",
	"I get wet when drying. I get dirty when wiping. What am I?" => "towel",
	"I wiggle and cannot see, sometimes underground and sometimes on a tree. I really don't want to be on a hook, and I become a person when combined with book. What am I?" => "worm",
	"I am lighter than air but a hundred people cannot lift me. Careful, I am fragile. What am I?" => "bubble"
}
my $pickedRiddle;


sub EVENT_SAY {
}

sub EVENT_SPAWN {
	@group = ();
	@groupname = ();
	@enemies = ();	
	$winners = "";
	quest::settimer("reminder", 30);
	quest::settimer("endriddle", 120);

	@group = plugin::GetGroupMembers($c);
	foreach $c (@group) {
		if (!$c) { next; }
		#quest::say($c->CharacterID());
		$winners .= $c->GetCleanName().", ";		
	}
	pickedRiddle = int(rand(12));
	quest::say(@riddles[pickedRiddle]);
}


sub givereward {
	$dbh = plugin::LoadMysql();
	if (!$dbh) {
		quest::say("Failed to load MySQL... Tell Shin wtfm8! $winners");
		return;
	}
	foreach $c (@group) {
    	$sth = $dbh->prepare("UPDATE `account_custom` SET unclaimed_encounter_rewards = unclaimed_encounter_rewards + 1, unclaimed_encounter_rewards_total = unclaimed_encounter_rewards_total + 1 WHERE account_id = ?");
    	$sth->execute($c->AccountID());	    	
    }
    quest::we(13, "$winners successfully answered a riddle in $zoneln!");
	$dbh->disconnect();
	quest::depop();
}

sub EVENT_TIMER {

	if ($timer eq "endriddle") { #encounter init, set variables to an easier to handle group
		quest::say("took too long, bye!");
		quest::depop();
		return;		
	}
	if ($timer eq "reminder") {
		quest::say("time is a ticking, hurry hurry, what's the answer?");
	}
}