+++
banner = "/news/images/megamerge.png"
date = "2017-11-01T21:25:00-07:00"
description = "Megamerge"
images = ["/news/images/megamerge.png"]
menu = ""
tags = ["bard", "monk", "cleric", "shaman", "druid", "rogue", "shadowknight", "paladin", "zone"]
title = "Megamerge"

+++
* Megamerge gets RebuildEQ's source up to date with latest eqemu master. This is over 1.5 years of commits added to the code, and it includes many changes including a full combat revamp, waypoint update fixes, among countless other major cleanups.
* Resetting #builds now costs money level 10 and above.
* Shadowknight's Mental Resistance now works.
* Zone Experience Modifiers have been removed.
* Monks get their AC bonus without weight concerns.
* Fix pet affinity to be available for all classes.
* Bard's Wish now extends songs by 1 tick and works.
* Bard, Monk, Cleric, Shaman, Druid, and Rogue procs now show proc chance and passively occur.
* Death Ward and Mark of Karn are no longer a cleric spells. Instead, it is part of the builds.
* Druid and Shamans no longer get Spirit of the Shrew.
* Cleric's Complete Heal was removed. The effect on Donal's Was also changed.
* #buff, #teleport, #return, and #resurrect are free until level 10.
* #buff no longer gives STR buff or clarity, and gives lesser buffs than before, druids are more viable.
* Shadowknight and Paladin's normal melee attacks are reduced by 25%.
* Rogue normal melee attacks have a curved bonus, increasing up to 50% at 50+.
* Paladin's skills Wave of Marr, Ward of Tunare, Elixir of Might, and Brell's Blessing locations were moved.
* Card Distiller is now sold by Nola and works.
* Did an out of era pass, any items out of era will now be flagged (out of era) but retain cards, so you can safely remove them. #issue while holding any items you believe are in error and were incorrectly flagged out of era.
* Added itemscore system. When you consider a player, you will now see an Item score percent based on the highest geared on server of any class. The highest geared player is updated every 12 hours.
* DPS was heavily revamped and likely may have errors. They are known and being addresed.
* Out of combat regen was reduced in half, as well as the dynamic increase each tick was removed. So, the formula is simply 1% per player in group. level 40+ this is reduced by another half, so 0.5% per player in group.
* Any build that relied on a chance for an effect to go off have been revamped to no longer have a chance roll. They can last 0 ticks, however, and their effectiveness likely reduced
* Many many other changes to builds, review your class fully to discover what was all changed.
* Healers now gain a passive 10% mana tap to all regular melee damage. #toggle buildecho to see the amount regenerated.
* Moved many build effects to #toggle buildecho. This can be spammy but helpful when verifying the usefulness of a skill.
* Weapon and Armor boxes chances for rares/legendaries have been reduced.
* Encounter system has been revamped to be account-wide timers. The frequency has increased, but no longer does character hopping cause new encounters to spawn, it's a universal timer.
<!--more-->