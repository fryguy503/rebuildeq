package server

import (
	"fmt"
	"log"
	"net/http"
	"strconv"

	"github.com/gorilla/mux"
)

func GetBuild(w http.ResponseWriter, r *http.Request) {
	vars := mux.Vars(r)

	build, resp, err := api.BuildApi.GetSpentBuildPoints(nil, vars["id"])
	if err != nil {
		//TODO: Handle errors more gracefully
		w.WriteHeader(http.StatusInternalServerError)
		log.Println("Failed", err.Error())
		return
	}
	if resp.StatusCode != 200 {
		w.WriteHeader(http.StatusInternalServerError)
		log.Println("Invalid status code", err.Error())
		return
	}

	character, resp, err := api.CharacterApi.GetCharacter(nil, vars["id"])
	if err != nil {
		//TODO: Handle errors more gracefully
		w.WriteHeader(http.StatusInternalServerError)
		log.Println("Failed", err.Error())
		return
	}
	if resp.StatusCode != 200 {
		w.WriteHeader(http.StatusInternalServerError)
		log.Println("Invalid status code", err.Error())
		return
	}

	tmp := getTemplate("")
	if tmp == nil {

		newTmp, tErr := loadTemplate(nil, "body", "build.tpl")
		if tErr != nil {
			w.WriteHeader(http.StatusInternalServerError)
			log.Println("failed to load template", tErr.Error())
			return
		}
		newTmp, tErr = loadTemplate(newTmp, "navmenu", "navmenu.tpl")
		if tErr != nil {
			w.WriteHeader(http.StatusInternalServerError)
			log.Println("failed to load template", tErr.Error())
			return
		}
		newTmp, tErr = loadTemplate(newTmp, "root", "root.tpl")
		if tErr != nil {
			w.WriteHeader(http.StatusInternalServerError)
			log.Println("failed to load template", tErr.Error())
			return
		}
		setTemplate("build", newTmp)
		tmp = newTmp
	}
	type Content struct {
		Site      Site
		Build     interface{}
		Character interface{}
	}
	content := Content{
		Site:      site,
		Build:     build,
		Character: character,
	}

	w.WriteHeader(http.StatusOK)
	if err = tmp.Execute(w, content); err != nil {
		w.WriteHeader(http.StatusInternalServerError)
		log.Println("Template rendering error", err.Error())
		return
	}
	return
}

func cleanBuild(buildSource string) (build string, err error) {
	skipElements := []int{1, 3, 5, 7, 9, 11, 12, 14, 15, 17, 19, 21, 23, 25, 27, 29, 30, 32, 33, 35, 37, 39, 41, 43, 45, 47, 48, 50, 51, 53}

	//$skipElements = array_flip($skipElements);
	var val int64
	for i := 0; i < 53; i++ {

		isSkipped := false
		for _, ele := range skipElements {
			if i == ele {
				isSkipped = true
				break
			}
		}
		if isSkipped {
			build += "0"
			continue
		}
		if val, err = strconv.ParseInt(buildSource[i:i+1], 10, 0); err == nil && val > 0 && val < 0 {
			build += buildSource[i : i+1]
			continue
		}
		build += "0"
	}
	if len(build) > 54 {
		build = build[0:53]
	}
	return
}

type BuildInfo struct {
	FullName string
	Monogram int
	Desc     string
	Styles0  string
	Styles1  string
	Styles2  string
}

func getBuildInfo(className string) (info *BuildInfo, err error) {
	switch className {
	//==================BARD======================
	case "bard":

		info = &BuildInfo{
			FullName: "Bard",
			Monogram: 8,
			Desc: `Bards are enhanced with their songs being more powerful, focused on utility.<br>
			Cassindra's Secret is a second form of mana song.<br>
			Many new combat enhancements assist bards in their usefulness.`,
			Styles0: "Virtuoso",
			Styles1: "Swordsinger",
			Styles2: "Maestro",
		}
		break
	//==================CLERIC======================
	case "cleric":
		info = &BuildInfo{
			FullName: "Cleric",
			Monogram: 2,
			Desc: `Clerics have adapted to be more combat ready, focused on healing.<br>
			Clerics focus on many procs.<br>
			Clerics no longer have complete heal.<br>
			Healer classes have an innate mana tap when they melee.`,
			Styles0: "Templar",
			Styles1: "Bishop",
			Styles2: "Archon",
		}
		break
	//==================DRUID======================
	case "druid":
		info = &BuildInfo{
			FullName: "Druid",
			Monogram: 6,
			Desc: `Druids have been enhanced in their heal role, focused on healing.<br>
			DoTs can be built to do significant damage.<br>
			Healer classes have an innate mana tap when they melee.`,
			Styles0: "Preserver",
			Styles1: "Warden",
			Styles2: "Hierophant",
		}
		break
	//==================ENCHANTER======================
	case "enchanter":
		info = &BuildInfo{
			FullName: "Enchanter",
			Monogram: 14,
			Desc: `Enchanters have mastered magic, focused on utility.<br>
			They are very effective at shutting down caster enemies with backfire.<br>
			Mesmerize only lasts 1 tick until you train Enthrall.<br>
			Shallow-breath line spells only last 1 tick until you train Drown.`,
			Styles0: "Illusionist",
			Styles1: "Entrancer",
			Styles2: "Beguiler",
		}
		break
	//==================MAGICIAN======================
	case "magician":
		info = &BuildInfo{
			FullName: "Magician",
			Monogram: 13,
			Desc: `Magicians specialize in conjuration of items, focused on utility.<br>
			Their pets are significantly weaker than live EQ, and do not hold aggro well.`,
			Styles0: "Conjurer",
			Styles1: "Elementalist",
			Styles2: "Geomancer",
		}
		break
	//==================MONK======================
	case "monk":
		info = &BuildInfo{
			FullName: "Monk",
			Monogram: 7,
			Desc: `Monks are disciplined fighters who help allies and pull enemies, focused on utility.<br>
			Monks do not compare to the damage of Rogues.<br>
			Monks do not need to worry about weight, their AC bonus always applies.`,
			Styles0: "Master",
			Styles1: "Transcendant",
			Styles2: "Ashenhand",
		}
		break

	//==================NECROMANCER======================
	case "necromancer":
		info = &BuildInfo{
			FullName: "Necromancer",
			Monogram: 11,
			Desc: `Necromancers have mastered the black arts manipulating both the living and dead, focused on utility.<br>
			Their pets are significantly weaker than live EQ, and do not hold aggro well.`,
			Styles0: "Heretic",
			Styles1: "Lich",
			Styles2: "Warlock",
		}
		break

	//==================PALADIN======================
	case "paladin":

		info = &BuildInfo{
			Monogram: 3,
			FullName: "Paladin",
			Desc: `Paladi: are a mix of warrior and cleric, focused on tank.<br,
			With:he Protector line, they can nearly be a viable healer choice.<br>
			Tanks are able to unlock the Charm of Defense, giving Defensive Discipline.`,
			Styles0: "Protector",
			Styles1: "Knight",
			Styles2: "Crusader",
		}
		break

	//==================RANGER======================
	case "ranger":
		info = &BuildInfo{
			FullName: "Ranger",
			Monogram: 4,
			Desc: `Rangers are a mix of warrior and druid, focused on utility.<br>
			Within a group, they are viable archers to deal ranged damage.`,
			Styles0: "Archer",
			Styles1: "Hunter",
			Styles2: "Plainswalker",
		}
		break

	//==================ROGUE======================
	case "rogue":
		info = &BuildInfo{
			FullName: "Rogue",
			Monogram: 9,
			Desc: `Rogues are assassins who specialize in deception, focused on damage.<br>
			Rogues are the best damage dealers in the melee classification.`,
			Styles0: "Assassin",
			Styles1: "Deceiver",
			Styles2: "Bandit",
		}
		break

	//==================SHAMAN======================
	case "shaman":
		info = &BuildInfo{
			FullName: "Shaman",
			Monogram: 10,
			Desc: `Shamans weild spiritual powers to bring aid to allies, focused on healing.<br>
			Healer classes have an innate mana tap when they melee.`,
			Styles0: "Prophet",
			Styles1: "Oracle",
			Styles2: "Elder",
		}
		break

	//==================WARRIOR======================
	case "warrior":
		info = &BuildInfo{
			FullName: "Warrior",
			Monogram: 1,
			Desc: `Warriors are masters of weapons, focused on tank.<br>
			Warriors are no longer the definitive best tank, competing with the Knights with defensive disciplines.<br>
			Tanks are able to unlock the Charm of Defense, giving Defensive Discipline`,
			Styles0: "Gladiator",
			Styles1: "Brawler",
			Styles2: "Champion",
		}
		break

	//==================WIZARD======================
	case "wizard":
		info = &BuildInfo{
			FullName: "Wizard",
			Monogram: 12,
			Desc: `Wizards are masters of the elements, focused on damage.<br>
			Wizards deal the highest damage of all magical users.`,
			Styles0: "Evoker",
			Styles1: "Channeler",
			Styles2: "Sage",
		}
		break

	//==================SHADOWKNIGHT======================
	case "shadowknight":
	default:
		info = &BuildInfo{
			FullName: "Shadow Knight",
			Monogram: 5,
			Desc: `Shadow Knights are a mix between warrior and necromancer, focused on tank.<br>
			Tanks are able to unlock the Charm of Defense, giving Defensive Discipline.`,
			Styles0: "Bloodreaver",
			Styles1: "Defiler",
			Styles2: "Revenant",
		}
		break
	}
	return

}

func classNameFromId(classId int) (className string) {
	switch classId {
	case 1:
		return "warrior"
	case 2:
		return "cleric"
	case 3:
		return "paladin"
	case 4:
		return "ranger"
	case 5:
		return "shadowknight"
	case 6:
		return "druid"
	case 7:
		return "monk"
	case 8:
		return "bard"
	case 9:
		return "rogue"
	case 10:
		return "shaman"
	case 11:
		return "necromancer"
	case 12:
		return "wizard"
	case 13:
		return "magician"
	case 14:
		return "enchanter"
	default:
		return "unknown"
	}
	return "unknown"
}

func validateBuild(buildSource string, level int) (build string, err error) {

	tier11 := int64(0)
	tier12 := int64(0)
	tier13 := int64(0)
	tier14 := int64(0)
	tier15 := int64(0)
	tier16 := int64(0)
	tier21 := int64(0)
	tier22 := int64(0)
	tier23 := int64(0)
	tier24 := int64(0)
	tier25 := int64(0)
	tier26 := int64(0)
	tier31 := int64(0)
	tier32 := int64(0)
	tier33 := int64(0)
	tier34 := int64(0)
	tier35 := int64(0)
	tier36 := int64(0)

	if level > 60 || level < 1 {
		err = fmt.Errorf("Invalid level provided: %d", level)
		return
	}

	build = buildSource

	grandTotal := int64(0)
	//Validate For tier-reqs TOTALS
	for i := 0; i < 53; i++ {
		val := int64(0)

		if len(build) <= i {
			val = 0
		} else {
			val, err = strconv.ParseInt(build[i-1:i], 10, 0)
			if err != nil {
				err = fmt.Errorf("Failed to parse index %d: %s", i, err.Error())
				return
			}
		}

		if val > 5 || val < 0 {
			err = fmt.Errorf("Invalid skill point amount (%d) on index %d", val, i)
			return
		}

		if i >= 0 && i <= 2 {
			tier11 += val
		}
		if i >= 18 && i <= 20 {
			tier21 += val
		}
		if i >= 36 && i <= 38 {
			tier31 += val
		}

		if i >= 3 && i <= 5 {
			tier12 += val
		}
		if i >= 21 && i <= 23 {
			tier22 += val
		}
		if i >= 39 && i <= 41 {
			tier32 += val
		}

		if i >= 6 && i <= 8 {
			tier13 += val
		}
		if i >= 24 && i <= 26 {
			tier23 += val
		}
		if i >= 42 && i <= 44 {
			tier33 += val
		}

		if i >= 9 && i <= 11 {
			tier14 += val
		}
		if i >= 27 && i <= 29 {
			tier24 += val
		}
		if i >= 45 && i <= 47 {
			tier34 += val
		}

		if i >= 12 && i <= 14 {
			tier15 += val
		}
		if i >= 30 && i <= 32 {
			tier25 += val
		}
		if i >= 48 && i <= 50 {
			tier35 += val
		}

		if i >= 15 && i <= 17 {
			tier16 += val
		}
		if i >= 33 && i <= 35 {
			tier26 += val
		}
		if i >= 51 && i <= 53 {
			tier36 += val
		}
		grandTotal += val
	}

	tierTotal := int64(0)
	if tier12 >= 1 && tier11 < 5 {
		err = fmt.Errorf("Invalid point spend on tier 12")
		return
	}
	tierTotal += tier12 + tier11
	if tier13 >= 1 && tierTotal < 10 {
		err = fmt.Errorf("Invalid point spend on tier 13")
		return
	}
	tierTotal += tier13
	if tier14 >= 1 && tierTotal < 15 {
		err = fmt.Errorf("Invalid point spend on tier 14")
		return
	}
	tierTotal += tier14
	if tier15 >= 1 && tierTotal < 20 {
		err = fmt.Errorf("Invalid point spend on tier 15")
		return
	}
	tierTotal += tier15
	if tier16 >= 1 && tierTotal < 25 {
		err = fmt.Errorf("Invalid point spend on tier 16")
		return
	}

	tierTotal = 0
	if tier22 >= 1 && tier21 < 5 {
		err = fmt.Errorf("Invalid point spend on tier 22")
		return
	}
	tierTotal += tier21 + tier22
	if tier23 >= 1 && tierTotal < 10 {
		err = fmt.Errorf("Invalid point spend on tier 23")
		return
	}
	tierTotal += tier23
	if tier24 >= 1 && tierTotal < 15 {
		err = fmt.Errorf("Invalid point spend on tier 24")
		return
	}
	tierTotal += tier24
	if tier25 >= 1 && tierTotal < 20 {
		err = fmt.Errorf("Invalid point spend on tier 25")
		return
	}
	tierTotal += tier25
	if tier26 >= 1 && tierTotal < 25 {
		err = fmt.Errorf("Invalid point spend on tier 26")
		return
	}

	tierTotal = 0
	if tier32 >= 1 && tier31 < 5 {
		err = fmt.Errorf("Invalid point spend on tier 32")
		return
	}
	tierTotal += tier32 + tier31
	if tier33 >= 1 && tierTotal < 10 {
		err = fmt.Errorf("Invalid point spend on tier 33")
		return
	}
	tierTotal += tier33
	if tier34 >= 1 && tierTotal < 15 {
		err = fmt.Errorf("Invalid point spend on tier 34")
		return
	}
	tierTotal += tier34
	if tier35 >= 1 && tierTotal < 20 {
		err = fmt.Errorf("Invalid point spend on tier 35")
		return
	}
	tierTotal += tier35
	if tier36 >= 1 && tierTotal < 25 {
		err = fmt.Errorf("Invalid point spend on tier 36")
		return
	}
	if grandTotal > int64(level) {
		err = fmt.Errorf("Too many points are spent (%d) for level %d", grandTotal, level)
		return
	}

	return
}

type Skill struct {
	Title string
	Desc  string
	Image string
}

func getSkills(className string) (skills map[int]*Skill) {
	skill := &Skill{}

	switch className {
	//==================BARD======================
	case "bard":
		skill = &Skill{
			Title: "Elemental Harmony",
			Desc:  "Resistant songs (lvl 9) now grant an additional <em data-base='10'>10</em> resistance to each resistance type<span class='perLevel'> per rank</span>.",
			Image: "/images/builds/icons/rb-brd-elementalharmony.png",
		}
		skills[0] = skill

		skill = &Skill{
			Title: "Healing Treble",
			Desc:  "Healing effects on songs (lvl 6) are <em data-base='10'>10</em>% more effective<span class='perLevel'> per rank</span>.",
			Image: "/images/builds/icons/rb-brd-healingtreble.png",
		}
		skills[2] = skill

		skill = &Skill{
			Title: "Psalm of Norrath",
			Desc:  "Damage shield effects on songs (lvl 25) are <em data-base='20'>20</em>% more effective<span class='perLevel'> per rank</span>.",
			Image: "/images/builds/icons/rb-brd-psalmofnorrath.png",
		}
		skills[4] = skill

		skill = &Skill{
			Title: "Cassindra's Chorus",
			Desc:  "Mana effects on songs (lvl 20) are <em data-base='10'>10</em>% more effective<span class='perLevel'> per rank</span>.",
			Image: "/images/builds/icons/rb-brd-cassindraschorus.png",
		}
		skills[6] = skill

		skill = &Skill{
			Title: "Shield of Songs",
			Desc:  "Rune effects on songs (lvl 49) are <em data-base='20'>20</em>% more effective<span class='perLevel'> per rank</span>.",
			Image: "/images/builds/icons/rb-brd-shieldofsongs.png",
		}
		skills[8] = skill

		skill = &Skill{
			Title: "Katta's Concord",
			Desc:  "Katta's Song of Sword (lvl 39) now also gives a 100 proc chance to those with the buff that deals (level * <em data-base='0.4'>0.4</em>) damage<span class='perLevel'> per rank</span>.",
			Image: "/images/builds/icons/rb-brd-kattasconcord.png",
		}
		skills[10] = skill

		skill = &Skill{
			Title: "Cassindra's Secret",
			Desc:  "Enhances Cassindra's Elegy (lvl 44) to also give <em data-base='2'>2</em> mana<span class='perLevel'> per rank</span>.",
			Image: "/images/builds/icons/rb-brd-rizlonaspurpose.png",
		}
		skills[13] = skill

		//http://everquest.allakhazam.com/db/spell.html?spell=6239
		skill = &Skill{
			Title: "Kinsong",
			Desc:  "Grants the Lesson of the Devoted AA, Increasing the groups spell critical dot dmg, dot, and accuracy. 10 minute recast time, each rank reduces recast by 30 seconds.",
			Image: "/images/builds/icons/rb-brd-kinsong.png",
		}
		skills[16] = skill

		skill = &Skill{
			Title: "Jonthon's Whistle",
			Desc:  "Grants the bard a passive 300 mod proc that deals (level * 2 * <em data-base='0.2'>0.2</em>) magic damage.",
			Image: "/images/builds/icons/rb-brd-jonathonswhistle.png",
		}
		skills[18] = skill

		skill = &Skill{
			Title: "Offhand Attack",
			Desc:  "All offhand attacks (lvl 17) have <em data-base='5'>5</em>% additional chance to hit<span class='perLevel'> per rank</span>.",
			Image: "/images/builds/icons/rb-brd-offhandattack.png",
		}
		skills[20] = skill

		skill = &Skill{
			Title: "Innate Songblade",
			Desc:  "Increases chance to hit and damage by <em data-base='2'>2</em>%<span class='perLevel'> per rank</span>.",
			Image: "/images/builds/icons/rb-brd-innatesongblade.png",
		}
		skills[22] = skill

		skill = &Skill{
			Title: "Warsong of Zek",
			Desc:  "Increases bard's melee damage by <em data-base='2'>2</em>%<span class='perLevel'> per rank</span>.",
			Image: "/images/builds/icons/rb-brd-warsongofzek.png",
		}
		skills[24] = skill

		skill = &Skill{
			Title: "Dance of Blades",
			Desc:  "Grants the Dance of Blades AA, increasing chance to dual wield and double attack as well as proc Bladewhirl at <em data-base='20'>20</em>% effectiveness<span class='perLevel'> per rank</span>.",
			Image: "/images/builds/icons/rb-brd-danceofblades.png",
		}
		skills[26] = skill

		skill = &Skill{
			Title: "Blade Dancer",
			Desc:  "When a bard is attacked while in a group, increases chance to dodge by <em data-base='2'>2</em>%<span class='perLevel'> per rank</span> per player in group.",
			Image: "/images/builds/icons/rb-brd-cacophony.png",
		}
		skills[28] = skill

		skill = &Skill{
			Title: "Harmonic Affinity",
			Desc:  "Increases proc chance modifier by <em data-base='5'>5</em>% <span class='perLevel'> per rank</span>.",
			Image: "/images/builds/icons/rb-brd-harmonicaffinity.png",
		}
		skills[31] = skill

		skill = &Skill{
			Title: "Bard's Wish",
			Desc:  "When rank 5, all beneficial songs last an additional tick.",
			Image: "/images/builds/icons/rb-brd-bardswish.png",
		}
		skills[34] = skill

		skill = &Skill{
			Title: "Chant Cycle",
			Desc:  "Chants with DoT effects now deal <em data-base='1'>1</em>% more damage per ally in group <span class='perLevel'> per rank</span>.",
			Image: "/images/builds/icons/rb-brd-chantcycle.png",
		}
		skills[36] = skill

		skill = &Skill{
			Title: "Boastful Bellow",
			Desc:  "Grants the Boastful Bellow AA, and lowers the reuse time by <em data-base='10'>10</em> seconds<span class='perLevel'> per rank</span>.",
			Image: "/images/builds/icons/rb-brd-boastfulbellow.png",
		}
		skills[38] = skill

		skill = &Skill{
			Title: "Selo's Crescendo",
			Desc:  "Selo's movement songs now work indoors while you are equal or below level <em data-base='12'>12</em><span class='perLevel'> per rank</span>.",
			Image: "/images/builds/icons/rb-brd-seloscrescendo.png",
		}
		skills[40] = skill

		skill = &Skill{
			Title: "Soothing Melody",
			Desc:  "When the bard uses a song with a healing effect on themselves, reduces hate of their target by (heal amount * <em data-base='2'>2</em>)<span class='perLevel'> per rank</span>.",
			Image: "/images/builds/icons/rb-brd-shieldofnotes.png",
		}
		skills[42] = skill

		skill = &Skill{
			Title: "Shout",
			Desc:  "Increases range of PB AE songs by <em data-base='20'>20</em>%<span class='perLevel'> per rank</span>.",
			Image: "/images/builds/icons/rb-brd-shout.png",
		}
		skills[44] = skill

		skill = &Skill{
			Title: "Siren's Song",
			Desc:  "Charm songs (lvl 27) now cost <em data-base='10'>10</em>% less mana<span class='perLevel'> per rank</span>.",
			Image: "/images/builds/icons/rb-brd-songofstone.png",
		}
		skills[46] = skill

		skill = &Skill{
			Title: "Lingering Twilight",
			Desc:  "Mesmerizing songs last <em data-base='0.6'>0.6</em> ticks longer<span class='perLevel'> per rank</span>.",
			Image: "/images/builds/icons/rb-brd-lingeringtwilight.png",
		}
		skills[49] = skill

		skill = &Skill{
			Title: "Fading Memories",
			Desc:  "Grants the Fading Memories AA, allowing you to escape all aggressions towards you, By default this costs 50% of your max mana, reduced by <em data-base='5'>5</em>%<span class='perLevel'> per rank</span>.",
			Image: "/images/builds/icons/rb-brd-fadingmemories.png",
		}
		skills[52] = skill

		break

	//==================CLERIC======================
	case "cleric":
		skill = &Skill{
			Title: "Believe",
			Desc:  "The cleric gains a 300 mod proc that deals (level * 0.75 * <em data-base='0.2'>0.2</em>) magic damage, and half the damage is health back to the cleric.",
			Image: "/images/builds/icons/rb-clr-believe.png",
		}
		skills[0] = skill

		skill = &Skill{
			Title: "Ward of Vie",
			Desc:  "All ward spells last an additional <em data-base='20'>20</em>% more maximum hitpoints<span class='perLevel'> per rank</span>.",
			Image: "/images/builds/icons/rb-clr-wardofvie.png",
		}
		skills[2] = skill

		skill = &Skill{
			Title: "Harken the Gods",
			Desc:  "Yaulp now gives increased accuracy, attack, and mana regen<span class='perLevel'> per rank</span>.",
			Image: "/images/builds/icons/rb-clr-harkenthegods.png",
		}
		skills[4] = skill

		skill = &Skill{
			Title: "Blessing of Haste",
			Desc:  "All spell haste spells are <em data-base='20'>20</em>% more effective on you<span class='perLevel'> per rank</span>.",
			Image: "/images/builds/icons/rb-clr-blessingofhaste.png",
		}
		skills[6] = skill

		skill = &Skill{
			Title: "Divine Hammer",
			Desc:  "The cleric gains a <em data-base='60'>60</em> mod proc that causes the Hand of the God spell, dealing 75-150 damage randomly.",
			Image: "/images/builds/icons/rb-clr-divinehammer.png",
		}
		skills[8] = skill

		skill = &Skill{
			Title: "Mark of Karn",
			Desc:  "Healing an ally with a single target spell, while they target an enemy, will cause the target to be affected by the Mark of Karn, healing allies who hit the enemy, for 0 to <em data-base='1'>1</em>ticks randomly.",
			Image: "/images/builds/icons/rb-clr-piouszealot.png",
		}
		skills[10] = skill

		skill = &Skill{
			Title: "Augmented Retribution",
			Desc:  "The cleric gains a <em data-base='100'>100</em> mod proc that deals a smite-like spell<span class='perLevel'> per rank</span>.",
			Image: "/images/builds/icons/rb-clr-augmentedretribution.png",
		}
		skills[13] = skill

		skill = &Skill{
			Title: "Divine Avatar",
			Desc:  "Grants the Divine Avatar AA, allowing a cleric many statistic bonuses and a <em data-base='10'>10</em>% chance dodge and longer duration <span class='perLevel'> per rank</span>.",
			Image: "/images/builds/icons/rb-clr-divineavatar.png",
		}
		skills[16] = skill

		skill = &Skill{
			Title: "Instill Life",
			Desc:  "When an ally is healed, there is a <em data-base='2'>2</em>% chance to heal for a bonus of <em data-base='2'>2</em>% the target's max health<span class='perLevel'> per rank</span>.",
			Image: "/images/builds/icons/rb-clr-instilllife.png",
		}
		skills[18] = skill

		skill = &Skill{
			Title: "Divine Bash",
			Desc:  "When the cleric uses bash, they heal for <em data-base='4'>4</em>% of the cleric's max hp per rank to a group member with lowest health<span class='perLevel'> per rank</span>. This does not heal the cleric.",
			Image: "/images/builds/icons/rb-clr-divinebash.png",
		}
		skills[20] = skill

		skill = &Skill{
			Title: "Intensity of the Resolute",
			Desc:  "Courage now grants Cleric buffs<br>Rank 1: +Spell Haste<br>Rank 2: +AC<br>Rank 3: +HP<br>Rank 4: +Symbol<br>Rank 5: +Yaulp",
			Image: "/images/builds/icons/rb-clr-intensifiedresolution.png",
		}
		skills[22] = skill

		skill = &Skill{
			Title: "Celestial Regeneration",
			Desc:  "Grants the Celestial Regeneration AA, restoring <em data-base='36'>36</em> hitpoints and <em data-base='2'>2</em> mana for 8 ticks<span class='perLevel'> per rank</span>.",
			Image: "/images/builds/icons/rb-clr-celestialbreeze.png",
		}
		skills[24] = skill

		skill = &Skill{
			Title: "Divine Arbitration",
			Desc:  "Grants the Divine Arbitration AA, balancing the damage each member of your group has taken, with a cooldown reduction of <em data-base='30'>30</em> seconds<span class='perLevel'> per rank</span>.",
			Image: "/images/builds/icons/rb-clr-divinearbitration.png",
		}
		skills[26] = skill

		skill = &Skill{
			Title: "Divine Resurrection",
			Desc:  "Grants the Divine Resurrection AA, reviving a fallen player. With a base of 24 hours, lowers cooldown by <em data-base='4'>4</em> hours<span class='perLevel'> per rank</span>.",
			Image: "/images/builds/icons/rb-clr-divineressurection.png",
		}
		skills[28] = skill

		skill = &Skill{
			Title: "Promise",
			Desc:  "All heals done by the cleric now have a <em data-base='2'>2</em> chance to have the mana cost reduced by <em data-base='10'>10</em>% mana <span class='perLevel'> per rank</span>.",
			Image: "/images/builds/icons/rb-clr-promise.png",
		}
		skills[31] = skill

		skill = &Skill{
			Title: "Harmonic Balance",
			Desc:  "Grants the Lesson of the Devoted AA, balancing the group's hitpoints and healing them. 10 minute recast time, each rank reduces recast by 30 seconds.",
			Image: "/images/builds/icons/rb-clr-harmonicbalance.png",
		}
		skills[34] = skill

		skill = &Skill{
			Title: "Strike",
			Desc:  "Increases the damage of all direct damage spells by <em data-base='2'>2</em>%<span class='perLevel'> per rank</span>.",
			Image: "/images/builds/icons/rb-clr-strike.png",
		}
		skills[36] = skill

		skill = &Skill{
			Title: "Ward of Rebuke",
			Desc:  "Ward skills deal an additional <em data-base='2'>2</em>% damage <span class='perLevel'> per rank</span> and give <em data-base='1'>1</em>% of the damage <span class='perLevel'> per rank</span> back as mana.",
			Image: "/images/builds/icons/rb-clr-wardofrebuke.png",
		}
		skills[38] = skill

		skill = &Skill{
			Title: "Fist of the Gods",
			Desc:  "Grants <em data-base='1'>1</em> bane damage versus undead<span class='perLevel'> per rank</span>.",
			Image: "/images/builds/icons/rb-clr-fistofthegods.png",
		}
		skills[40] = skill

		skill = &Skill{
			Title: "Divine Retribution",
			Desc:  "Grants the Divine Retribution AA with <em data-base='20'>20</em>%<span class='perLevel'> per rank</span> proc effectiveness.",
			Image: "/images/builds/icons/rb-clr-divineretribution.png",
		}
		skills[42] = skill

		skill = &Skill{
			Title: "Turn Undead",
			Desc:  "Grants the Turn Undead AA dealing <em data-base='500'>500</em> damage<span class='perLevel'> per rank</span> and a <em data-base='1'>1</em>% chance<span class='perLevel'> per rank</span> to deal 32000 damage.",
			Image: "/images/builds/icons/rb-clr-turnundead.png",
		}
		skills[44] = skill

		skill = &Skill{
			Title: "Exquisite Benediction",
			Desc:  "While meleeing an undead creature, increases proc chance of all build procs by <em data-base='20'>20</em><span class='perLevel'> per rank</span>.",
			Image: "/images/builds/icons/rb-clr-exquisitebenediction.png",
		}
		skills[46] = skill

		skill = &Skill{
			Title: "Mark of Retribution",
			Desc:  "Increases the damage of Mark of Retribution by <em data-base='20'>20</em>%<span class='perLevel'> per rank</span>.",
			Image: "/images/builds/icons/rb-clr-markofretribution.png",
		}
		skills[49] = skill

		skill = &Skill{
			Title: "Death Pact",
			Desc:  "Healing an ally with a single target spell gives them a 0 to <em data-base='1'>1</em> tick duration random death pact buff<span class='perLevel'> per rank</span>.",
			Image: "/images/builds/icons/rb-clr-avatarsboon.png",
		}
		skills[52] = skill
		break

	//==================DRUID======================
	case "druid":
		skill = &Skill{
			Title: "Entrap",
			Desc: `Grants the Entrap AA, snaring the target. Mana cost increases across levels. <br>
			Rank 1 Snares by 41%-96%, 0 resist adjustment, 0.4% mana cost reduction.<br>
			Rank 2 Snares by 57%-121%, -50 resist adjustment, 0.8% mana cost reduction.<br>
			Rank 3 Snares by 57%-141%, -50 resist adjustment, 1.2% mana cost reduction.<br>
			Rank 4 Snares by 57%-141%, -85 resist adjustment, 1.6% mana cost reduction.<br>
			Rank 5 Snares by 57%-141%, -85 resist adjustment, 3.2% mana cost reduction.<br>`,
			Image: "/images/builds/icons/rb-dru-entrap.png",
		}
		skills[0] = skill

		skill = &Skill{
			Title: "One With Nature",
			Desc:  "Grants a passive where each time you are hit, <em data-base='2'>2</em>% of the damage is converted into mana<span class='perLevel'> per rank</span>.",
			Image: "/images/builds/icons/rb-dru-treeform.png",
		}
		skills[2] = skill

		skill = &Skill{
			Title: "Teleport Bind",
			Desc:  "Grants the teleport bind AA. Costs <em data-base='85'>85</em>% of maximumum mana. Each additional rank decreases the mana cost by 15%.",
			Image: "/images/builds/icons/rb-dru-teleportbind.png",
		}
		skills[4] = skill

		skill = &Skill{
			Title: "Exodus",
			Desc:  "Grants the Exodus AA, which has a base 5 second cast time. Each rank reduces casting time by 1 second.",
			Image: "/images/builds/icons/rb-dru-exodus.png",
		}
		skills[6] = skill

		skill = &Skill{
			Title: "Call of the Wild",
			Desc:  "Grants the Call of the Wild AA, causing enemies nearby to be stunned. Each rank reduces recast time by 300 seconds.",
			Image: "/images/builds/icons/rb-dru-callofthewild.png",
		}
		skills[8] = skill

		skill = &Skill{
			Title: "Secondary Recall",
			Desc:  "Grants Secondary Recall AA. Each rank reduces the recast time substantially, 1: 24hrs, 2: 18 hrs, 3: 12hrs, 4: 6hrs, 5: 3hrs.",
			Image: "/images/builds/icons/rb-dru-secondaryrecall.png",
		}
		skills[10] = skill

		skill = &Skill{
			Title: "Ring Affinity",
			Desc:  "Ring spells cast <em data-base='5'>5</em>% faster and cost <em data-base='10'>10</em>%% less mana.",
			Image: "/images/builds/icons/rb-dru-ringaffinity.png",
		}
		skills[13] = skill

		skill = &Skill{
			Title: "Dire Charm",
			Desc:  "Charm animals from -10 to -5 of your level, based on rank. They get a pet-like adjusted stats, this is an experiment for future mage pet AI improvements.",
			Image: "/images/builds/icons/rb-dru-direcharm.png",
		}
		skills[16] = skill

		skill = &Skill{
			Title: "Regeneration",
			Desc:  "Grants the druid an innate hp regeneration of Level * 0.2 hitpoints (minimum 2) per tick, a self only damage shield of <em data-base='2'>2</em>,  as well as any duration regeneration spells casted by the druid give <em data-base='20'>20</em>% additional hitpoint regeneration per tick while in the same zone as the druid<span class='perLevel'> per rank</span>.",
			Image: "/images/builds/icons/rb-dru-regeneration.png",
		}
		skills[18] = skill

		skill = &Skill{
			Title: "Convergence of Spirits",
			Desc:  "Grants the Convergence of Spirits AA, giving a heal over time that heals for <em data-base='0.5'>0.5</em>% of the target's max health per tick for <em data-base='6'>6</em> seconds. This also causes normal heals to be boosted by <em data-base='5'>5</em>%<span class='perLevel'> per rank</span>.",
			Image: "/images/builds/icons/rb-dru-convergenceofspirits.png",
		}
		skills[20] = skill

		skill = &Skill{
			Title: "Lifeflow",
			Desc:  "While an ally has Covergence of Spirits or Nature's Boon buff on them, they are granted a <em data-base='1'>1</em>% death save chance, healing when triggered for 8000 hitpoints<span class='perLevel'> per rank</span>.",
			Image: "/images/builds/icons/rb-dru-lifeflow.png",
		}
		skills[22] = skill

		skill = &Skill{
			Title: "Spirit of the Wood",
			Desc:  "Grants the Spirit of the Wood AA, which casts buffs scaled based on your level and the target's level.<br>Rank 1: STR<br>Rank 2: HP Regen<br>Rank 3: HP<br>Rank 4: Damage Shield<br>Rank 5: Doubles Duration",
			Image: "/images/builds/icons/rb-dru-spiritofthewood.png",
		}
		skills[24] = skill

		skill = &Skill{
			Title: "Spiritual Awakening",
			Desc:  "The druid gains a 300 mod proc that deals (level * 1.5 * <em data-base='0.2'>0.2</em>) magic damage and melee hits tap <em data-base='1'>1</em> mana from the target.",
			Image: "/images/builds/icons/rb-dru-spiritualawakening.png",
		}
		skills[26] = skill

		skill = &Skill{
			Title: "Nature's Boon",
			Desc:  "Grants the Nature's Boon AA, where the target receives a buff that lasts 84 seconds, duration reduced by <em data-base='12'>12</em> seconds due to rank. When the buff fades, the target is healed for <em data-base='20'>20</em>% of the druid's max mana. If Nature's Boon is removed early, it will heal for a portion based on duration buff lasted. This also causes normal heals to be boosted by <em data-base='5'>5</em>%<span class='perLevel'> per rank</span>. ",
			Image: "/images/builds/icons/rb-dru-naturesboon.png",
		}
		skills[28] = skill

		skill = &Skill{
			Title: "Nature's Whisper",
			Desc:  "While a target is affected by Nature's Boon or Convergence of Spirits, the druid as well as the target regain <em data-base='2'>2</em>% of any healing done from these spells as mana.<span class='perLevel'> per rank</span>.",
			Image: "/images/builds/icons/rb-dru-natureswhisper.png",
		}
		skills[31] = skill

		skill = &Skill{
			Title: "Nature's Guardian",
			Desc:  "Grants the Nature's Guardian AA, where <em data-base='3'>3</em>% of the caster's max mana is infused by nature and can be transferred to a target or to the caster<span class='perLevel'> per rank</span>.",
			Image: "/images/builds/icons/rb-dru-naturesguardian.png",
		}
		skills[34] = skill

		skill = &Skill{
			Title: "Intensity",
			Desc:  "When an enemy is affected by a DoT, it deals <em data-base='0.7'>0.7</em>% more damage for each ally in group.",
			Image: "/images/builds/icons/rb-dru-intensity.png",
		}
		skills[36] = skill

		skill = &Skill{
			Title: "Lingering Pain",
			Desc:  "When a direct spell is casted, a 0 to <em data-base='1'>1</em> tick duration DoT will also affect the target if the spell casted was obtained within 15 levels of the enemy's level<span class='perLevel'> per rank</span>.",
			Image: "/images/builds/icons/rb-dru-lingeringpain.png",
		}
		skills[38] = skill

		skill = &Skill{
			Title: "Focused Swarm",
			Desc:  "When standing nearby a mob, DoTs now deal <em data-base='1'>1</em>% more damage for each ally in group. This damage bonus reduces by 10% for every 20m you're away from an enemy<span class='perLevel'> per rank</span>.",
			Image: "/images/builds/icons/rb-dru-focusedswarm.png",
		}
		skills[40] = skill

		skill = &Skill{
			Title: "Blessing of Ro",
			Desc:  "All Ro debuffs now spread to 0 to <em data-base='1'>1</em> additional enemies within <em data-base='5'>5</em>m of an affected target if they are on the aggro list of the druid.",
			Image: "/images/builds/icons/rb-dru-blessingofro.png",
		}
		skills[42] = skill

		skill = &Skill{
			Title: "Whirling Disaster",
			Desc:  "Direct Damage spells now also stun for (0 to <em data-base='1'>1</em>/2) seconds if the target is at least 5 levels below the druid.",
			Image: "/images/builds/icons/rb-dru-whirlingdisaster.png",
		}
		skills[44] = skill

		skill = &Skill{
			Title: "Stinging Affliction",
			Desc:  "DoTs and Direct Damage spells have a <em data-base='1'></em>% chance to critical hit<span class='perLevel'> per rank</span>.",
			Image: "/images/builds/icons/rb-dru-stingingaffliction.png",
		}
		skills[46] = skill

		skill = &Skill{
			Title: "Deep Roots",
			Desc:  "When a root wears off, there is a <em data-base='3'></em>% chance the target will be snared if it is not already<span class='perLevel'> per rank</span>.",
			Image: "/images/builds/icons/rb-dru-deeproots.png",
		}
		skills[49] = skill

		skill = &Skill{
			Title: "Nature's Blight",
			Desc:  "Grants the Lesson of the Devoted AA, causing the target to take 5% increased spell damage. 5 minute recast time, each rank reduces recast by 30 seconds..",
			Image: "/images/builds/icons/rb-dru-naturesblight.png",
		}
		skills[52] = skill
		break

	//==================ENCHANTER======================
	case "enchanter":
		skill = &Skill{
			Title: "Nightmare",
			Desc:  "DoT spells do an additional <em data-base='1'></em>% damage per ally in group<span class='perLevel'> per rank</span>.",
			Image: "/images/builds/icons/rb-enc-nightmare.png",
		}
		skills[0] = skill

		skill = &Skill{
			Title: "Crippling Presence",
			Desc:  "When an enemy is affected by a disempowering spell, they deal <em data-base='2'></em>% less damage<span class='perLevel'> per rank</span>.",
			Image: "/images/builds/icons/rb-enc-cripplingpresence.png",
		}
		skills[2] = skill

		skill = &Skill{
			Title: "Soothing Words",
			Desc:  "Grants the Soothing Words AA, reducing your target's hatred for their current target by 5000 points if that creature's target is a member of your group or raid. Each rank reduces cooldown by <em data-base='30'></em> seconds<span class='perLevel'> per rank</span>.",
			Image: "/images/builds/icons/rb-enc-soothingwords.png",
		}
		skills[4] = skill

		skill = &Skill{
			Title: "Mind over Matter",
			Desc:  "Grants the Mind over Matter AA, absorbing damage in mana before hitpoints. Each rank improves reduction by <em data-base='2'></em>%<span class='perLevel'> per rank</span>.",
			Image: "/images/builds/icons/rb-enc-mindovermatter.png",
		}
		skills[6] = skill

		skill = &Skill{
			Title: "Beneficial Dispell",
			Desc:  "When using a spell with a cancel magic effect, increases chance by <em data-base='20'></em>%<span class='perLevel'> per rank</span> that a beneficial buff will not be affected.",
			Image: "/images/builds/icons/rb-enc-beneficialdispell.png",
		}
		skills[8] = skill

		skill = &Skill{
			Title: "Persuasion",
			Desc:  "Increases buy and sell price to merchants by <em data-base='3'></em>%<span class='perLevel'> per rank</span>.",
			Image: "/images/builds/icons/rb-enc-persuasion.png",
		}
		skills[10] = skill

		skill = &Skill{
			Title: "Choke",
			Desc:  "While an enemy is under the effect of a shallow-breath line debuff, the enemy takes (level *<em data-base='1'></em>/4) damage <span class='perLevel'> per rank</span> when they land an attack.",
			Image: "/images/builds/icons/rb-enc-choke.png",
		}
		skills[13] = skill

		skill = &Skill{
			Title: "Drown",
			Desc:  "Lowers mana cost of DoTs by <em data-base='3'>%</em> tick<span class='perLevel'> per rank</span>.",
			Image: "/images/builds/icons/rb-enc-drown.png",
		}
		skills[16] = skill

		skill = &Skill{
			Title: "Enthrall",
			Desc:  "Each rank reduces mana cost of mesmerize spells by <em data-base='1'>1</em>%, at max rank increases duration by 1 tick<span class='perLevel'> per rank</span>.",
			Image: "/images/builds/icons/rb-enc-enthrall.png",
		}
		skills[18] = skill

		skill = &Skill{
			Title: "Tash",
			Desc:  "While an enemy is tashed, other group members are granted a 300 mod (enemy level * <em data-base='0.2'></em>) damage proc while attacking<span class='perLevel'> per rank</span>.",
			Image: "/images/builds/icons/rb-enc-tash.png",
		}
		skills[20] = skill

		skill = &Skill{
			Title: "Backfire",
			Desc:  "Wandering Mind, Scryer's Bypass, and Torment of Argli now have the backfire effect. If an enemy successfully channels a spell, they are interrupted, this spell effect is removed, and the enemy takes (enemy level * 25 * <em data-base='0.2'>0.2</em>) damage<span class='perLevel'> per rank</span>.",
			Image: "/images/builds/icons/rb-enc-backfire.png",
		}
		skills[22] = skill

		skill = &Skill{
			Title: "Energy Burn",
			Desc:  "When you use a spell that takes mana from an enemy, you now deal (mana taken * <em data-base='0.7'>0.4</em>) damage<span class='perLevel'> per rank</span>.",
			Image: "/images/builds/icons/rb-enc-energyburn.png",
		}
		skills[24] = skill

		skill = &Skill{
			Title: "Feedback",
			Desc:  "When you use a detrimental spell, you deal <em data-base='10'>10</em> bonus damage<span class='perLevel'> per rank</span>.",
			Image: "/images/builds/icons/rb-enc-feedback.png",
		}
		skills[26] = skill

		skill = &Skill{
			Title: "Focus",
			Desc:  "When you use a spell with a stun component, reduces hate generated by <em data-base='7'>7</em>%<span class='perLevel'> per rank</span>.",
			Image: "/images/builds/icons/rb-enc-focus.png",
		}
		skills[28] = skill

		skill = &Skill{
			Title: "Lifeflow",
			Desc:  "When you use a spell that takes mana from an enemy with mana, you heal for (mana taken * <em data-base='0.4'>0.4</em>) hitpoints<span class='perLevel'> per rank</span>.",
			Image: "/images/builds/icons/rb-enc-lifeflow.png",
		}
		skills[31] = skill

		skill = &Skill{
			Title: "Extended Charm",
			Desc:  "When you charm an enemy, increases the minimum duration by 0 to <em data-base='1'>1</em> ticks<span class='perLevel'> per rank</span>.",
			Image: "/images/builds/icons/rb-enc-direcharm.png",
		}
		skills[34] = skill

		skill = &Skill{
			Title: "Mind Devorour",
			Desc:  "When you cast a detrimental spell against a monster with mana, you have a <em data-base='2'>2</em>% chance to recover <em data-base='10'>10</em>% mana<span class='perLevel'> per rank</span>.",
			Image: "/images/builds/icons/rb-enc-entropy.png",
		}
		skills[36] = skill

		skill = &Skill{
			Title: "Color Shock",
			Desc:  "Grants the Color Shock AA, causing a chance to stun when attacked. Chance increases by <em data-base='1'>1</em>%<span class='perLevel'> per rank</span>.",
			Image: "/images/builds/icons/rb-enc-colorshock.png",
		}
		skills[38] = skill

		skill = &Skill{
			Title: "Mana Spear",
			Desc:  "When you use a spell that takes mana from an enemy, increases chance to land by <em data-base='2'>2</em>%<span class='perLevel'> per rank</span>.",
			Image: "/images/builds/icons/rb-enc-manaspear.png",
		}
		skills[40] = skill

		skill = &Skill{
			Title: "Flowing Thought",
			Desc: "Breeze now grants the enchanter many of their buffs.<br>Rank 1: Breeze (to mana users)<br>Rank 2: Visage Line (+to tanks, -to rest)<br>Rank 3: Gift Line and Brilliance/Insight (to mana users)<br>Rank 4: Haste (to non-casters)<br>Rank 5: Doubles duration of buffs'; 	",
			Image: "/images/builds/icons/rb-enc-flowingthought.png",
		}
		skills[42] = skill

		skill = &Skill{
			Title: "Subtle Casting",
			Desc:  "Lowers aggression when casting a spell by <em data-base='2'>2</em>%<span class='perLevel'> per rank</span>.",
			Image: "/images/builds/icons/rb-enc-subtlecasting.png",
		}
		skills[44] = skill

		skill = &Skill{
			Title: "Bad Moon",
			Desc:  "While grouped with an enchanter, all allies gain an innate 100 proc that deals a (level * <em data-base='0.2'>0.2</em>) lifetap<span class='perLevel'> per rank</span>",
			Image: "/images/builds/icons/rb-enc-badmoon.png",
		}
		skills[46] = skill

		skill = &Skill{
			Title: "Tranquility",
			Desc:  "While in a group, you and your allies gain (group size * level * <em data-base='0.1'>0.1</em>) mana regen per tick<span class='perLevel'> per rank</span>",
			Image: "/images/builds/icons/rb-enc-tranquility.png",
		}
		skills[49] = skill

		skill = &Skill{
			Title: "Reclaim",
			Desc:  "When you tell your pet to leave, you will gain (mana * <em data-base='0.2'>0.2</em>) of back of it's mana cost with ratio of current to max hitpoints<span class='perLevel'> per rank</span>",
			Image: "/images/builds/icons/rb-enc-reclaim.png",
		}
		skills[52] = skill
		break

	//==================MAGICIAN======================
	case "magician":
		skill = &Skill{
			Title: "Summoning Focus",
			Desc:  "Items summoned by the magician are reinforced, giving better stats. Additional ranks increase the level of spells affected.",
			Image: "/images/builds/icons/rb-mag-summoningfocus.png",
		}
		skills[0] = skill

		skill = &Skill{
			Title: "Quick Summoning",
			Desc:  "Reduces the cast time of pet summoning spells by <em data-base='10'>10</em>%<span class='perLevel'> per rank</span>.",
			Image: "/images/builds/icons/rb-mag-quicksummoning.png",
		}
		skills[2] = skill

		skill = &Skill{
			Title: "Improved Reclaim Energy",
			Desc:  "Increases the amount of mana returned by Reclaim Energy by <em data-base='5'>5</em>%<span class='perLevel'> per rank</span>.",
			Image: "/images/builds/icons/rb-mag-improvedreclaimenergy.png",
		}
		skills[4] = skill

		skill = &Skill{
			Title: "Modulation Shard",
			Desc:  "Summons a modulation rod with <em data-base='1'>1</em> charge<span class='perLevel'> per rank</span>.",
			Image: "/images/builds/icons/rb-mag-modulationshard.png",
		}
		skills[6] = skill

		skill = &Skill{
			Title: "Companion's Intensity",
			Desc:  "Increases your pet's damage melee damage by <em data-base='2'>2</em>%<span class='perLevel'> per rank</span>.",
			Image: "/images/builds/icons/rb-mag-companionsdurability.png",
		}
		skills[8] = skill

		skill = &Skill{
			Title: "Suspended Minion",
			Desc:  "Grants the Suspended Minion AA, allowing you to suspend a minion to be recalled later. Further ranks allow preserving buffs and items while suspended.",
			Image: "/images/builds/icons/rb-mag-suspendedminion.png",
		}
		skills[10] = skill

		skill = &Skill{
			Title: "Mend Companion",
			Desc:  "Grants the Mend Companion AA, healing <em data-base='20'>20</em>% of your pet's HP per rank",
			Image: "/images/builds/icons/rb-mag-mendcompanion.png",
		}
		skills[13] = skill

		skill = &Skill{
			Title: "Companion of Necessity",
			Desc:  "Grants the Companion of Necessity AA, summoning a temporary pet that will gain the attention of one creature and cause that creature to forget all anger when the pet dies. Each rank grants <em data-base='20'>20</em>% of maximum duration.",
			Image: "/images/builds/icons/rb-mag-companionofnecessity.png",
		}
		skills[16] = skill

		skill = &Skill{
			Title: "Shared Health",
			Desc:  "Grants the Shared Health AA, causing <em data-base='10'>10</em>% of your incoming damage<span class='perLevel'> per rank</span> to be sent to your pet instead.",
			Image: "/images/builds/icons/rb-mag-sharedhealth.png",
		}
		skills[18] = skill

		skill = &Skill{
			Title: "Host in the Shell",
			Desc:  "Grants the Host in the Shell AA, creating a rune effect on your pet with <em data-base='20'>20</em>% of the rune's maximum value<span class='perLevel'> per rank</span>.",
			Image: "/images/builds/icons/rb-mag-hostintheshell.png",
		}
		skills[20] = skill

		skill = &Skill{
			Title: "Turn Summoned",
			Desc:  "Grants the Turn Summoned AA, inflicing a DoT for <em data-base='500'>500</em> damage per rank per tick for 4 ticks with a <em data-base='1'>1</em>% chance<span class='perLevel'> per rank</span> to cause 32000 damage.",
			Image: "/images/builds/icons/rb-mag-turnsummoned.png",
		}
		skills[22] = skill

		skill = &Skill{
			Title: "Frenzied Burnout",
			Desc:  "Reduces the mana cost of direct damage spells by <em data-base='10'>10</em>%<span class='perLevel'> per rank</span>.",
			Image: "/images/builds/icons/rb-mag-frenziedburnout.png",
		}
		skills[24] = skill

		skill = &Skill{
			Title: "Elemental Alacrity",
			Desc:  "Improves element-based direct damage spells by <em data-base='4'>4</em>% damage per rank.",
			Image: "/images/builds/icons/rb-mag-elementalalacrity.png",
		}
		skills[26] = skill

		skill = &Skill{
			Title: "Call of the Hero",
			Desc:  "Grants the Call of the Hero AA with reduced cast time and cooldown timer per rank.",
			Image: "/images/builds/icons/rb-mag-callofthehero.png",
		}
		skills[28] = skill

		skill = &Skill{
			Title: "Clockwork Merchant",
			Desc:  "Grants the Clockwork Banker AA that summons a merchant. Ranks decrease the cooldown substantially.",
			Image: "/images/builds/icons/rb-mag-clockworkmerchant.png",
		}
		skills[31] = skill

		skill = &Skill{
			Title: "Servant of Ro",
			Desc:  "Grants the Servant of Ro AA that calls a loyal servant into being who will repeatedly hurl fire at your target. Ranks increase the duration of this temprorary pet.",
			Image: "/images/builds/icons/rb-mag-servantofro.png",
		}
		skills[34] = skill

		skill = &Skill{
			Title: "Dimensional Shield",
			Desc:  "Grants Dimensional Shield AA that allows a chance to shadow step away from the attacking target. Ranks increase the chance of the defensive proc by <em data-base='20'>20</em>% per rank.",
			Image: "/images/builds/icons/rb-mag-dimensionalshield.png",
		}
		skills[36] = skill

		skill = &Skill{
			Title: "Heart of Stone",
			Desc:  "Grants Heart of Stone AA that provides a melee guard. The melee guard is scaled at 10% per rank.",
			Image: "/images/builds/icons/rb-mag-heartofstone.png",
		}
		skills[38] = skill

		skill = &Skill{
			Title: "Heart of Vapor",
			Desc:  "Grants Heart of Vapor AA that reduces hate generated. The effectiveness of the spell is 20>% per rank.",
			Image: "/images/builds/icons/rb-mag-heartofvapor.png",
		}
		skills[40] = skill

		skill = &Skill{
			Title: "Shock of Swords",
			Desc:  "Increases the damage caused by sword and blade spells by <em data-base='4'>4</em>% per rank.",
			Image: "/images/builds/icons/rb-mag-shockofswords.png",
		}
		skills[42] = skill

		skill = &Skill{
			Title: "Heart of Ice",
			Desc:  "Grants Heart of Ice AA that provides a spell guard. The spell guard is scaled at 10% per rank.",
			Image: "/images/builds/icons/rb-mag-heartofice.png",
		}
		skills[44] = skill

		skill = &Skill{
			Title: "Quick Damage",
			Desc:  "Reduces the cast time of direct damage spells that have casting times longer than 3 seconds. Each rank further decreases the cast time.",
			Image: "/images/builds/icons/rb-mag-quickdamage.png",
		}
		skills[46] = skill

		skill = &Skill{
			Title: "Heart of Flames",
			Desc:  "Grants Heart of Flames AA that provides a massive damage shield. The effectiveness of the spell is scaled at <em data-base='20'>20</em>% <span class='perLevel'> per rank</span>.",
			Image: "/images/builds/icons/rb-mag-heartofflames.png",
		}
		skills[49] = skill

		skill = &Skill{
			Title: "Primal Fusion",
			Desc:  "When you attack with a direct damage spell, your pet will also cast the spell dealing <em data-base='5'>5</em> of it's damage<span class='perLevel'> per rank</span>.",
			Image: "/images/builds/icons/rb-mag-primalfusion.png",
		}
		skills[52] = skill
		break

	//==================MONK======================
	case "monk":
		skill = &Skill{
			Title: "Intensified Training",
			Desc:  "The monk gains a 300 mod proc that deals (level * 1.25 * <em data-base='0.2'>0.2</em>) magic damage<span class='perLevel'> per rank</span>.",
			Image: "/images/builds/icons/rb-mnk-intensifiedtraining.png",
		}
		skills[0] = skill

		skill = &Skill{
			Title: "Familiarity",
			Desc:  "Every time a special attack lands on an enemy, the monk gains <em data-base='2'>2</em> armor against the target<span class='perLevel'> per rank</span>.",
			Image: "/images/builds/icons/rb-mnk-familiarity.png",
		}
		skills[2] = skill

		skill = &Skill{
			Title: "Block",
			Desc:  "Increases block by <em data-base='2'>2</em>%<span class='perLevel'> per rank</span>.",
			Image: "/images/builds/icons/rb-mnk-block.png",
		}
		skills[4] = skill

		skill = &Skill{
			Title: "Relentless Training",
			Desc:  "Increases damage of Tiger Claw, Eagle Strike, Tail Whip and other special attacks by <em data-base='10'>10</em>%<span class='perLevel'> per rank</span>.",
			Image: "/images/builds/icons/rb-mnk-relentlesstraining.png",
		}
		skills[6] = skill

		skill = &Skill{
			Title: "Expose Weakness",
			Desc:  "When using Tiger Claw, Eagle Strike, Tail Whip and other special attacks, increases accuracy of all attacking allies by 0 to <em data-base='2'>2</em><span class='perLevel'> per rank</span> vs that enemy.",
			Image: "/images/builds/icons/rb-mnk-exposeweakness.png",
		}
		skills[8] = skill

		skill = &Skill{
			Title: "Destiny",
			Desc:  "When you have an enemy targeted, increases avoidance by <em data-base='1'>1</em>% <span class='perLevel'> per rank</span>",
			Image: "/images/builds/icons/rb-mnk-destiny.png",
		}
		skills[10] = skill

		skill = &Skill{
			Title: "Wu's Quickening",
			Desc:  "Reduces delay of your primary weapon by <em data-base='1'>1</em> <span class='perLevel'> per rank</span>, to a minimum of 7.",
			Image: "/images/builds/icons/rb-mnk-wusquickening.png",
		}
		skills[13] = skill

		skill = &Skill{
			Title: "Grace of the Order",
			Desc:  "Grants the Lesson of the Devoted AA, increasing max health by 15% and a 250dd stun. 10 minute recast time, each rank reduces recast by 30 seconds.",
			Image: "/images/builds/icons/rb-mnk-graceoftheorder.png",
		}
		skills[16] = skill

		skill = &Skill{
			Title: "Partial Mending",
			Desc:  "When mend fails, the monk still heals for <em data-base='10'>10</em>% of the mending amount<span class='perLevel'> per rank</span>.",
			Image: "/images/builds/icons/rb-mnk-partialmending.png",
		}
		skills[18] = skill

		skill = &Skill{
			Title: "Inner Chakra",
			Desc:  "Heals received while using feign death, including mend, heal for an additional <em data-base='4'>4</em>%<span class='perLevel'> per rank</span>.",
			Image: "/images/builds/icons/rb-mnk-innerchakra.png",
		}
		skills[20] = skill

		skill = &Skill{
			Title: "Channel Chakra",
			Desc:  "While your health is less than <em data-base='10'>10</em>%, and no enemy is actively attacking you, your normal melee attacks lifetap for <em data-base='2'>2</em>% damage<span class='perLevel'> per rank</span>.",
			Image: "/images/builds/icons/rb-mnk-channelchakra.png",
		}
		skills[22] = skill

		skill = &Skill{
			Title: "Mending Aura",
			Desc:  "When you use Mend, you now heal the rest of the group within <em data-base='5'>5</em> meters for <em data-base='20'>20</em>% the mend heal amount<span class='perLevel'> per rank</span>.",
			Image: "/images/builds/icons/rb-mnk-mendingaura.png",
		}
		skills[24] = skill

		skill = &Skill{
			Title: "Divine Surge",
			Desc:  "When you land Tiger Claw, Eagle Strike, Tail Whip or other special attacks, your group recovers <em data-base='2'>2</em> mana within <em data-base='5'>5</em>m<span class='perLevel'> per rank</span>.",
			Image: "/images/builds/icons/rb-mnk-divinesurge.png",
		}
		skills[26] = skill

		skill = &Skill{
			Title: "Improved Mend",
			Desc:  "When you use Mend, you heal an additional 5% to <em data-base='10'>10</em>% hitpoints<span class='perLevel'> per rank</span>.",
			Image: "/images/builds/icons/rb-mnk-improvedmend.png",
		}
		skills[28] = skill

		skill = &Skill{
			Title: "Purify Body",
			Desc:  "Grants the Purify Body AA, curing <em data-base='1'>1</em> detrimental effect on the monk<span class='perLevel'> per rank</span>. At rank 5, it will also cure resurrection sickness.",
			Image: "/images/builds/icons/rb-mnk-purifybody.png",
		}
		skills[31] = skill

		skill = &Skill{
			Title: "Tranquility",
			Desc:  "When you are not affected by negative effects, not under feign death, nor are engaged by an enemy, and in a full group, you regenerate <em data-base='2'>2</em>% of your total missing health per tick <span class='perLevel'> per rank</span>. Lesser group sizes give reduced healing.",
			Image: "/images/builds/icons/rb-mnk-tranquility.png",
		}
		skills[34] = skill

		skill = &Skill{
			Title: "Agile Feet",
			Desc:  "Increases your chance to resist snares by <em data-base='2'>2</em>% <span class='perLevel'> per rank</span>.",
			Image: "/images/builds/icons/rb-mnk-agilefeet.png",
		}
		skills[36] = skill

		skill = &Skill{
			Title: "Cowardly Stance",
			Desc:  "Increases your movement speed by up to <em data-base='10'>10</em>% based on missing health. Does not stack with movement buffs<span class='perLevel'> per rank</span>.",
			Image: "/images/builds/icons/rb-mnk-cowardlystance.png",
		}
		skills[38] = skill

		skill = &Skill{
			Title: "Thunderfoot",
			Desc:  "Grants a passive spell block that returns when used after (level - <em data-base='6'>6</em>) seconds<span class='perLevel'> per rank</span>.",
			Image: "/images/builds/icons/rb-mnk-thunderfoot.png",
		}
		skills[40] = skill

		skill = &Skill{
			Title: "Stoic Mind",
			Desc:  "While your health is not below <em data-base='2'>2</em>%, your resistance to spells is increased by <em data-base='3'>3</em>%<span class='perLevel'> per rank</span>.",
			Image: "/images/builds/icons/rb-mnk-stoicmind.png",
		}
		skills[42] = skill

		skill = &Skill{
			Title: "Grounded Essence",
			Desc:  "Gives a <em data-base='2'>2</em>% to resist an attempt at being summoned by an enemy<span class='perLevel'> per rank</span>.",
			Image: "/images/builds/icons/rb-mnk-groundedessence.png",
		}
		skills[44] = skill

		skill = &Skill{
			Title: "Slow Heart Rate",
			Desc:  "When you feign death with health below <em data-base='2'>2</em>%<span class='perLevel'> per rank</span>, your feign death will cause all enemies to immediately forget you",
			Image: "/images/builds/icons/rb-mnk-slowheartrate.png",
		}
		skills[46] = skill

		skill = &Skill{
			Title: "Mirror",
			Desc:  "While your health is at 99% or higher, your chance to evade attacks is increased by <em data-base='2'>2</em>%<span class='perLevel'> per rank</span>.",
			Image: "/images/builds/icons/rb-mnk-mirror.png",
		}
		skills[49] = skill

		skill = &Skill{
			Title: "Moving Mountains",
			Desc:  "When you use the throw stone ability against an enemy lower level than you, you now knockback the enemy <em data-base='1'>1</em>m<span class='perLevel'> per rank</span>.",
			Image: "/images/builds/icons/rb-mnk-movingmountains.png",
		}
		skills[52] = skill
		break

	//==================NECROMANCER======================
	case "necromancer":
		skill = &Skill{
			Title: "Corruption",
			Desc:  "DoT damage is increased by <em data-base='1'>1</em>% per ally in group<span class='perLevel'> per rank</span>.",
			Image: "/images/builds/icons/rb-nec-corruption.png",
		}
		skills[0] = skill

		skill = &Skill{
			Title: "Cavorting Bones",
			Desc:  "Empowers your pet to dynamically level with you at <em data-base='20'>20</em>% effectiveness<span class='perLevel'> per rank</span>. At 59+, the pet will be a spectre.",
			Image: "/images/builds/icons/rb-nec-cavoringbones.png",
		}
		skills[2] = skill

		skill = &Skill{
			Title: "Shocking Bolt",
			Desc:  "When a poison-based DoT with bolt in it's name (or venom of the snake) lands on an enemy, the instant damage is increased by <em data-base='5'>5</em>% <span class='perLevel'> per rank</span>. It also has a <em data-base='1'>1</em>% chance to hit for quad damage.",
			Image: "/images/builds/icons/rb-nec-shockingbolt.png",
		}
		skills[4] = skill

		skill = &Skill{
			Title: "Burning Soul",
			Desc:  "When an enemy is affected by a fire-based DoT, it deals <em data-base='1'>1</em>% more damage for each ally in group.",
			Image: "/images/builds/icons/rb-nec-burningsoul.png",
		}
		skills[6] = skill

		skill = &Skill{
			Title: "Lingering Curse",
			Desc:  "Increases DoT duration by <em data-base='1'>1</em> tick per rank, the duration is lowered the closer the enemy is to your level. Minimum 1 tick<span class='perLevel'> per rank</span>.",
			Image: "/images/builds/icons/rb-nec-lingeringcurse.png",
		}
		skills[8] = skill

		skill = &Skill{
			Title: "Decay",
			Desc:  "While a DoT affects an enemy, mana is returned to the necromancer at a rate of <em data-base='1'>1</em>% of cost per tick<span class='perLevel'> per rank</span>.",
			Image: "/images/builds/icons/rb-nec-decay.png",
		}
		skills[10] = skill

		skill = &Skill{
			Title: "Splurt",
			Desc:  "Splurt now deals <em data-base='10'>10</em>% more damage<span class='perLevel'> per rank</span>.",
			Image: "/images/builds/icons/rb-nec-splurt.png",
		}
		skills[13] = skill

		skill = &Skill{
			Title: "Venom Strike",
			Desc:  "Poison-based direct damage spells such as Torbas line of spells, now have a <em data-base='1'>1</em>% chance to also apply a poison damage over time<span class='perLevel'> per rank</span>.",
			Image: "/images/builds/icons/rb-nec-venomstrike.png",
		}
		skills[16] = skill

		skill = &Skill{
			Title: "Shroud of Death",
			Desc:  "Your pet gains a 400 mod proc DD that deals (level * <em data-base='0.2'>0.2</em>) magic damage and if Spirit Focus is trained and a focus target is set, a recourse heal for 100% of damage dealt is given<span class='perLevel'> per rank</span>.",
			Image: "/images/builds/icons/rb-nec-shroudofdeath.png",
		}
		skills[18] = skill

		skill = &Skill{
			Title: "Life Burn",
			Desc:  "Unlocks the Life Burn AA, dealing <em data-base='2'>2</em>% of your current health as damage<span class='perLevel'> per rank</span> at a very low mana cost.",
			Image: "/images/builds/icons/rb-nec-lifeburn.png",
		}
		skills[20] = skill

		skill = &Skill{
			Title: "Pact of Hate",
			Desc:  "Dark Pact line spells now regenerate an additional <em data-base='10'>10</em>% mana based on damage dealt<span class='perLevel'> per rank</span>.",
			Image: "/images/builds/icons/rb-nec-pactofhate.png",
		}
		skills[22] = skill

		skill = &Skill{
			Title: "Blood Magic",
			Desc:  "Grants the Blood Magic AA, giving the necromancer the ability to cast spells at the cost of health. With a base of 10 minutes, each rank reduces cooldown by 30 seconds.",
			Image: "/images/builds/icons/rb-nec-bloodmagic.png",
		}
		skills[24] = skill

		skill = &Skill{
			Title: "Life Blood",
			Desc:  "Increases amount healed by lifetaps by (<em data-base='2'>2</em>% * group size) <span class='perLevel'> per rank</span> and increases chance to critical heal by <em data-base='2'>2</em>%.",
			Image: "/images/builds/icons/rb-nec-lifeblood.png",
		}
		skills[26] = skill

		skill = &Skill{
			Title: "Spirit Focus",
			Desc:  "Enables use of the #focus command, transferring recourses such as life taps to the focused ally for <em data-base='16'>16</em>% of the recourse given<span class='perLevel'> per rank</span>.",
			Image: "/images/builds/icons/rb-nec-spiritfocus.png",
		}
		skills[28] = skill

		skill = &Skill{
			Title: "Dying Grasp",
			Desc:  "Grants the Dying Grasp AA, a high damage, fast casting lifetap. Base cooldown of 360 seconds, each rank reduces cooldown by 30 seconds.",
			Image: "/images/builds/icons/rb-nec-dyinggrasp.png",
		}
		skills[31] = skill

		skill = &Skill{
			Title: "Servant of Blood",
			Desc:  "Grants the Lesson of the Devoted AA, summoning a blood skeleton that lifetaps health to the group for 30 seconds. 10 minute recast time, each rank reduces recast by 30 seconds.",
			Image: "/images/builds/icons/rb-nec-servantofblood.png",
		}
		skills[34] = skill

		skill = &Skill{
			Title: "Life Link",
			Desc:  "Necromancer pets now recourse to the #focus target, or the necro themselves.<span class='perLevel'> per rank</span>.",
			Image: "/images/builds/icons/rb-nec-venomstrike.png",
		}
		skills[31] = skill
		break

	//==================PALADIN======================
	case "paladin":
		skill = &Skill{
			Title: "Rodcet's Gift",
			Desc:  "Single target healing spells now spread to allies within <em data-base='10'>10</em>m of the healed target, healing them for <em data-base='2'>2</em>% the original heal amount<span class='perLevel'> per rank</span>.",
			Image: "/images/builds/icons/rb-pal-rodcetsgift.png",
		}
		skills[0] = skill

		skill = &Skill{
			Title: "Hand of Piety",
			Desc:  "Grants the Hand of Piety AA, allowing the user to heal the group for <em data-base='2'>2</em>% of their max health <span class='perLevel'> per rank</span>.",
			Image: "/images/builds/icons/rb-pal-handofpiety.png",
		}
		skills[2] = skill

		skill = &Skill{
			Title: "Instill Purpose",
			Desc:  "Divine Purpose and Breath of Tunare now grant <em data-base='20'>20</em>% more hitpoint regeneration <span class='perLevel'> per rank</span>.",
			Image: "/images/builds/icons/rb-pal-instillpurpose.png",
		}
		skills[4] = skill

		skill = &Skill{
			Title: "Refreshing Breeze",
			Desc:  "All healing except Hand of Piety give healed targets <em data-base='0.5'>0.5</em>% of amount healed as mana<span class='perLevel'> per rank</span>. Does not work when healing yourself.",
			Image: "/images/builds/icons/rb-pal-refreshingbreeze.png",
		}
		skills[6] = skill

		skill = &Skill{
			Title: "Brell's Blessing",
			Desc:  "Courage now grants Paladin buffs<br>Rank 1: AC<br>Rank 2: HP Line 1<br>Rank 3: HP Symbol Line<br>Rank 4: HP Line 2 (Brell)<br>Rank 5: Double duration.",
			Image: "/images/builds/icons/rb-pal-brellsblessing.png",
		}
		skills[8] = skill

		skill = &Skill{
			Title: "Soul Cleansing",
			Desc:  "Cleansing heal over time spells now have a <em data-base='2'>2</em>% chance to cure an ailment<span class='perLevel'> per rank</span>.",
			Image: "/images/builds/icons/rb-pal-soulcleansing.png",
		}
		skills[10] = skill

		skill = &Skill{
			Title: "Wave of Marr",
			Desc:  "All wave-based group spells cost <em data-base='10'>10</em>% less mana to cast<span class='perLevel'> per rank</span>.",
			Image: "/images/builds/icons/rb-pal-waveofmarr.png",
		}
		skills[13] = skill

		skill = &Skill{
			Title: "Ward of Tunare",
			Desc:  "Passively grants the Paladin a <em data-base='6'>6</em>% bonus when healed by other allies<span class='perLevel'> per rank</span>.",
			Image: "/images/builds/icons/rb-pal-wardoftunare.png",
		}
		skills[16] = skill

		skill = &Skill{
			Title: "Shield of Nife",
			Desc:  "Grants an Undead-only damage shield that deals <em data-base='7'>7</em> damage<span class='perLevel'> per rank</span>.",
			Image: "/images/builds/icons/rb-pal-shieldofnife.png",
		}
		skills[18] = skill

		skill = &Skill{
			Title: "Armor of Faith",
			Desc:  "Damage taken from Undead is reduced by <em data-base='2.5'>2.5</em>%<span class='perLevel'> per rank</span>.",
			Image: "/images/builds/icons/rb-pal-armoroffaith.png",
		}
		skills[20] = skill

		skill = &Skill{
			Title: "Purification",
			Desc:  "Grants the Purification AA, curing <em data-base='1'>1</em> detrimental effect on the paladin<span class='perLevel'> per rank</span>. At rank 5, it will also cure resurrection sickness.",
			Image: "/images/builds/icons/rb-pal-purification.png",
		}
		skills[22] = skill

		skill = &Skill{
			Title: "Holy Servant",
			Desc:  "When a group member within <em data-base='2'>2</em>m is attacked, <em data-base='2.5'>2.5</em>% of the dealt damage is redirected to the paladin and is reduced by <em data-base='2'>2</em>%<span class='perLevel'> per rank</span>.",
			Image: "/images/builds/icons/rb-pal-holyservant.png",
		}
		skills[24] = skill

		skill = &Skill{
			Title: "Divine Stun",
			Desc:  "Grants the Divine Stun AA, causing a target to be stunned and marked with divine anger. Any time the Paladin casts a heal spell on a group member, the marked enemy gains an additional <em data-base='200'>200</em> hatred<span class='perLevel'> per rank</span>.",
			Image: "/images/builds/icons/rb-pal-divinestun.png",
		}
		skills[26] = skill

		skill = &Skill{
			Title: "Act of Valor",
			Desc:  "Grants the Act of Valor AA, summoning a squire that will dutifully assist the Paladin, casting stuns and healing themself. Each rank increases his stats and power by <em data-base='20'>20</em>% efficiency<span class='perLevel'> per rank</span>.",
			Image: "/images/builds/icons/rb-pal-actofvalor.png",
		}
		skills[28] = skill

		skill = &Skill{
			Title: "Elixir of Might",
			Desc:  "Instrument of Nife and Divine Might proc effects now heal the Paladin for <em data-base='10'>10</em>% of damage dealt as well as gain <em data-base='2'>2</em> mana<span class='perLevel'> per rank</span>.",
			Image: "/images/builds/icons/rb-pal-elixirofmight.png",
		}
		skills[31] = skill

		skill = &Skill{
			Title: "Flames of Redemption",
			Desc:  "Grants the Lesson of the Devoted AA, causing flames of redemption buff improving healing effectiveness by 25% and the flames of redemption DD proc. 10 minute recast time, each rank reduces recast by 30 seconds.",
			Image: "/images/builds/icons/rb-pal-flamesofredemption.png",
		}
		skills[34] = skill

		skill = &Skill{
			Title: "Zealot's Fervor",
			Desc:  "When a heal is casted by a paladin, up to <em data-base='1'>1</em> nearby enemies of the target are dealt <em data-base='1'>1</em>% of the healing as damage. <span class='perLevel'> per rank</span>.",
			Image: "/images/builds/icons/rb-pal-zealotsfervor.png",
		}
		skills[36] = skill

		skill = &Skill{
			Title: "Knight's Advantage",
			Desc:  "2 handed weapons deal an additional <em data-base='5'>5</em>% damage<span class='perLevel'> per rank</span>.",
			Image: "/images/builds/icons/rb-pal-knightsadvantage.png",
		}
		skills[38] = skill

		skill = &Skill{
			Title: "Chosen",
			Desc:  "All self proc buffs deal <em data-base='25'>25</em>% more damage<span class='perLevel'> per rank</span>.",
			Image: "/images/builds/icons/rb-pal-chosen.png",
		}
		skills[40] = skill

		skill = &Skill{
			Title: "Purpose of Marr",
			Desc:  "Valor of Marr now grants <em data-base='10'>10</em>% additional attack speed<span class='perLevel'> per rank</span>.",
			Image: "/images/builds/icons/rb-pal-purposeofmarr.png",
		}
		skills[42] = skill

		skill = &Skill{
			Title: "Flame of Light",
			Desc:  "Flame of Light now deals an additional <em data-base='20'>20</em>% damage<span class='perLevel'> per rank</span>.",
			Image: "/images/builds/icons/rb-pal-flameoflight.png",
		}
		skills[44] = skill

		skill = &Skill{
			Title: "Dismiss Evil",
			Desc:  "When attacking an evil creature, gives a <em data-base='1'>1</em>% chance to critical hit<span class='perLevel'> per rank</span>.",
			Image: "/images/builds/icons/rb-pal-dismissevil.png",
		}
		skills[46] = skill

		skill = &Skill{
			Title: "Frail",
			Desc:  "Stun spells also cripple the target for 0 to <em data-base='1'>1</em>ticks <span class='perLevel'> per rank</span>.",
			Image: "/images/builds/icons/rb-pal-frail.png",
		}
		skills[49] = skill

		skill = &Skill{
			Title: "Slayer",
			Desc:  "Grants an ability to cleanse the target, similar to Slay Undead, but works on ALL creature types, up to the level of the paladin, with a <em data-base='100'>100</em> mod proc<span class='perLevel'> per rank</span>.",
			Image: "/images/builds/icons/rb-pal-slayer.png",
		}
		skills[52] = skill
		break
	//==================RANGER======================
	case "ranger":
		break

	//==================ROGUE======================
	case "rogue":
		skill = &Skill{
			Title: "Appraisal",
			Desc:  "The rogue gains a 400 mod proc that deals (level * 3 * <em data-base='0.2'>0.2</em>) magic damage as well as a fleeting fury buff.",
			Image: "/images/builds/icons/rb-rog-appraisal.png",
		}
		skills[0] = skill

		skill = &Skill{
			Title: "Killing Spree",
			Desc:  "Each time a creature is successfully killed, the rogue gains a killing spree counter. For a limited time, attacks deal an additional <em data-base='5'>5</em>% damage per counter, with a cap of <em data-base='2'>2</em> counters<span class='perLevel'> per rank</span>.",
			Image: "/images/builds/icons/rb-rog-killingspree.png",
		}
		skills[2] = skill

		skill = &Skill{
			Title: "Thief's Eyes",
			Desc:  "Increases accuracy by <em data-base='2'>2</em>% with all skills <span class='perLevel'> per rank</span>.",
			Image: "/images/builds/icons/rb-rog-thiefseyes.png",
		}
		skills[4] = skill

		skill = &Skill{
			Title: "Sinister Strikes",
			Desc:  "Increases offhand damage bonus by <em data-base='10'>10</em>%<span class='perLevel'> per rank</span>.",
			Image: "/images/builds/icons/rb-rog-sinisterstrikes.png",
		}
		skills[6] = skill

		skill = &Skill{
			Title: "Sneak Attack",
			Desc:  "If a rogue is sneaking and uses a backstab while an enemy is greater than 70% hp, improves chance to hit with a backstab by <em data-base='2000'>2000</em>% and critical chance increases by <em data-base='10'>10</em>% <span class='perLevel'> per rank</span>.",
			Image: "/images/builds/icons/rb-rog-sneakattack.png",
		}
		skills[8] = skill

		skill = &Skill{
			Title: "Focused Stab",
			Desc:  "Backstab has a <em data-base='5'>5</em>% better chance to hit<span class='perLevel'> per rank</span> and when maxxed, allows a chance to backstabs from front.",
			Image: "/images/builds/icons/rb-rog-focusedstab.png",
		}
		skills[10] = skill

		skill = &Skill{
			Title: "Vital Organs",
			Desc:  "Backstab deals <em data-base='20'>20</em>% more damage<span class='perLevel'> per rank</span>.",
			Image: "/images/builds/icons/rb-rog-vitalorgans.png",
		}
		skills[13] = skill

		skill = &Skill{
			Title: "Assassin's Taint",
			Desc:  "Grants the Lesson of the Devoted AA, granting the assassins taint buff that grants triple backstab and a proc that causes skill taken damage to be increased by 7%. 10 minute recast time, each rank reduces recast by 30 seconds.",
			Image: "/images/builds/icons/rb-rog-assassinstaint.png",
		}
		skills[16] = skill

		skill = &Skill{
			Title: "Sleight Distraction",
			Desc:  "When the rogue successfully pick pockets an enemy (even if they do not obtain an item) while in a group, the enemy becomes mesmerized for 0 to <em data-base='1'>1</em> ticks. The next time the enemy attacks the rogue it has a very high chance of missing. <span class='perLevel'> per rank</span>",
			Image: "/images/builds/icons/rb-rog-sleightdistraction.png",
		}
		skills[18] = skill

		skill = &Skill{
			Title: "Jarring Stab",
			Desc:  "When the rogue successfully backstabs an enemy, all enemies that are hated by the rogue have a reduction of (<em data-base='0.2'>0.2</em> * damage) hate<span class='perLevel'> per rank</span>.",
			Image: "/images/builds/icons/rb-rog-jarringstab.png",
		}
		skills[20] = skill

		skill = &Skill{
			Title: "Untapped Potential",
			Desc:  "When you successfully pickpocket, your group recovers <em data-base='1'>1</em>% of a target's max mana when within <em data-base='5'>5</em>m<span class='perLevel'> per rank</span>.",
			Image: "/images/builds/icons/rb-rog-untappedpotential.png",
		}
		skills[22] = skill

		skill = &Skill{
			Title: "Confuse",
			Desc:  "When a rogue uses beg on an enemy, there is a very small chance to cause the enemy to be mesmerized for 6 seconds.",
			Image: "/images/builds/icons/rb-rog-confuse.png",
		}
		skills[24] = skill

		skill = &Skill{
			Title: "Gangster's Paradise",
			Desc:  "Rogue melee attacks passively cause <em data-base='10'>10</em> less hate per attack, and when a rogue is out of combat and does not move for some time, they have a chance to gain a Shroud of Stealth like state. The chances of gaining Shroud of Stealth is increased when two rogues are grouped and near each other.",
			Image: "/images/builds/icons/rb-rog-gangstersparadise.png",
		}
		skills[26] = skill

		skill = &Skill{
			Title: "Moss Stone",
			Desc:  "When throw stone is used on a creature with less than 20% health and is not snared, it has a <em data-base='20'>20</em>% chance to ensnare the enemy.",
			Image: "/images/builds/icons/rb-rog-mossstone.png",
		}
		skills[28] = skill

		skill = &Skill{
			Title: "Duelist",
			Desc:  "While engaged with a single enemy who is lesser level than the rogue, the rogue gains improved evasion. Many factors decrease the effectiveness of this skill, such as the level of the enemy and how much health they have.",
			Image: "/images/builds/icons/rb-rog-duelist.png",
		}
		skills[31] = skill

		skill = &Skill{
			Title: "Escape",
			Desc:  "Grants the Escape AA, allowing the rogue to escape combat instantly for 50% of your endurance bar. Endurance cost is reduced by <em data-base='10'>10</em>%<span class='perLevel'> per rank</span>.",
			Image: "/images/builds/icons/rb-rog-escape.png",
		}
		skills[34] = skill

		skill = &Skill{
			Title: "Sleight of Strength",
			Desc:  "When the rogue successfully pick pockets, they gain a random beneficial buff for 0 to <em data-base='1'>1</em> ticks<span class='perLevel'> per rank</span>.",
			Image: "/images/builds/icons/rb-rog-sleightofstrength.png",
		}
		skills[36] = skill

		skill = &Skill{
			Title: "Haggle",
			Desc:  "When a rogue sells or buys items, the price is improved by <em data-base='2'>2</em>%<span class='perLevel'> per rank</span>.",
			Image: "/images/builds/icons/rb-rog-haggle.png",
		}
		skills[38] = skill

		skill = &Skill{
			Title: "Hidden Stash",
			Desc:  "When a rogue pickpockets, they dive deeper into the enemy's pockets to discover a hidden stash of coin<span class='perLevel'> per rank</span>.",
			Image: "/images/builds/icons/rb-rog-hiddenstash.png",
		}
		skills[40] = skill

		skill = &Skill{
			Title: "Throwing Precision",
			Desc:  "Increases the minimum damage of throwing daggers by <em data-base='10'>10</em>%<span class='perLevel'> per rank</span>.",
			Image: "/images/builds/icons/rb-rog-throwingprecision.png",
		}
		skills[42] = skill

		skill = &Skill{
			Title: "Mugging Shot",
			Desc: "Adds a special proc based on the offhand wielded by the rogue, has a <em data-base='100'>100</em> proc rate<span class='perLevel'> per rank</span>.<br>Mace: Lowers aggro by <em data-base='50'>50</em> hate and interrupts foe.<br>	Sword: Deals <em data-base='5'>5</em> damage. Dagger: Drains mana by <em data-base='100'>100</em> and deals <em data-base='2'>2</em> damage.",
			Image: "/images/builds/icons/rb-rog-muggingshot.png",
		}
		skills[44] = skill

		skill = &Skill{
			Title: "Deadly Dagger",
			Desc:  "Increases the maximum damage of throwing daggers by <em data-base='20'>20</em>%<span class='perLevel'> per rank</span>.",
			Image: "/images/builds/icons/rb-rog-deadlydagger.png",
		}
		skills[46] = skill

		skill = &Skill{
			Title: "Thieves' Affinity",
			Desc:  "Increases proc chance of innate and card weapon procs by <em data-base='2.5'>2.5</em>%<span class='perLevel'> per rank</span>.",
			Image: "/images/builds/icons/rb-rog-thievesaffinity.png",
		}
		skills[49] = skill

		skill = &Skill{
			Title: "Hidden Dagger",
			Desc:  "If an enemy is not engaged, and is hit by a dagger thrown by a rogue sneaking, it will break sneak, and has a <em data-base='15'>15</em>% chance to not be social<span class='perLevel'> per rank</span>.",
			Image: "/images/builds/icons/rb-rog-hiddendagger.png",
		}
		skills[52] = skill
		break

	//==================SHAMAN======================
	case "shaman":
		//0
		skill = &Skill{
			Title: "Spirit of Speed",
			Desc:  "Spirit of Wolf lasts <em data-base='20'>20</em>% longer<span class='perLevel'> per rank</span>.",
			Image: "/images/builds/icons/rb-shm-spiritofspeed.png",
		}
		skills[0] = skill
		//1
		//2
		skill = &Skill{
			Title: "Purify Soul",
			Desc:  "Grants the Purify Soul AA, which cures target of disease, poison, as well as gives a <em data-base='10'>10</em>% chance to heal the target by <em data-base='1'>1</em>% max HP per tick regen<span class='perLevel'> per rank</span>.",
			Image: "/images/builds/icons/rb-shm-purifysoul.png",
		}
		skills[2] = skill
		//3
		//4
		skill = &Skill{
			Title: "Ancestral Aid",
			Desc:  "Grants the Ancestral Aid AA, which casts focus line buff scaled to your level.<br>Rank 1: STR<br>Rank 2: DEX and AGI<br>Rank 3: STA<br>Rank 4: HP<br>Rank 5: Haste",
			Image: "/images/builds/icons/rb-shm-ancestralaid.png",
		}
		skills[4] = skill
		//5
		//6
		skill = &Skill{
			Title: "Extended Haste",
			Desc:  "Improves attack speed spells used by the caster by increasing their duration by <em data-base='30'>30</em>%<span class='perLevel'> per rank</span>.",
			Image: "/images/builds/icons/rb-shm-extendedhaste.png",
		}
		skills[6] = skill

		skill = &Skill{
			Title: "Spiritual Healing",
			Desc:  "Heals to allies also heal the shaman <em data-base='5'>5</em>% health<span class='perLevel'> per rank</span>.",
			Image: "/images/builds/icons/rb-shm-spiritualhealing.png",
		}
		skills[8] = skill

		skill = &Skill{
			Title: "Covenant of Spirit",
			Desc:  "Grants the Covenent of Spirit AA, which imbues divine intervention on the target with a <em data-base='2'>2</em>% death save success<span class='perLevel'> per rank</span>.<b>NOT IMPLEMENTED</b>",
			Image: "/images/builds/icons/rb-shm-covenantofspirit.png",
		}
		skills[10] = skill

		skill = &Skill{
			Title: "Reinforce Torpor",
			Desc:  "Stoicism and Torpor heal for an additional <em data-base='10'>10</em>%<span class='perLevel'> per rank</span>.",
			Image: "/images/builds/icons/rb-shm-reinforcetorpor.png",
		}
		skills[13] = skill

		skill = &Skill{
			Title: "Fateseer's Boon",
			Desc:  "Grants the Lesson of the Devoted AA, giving a group buff that increases critical damage by 70% with all skills, chance to critical hit by 50% with all skills, as well as a 400 hitpoint per tick regen. 10 minute recast time, each rank reduces recast by 30 seconds.",
			Image: "/images/builds/icons/rb-shm-fateseersboon.png",
		}
		skills[16] = skill

		skill = &Skill{
			Title: "Cannibalize",
			Desc:  "Grants the Cannibalization AA, causing <em data-base='5'>5</em>% current HP loss in exchange for mana at <em data-base='10'>10</em>%<span class='perLevel'> per rank</span>.",
			Image: "/images/builds/icons/rb-shm-cannibalize.png",
		}
		skills[18] = skill

		skill = &Skill{
			Title: "Spirit Call",
			Desc:  "Grants the Spirit Call AA, summoning a racial pet with <em data-base='10'>10</em>% effectiveness<span class='perLevel'> per rank</span>.",
			Image: "/images/builds/icons/rb-shm-spiritcall.png",
		}
		skills[20] = skill

		skill = &Skill{
			Title: "Virulent Paralysis",
			Desc:  "Grants the Virulent Paralysis AA, causing a target to be immobilized. Each rank increases duration by <em data-base='6'>6</em> seconds <span class='perLevel'> per rank</span>.",
			Image: "/images/builds/icons/rb-shm-virulentparalysis.png",
		}
		skills[22] = skill

		skill = &Skill{
			Title: "Poison",
			Desc:  "All poison-based DoTs now deal <em data-base='1'>1</em>% additional damage per ally in group<span class='perLevel'> per rank</span>.",
			Image: "/images/builds/icons/rb-shm-poison.png",
		}
		skills[24] = skill

		skill = &Skill{
			Title: "Extended Turgur",
			Desc:  "Increases duration of slow by <em data-base='5'>5</em>% as well as penetrates magic defense by <em data-base='5'>5</em>%<span class='perLevel'> per rank</span>.",
			Image: "/images/builds/icons/rb-shm-extendedturgur.png",
		}
		skills[26] = skill
		//37
		//38
		skill = &Skill{
			Title: "Ancient Wrath",
			Desc:  "All direct damage spells now deal <em data-base='10'>10</em>% more damage as well as <em data-base='1'>1</em>% chance to critical hit<span class='perLevel'> per rank</span>.",
			Image: "/images/builds/icons/rb-shm-ancientwrath.png",
		}
		skills[28] = skill

		skill = &Skill{
			Title: "Turgur's Echo",
			Desc:  "When a slow-based spell is resisted, the spell will try to land again with <em data-base='2'>2</em> less resistance<span class='perLevel'> per rank</span>.",
			Image: "/images/builds/icons/rb-shm-turgursecho.png",
		}
		skills[31] = skill

		skill = &Skill{
			Title: "Spiritual Channeling",
			Desc:  "While this ability is active, all spells cost HP rather than mana. Cooldown of reuse is reduced by <em data-base='6'>6</em>seconds<span class='perLevel'> per rank</span>.",
			Image: "/images/builds/icons/rb-shm-spiritualchanneling.png",
		}
		skills[34] = skill

		skill = &Skill{
			Title: "Fury",
			Desc:  "The shaman gains a 400 mod proc that deals (level * 1.5 * <em data-base='0.2'>0.2</em>) magic damage.",
			Image: "/images/builds/icons/rb-shm-fury.png",
		}
		skills[36] = skill

		skill = &Skill{
			Title: "Rabid Bear",
			Desc:  "Grants the Rabid Bear AA, granting <em data-base='2'>2</em>% attack speed and the tainted bite proc line with <em data-base='20'>20</em>% effectiveness<span class='perLevel'> per rank</span>.",
			Image: "/images/builds/icons/rb-shm-rabidbear.png",
		}
		skills[38] = skill

		skill = &Skill{
			Title: "Ancestral Guard",
			Desc:  "Grants the Ancestral Guard AA, granting <em data-base='2'>2</em>% evasion<span class='perLevel'> per rank</span>.",
			Image: "/images/builds/icons/rb-shm-ancestralguard.png",
		}
		skills[40] = skill

		skill = &Skill{
			Title: "Call of the Ancients",
			Desc:  "Grants the Call of the Ancients AA, summoning a spirit that deals <em data-base='1'>1</em> %of an enemy's current health (maximum <em data-base='100'>100</em>) per attack<span class='perLevel'> per rank</span>.",
			Image: "/images/builds/icons/rb-shm-calloftheancients.png",
		}
		skills[42] = skill

		skill = &Skill{
			Title: "Spiritual Wrath",
			Desc:  "Grants the Spiritual Wrath AA, attacking your target<span class='perLevel'> per rank</span>.",
			Image: "/images/builds/icons/rb-shm-spiritualwrath.png",
		}
		skills[44] = skill

		skill = &Skill{
			Title: "Mark of Sloth",
			Desc:  "On each attack, grants a chance to trigger a sloth effect, causing the next direct damage spell to deal <em data-base='5'>5</em>% bonus damage<span class='perLevel'> per rank</span>.",
			Image: "/images/builds/icons/rb-shm-markofsloth.png",
		}
		skills[46] = skill

		skill = &Skill{
			Title: "Feral Swipe",
			Desc:  "Grants the Feral Swipe AA, giving a bonus attack ability with <em data-base='5'>5</em>% effectiveness<span class='perLevel'> per rank</span>.",
			Image: "/images/builds/icons/rb-shm-feralswipe.png",
		}
		skills[49] = skill

		skill = &Skill{
			Title: "Paragon of Spirit",
			Desc:  "Grants the Paragon of Spirit AA, giving a mana and hp regen ability <em data-base='20'>20</em>% effectiveness<span class='perLevel'> per rank</span>.",
			Image: "/images/builds/icons/rb-shm-paragonofspirit.png",
		}
		skills[52] = skill

		break

	//==================WARRIOR======================
	case "warrior":

		break

	//==================WIZARD======================
	case "wizard":

		break

	//==================SHADOWKNIGHT======================
	case "shadowknight":
	default:
		//0
		skill = &Skill{
			Title: "Leech Touch",
			Desc:  "Grants the Leech Touch AA, which replaces all normal Knight lifetaps. It will use your best lifetap, curved up, as well as improves all lifetaps by (<em data-base='2'>2</em>% * group size) <span class='perLevel'> per rank</span> and grants a <em data-base='1'>1</em>% critical heal rate<span class='perLevel'> per rank</span>.",
			Image: "/images/builds/icons/rb-shd-leechtouch.png",
		}
		skills[0] = skill

		skill = &Skill{
			Title: "Gouging Skin",
			Desc:  "When attacked, causes a <em data-base='4'>4</em> point damage shield and <em data-base='30'>30</em> hate<span class='perLevel'> per rank</span>.",
			Image: "/images/builds/icons/rb-shd-gougingskin.png",
		}
		skills[2] = skill

		skill = &Skill{
			Title: "Hungering Aura",
			Desc:  "Improves lifetaps casted by Leech Touch or Innate Procs by <em data-base='5'>5</em>% healing for each enemy attacking you with a maximum of <em data-base='1'>1</em> enemies or group size, whichever is lower<span class='perLevel'> per rank</span>.",
			Image: "/images/builds/icons/rb-shd-hungeringaura.png",
		}
		skills[4] = skill

		skill = &Skill{
			Title: "Steadfast Servant",
			Desc:  "Grants the Steadfast Servant AA, summoning a pet at <em data-base='20'>20</em>% effectiveness<span class='perLevel'> per rank</span>.",
			Image: "/images/builds/icons/rb-shd-steadfastservant.png",
		}
		skills[6] = skill

		skill = &Skill{
			Title: "Zevfeer's Feast",
			Desc:  "When you use the Leech Touch AA, your group recover <em data-base='0.5'>0.5</em>% of a target's max mana when within <em data-base='5'>5</em>m<span class='perLevel'> per rank</span>.",
			Image: "/images/builds/icons/rb-shd-zevfeersfeast.png",
		}
		skills[8] = skill

		skill = &Skill{
			Title: "Sworn Enemy",
			Desc:  "When you use taunt, you mark a target as your sworn enemy. For the next 3 ticks, any spell damage dealt to target causes (mana * <em data-base='0.5'>0.5</em>) hate<span class='perLevel'> per rank</span>.",
			Image: "/images/builds/icons/rb-shd-swornenemy.png",
		}
		skills[10] = skill

		skill = &Skill{
			Title: "Banshee's Mirror",
			Desc:  "Passively grants the Shadow Knight a <em data-base='6'>6</em>% bonus when healed by other allies<span class='perLevel'> per rank</span>.",
			Image: "/images/builds/icons/rb-shd-bansheesmirror.png",
		}
		skills[13] = skill

		skill = &Skill{
			Title: "Reaper's Strike",
			Desc:  "Grants the Lesson of the Devoted AA, which improves accuracy by 50% and gain lifetap from weapon damage. 10 minute recast time, each rank reduces recast by 30 seconds.",
			Image: "/images/builds/icons/rb-shd-reapersstrike.png",
		}
		skills[16] = skill

		skill = &Skill{
			Title: "Festering Spear",
			Desc:  "Improve spear type spells by (level * <em data-base='1'>1</em>) bonus damage <span class='perLevel'> per rank</span>. Also gives a <em data-base='1'>1</em>% chance to cause quad damage.",
			Image: "/images/builds/icons/rb-shd-festeringspear.png",
		}
		skills[18] = skill

		skill = &Skill{
			Title: "Festering Wound",
			Desc:  "Improves DoT damage by <em data-base='1'>1</em>% for each ally in group<span class='perLevel'> per rank</span>.",
			Image: "/images/builds/icons/rb-shd-festeringwound.png",
		}
		skills[20] = skill

		skill = &Skill{
			Title: "Rotten Core",
			Desc:  "Each time a creature is successfully killed, the knight gains a rotten core counter. For 60 seconds, each counter adds <em data-base='3'>3</em>% damage<span class='perLevel'> per rank</span> to attacks, with a cap of <em data-base='1'>1</em> counters. Getting a kill resets the counter.",
			Image: "/images/builds/icons/rb-shd-rottencore.png",
		}
		skills[22] = skill

		skill = &Skill{
			Title: "Lingering Pain",
			Desc:  "All direct damage spells cause a DoT effect for 0 to <em data-base='1'>1</em> ticks<span class='perLevel'> per rank</span>.",
			Image: "/images/builds/icons/rb-shd-lingeringpain.png",
		}
		skills[24] = skill

		skill = &Skill{
			Title: "Blood Oath",
			Desc:  "While using a 2 handed weapon, increases damage by <em data-base='5'>5</em>%<span class='perLevel'> per rank</span>.",
			Image: "/images/builds/icons/rb-shd-bloodoath.png",
		}
		skills[26] = skill

		skill = &Skill{
			Title: "Gift of Urash",
			Desc:  "Increases all skill damage by <em data-base='5'>5</em>%<span class='perLevel'> per rank</span>.",
			Image: "/images/builds/icons/rb-shd-giftofurash.png",
		}
		skills[28] = skill

		skill = &Skill{
			Title: "Unholy Focus",
			Desc:  "Enables use of the #focus command, transferring lifetaps to the focused ally for <em data-base='4'>4</em>% of the recourse given<span class='perLevel'> per rank</span>.",
			Image: "/images/builds/icons/rb-shd-unholyfocus.png",
		}
		skills[31] = skill

		skill = &Skill{
			Title: "Bash of Death",
			Desc:  "When you bash a target that is equal to your level or lower and the enemy is at <em data-base='10'>10</em>% or less total health you deal an additional (level * <em data-base='1'>1</em>) <span class='perLevel'> per rank</span>.",
			Image: "/images/builds/icons/rb-shd-bashofdeath.png",
		}
		skills[34] = skill

		skill = &Skill{
			Title: "Embrace Death",
			Desc:  "Grants you the Death Peace AA, giving the ability to feign death as well as heal you for <em data-base='1'>1</em>% of missing health<span class='perLevel'> per rank</span>.",
			Image: "/images/builds/icons/rb-shd-embracedeath.png",
		}
		skills[36] = skill

		skill = &Skill{
			Title: "Darkness",
			Desc:  "Darkness-based and Terror spells now cause <em data-base='40'>40</em>% more hate<span class='perLevel'> per rank</span>.",
			Image: "/images/builds/icons/rb-shd-darkness.png",
		}
		skills[38] = skill

		skill = &Skill{
			Title: "Empathetic Soul",
			Desc:  "Improves Dark Empathy by granting an additional <em data-base='40'>40</em> hitpoints healed and <em data-base='0.5'>0.5</em>% max mana <span class='perLevel'> per rank</span>.",
			Image: "/images/builds/icons/rb-shd-empatheticsoul.png",
		}
		skills[40] = skill

		skill = &Skill{
			Title: "Embrace Shadow",
			Desc:  "Each time you feign death, you are instantly be invisible to both living and undead creatures for <em data-base='1'>1</em> tick<span class='perLevel'> per rank</span>.",
			Image: "/images/builds/icons/rb-shd-embraceshadow.png",
		}
		skills[42] = skill

		skill = &Skill{
			Title: "Siphon of Death",
			Desc:  "Vampiric Embrace, Scream of Death and Shroud of Death now also grant a mana tap for <em data-base='5'>5</em>% of damage dealt<span class='perLevel'> per rank</span>.",
			Image: "/images/builds/icons/rb-shd-siphonofdeath.png",
		}
		skills[44] = skill

		skill = &Skill{
			Title: "Nightmare",
			Desc:  "Fear now causes target to be stunned in panic for 0 to <em data-base='1'>1</em> seconds<span class='perLevel'> per rank</span> before fleeing.",
			Image: "/images/builds/icons/rb-shd-nightmare.png",
		}
		skills[46] = skill

		skill = &Skill{
			Title: "Mental Resistance",
			Desc:  "Gives a <em data-base='2'>2</em>% chance to resist stun effects<span class='perLevel'> per rank</span>.",
			Image: "/images/builds/icons/rb-shd-mentalresistance.png",
		}
		skills[49] = skill

		skill = &Skill{
			Title: "Cloak of Shadows",
			Desc:  "Grants the Cloak of the Shadows AA, allowing you to step into the shadows, causing a <em data-base='5'>5</em>% chance that all targets will forget your actions.",
			Image: "/images/builds/icons/rb-shd-cloakofshadows.png",
		}
		skills[52] = skill

		break
	}
	return
}
