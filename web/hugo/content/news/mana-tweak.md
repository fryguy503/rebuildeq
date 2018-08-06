+++
banner = "/news/images/site.png"
date = "2017-12-18T01:19:18-07:00"
description = "Mana Tweak"
images = ["/news/images/site.png"]
menu = ""
tags = ["mana"]
title = "Mana Tweak"

+++
* You will hear a ding sound and get a message when you gain a bottle of experience.
* Charmed pets lose charm if you builds reset
* Keeper of Souls is no longer a long duration pop after killing Key Master, it is now only 10 seconds.
* #toggle debugecho will display bane damage amounts. (debugecho leaves if you zone, and is in general spammy, but insightful for testing)
* Quick Damage is now more verbose with how the build ranks are affecting spells.
* Fixed #buff at around level 35, having too high of a spell casted on you.
* Elixir of Might should heal for description instead of 1hp
* We did work on the fragment de-sync bug. Needs more testing on live to verify it's fix.
* Many mana changes were done. This is not a final stage, however it helps place regeneration in a more controllable situation for me to assess and tweak later.
* Healer mana taps increased from 10% to 20%
* Cassindra's Chorus increased from 10% to 26% boost per rank.
* Cassindra's Secret increased from 2 to 3 mana per rank.
* Tranquility changed from 0.1 to 0.04 mana with level formula per tick, group formula revised
* Divine Surge changed from skill-based mana pump to a group passive mana regen.
* Untapped Potential changed from skill-based mana pump to a group passive mana regen.
* Zevfeer's Fast changed from skill-based mana pump to a group passive mana regen.
* Paladin's Purification had a typo, it may work now. NOTE that all 3 forms of purification (SHM/PAL/MNK) no longer cure rez.
* Feydedar is now flagged as a dragon.
* Druid resist spells were re-introduced as castable spells. If you type #builds it should autotrain them.
* Heroism and Fortifiaction logic was repaired, this should resolve "Too high level for your target" messages
* Did work on consider text and color, it still needs more work but we're improving it.
* Rogue Sneak attack should now function
* Install Purpose should echo and work better.
* Reinforce Torpor should now work with Stoicism
* T-Staff stun duration was increased to be significantly longer as it should be. (This may be adjusted again)
* Donal's BP was changed to superior healing with a 10s cast time.
* Squires should no longer con undead.
<!--more-->