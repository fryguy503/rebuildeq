---
shortName: dru
fullName: Druid
monogram: 6
banner: post/images/site.png
description: Druids have been enhanced in their heal role, focused on healing.
images: [ post/images/site.png ]
tags: [ druid ]
title: Druid
builds:
  styles:
    left: Preserver
    middle: Warden
    right: Hierophant
  build0:
    index: 0
    name: Entrap
    description: "Grants the Entrap AA, snaring the target. Mana cost increases across levels. <br>Rank 1 Snares by 41%-96%, 0 resist adjustment, 0.4% mana cost reduction.<br>Rank 2 Snares by 57%-121%, -50 resist adjustment, 0.8% mana cost reduction.<br>Rank 3 Snares by 57%-141%, -50 resist adjustment, 1.2% mana cost reduction.<br>Rank 4 Snares by 57%-141%, -85 resist adjustment, 1.6% mana cost reduction.<br>Rank 5 Snares by 57%-141%, -85 resist adjustment, 3.2% mana cost reduction.<br>"
    shortname: entrap
  build2:
    index: 2
    push: 1
    name: One With Nature
    description: "Grants a passive where each time you are hit, <em data-base='2'>2</em>% of the damage is converted into mana<span class='perLevel'> per rank</span>."
    shortname: treeform
  build4:
    index: 4
    push: 1
    name: Teleport Bind
    description: "Grants the teleport bind AA. Costs <em data-base='85'>85</em>% of maximumum mana. Each additional rank decreases the mana cost by 15%."
    shortname: teleportbind
  build6:
    index: 6
    name: Exodus
    description: "Grants the Exodus AA, which has a base 5 second cast time. Each rank reduces casting time by 1 second."
    shortname: exodus
  build8:
    index: 8
    push: 1
    name: Call of the Wild
    description: "Grants the Call of the Wild AA, causing enemies nearby to be stunned. Each rank reduces recast time by 300 seconds."
    shortname: callofthewild
  build10:
    index: 10
    push: 1
    name: Secondary Recall
    description: "Grants Secondary Recall AA. Each rank reduces the recast time substantially, 1: 24hrs, 2: 18 hrs, 3: 12hrs, 4: 6hrs, 5: 3hrs."
    shortname: secondaryrecall
  build13:
    index: 13
    push: 1
    name: Ring Affinity
    description: "Ring spells cast <em data-base='5'>5</em>% faster and cost <em data-base='10'>10</em>%% less mana."
    shortname: ringaffinity
  build16:
    index: 16
    push: 1
    name: Dire Charm
    description: "Charm animals from -10 to -5 of your level, based on rank. They get a pet-like adjusted stats, this is an experiment for future mage pet AI improvements."
    shortname: direcharm
  build18:
    index: 18
    name: Regeneration
    description: "Grants the druid an innate hp regeneration of Level * 0.2 hitpoints (minimum 2) per tick, a self only damage shield of <em data-base='2'>2</em>,  as well as any duration regeneration spells casted by the druid give <em data-base='20'>20</em>% additional hitpoint regeneration per tick while in the same zone as the druid<span class='perLevel'> per rank</span>."
    shortname: regeneration
  build20:
    index: 20
    push: 1
    name: Convergence of Spirits
    description: "Grants the Convergence of Spirits AA, giving a heal over time that heals for <em data-base='0.5'>0.5</em>% of the target\'s max health per tick for <em data-base='6'>6</em> seconds. This also causes normal heals to be boosted by <em data-base='5'>5</em>%<span class='perLevel'> per rank</span>."
    shortname: convergenceofspirits
  build22:
    index: 22
    push: 1
    name: Lifeflow
    description: "While an ally has Covergence of Spirits or Nature\'s Boon buff on them, they are granted a <em data-base='1'>1</em>% death save chance, healing when triggered for 8000 hitpoints<span class='perLevel'> per rank</span>."
    shortname: lifeflow
  build24:
    index: 24
    name: Spirit of the Wood
    description: "Grants the Spirit of the Wood AA, which casts buffs scaled based on your level and the target\'s level.<br>Rank 1: STR<br>Rank 2: HP Regen<br>Rank 3: HP<br>Rank 4: Damage Shield<br>Rank 5: Doubles Duration"
    shortname: spiritofthewood
  build26:
    index: 26
    push: 1
    name: Spiritual Awakening
    description: "The druid gains a 300 mod proc that deals (level * 1.5 * <em data-base='0.2'>0.2</em>) magic damage and melee hits tap <em data-base='1'>1</em> mana from the target."
    shortname: spiritualawakening
  build28:
    index: 28
    push: 1
    name: Nature's Boon
    description: "Grants the Nature\'s Boon AA, where the target receives a buff that lasts 84 seconds, duration reduced by <em data-base='12'>12</em> seconds due to rank. When the buff fades, the target is healed for <em data-base='20'>20</em>% of the druid\'s max mana. If Nature\'s Boon is removed early, it will heal for a portion based on duration buff lasted. This also causes normal heals to be boosted by <em data-base='5'>5</em>%<span class='perLevel'> per rank</span>. "
    shortname: naturesboon
  build31:
    index: 31
    push: 1
    name: Nature's Whisper
    description: "While a target is affected by Nature\'s Boon or Convergence of Spirits, the druid as well as the target regain <em data-base='2'>2</em>% of any healing done from these spells as mana.<span class='perLevel'> per rank</span>."
    shortname: natureswhisper
  build34:
    index: 34
    push: 1
    name: Nature's Guardian
    description: "Grants the Nature\'s Guardian AA, where <em data-base='3'>3</em>% of the caster\'s max mana is infused by nature and can be transferred to a target or to the caster<span class='perLevel'> per rank</span>."
    shortname: naturesguardian
  build36:
    index: 36
    name: Intensity
    description: "When an enemy is affected by a DoT, it deals <em data-base='0.7'>0.7</em>% more damage for each ally in group."
    shortname: intensity
  build38:
    index: 38
    push: 1
    name: Lingering Pain
    description: "When a direct spell is casted, a 0 to <em data-base='1'>1</em> tick duration DoT will also affect the target if the spell casted was obtained within 15 levels of your current level<span class='perLevel'> per rank</span>."
    shortname: lingeringpain
  build40:
    index: 40
    push: 1
    name: Focused Swarm
    description: "When standing nearby a mob, DoTs now deal <em data-base='1'>1</em>% more damage for each ally in group. This damage bonus reduces by 10% for every 20m you\'re away from an enemy<span class='perLevel'> per rank</span>."
    shortname: focusedswarm
  build42:
    index: 42
    name: Blessing of Ro
    description: "All Ro debuffs now spread to 0 to <em data-base='1'>1</em> additional enemies within <em data-base='5'>5</em>m of an affected target if they are on the aggro list of the druid."
    shortname: blessingofro
  build44:
    index: 44
    push: 1
    name: Whirling Disaster
    description: "Direct Damage spells now also stun for (0 to <em data-base='1'>1</em>/2) seconds if the target is at least 5 levels below the druid."
    shortname: whirlingdisaster
  build46:
    index: 46
    push: 1
    name: Stinging Affliction
    description: "DoTs and Direct Damage spells have a <em data-base='1'></em>% chance to critical hit<span class='perLevel'> per rank</span>."
    shortname: stingingaffliction
  build49:
    index: 49
    push: 1
    name: Deep Roots
    description: "When a root wears off, there is a <em data-base='3'></em>% chance the target will be snared if it is not already<span class='perLevel'> per rank</span>."
    shortname: deeproots
  build52:
    index: 52
    push: 1
    name: Nature's Blight
    description: "Grants the Lesson of the Devoted AA, causing the target to take 5% increased spell damage. 5 minute recast time, each rank reduces recast by 30 seconds.."
    shortname: naturesblight
---
Druids have been enhanced in their heal role, focused on healing.

<!--more-->

DoTs can be built to do significant damage.
Healer classes have an innate mana tap when they melee.