---
shortName: rog
fullName: Rogue
monogram: 9
banner: post/images/site.png
description: Rogues are assassins who specialize in deception, focused on damage.
images: [ post/images/site.png ]
tags: [ rogue ]
title: Rogue
builds:
  styles:
    left: Assassin
    middle: Deceiver
    right: Bandit
  build0:
    index: 0
    name: Appraisal
    description: "The rogue gains a 400 mod proc that deals (level * 3 * <em data-base='0.2'>0.2</em>) magic damage as well as a fleeting fury buff."
    shortname: appraisal
  build2:
    index: 2
    push: 1
    name: Killing Spree
    description: "Each time a creature is successfully killed, the rogue gains a killing spree counter. For a limited time, attacks deal an additional <em data-base='5'>5</em>% damage per counter, with a cap of <em data-base='2'>2</em> counters<span class='perLevel'> per rank</span>."
    shortname: killingspree
  build4:
    index: 4
    push: 1
    name: Thief's Eyes
    description: "Increases accuracy by <em data-base='2'>2</em>% with all skills <span class='perLevel'> per rank</span>."
    shortname: thiefseyes
  build6:
    index: 6
    name: Sinister Strikes
    description: "Increases offhand damage bonus by <em data-base='10'>10</em>%<span class='perLevel'> per rank</span>."
    shortname: sinisterstrikes
  build8:
    index: 8
    push: 1
    name: Sneak Attack
    description: "If a rogue is sneaking and uses a backstab while an enemy is greater than 70% hp, improves chance to hit with a backstab by <em data-base='2000'>2000</em>% and critical chance increases by <em data-base='10'>10</em>% <span class='perLevel'> per rank</span>."
    shortname: sneakattack
  build10:
    index: 10
    push: 1
    name: Focused Stab
    description: "Backstab has a <em data-base='5'>5</em>% better chance to hit<span class='perLevel'> per rank</span> and when maxxed, allows a chance to backstabs from front."
    shortname: focusedstab
  build13:
    index: 13
    push: 1
    name: Vital Organs
    description: "The base damage for Backstab increases by <em data-base='10'>10</em>%<span class='perLevel'> per rank</span>."
    shortname: vitalorgans
  build16:
    index: 16
    push: 1
    name: Assassin's Taint
    description: "Grants the Lesson of the Devoted AA, granting the assassins taint buff that grants triple backstab and a proc that causes skill taken damage to be increased by 7%. 10 minute recast time, each rank reduces recast by 30 seconds."
    shortname: assassinstaint
  build18:
    index: 18
    name: Sleight Distraction
    description: "When the rogue successfully pick pockets an enemy (even if they do not obtain an item) while in a group, the enemy becomes mesmerized for 0 to <em data-base='1'>1</em> ticks. The next time the enemy attacks the rogue it has a very high chance of missing. <span class='perLevel'> per rank</span>"
    shortname: sleightdistraction
  build20:
    index: 20
    push: 1
    name: Jarring Stab
    description: "When the rogue successfully backstabs an enemy, all enemies that are hated by the rogue have a reduction of (<em data-base='0.2'>0.2</em> * damage) hate<span class='perLevel'> per rank</span>."
    shortname: jarringstab
  build22:
    index: 22
    push: 1
    name: Untapped Potential
    description: "While in a group, you and your allies gain (group size * level * <em data-base='0.019'>0.019</em>) mana regen per tick, capped at maximum group size 3<span class='perLevel'> per rank</span>"
    shortname: untappedpotential
  build24:
    index: 24
    name: Confuse
    description: "When a rogue uses Beg on an enemy, there is a <em data-base='0.5'>0.5</em>% chance to cause the enemy to be mesmerized for 6 ticks."
    shortname: confuse
  build26:
    index: 26
    push: 1
    name: Gangster's Paradise
    description: "Rogue melee attacks passively cause <em data-base='10'>10</em> less hate per attack, and when a rogue is out of combat and does not move for some time, they have a chance to gain a Shroud of Stealth like state. The chances of gaining Shroud of Stealth is increased when two rogues are grouped and near each other."
    shortname: gangstersparadise
  build28:
    index: 28
    push: 1
    name: Moss Stone
    description: "When throw stone is used on a creature with less than 20% health and is not snared, it has a <em data-base='20'>20</em>% chance to ensnare the enemy."
    shortname: mossstone
  build31:
    index: 31
    push: 1
    name: Duelist
    description: "While engaged with a single enemy who is lesser level than the rogue, the rogue gains improved evasion. Many factors decrease the effectiveness of this skill, such as the level of the enemy and how much health they have."
    shortname: duelist
  build34:
    index: 34
    push: 1
    name: Escape
    description: "Grants the Escape AA, allowing the rogue to escape combat instantly for 50% of your endurance bar. Endurance cost is reduced by <em data-base='10'>10</em>%<span class='perLevel'> per rank</span>."
    shortname: escape
  build36:
    index: 36
    name: Sleight of Strength
    description: "When the rogue successfully pick pockets, they gain a random beneficial buff for 0 to <em data-base='1'>1</em> ticks<span class='perLevel'> per rank</span>."
    shortname: sleightofstrength
  build38:
    index: 38
    push: 1
    name: Haggle
    description: "When a rogue sells or buys items, the price is improved by <em data-base='2'>2</em>%<span class='perLevel'> per rank</span>."
    shortname: haggle
  build40:
    index: 40
    push: 1
    name: Hidden Stash
    description: "When a rogue pickpockets, they dive deeper into the enemy\'s pockets to discover a hidden stash of coin<span class='perLevel'> per rank</span>."
    shortname: hiddenstash
  build42:
    index: 42
    name: Throwing Precision
    description: "Increases the minimum damage of throwing daggers by <em data-base='10'>10</em>%<span class='perLevel'> per rank</span>."
    shortname: throwingprecision
  build44:
    index: 44
    push: 1
    name: Mugging Shot
    description: "Adds a special proc based on the offhand wielded by the rogue, has a <em data-base='100'>100</em> proc rate<span class='perLevel'> per rank</span>.<br>Mace: Lowers aggro by <em data-base='50'>50</em> hate and interrupts foe.<br>	Sword: Deals <em data-base='5'>5</em> damage. Dagger: Drains mana by <em data-base='100'>100</em> and deals <em data-base='2'>2</em> damage."
    shortname: muggingshot
  build46:
    index: 46
    push: 1
    name: Deadly Dagger
    description: "Increases the maximum damage of throwing daggers by <em data-base='20'>20</em>%<span class='perLevel'> per rank</span>."
    shortname: deadlydagger
  build49:
    index: 49
    push: 1
    name: Thieves' Affinity
    description: "Increases proc chance of innate and card weapon procs by <em data-base='2'5'>2.5</em>%<span class='perLevel'> per rank</span>."
    shortname: thievesaffinity
  build52:
    index: 52
    push: 1
    name: Hidden Dagger
    description: "If an enemy is not engaged, and is hit by a dagger thrown by a rogue sneaking, it will break sneak, and has a <em data-base='15'>15</em>% chance to not be social<span class='perLevel'> per rank</span>."
    shortname: hiddendagger
---
Rogues are assassins who specialize in deception, focused on damage.

<!--more-->

Rogues are the best damage dealers in the melee classification.