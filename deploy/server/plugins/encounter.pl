# Handles encounter-related events

sub encounterreward() {
	my @group = shift;
	my $winnerList = shift;
	my $zoneln = shift;

	$dbh = plugin::LoadMysql();
	if (!$dbh) {
		quest::say("Failed to load MySQL... Tell Shin wtfm8! $winnerList");
		return;
	}
	foreach $c (@group) {
    	$sth = $dbh->prepare("UPDATE `account_custom` SET unclaimed_encounter_rewards = unclaimed_encounter_rewards + 1, unclaimed_encounter_rewards_total = unclaimed_encounter_rewards_total + 1 WHERE account_id = ?");
    	$sth->execute($c->AccountID());	    	
    }
    if ($isRare == 1) {
		quest::we(13, "$winnerList successfully stopped $encounterType in $zoneln!");
    } else {
    	quest::we(13, "$winnerList successfully stopped $encounterType in $zoneln!");
	}
	$dbh->disconnect();
}