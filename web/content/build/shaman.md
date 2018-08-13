---
shortName: shm
fullName: Shaman
monogram: 10
banner: post/images/site.png
description: Shamans weild spiritual powers to bring aid to allies, focused on healing.
images: [ post/images/site.png ]
tags: [ shaman ]
title: Shaman
builds:
  styles:
    left: Prophet
    middle: Oracle
    right: Elder
  build0:
    index: 0
    name: Spirit of Speed
    description: "Spirit of Wolf lasts <em data-base='20'>20</em>% longer<span class='perLevel'> per rank</span>."
    shortname: spiritofspeed
  build2:
    index: 2
    push: 1
    name: Purify Soul
    description: "Grants the Purify Soul AA, which cures target of disease, poison, as well as gives a <em data-base='10'>10</em>% chance to heal the target by <em data-base='1'>1</em>% max HP per tick regen<span class='perLevel'> per rank</span>."
    shortname: purifysoul
  build4:
    index: 4
    push: 1
    name: Ancestral Aid
    description: "Grants the Ancestral Aid AA, which casts focus line buff scaled to your level.<br>Rank 1: STR<br>Rank 2: DEX and AGI<br>Rank 3: STA<br>Rank 4: HP<br>Rank 5: Haste"
    shortname: ancestralaid
  build6:
    index: 6
    name: Extended Haste
    description: "Improves attack speed spells used by the caster by increasing their duration by <em data-base='30'>30</em>%<span class='perLevel'> per rank</span>."
    shortname: extendedhaste
  build8:
    index: 8
    push: 1
    name: Spiritual Healing
    description: "Heals to allies also heal the shaman <em data-base='5'>5</em>% health<span class='perLevel'> per rank</span>."
    shortname: spiritualhealing
  build10:
    index: 10
    push: 1
    name: Covenant of Spirit
    description: "Grants the Covenent of Spirit AA, which imbues divine intervention on the target with a <em data-base='2'>2</em>% death save success<span class='perLevel'> per rank</span>.<b>NOT IMPLEMENTED</b>"
    shortname: covenantofspirit
  build13:
    index: 13
    push: 1
    name: Reinforce Torpor
    description: "Stoicism and Torpor heal for an additional <em data-base='10'>10</em>%<span class='perLevel'> per rank</span>."
    shortname: reinforcetorpor
  build16:
    index: 16
    push: 1
    name: Fateseer's Boon
    description: "Grants the Lesson of the Devoted AA, giving a group buff that increases critical damage by 70% with all skills, chance to critical hit by 50% with all skills, as well as a 400 hitpoint per tick regen. 10 minute recast time, each rank reduces recast by 30 seconds."
    shortname: fateseersboon
  build18:
    index: 18
    name: Cannibalize
    description: "Grants the Cannibalization AA, causing <em data-base='5'>5</em>% current HP loss in exchange for mana at <em data-base='10'>10</em>%<span class='perLevel'> per rank</span>."
    shortname: cannibalize
  build20:
    index: 20
    push: 1
    name: Spirit Call
    description: "Grants the Spirit Call AA, summoning a racial pet with <em data-base='10'>10</em>% effectiveness<span class='perLevel'> per rank</span>."
    shortname: spiritcall
  build22:
    index: 22
    push: 1
    name: Virulent Paralysis
    description: "Grants the Virulent Paralysis AA, causing a target to be immobilized. Each rank increases duration by <em data-base='6'>6</em> seconds <span class='perLevel'> per rank</span>."
    shortname: virulentparalysis
  build24:
    index: 24
    name: Poison
    description: "All poison-based DoTs now deal <em data-base='1'>1</em>% additional damage per ally in group<span class='perLevel'> per rank</span>."
    shortname: poison
  build26:
    index: 26
    push: 1
    name: Extended Turgur
    description: "Increases duration of slow by <em data-base='5'>5</em>% as well as penetrates magic defense by <em data-base='5'>5</em>%<span class='perLevel'> per rank</span>."
    shortname: extendedturgur
  build28:
    index: 28
    push: 1
    name: Ancient Wrath
    description: "All direct damage spells now deal <em data-base='7.5'>7.5</em>% more damage as well as <em data-base='1'>1</em>% chance to critical hit<span class='perLevel'> per rank</span>."
    shortname: ancientwrath
  build31:
    index: 31
    push: 1
    name: Turgur's Echo
    description: "When a slow-based spell is resisted, the spell will try to land again with <em data-base='2'>2</em> less resistance<span class='perLevel'> per rank</span>."
    shortname: turgursecho
  build34:
    index: 34
    push: 1
    name: Spiritual Channeling
    description: "While this ability is active, all spells cost HP rather than mana. Cooldown of reuse is reduced by <em data-base='6'>6</em>seconds<span class='perLevel'> per rank</span>."
    shortname: spiritualchanneling
  build36:
    index: 36
    name: Fury
    description: "The shaman gains a 400 mod proc that deals (level * 1.5 * <em data-base='0.2'>0.2</em>) magic damage."
    shortname: fury
  build38:
    index: 38
    push: 1
    name: Rabid Bear
    description: "Grants the Rabid Bear AA, granting <em data-base='2'>2</em>% attack speed and the tainted bite proc line with <em data-base='20'>20</em>% effectiveness<span class='perLevel'> per rank</span>."
    shortname: rabidbear
  build40:
    index: 40
    push: 1
    name: Ancestral Guard
    description: "Grants the Ancestral Guard AA, granting <em data-base='2'>2</em>% evasion<span class='perLevel'> per rank</span>."
    shortname: ancestralguard
  build42:
    index: 42
    name: Call of the Ancients
    description: "Grants the Call of the Ancients AA, summoning a spirit that deals (level * 1.5 * <em data-base='1'>1</em>) damage per hit for 60 seconds (maximum level * 12 *<em data-base='1'>1</em>) damage <span class='perLevel'> per rank</span>."
    shortname: calloftheancients
  build44:
    index: 44
    push: 1
    name: Spiritual Wrath
    description: "While you have an active pet, all direct damage spells now deal <em data-base='2.5'>2.5</em>% more damage."
    shortname: spiritualwrath
  build46:
    index: 46
    push: 1
    name: Mark of Sloth
    description: "On each attack, grants a chance to trigger a sloth effect, causing the next direct damage spell to deal <em data-base='5'>5</em>% bonus damage<span class='perLevel'> per rank</span>."
    shortname: markofsloth
  build49:
    index: 49
    push: 1
    name: Feral Swipe
    description: "Grants the Feral Swipe AA, giving a bonus attack ability with <em data-base='5'>5</em>% effectiveness<span class='perLevel'> per rank</span>."
    shortname: feralswipe
  build52:
    index: 52
    push: 1
    name: Paragon of Spirit
    description: "Grants the Paragon of Spirit AA, giving a mana and hp regen ability <em data-base='20'>20</em>% effectiveness<span class='perLevel'> per rank</span>."
    shortname: paragonofspirit
---
Shamans weild spiritual powers to bring aid to allies, focused on healing.

<!--more-->

Healer classes have an innate mana tap when they melee.