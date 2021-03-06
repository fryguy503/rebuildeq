my %riddles = ( 
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
);

my $answer;

sub EVENT_SPAWN {
	quest::say("Spawning");
	$pickedRiddle = int(rand(13));
	my $i = 0;	
	foreach my $riddle (keys %riddles) {
		if ($i == $pickedRiddle) {
			quest::say($riddle);
			$answer = $riddles[$riddle];
			end;
		}
		$i++;
	}
}

sub EVENT_SAY {
	 if($text=$answer){
	 	quest::say("Correct");
	 } else {
	 	quest::say("Incorrect.. try again!");
	 }
}