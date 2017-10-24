package main

import (
	"fmt"
	"log"
	"strings"

	_ "github.com/go-sql-driver/mysql"
	"github.com/jmoiron/sqlx"
	"github.com/xackery/eqemuconfig"
	"github.com/xackery/goeq/item"
)

var (
	config *eqemuconfig.Config
	char   *Character
)

type Database struct {
	instance *sqlx.DB
}

type Character struct {
	Name string
}

func (c *Character) IsManaUser() bool {
	return false
}

func main() {
	var err error
	counter := 0
	ids := buildList()
	if err = loadConfig(); err != nil {
		log.Fatal(err.Error())
	}

	db := Database{}
	if err = loadDatabase(&db); err != nil {
		log.Fatal(err.Error())
	}
	fmt.Println("Turning", len(ids), "items to OOE")
	for _, id := range ids {
		if err = db.ooeItem(id); err != nil {
			log.Fatal(err.Error())
		}
		counter++
		if counter%5000 == 0 {
			fmt.Println(id)
		}
	}
	fmt.Println("Done")
}

func loadConfig() error {
	if config != nil {
		return nil
	}
	var err error
	if config, err = eqemuconfig.GetConfig(); err != nil {
		return err
	}
	return nil
}

func loadDatabase(db *Database) error {
	if db == nil {
		return fmt.Errorf("No database")
	}
	var err error
	if db.instance, err = sqlx.Open("mysql", fmt.Sprintf("%s:%s@tcp(%s:%s)/%s?charset=utf8&parseTime=true", config.Database.Username, config.Database.Password, config.Database.Host, config.Database.Port, config.Database.Db)); err != nil {
		return fmt.Errorf("error connecting to db: %s", err.Error())
	}
	return nil
}

func (db *Database) ooeItem(id int64) (err error) {
	if db == nil {
		err = fmt.Errorf("No database")
		return
	}
	if db.instance == nil {
		err = fmt.Errorf("No database instance")
		return
	}

	item := item.Item{}
	query := "SELECT * FROM items WHERE id = ? LIMIT 1"
	if err = db.instance.Get(&item, query, id); err != nil {
		err = nil
		return
	}

	if strings.Contains(item.Name, "(out of era)") {
		err = nil
		return
	}

	query = "UPDATE items SET name = ?, aagi = 0, ac = 0, accuracy = 0, acha = 0, adex = 0, aint = 0, artifactflag = 0, asta = 0, astr = 0, attack = 0, avoidance = 0, awis = 0, bagsize = 0, bagslots = 0, bagtype = 0, bagwr = 0, banedmgamt = 0, banedmgraceamt = 0, banedmgbody = 0, banedmgrace = 0, bardtype = 0, bardvalue = 0, book = 0, casttime = 0, casttime_ = 0, charmfile = '', charmfileid = '', classes = 0, color = 0, combateffects = '', extradmgskill = 0, extradmgamt = 0, price = 0, cr = 0, damage = 0, damageshield = 0, deity = 0, delay = 0, augdistiller = 0, dotshielding = 0, dr = 0, clicktype = 0, clicklevel2 = 0, elemdmgtype = 0, elemdmgamt = 0, endur = 0, factionamt1 = 0, factionamt2 = 0, factionamt3 = 0, factionamt4 = 0, factionmod1 = 0, factionmod2 = 0, factionmod3 = 0, factionmod4 = 0, filename = '', focuseffect = 0, fr = 0, fvnodrop = 0, haste = 0, clicklevel = 0, hp = 0, regen = 0, idfile = '', itemclass = 0, itemtype = 0, ldonprice = 0, ldontheme = 0, ldonsold = 0, light = 0, lore = '', loregroup = 0, magic = 0, mana = 0, manaregen = 0, enduranceregen = 0, material = 0, herosforgemodel = 0, maxcharges = 0, mr = 0, nodrop = 0, pendingloreflag = 0, pr = 0, procrate = 0, races = 0, reclevel = 0, recskill = 0, reqlevel = 0, sellrate = 0, shielding = 0, size = 0, skillmodtype = 0, skillmodvalue = 0, slots = 0, clickeffect = 0, spellshield = 0, strikethrough = 0, stunresist = 0, summonedflag = 0, tradeskills = 0, favor = 0, weight = 0, UNK012 = 0, UNK013 = 0, benefitflag = 0, UNK054 = 0, UNK059 = 0, booktype = 0, recastdelay = 0, recasttype = 0, guildfavor = 0, UNK123 = 0, UNK124 = 0, attuneable = 0, nopet = 0, UNK127 = 0, pointtype = 0, potionbelt = 0, potionbeltslots = 0, stacksize = 0, notransfer = 0, stackable = 0, proceffect = 0, proctype = 0, proclevel2 = 0, proclevel = 0, UNK142 = 0, worneffect = 0, worntype = 0, wornlevel2 = 0, wornlevel = 0, UNK147 = 0, focustype = 0, focuslevel2 = 0, focuslevel = 0, UNK152 = 0, scrolleffect = 0, scrolltype = 0, scrolllevel2 = 0, scrolllevel = 0, UNK157 = 0, serialized = 0, verified = 0, serialization = '', source = '', UNK033 = 0, lorefile = '', UNK014 = 0, svcorruption = 0, skillmodmax = 0, UNK060 = 0, augslot1unk2 = 0, augslot2unk2 = 0, augslot3unk2 = 0, augslot4unk2 = 0, augslot5unk2 = 0, augslot6unk2 = 0, UNK120 = 0, UNK121 = 0, questitemflag = 0, UNK132 = '', clickunk5 = 0, clickunk6 = '', clickunk7 = 0, procunk1 = 0, procunk2 = 0, procunk3 = 0, procunk4 = 0, procunk6 = '', procunk7 = 0, wornunk1 = 0, wornunk2 = 0, wornunk3 = 0, wornunk4 = 0, wornunk5 = 0, wornunk6 = '', wornunk7 = 0, focusunk1 = 0, focusunk2 = 0, focusunk3 = 0, focusunk4 = 0, focusunk5 = 0, focusunk6 = '', focusunk7 = 0, scrollunk1 = 0, scrollunk2 = 0, scrollunk3 = 0, scrollunk4 = 0, scrollunk5 = 0, scrollunk6 = '', scrollunk7 = 0, UNK193 = 0, purity = 0, evoitem = 0, evoid = 0, evolvinglevel = 0, evomax = 0, clickname = '', procname = '', wornname = '', focusname = '', scrollname = '', dsmitigation = 0, heroic_str = 0, heroic_int = 0, heroic_wis = 0, heroic_agi = 0, heroic_dex = 0, heroic_sta = 0, heroic_cha = 0, heroic_pr = 0, heroic_dr = 0, heroic_fr = 0, heroic_cr = 0, heroic_mr = 0, heroic_svcorrup = 0, healamt = 0, spelldmg = 0, clairvoyance = 0, backstabdmg = 0, created = '', elitematerial = 0, ldonsellbackrate = 0, scriptfileid = 0, expendablearrow = 0, powersourcecapacity = 0, bardeffect = 0, bardeffecttype = 0, bardlevel2 = 0, bardlevel = 0, bardunk1 = 0, bardunk2 = 0, bardunk3 = 0, bardunk4 = 0, bardunk5 = 0, bardname = '', bardunk7 = 0, UNK214 = 0, UNK219 = 0, UNK220 = 0, UNK221 = 0, heirloom = 0, UNK223 = 0, UNK224 = 0, UNK225 = 0, UNK226 = 0, UNK227 = 0, UNK228 = 0, UNK229 = 0, UNK230 = 0, UNK231 = 0, UNK232 = 0, UNK233 = 0, UNK234 = 0, placeable = 0, UNK236 = 0, UNK237 = 0, UNK238 = 0, UNK239 = 0, UNK240 = 0, UNK241 = 0, epicitem = 0 WHERE id = ? LIMIT 1"
	if _, err = db.instance.Exec(query, item.Name+" (out of era)", id); err != nil {
		return
	}
	return
}

func buildList() (ids []int64) {
	ids = []int64{
		100085, //Tinmyn's Oil Can
		100219, //Scratched Hide Leggings
		100221, //Glossy Silk Wristband
		100222, //Glossy Silk Gloves
		100223, //Glossy Silk Slippers
		100224, //Glossy Silk Hat
		100225, //Glossy Silk Sleeves
		100226, //Glossy Silk Pantaloons
		100227, //Glossy Silk Robe
		100235, //Dedicated Steel Bracer
		100236, //Dedicated Steel Gauntlets
		100237, //Dedicated Steel Boots
		100238, //Dedicated Steel Helm
		100239, //Dedicated Steel Vambraces
		100240, //Dedicated Steel Greaves
		100241, //Dedicated Steel Breastplate
		100242, //Purified Steel Bracer
		100243, //Purified Steel Gauntlets
		100244, //Purified Steel Boots
		100245, //Purified Steel Helm
		100246, //Purified Steel Vambraces
		100247, //Purified Steel Greaves
		100248, //Purified Steel Breastplate
		100249, //Druadic Linked Wristguard
		100250, //Druadic Linked Gauntlets
		100251, //Druadic Linked Boots
		100252, //Druadic Linked Coif
		100253, //Druadic Linked Sleeves
		100254, //Druadic Linked Leggings
		100255, //Druadic Linked Coat
		100256, //Necrotic Steel Bracer
		100257, //Necrotic Steel Gauntlets
		100258, //Necrotic Steel Boots
		100259, //Necrotic Steel Helm
		100260, //Necrotic Steel Vambraces
		100261, //Necrotic Steel Greaves
		100262, //Necrotic Steel Breastplate
		100263, //Druadic Hide Wristguard
		100264, //Druadic Hide Gloves
		100265, //Druadic Hide Boots
		100266, //Druadic Hide Cowl
		100267, //Druadic Hide Armwraps
		100268, //Druadic Hide Leggings
		100269, //Druadic Hide Tunic
		100277, //Bracer of the Dream
		100278, //Gauntlets of the Dream
		100279, //Boots of the Dream
		100280, //Helm of the Dream
		100281, //Vambraces of the Dream
		100282, //Greaves of the Dream
		100283, //Breastplate of the Dream
		100291, //Dedicated Alloy Wristguard
		100292, //Dedicated Alloy Gauntlets
		100293, //Dedicated Alloy Boots
		100294, //Dedicated Alloy Coif
		100295, //Dedicated Alloy Sleeves
		100296, //Dedicated Alloy Leggings
		100297, //Dedicated Alloy Coat
		100298, //Necrotic Silk Wristband
		100299, //Necrotic Silk Gloves
		100323, //Dreamer's Silk Sleeves
		100324, //Dreamer's Silk Pantaloons
		100325, //Dreamer's Silk Robe
		100326, //Commanding Hide Wristguard
		100327, //Commanding Hide Gloves
		100328, //Commanding Hide Boots
		100329, //Commanding Hide Cowl
		100330, //Commanding Hide Armwraps
		100331, //Commanding Hide Leggings
		100332, //Commanding Hide Tunic
		100347, //Dedicated Flamesteel Bracer
		100348, //Dedicated Flamesteel Gauntlets
		100349, //Dedicated Flamesteel Boots
		100350, //Dedicated Flamesteel Helm
		100351, //Dedicated Flamesteel Vambraces
		100352, //Dedicated Flamesteel Greaves
		100353, //Dedicated Flamesteel Breastplate
		100354, //Purified Flamesteel Bracer
		100355, //Purified Flamesteel Gauntlets
		100356, //Purified Flamesteel Boots
		100357, //Purified Flamesteel Helm
		100358, //Purified Flamesteel Vambraces
		100359, //Purified Flamesteel Greaves
		100360, //Purified Flamesteel Breastplate
		100361, //Druadic Flamelinked Wristguard
		100362, //Druadic Flamelinked Gauntlets
		100363, //Druadic Flamelinked Boots
		100364, //Druadic Flamelinked Coif
		100365, //Druadic Flamelinked Sleeves
		100366, //Druadic Flamelinked Leggings
		100367, //Druadic Flamelinked Coat
		100368, //Necrotic Flamesteel Bracer
		100369, //Necrotic Flamesteel Gauntlets
		100370, //Necrotic Flamesteel Boots
		100371, //Necrotic Flamesteel Helm
		100372, //Necrotic Flamesteel Vambraces
		100373, //Necrotic Flamesteel Greaves
		100374, //Necrotic Flamesteel Breastplate
		100375, //Druadic Flamehide Wristguard
		100376, //Druadic Flamehide Gloves
		100377, //Druadic Flamehide Boots
		100378, //Druadic Flamehide Cowl
		100379, //Druadic Flamehide Armwraps
		100380, //Druadic Flamehide Leggings
		100381, //Druadic Flamehide Tunic
		100389, //Flamesteel Bracer of the Dream
		100390, //Flamesteel Gauntlets of the Dream
		100391, //Flamesteel Boots of the Dream
		100392, //Flamesteel Helm of the Dream
		100393, //Flamesteel Vambraces of the Dream
		100394, //Flamesteel Greaves of the Dream
		100395, //Flamesteel Breastplate of the Dream
		100426, //Commanding Firesilk Slippers
		100427, //Commanding Firesilk Hat
		100428, //Commanding Firesilk Sleeves
		100429, //Commanding Firesilk Pantaloons
		100430, //Commanding Firesilk Robe
		100431, //Dreamer's Firesilk Wristband
		100432, //Dreamer's Firesilk Gloves
		100433, //Dreamer's Firesilk Slippers
		100434, //Dreamer's Firesilk Hat
		100435, //Dreamer's Firesilk Sleeves
		100436, //Dreamer's Firesilk Pantaloons
		100437, //Dreamer's Firesilk Robe
		100438, //Commanding Flamehide Wristguard
		100439, //Commanding Flamehide Gloves
		100440, //Commanding Flamehide Boots
		100441, //Commanding Flamehide Cowl
		100442, //Commanding Flamehide Armwraps
		100443, //Commanding Flamehide Leggings
		100444, //Commanding Flamehide Tunic
		100459, //Dedicated Chillsteel Bracer
		100460, //Dedicated Chillsteel Gauntlets
		100461, //Dedicated Chillsteel Boots
		100462, //Dedicated Chillsteel Helm
		100463, //Dedicated Chillsteel Vambraces
		100464, //Dedicated Chillsteel Greaves
		100465, //Dedicated Chillsteel Breastplate
		100466, //Purified Chillsteel Bracer
		100467, //Purified Chillsteel Gauntlets
		100468, //Purified Chillsteel Boots
		100469, //Purified Chillsteel Helm
		100470, //Purified Chillsteel Vambraces
		100471, //Purified Chillsteel Greaves
		100472, //Purified Chillsteel Breastplate
		100473, //Druadic Frostlinked Wristguard
		100474, //Druadic Frostlinked Gauntlets
		100475, //Druadic Frostlinked Boots
		100476, //Druadic Frostlinked Coif
		100477, //Druadic Frostlinked Sleeves
		100478, //Druadic Frostlinked Leggings
		100479, //Druadic Frostlinked Coat
		100480, //Necrotic Chillsteel Bracer
		100481, //Necrotic Chillsteel Gauntlets
		100482, //Necrotic Chillsteel Boots
		100483, //Necrotic Chillsteel Helm
		100484, //Necrotic Chillsteel Vambraces
		100485, //Necrotic Chillsteel Greaves
		100486, //Necrotic Chillsteel Breastplate
		100487, //Druadic Chillhide Wristguard
		100488, //Druadic Chillhide Gloves
		100489, //Druadic Chillhide Boots
		100490, //Druadic Chillhide Cowl
		100491, //Druadic Chillhide Armwraps
		100492, //Druadic Chillhide Leggings
		100493, //Druadic Chillhide Tunic
		100501, //Chillsteel Bracer of the Dream
		100502, //Chillsteel Gauntlets of the Dream
		100503, //Chillsteel Boots of the Dream
		100504, //Chillsteel Helm of the Dream
		100505, //Chillsteel Vambraces of the Dream
		100506, //Chillsteel Greaves of the Dream
		100507, //Chillsteel Breastplate of the Dream
		100515, //Dedicated Frostlinked Wristguard
		100516, //Dedicated Frostlinked Gauntlets
		100517, //Dedicated Frostlinked Boots
		100518, //Dedicated Frostlinked Coif
		100519, //Dedicated Frostlinked Sleeves
		100520, //Dedicated Frostlinked Leggings
		100521, //Dedicated Frostlinked Coat
		100522, //Necrotic Frostsilk Wristband
		100523, //Necrotic Frostsilk Gloves
		100524, //Necrotic Frostsilk Slippers
		100525, //Necrotic Frostsilk Hat
		100526, //Necrotic Frostsilk Sleeves
		100527, //Necrotic Frostsilk Pantaloons
		100528, //Necrotic Frostsilk Robe
		100529, //Intense Frostsilk Wristband
		100530, //Intense Frostsilk Gloves
		100531, //Intense Frostsilk Slippers
		100532, //Intense Frostsilk Hat
		100533, //Intense Frostsilk Sleeves
		100534, //Intense Frostsilk Pantaloons
		100535, //Intense Frostsilk Robe
		100536, //Commanding Frostsilk Wristband
		100537, //Commanding Frostsilk Gloves
		100538, //Commanding Frostsilk Slippers
		100539, //Commanding Frostsilk Hat
		100540, //Commanding Frostsilk Sleeves
		100541, //Commanding Frostsilk Pantaloons
		100542, //Commanding Frostsilk Robe
		100543, //Dreamer's Frostsilk Wristband
		100544, //Dreamer's Frostsilk Gloves
		100545, //Dreamer's Frostsilk Slippers
		100546, //Dreamer's Frostsilk Hat
		100547, //Dreamer's Frostsilk Sleeves
		100548, //Dreamer's Frostsilk Pantaloons
		100549, //Dreamer's Frostsilk Robe
		100550, //Commanding Chillhide Wristguard
		100551, //Commanding Chillhide Gloves
		100552, //Commanding Chillhide Boots
		100553, //Commanding Chillhide Cowl
		100554, //Commanding Chillhide Armwraps
		100555, //Commanding Chillhide Leggings
		100556, //Commanding Chillhide Tunic
		100571, //Dedicated Terrasteel Bracer
		100572, //Dedicated Terrasteel Gauntlets
		100573, //Dedicated Terrasteel Boots
		100574, //Dedicated Terrasteel Helm
		100575, //Dedicated Terrasteel Vambraces
		100576, //Dedicated Terrasteel Greaves
		100577, //Dedicated Terrasteel Breastplate
		100578, //Purified Terrasteel Bracer
		100579, //Purified Terrasteel Gauntlets
		100580, //Purified Terrasteel Boots
		100581, //Purified Terrasteel Helm
		100582, //Purified Terrasteel Vambraces
		100583, //Purified Terrasteel Greaves
		100584, //Purified Terrasteel Breastplate
		100585, //Druadic Tremorchain Wristguard
		100586, //Druadic Tremorchain Gauntlets
		100587, //Druadic Tremorchain Boots
		100588, //Druadic Tremorchain Coif
		100589, //Druadic Tremorchain Sleeves
		100590, //Druadic Tremorchain Leggings
		100591, //Druadic Tremorchain Coat
		100592, //Necrotic Terrasteel Bracer
		100593, //Necrotic Terrasteel Gauntlets
		100594, //Necrotic Terrasteel Boots
		100595, //Necrotic Terrasteel Helm
		100596, //Necrotic Terrasteel Vambraces
		100597, //Necrotic Terrasteel Greaves
		100598, //Necrotic Terrasteel Breastplate
		100599, //Druadic Tremorhide Wristguard
		100683, //Dedicated Cloudsteel Bracer
		100684, //Dedicated Cloudsteel Gauntlets
		100685, //Dedicated Cloudsteel Boots
		100686, //Dedicated Cloudsteel Helm
		100687, //Dedicated Cloudsteel Vambraces
		100688, //Dedicated Cloudsteel Greaves
		100689, //Dedicated Cloudsteel Breastplate
		100690, //Purified Cloudsteel Bracer
		100691, //Purified Cloudsteel Gauntlets
		100692, //Purified Cloudsteel Boots
		100693, //Purified Cloudsteel Helm
		100694, //Purified Cloudsteel Vambraces
		100695, //Purified Cloudsteel Greaves
		100696, //Purified Cloudsteel Breastplate
		100697, //Druadic Stormlinked Wristguard
		100698, //Druadic Stormlinked Gauntlets
		100699, //Druadic Stormlinked Boots
		100700, //Druadic Stormlinked Coif
		100701, //Druadic Stormlinked Sleeves
		100702, //Druadic Stormlinked Leggings
		100703, //Druadic Stormlinked Coat
		100704, //Necrotic Cloudsteel Bracer
		100705, //Necrotic Cloudsteel Gauntlets
		100706, //Necrotic Cloudsteel Boots
		100707, //Necrotic Cloudsteel Helm
		100708, //Necrotic Cloudsteel Vambraces
		100709, //Necrotic Cloudsteel Greaves
		100710, //Necrotic Cloudsteel Breastplate
		100711, //Druadic Stormhide Wristguard
		100712, //Druadic Stormhide Gloves
		100713, //Druadic Stormhide Boots
		100714, //Druadic Stormhide Cowl
		100715, //Druadic Stormhide Armwraps
		100716, //Druadic Stormhide Leggings
		100717, //Druadic Stormhide Tunic
		100725, //Cloudsteel Bracer of the Dream
		100726, //Cloudsteel Gauntlets of the Dream
		100727, //Cloudsteel Boots of the Dream
		100728, //Cloudsteel Helm of the Dream
		100729, //Cloudsteel Vambraces of the Dream
		100730, //Cloudsteel Greaves of the Dream
		100731, //Cloudsteel Breastplate of the Dream
		100739, //Dedicated Stormlinked Wristguard
		100740, //Dedicated Stormlinked Gauntlets
		100741, //Dedicated Stormlinked Boots
		100742, //Dedicated Stormlinked Coif
		100743, //Dedicated Stormlinked Sleeves
		100744, //Dedicated Stormlinked Leggings
		100745, //Dedicated Stormlinked Coat
		100746, //Necrotic Windsilk Wristband
		100747, //Necrotic Windsilk Gloves
		100748, //Necrotic Windsilk Slippers
		100749, //Necrotic Windsilk Hat
		100750, //Necrotic Windsilk Sleeves
		100751, //Necrotic Windsilk Pantaloons
		100752, //Necrotic Windsilk Robe
		100753, //Intense Windsilk Wristband
		100754, //Intense Windsilk Gloves
		100755, //Intense Windsilk Slippers
		100756, //Intense Windsilk Hat
		100757, //Intense Windsilk Sleeves
		100758, //Intense Windsilk Pantaloons
		100759, //Intense Windsilk Robe
		100760, //Commanding Windsilk Wristband
		100761, //Commanding Windsilk Gloves
		100762, //Commanding Windsilk Slippers
		100763, //Commanding Windsilk Hat
		100764, //Commanding Windsilk Sleeves
		100765, //Commanding Windsilk Pantaloons
		100766, //Commanding Windsilk Robe
		100767, //Dreamer's Windsilk Wristband
		100768, //Dreamer's Windsilk Gloves
		100769, //Dreamer's Windsilk Slippers
		100770, //Dreamer's Windsilk Hat
		100771, //Dreamer's Windsilk Sleeves
		100772, //Dreamer's Windsilk Pantaloons
		100773, //Dreamer's Windsilk Robe
		100774, //Commanding Stormhide Wristguard
		100775, //Commanding Stormhide Gloves
		100776, //Commanding Stormhide Boots
		100777, //Commanding Stormhide Cowl
		100778, //Commanding Stormhide Armwraps
		100779, //Commanding Stormhide Leggings
		100780, //Commanding Stormhide Tunic
		100795, //Dedicated Chromasteel Bracer
		100796, //Dedicated Chromasteel Gauntlets
		100797, //Dedicated Chromasteel Boots
		100798, //Dedicated Chromasteel Helm
		100799, //Dedicated Chromasteel Vambraces
		100886, //Commanding Chromahide Wristguard
		100887, //Commanding Chromahide Gloves
		100888, //Commanding Chromahide Boots
		100889, //Commanding Chromahide Cowl
		100890, //Commanding Chromahide Armwraps
		100891, //Commanding Chromahide Leggings
		100892, //Commanding Chromahide Tunic
		100900, //Warping Steel Bracer
		100901, //Warped Steely Bracer
		100902, //Alloy-Linked Wristband
		100903, //Scorched Hide Wristguard
		100904, //Glossed Silk Wristband
		100905, //Glossy Silk Wristwrap
		100906, //Necrotic Steel Bracer
		100907, //Dedicated Alloy Wristguard
		100908, //Necrotic Silk Wristband
		100909, //Commanding Hide Wristguard
		100910, //Necrotic Flamesteeled Bracer
		100911, //Dedicated Flamelink Wristguard
		100912, //Necrotic Firesilken Wristband
		100914, //Necrotic Chillsteel Wristguard
		100915, //Dedicated Frostlinked Bracer
		100916, //Necrotic Frostsilk Wristwrap
		100917, //Commanding Chillhide Wristwrap
		100918, //Necrotic Terrasteel Wristguard
		100919, //Dedicated Tremorchain Bracer
		100920, //Necrotic Terrasilk Wristwrap
		100921, //Commanding Tremorhide Bracer
		100922, //Necrotic Cloudsteel Wristguard
		100923, //Dedicated Stormlinked Bracer
		100924, //Necrotic Windsilk Wristwrap
		100925, //Commanding Stormhide Bracer
		100926, //Necrotic Chromasteel Wristguard
		100927, //Dedicated Chromalinked Bracer
		100928, //Necrotic Kaleidosilk Wristwrap
		100929, //Commanding Chromahide Bracer
		101046, //Lelluran's Scarred Longsword
		101047, //Wirlem's Archblade
		101048, //Eldanddor's Avenger
		101049, //Lelluran's Mace
		101050, //Flail of Redemption
		101051, //Faende's Swagger Stick
		101052, //Orrel's War-Staff
		101053, //Fearpoint
		101054, //Bejeweled Parrypoint
		101055, //Steamwork Shiv
		101056, //Dreadfall Pike
		101057, //Dawnlight Zweihander
		101058, //Dawnlight Fistwraps
		101059, //Steamwork Compound Bow
		101108, //Solidified Spite
		101109, //Steamwork Faceplate
		101110, //Firemarshal's Signal Whistle
		101111, //Slime Covered Paulder
		101112, //Folded Propellers
		101113, //Bloodmoon Warrior Crest
		101114, //Shiny Ring Gear
		101115, //Bloodmoon Assassin's Belt
		101116, //Faded Treasure Map
		101117, //Shiny Trinket
		101118, //Thorny Oak Mask
		101119, //Chain of Gears
		101120, //Bloodmoon Ritual Mantle
		101121, //Flexible Metal Plating
		101122, //Shield of the Flame Spirits
		101123, //Lifter's Insignia Ring
		101124, //Strong Propeller Drive Belt
		101125, //Condensed Cleaning Residue
		101126, //Fire Reminder
		101127, //Neophyte's Veil
		101128, //Mechanomagical Upper Appendage Joint Plating
		101129, //Gardener's Shawl
		101130, //Bloodmoon Cleric Cloak
		101131, //Bulwark of the Elddar
		101132, //Silvered Ring Gear
		101133, //Mechanical Drive Belt
		101134, //Energized Silver Gear
		101135, //Waterlogged Wheel
		101136, //Dimly Lit Ghostband
		101137, //Bloodmoon Signet Ring
		101138, //Copper Friction Ring
		101139, //Dull Ancestral Signet
		101140, //Energized Wire Coil
		101141, //Fungus Spore Earring
		101142, //Decomposing Metatarsal Stud
		101143, //Mechanomagical Spring
		101144, //Bloodfang Earring
		101145, //Bloodmoon Wolf Whistle
		101146, //Steam Suit Power Cell
		101147, //Rusty Gear
		101148, //Jaklor's Keyring
		101163, //Hook-Bladed Hand Axe
		101164, //Exoskeleton Backup Short Sword
		101165, //Yarnhilted Longsword
		101167, //Grawlthin's Axe
		101168, //Tristos' Weighted Wrench
		101169, //Steelgrip Power-Wrench
		101170, //Hardened Slime Cudgel
		101171, //Energized Hydraulic Rod
		101172, //Main Whirlie Propeller Shaft
		101173, //All-Purpose Longwrench
		101174, //Shortblade of Heart Piercing
		101175, //Pointed Control Shaft
		101176, //Magma-ground Dirk
		101177, //Perilous Pike
		101178, //Sanguine Spear
		101179, //Deadly Weeder's Knives
		101180, //Ralfin's Bloodorb
		101181, //Elkhorn Longbow
		101200, //Storeroom Access Bauble
		101201, //Engraved Horn Earring
		101202, //Steamwork Visor
		101203, //Bolt Studded Choker
		101204, //Shroud of Dusk
		101205, //Cloak of Battered Leather
		101206, //Greasy Clockwork Bauble
		101207, //Clockwork Defensive Guard
		101208, //Oil Drenched Gaudy Ring
		101209, //Polished Horn Ring
		101210, //Servan't Belt
		101211, //Charm of Death's Embrace
		101212, //Micro Repair Tools
		101213, //Moonbound Earring
		101214, //Fine Silver Gear Veil
		101215, //Polished Metallic Pendant
		101216, //Tattered Technician's Mantle
		101217, //Oil Soaked Traveling Cloak
		101218, //Elaborate Clockwork Talisman
		101219, //Acorn Buckler
		101220, //Ring of the Hard Charger
		101221, //Band of Bondage
		101222, //Sash of the Slavers
		101223, //Crude Iron Figurine
		101224, //Fuel Nugget Bauble
		101225, //Steel Spaulders of the Tinkerer
		101226, //Mechanical Back Protection Apparatus
		101227, //Reinforced Steamwork Shield
		101228, //Girdle of the Engineer
		101237, //Troopleader's Sword
		101238, //Lifegutter Appendage
		101240, //Massive Steam-Powered Axe
		101241, //Enhanced Arcsteel Mace
		101242, //Steam Forged Iron Rod
		101243, //Wire Wrapped Sceptre
		101244, //Slagspring's Hydraulic Maul
		101245, //Mechanomagical Grinder Drill
		101246, //Ripper
		101247, //Trainer's Drill Arm
		101248, //Stub-nosed Pliers
		101249, //Bound Torsion Spring
		101300, //Crystal Studded Frozen Hoop
		101301, //Faceplate of Blistering Flame
		101302, //Molten Lava Torque
		101303, //Shroudsteel Pauldrons
		101304, //Condensed Plate Cloak
		101305, //Smooth Dwerium Shield
		101306, //Dark Girdle of the Glacier
		101307, //Magnanimous Icy Stud
		101308, //Smoldering Veil
		101309, //Ironflame Gorget of Steam
		101310, //Swirling-Storm Shoulderguard
		101311, //Glowing Loam Cloak
		101312, //Shimmering Galeforce Aegis
		101313, //Band of Smooth Granite
		101314, //Icy Cinch of Hope
		101315, //Jagged Icy Loop
		101316, //Lavastone Visor
		101317, //Necklace of Focused Flame
		101318, //Cloudburst Chainmail Mantle
		101319, //Cloak of Interlocking Marble
		101320, //Jagged Marble Loop
		101321, //Frozen Belt of the North
		101322, //Icecaster's Earring of Influence
		101323, //Jeweled Veil of the Inferno
		101324, //Sizzling Dragonblood Necklace
		101325, //Cyclonic Shoulderpads
		101326, //Crystal-Adorned Cloak
		101327, //Rune of Draconic Wisdom
		101328, //Ancient Crystal Ring
		101329, //Frostsilk Sash of Ice
		101330, //Draconic Servant's Wand
		101331, //Flame-tempered Brand
		101332, //Sandblasted Signet
		101333, //Featherlight Signet
		101334, //Frost-Runed Bulwark
		101335, //Crystalline Earring of Ice
		101336, //Galeforce Wyvern's Stud
		101337, //Feral Igneous Chopper
		101338, //Tempestuous Longsword
		101340, //Cauterizing Greatsword of Agony
		101341, //Smoldering Cudgel of Grief
		101342, //Wyvern-Priest's Runed Censer
		101343, //Caduceus of the Deep
		101344, //Maul of the Elder Wyvern
		101345, //Shank of the Eternal Squall
		101346, //Glacier-Crystal Lance
		101347, //The Foul Wind
		101348, //Racnar-Bone Recurve
		101349, //Rune of Draconic Loyalty
		10137,  //Ring of Flowing Stones
		101500, //Faende's Diamond Earstud
		101501, //Valorous Visage of Vigor
		101502, //Pendant of the Stoic
		101503, //Blood Soaked Pauldrons
		101504, //Obsidian Drape of Battle
		101505, //Badge of the Resolute Defender
		101506, //Gilded Targe of Kulthar
		101507, //Inscribed Signet of Wegar
		101508, //Barded Gird of Wirlem
		101509, //Orrel's Nightmarish Bauble
		101510, //Elladrial's Singular Auric Ringlet
		101511, //Elladrial's Humility
		101512, //Elladrial's True Pendant of Solace
		101513, //Heavy Spaulders of Gifilnos
		101514, //Elladrial's Scintillating Cloak
		101515, //Eye of Roloff
		101516, //Ring of Healing Visions
		101517, //Sash of Ageless Virtue
		101518, //Emblem of Vestal Grace
		101519, //Firelight Earring
		101520, //Mask of the Deathbringer
		101521, //Gorget of Ferocity
		101522, //Pauldrons of the Ageless Rage
		101523, //Fortunisa's Arcane Nightcloak
		101524, //Gifilnos' Miraculous Hunting Bag
		101525, //Gilded Signet of Valarine
		101526, //Orcish Slaver's Harness
		101527, //Greater Talisman of Werewolf Brain
		101528, //Pearl Studded Earring of Power
		101529, //Visage of Dancing Flame
		101530, //Necklace of Living Ice
		101531, //Epaulettes of the Ageless
		101532, //Moonfire Cape of Ages
		101533, //Fangbreaker Stalking Beads
		101534, //Wendia's Gleaming Guardlet
		101535, //Wendia's Golden Sash
		101536, //Wendia's Blessing
		101608, //Writhing Spite
		101609, //Part Sorter's Faceplate
		101610, //Necklace of Fire Beads
		101611, //Metal Slime Etched Paulders
		101612, //Ivy Etched Folded Propeller
		101613, //Crawtooth's Shield
		101614, //Chamberlain's Ring Gear
		101615, //Balkor's Belt
		101616, //Hester's Treasure Map
		101617, //Part Sorter's Trinket
		101618, //Mask of Ten Thorns
		101619, //Jon E's Control Device
		101620, //Vorash's Ritual Mantle
		101621, //Fine Mesh Backside Heat Protection
		101622, //Pyroplasmic Protector
		101623, //Signate Ring of the Master Lifter
		101624, //Fizzlebot's Propeller Drive Belt
		101625, //Belchforth Pearl
		101626, //Emblem of the Firemarshal
		101627, //Face of Innocence
		101628, //Siegemarshal's Collar
		101629, //Groundskeeper's Shawl
		101630, //Ralfin's Cloak of the Moon
		101631, //Bulwark of the Swiftstalker
		101632, //Fuzzbert's Heart Ring Gear
		101633, //Chamberlain's Drive Belt
		101634, //Destructorizor Power Core
		101635, //Silius's Waterlogged Wheel
		101636, //Viridian Ghostband
		101637, //Vorash's Signet Ring
		101638, //Hogswaller's Voice System Casing
		101639, //Signet of the Deathguard
		101640, //Fuelmaster's Bauble
		101641, //Fungusbloom Cap Earring
		101642, //Petrified Metatarsal Stud
		101643, //Hardbottom's Gearcase Gasket
		101644, //Rakno's Fang
		101645, //Horak's Wolf Whistle
		101646, //The Guardian's Power Coil
		101647, //Rusty Steamwork Eye
		101648, //Bloodied Gnome Head
		101700, //Chamberlain Access Bauble
		101701, //Finely Carved Horn Bangle
		101702, //Model XIV Face Plate
		101703, //Twiner's Bolt Studded Choker
		101704, //Findlewill's Shroud of Eternal Night
		101705, //Cloak of the Rocksmasher
		101706, //Lotrip's Clockwork Bauble
		101707, //Steam-Powered Defensive Device
		101708, //Oily Diamond Ring
		101709, //Pitted Iron Ring
		101710, //Matron's Sash
		101711, //Eldaroth's Phylactery of Pain
		101712, //Model XIV Repair Tools
		101713, //Earring of the Waning Moon
		101714, //Chamberlain Logic Center
		101715, //Lotrip's Scrap Metal Amulet
		101716, //Steamwork Technician's Mantle
		101717, //Polished Cloak of Woven Wire
		101718, //Twiner's Clockwork Talisman
		101719, //Shield of Emerald Daylight
		101720, //Rocksmasher Ring
		101721, //Golden Band of Bondage
		101722, //Dark Sash of the Master
		101723, //Etched Iron Sphere
		101724, //Model XI Fuel Nugget Bauble
		101725, //Binsprocket's Favored Spaulders
		101726, //Experimental Distraction Cloak
		101727, //Thickgear's Defensive Apparatus
		101728, //Slagspring's Belt of Tinkering
		101800, //Torrentus' Studded Hoop
		101801, //Alkaa's Visage of Combustion
		101802, //Flamesteel Gorget of Protection
		101803, //Zirkanamef's Shrouded Spaulders
		101804, //Tectoran's Cloak of Tremors
		101805, //Tectoran's Stonescale Aegis
		101806, //Torrentus' Waistplate of the Glacier
		101807, //Icy Lightstud of Torrentus
		101808, //Blessed Facemask of the Dragonborn
		101809, //Alkaa's Choker of Blessings
		101810, //Zirkanamef's Stormhide Mantle
		101811, //Stone-blessed Benevolent Cloak
		101812, //Zirkanamef's Pearly Escutcheon
		101813, //Ring of Hallowed Earth
		101814, //Torrentus' Frozen Cinch
		101815, //Painstud of Torrentus
		101816, //Smoldering Mask of Cruelty
		101817, //Alkaa's Magmatic Neckguard
		101818, //Stormy Pauldrons of Lightning
		101819, //Swift Stonecloak of Tectoran
		101820, //Bloodthirsty Granite Ring
		101821, //Torrentus' Prized Bloodbelt
		101822, //Glowing Draconic Icehoop
		101823, //Alkaa's Incendiary Facade
		101824, //Alkaa's Burning Pendant
		101825, //Mantle of the Great Storm
		101826, //Tectonic Shroud of Crystallos
		101827, //Prismatic Glyph of Wisdom
		101828, //Quaking Ring of Tectoran
		101829, //Torrentus' Frostsilk Sash
		101830, //Torch of Eternal Servitude
		101831, //Brand of Holy Conflagration
		101832, //Sandbattered Signet of Comfort
		101833, //Featherlight Signet of Wind
		101834, //Bulwark of Freezing Rains
		101835, //Enchanted Wyvern-Skin Hoop
		101836, //Thunderclap Hoop
		101849, //Prismatic Glyph of Loyalty
		10231,  //Puremetal Band
		10234,  //Simple Ring of Purity
		10240,  //Band of Elder Understanding
		10242,  //Earring of Embedded Coral
		10654,  //Moss Encrusted Band
		10948,  //Timestone Adorned Ring
		11030,  //Bracer of Flickering Flames
		11163,  //Trydan's Bracer of Nobility
		11173,  //Grimror's Bracer of the Plagues
		11178,  //Rizlona's Fiery Bracer
		11193,  //Askr's Thunderous Bracer
		11196,  //Dumul's Bracer of the Brute
		11199,  //Ultor's Bracer of Faith
		11278,  //Rosrak's Bracer of the Primal
		11281,  //Kerasha's Sylvan Bracer
		11298,  //Romar's Bracer of Visions
		11303,  //Magi`Kot's Bangle of Convergence
		11306,  //Miragul's Bracelet of Risen Souls
		11309,  //Maelin's Bracelet of Lore
		11323,  //Shimmering Sleeves of Flame
		11324,  //Fire Crested Rune
		11402,  //Leaf-twined Guards
		11438,  //Trydan's Armplates of Nobility
		11441,  //Grimror's Sleeves of the Plagues
		11444,  //Rizlona's Fiery Vambraces
		11447,  //Askr's Thunderous Armplates
		11450,  //Dumul's Sleeves of the Brute
		11529,  //Rosrak's Sleeves of the Primal
		11575,  //Kerasha's Sylvan Sleeves
		11578,  //Romar's Sleeves of Visions
		11598,  //Magi`Kot's Sleeves of Convergence
		11618,  //Miragul's Sleeves of Risen Souls
		11876,  //Maelin's Sleeves of Lore
		12054,  //Cord of the Pyre
		12082,  //Cloak of Combustion
		12510,  //Gleaming Mesh Girdle
		12592,  //Great Mask of Flame
		12627,  //Trydan's Gauntlets of Nobility
		12637,  //Grimror's Gauntlets of the Plagues
		12664,  //Rizlona's Fiery Gauntlets
		12665,  //Staff of Prismatic Power
		12816,  //Askr's Thunderous Gauntlets
		13553,  //Dumul's Gloves of the Brute
		13555,  //Ancient Longhandled Frostreaver
		13563,  //Ultor's Gauntlets of Faith
		13579,  //Rosrak's Gauntlets of the Primal
		13603,  //Kerasha's Sylvan Gloves
		13614,  //Romar's Gloves of Visions
		13619,  //Magi`Kot's Gloves of Convergence
		13623,  //Miragul's Gloves of Risen Souls
		13627,  //Maelin's Gloves of Lore
		13634,  //Kelp-lined Mantle
		13638,  //Pauldrons of Purity
		13647,  //Mantle of Pure Spirit
		13673,  //Shroud of Provocation
		13674,  //Shroud of Survival
		13694,  //Sharkbone Plated Shoulderpads
		14747,  //Vest of Phoenix Feathers
		14818,  //Ring of Thunderous Forces
		14943,  //Immaculate Vest of the Fire Tyrant
		14961,  //Mail of Storms
		15001,
		15001, //Ghostrider's Bridle and Barding
		15002, //Chestguard of Enchanted Marble
		15805, //Shroud of Eternity
		15812, //Tethered Air Cape
		15814, //Cape of Flames
		15815, //Cloak of the Falling Skies
		15822, //Shroud of the Stonecrafter
		15823, //Raiment of the Fire Son
		15824, //Platinum Cloak of War
		15840, //Cloak of Flickering Flame
		15842, //Cloak of Retribution
		15847, //Celestial Cloak
		15867, //Wand of Impenetrable Force
		15871, //Woven Steel Sash
		15873, //Valiant Belt of Fallen Heroes
		15877, //Belt of Tidal Energy
		15881, //Cord of Potential
		15927, //Belt of Temporal Bindings
		16097, //Double Woven Kelp Cord
		16156, //Cord of Temporal Weavings
		16158, //Bands of Earthen Energy
		16255, //Signet of Might
		16257, //Signet of the Arcane
		16576,
		16576, //Staff of Phenomenal Power
		16637, //Leaf-jointed Cloak
		16679, //Earring of Eternal Flame
		16757, //Trydan's Greaves of Nobility
		16763, //Grimror's Greaves of the Plagues
		16771, //Rizlona's Fiery Greaves
		16777, //Askr's Thunderous Greaves
		16787, //Dumul's Leggings of the Brute
		16797, //Ultor's Greaves of Faith
		16803, //Rosrak's Greaves of the Primal
		16811, //Kerasha's Sylvan Leggings
		16931, //Romar's Pantaloons of Visions
		17337,
		17337, //Fabled Secrets of the Planes
		17524, //Felbane the Dragon Slayer
		19021, //Magi`Kot's Pants of Convergence
		19024, //Miragul's Greaves of Risen Souls
		19027, //Maelin's Leggings of Lore
		19092, //Staff of Elemental Essence
		19094, //Sable Shoes of Flame
		19449, //Trydan's Boots of Nobility
		19546, //Grimror's Boots of the Plagues
		19549, //Rizlona's Fiery Boots
		19762, //Shimmering Black Pearl
		19838, //Askr's Thunderous Boots
		19839,
		19839, //Focus of Primal Elements
		20032, //Dumul's Boots of the Brute
		20074, //Ultor's Boots of Faith
		20076,
		20076, //Aegis of Superior Divinity
		20078, //Rosrak's Boots of the Primal
		20422, //Kerasha's Sylvan Boots
		20425, //Romar's Slippers of Visions
		20428, //Magi`Kot's Shoes of Convergence
		20431, //Miragul's Shoes of Risen Souls
		20434, //Maelin's Shoes of Lore
		20453, //Bone Sliver Ornament
		20454, //Stone Etched Mallet
		20486, //The Orb of the Sun
		20496, //Spool of Woven Time
		20507, //Blackflame Sphere
		20508, //Symbol of Ancient Summoning
		20621, //Earthen Bile
		20625, //Serrated Dart of Energy
		20627, //Hammer of Holy Vengeance
		20896, //Air Fetish
		20898, //Symbol of the Planemasters
		21875, //Cudgel of Glowing Clay
		21876, //Wand of Temporal Power
		21886, //Hammer of Hours
		21993, //Bracer of the Inferno
		21994, //Protective Sleeves
		21995, //Armguards of the Brute
		21996, //Cloak of Ferocity
		21997, //Cloak of Wishes
		21998, //Cape of Endless Torment
		21999, //Hoop of the Enlightened
		22883, //Cudgel of Wrecking
		22889, //Heavy Bludgeoner
		22890, //Cudgel of Venomous Hatred
		22894, //Hammer of the Timeweaver
		22959, //Serpent of Vindication
		22972, //Clawed Earthcrafter's Hoop
		22986, //Edge of Eternity
		22990, //Gem Encrusted Axe
		22998, //Ethereal Destroyer
		23498, //Hopebringer
		24569, //Rune Stamped Blade
		24570, //Songblade of the Eternal
		24573, //Timespinner, Blade of the Hunter
		24585, //Sword of Primordial Power
		24587, //Ivory Hilted Cleaver
		24589, //Spear of Fire
		24602, //Ifir, Dagger of Fire
		24695, //Reinforced Mephit Talon
		24699, //Time's Antithesis
		24773, //Bejeweled Dagger of Summoning
		24774, //Algae Covered Stiletto
		24776, //Dagger of Distraction
		24789, //Staff of Eternal Flames
		24793,
		24793, //Greatstaff of Power
		24879, //Earthspined Staff
		24999,
		24999, //Staff of Transcendence
		25220, //Rune Etched Bamboo Bo
		25844, //Pulsing Emerald Hoop
		25981, //Ornate Greatblade
		25983, //Stone Etched War Sword
		25987, //Basalt Greatsword of the Protector
		25989, //Blade of War
		25995, //Boots of Despair
		25998, //Shield of the Vortex
		26038, //Opalescent Two-Handed Sword
		26087, //Greatstaff of Misery
		26092,
		26092, //Greatblade of Chaos
		26095, //Crow Footed Lance
		26220, //Hammer of Crushing Waves
		2630,
		2630,  //Whispering Air Bangle
		26587, //The Sword of Ssraeshza
		26599, //Caen's Bo Staff of Fury
		26607, //Hobart's Ring of Rage
		26737, //Exquisite Puresteel Wraps
		26738, //Fiery Staff of Zha
		26740, //Shinai of the Ancients
		26748, //Wand of the Firestorm
		26749, //Azaliil's Ring of Analogies
		26761, //Belt of Mastery
		26770, //Great Shadow Platemail
		26776, //Robe of Secrets
		26778, //Orb of Secrets
		26779, //Mask of Secrets
		26782, //Mail of Judgment
		26784, //Torch of Judgment
		26787, //Wristband of Judgement
		26788, //Xephyrus, Wand of the Flowing Wind
		26789, //Time Traveler's Abandoned Notebook
		26795, //Grimoire of Extraplanar Wisdom
		26798, //Flame Idol of Ro
		26799, //Globe of Mystical Protection
		26865, //Symbol of the Plaguebringer
		26895, //Orb of Clinging Death
		26899, //Wand of the Vortex
		26980, //Earring of Unseen Horrors
		26981, //Veil of Lost Hopes
		26982, //Visor of the Berserker
		26983, //Faceguard of Frenzy
		26984, //Mask of Simplicity
		26985, //Veil of Warmth
		26986, //Shoes of Fleeting Fury
		26987, //Stone of Flowing Time
		26988, //Winged Storm Boots
		26989, //Prismatic Ring of Resistance
		26990, //Band of Primordial Energy
		26991, //Band of Prismatic Focus
		26992, //Ring of Force
		26993, //Pulsing Onyx Ring
		26994, //Ring of Evasion
		26995, //Tiny Jade Ring
		26996, //Gloves of the Unseen
		27000, //Padded Tigerskin Gloves
		27106, //Circular Crystalline Formation
		27272, //Intricately Etched Seashell
		27273, //Bulwark of Shimmering Steel
		27274, //Barrier of Freezing Winds
		27280, //Whorl of Unnatural Forces
		27298, //Shield of Strife
		27818, //Bow of the Tempest
		27986, //Alabaster Hilted Wind Bow
		27990, //Gauntlets of Disruption
		27992, //The Rhythm of Xegony
		27994, //Lute of the Flowing Waters
		27996, //Blaring Horn of Fire
		27998, //War Drums of the Rathe
		28246, //Gloves of Airy Mists
		28605, //Coif of Flowing Time
		28647, //Helm of Flowing Time
		28648, //Cap of Flowing Time
		28649, //Ethereal Silk Leggings
		28650, //Greaves of Furious Might
		28651, //Leggings of Furious Might
		28652, //Pants of Furious Might
		28653, //Glowing Chains
		28654, //Amulet of Crystal Dreams
		28655, //Smooth Onyx Torque
		28656, //Tactician's Shield
		28657, //Fiery Crystal Guard
		28658, //Mantle of Deadly Precision
		28659, //Pauldrons of Devastation
		28660, //Drape of the Unending
		28661, //Shawl of Eternal Forces
		28662, //Girdle of Restoration
		28663, //Runewarded Belt
		28664, //Girdle of Intense Durability
		28665, //Zealot's Spiked Bracer
		28666, //Wristband of Echoed Thoughts
		28667, //Bracer of Precision
		28668, //Wristguard of Keen Vision
		28935, //Bow of Flames
		28941, //Great Sword of Slaughter
		28957, //Girdle of Focus
		28961, //Great Sword of Pestilence
		28964, //Cloak of Frozen Flames
		28966, //Star Weave
		28969, //Halberd of Destruction
		28974, //Great Maul of Slaughter
		28981, //Grimoire of Enchantment
		28985, //Scythe of Shadows
		28992, //Cloak of Glowing Embers
		28993, //Silver Band of Secrets
		28994, //Crimson Ring of Judgment
		29172, //Vanazir, Dreamer's Despair
		29174, //Mask of Strategic Insight
		31603, //Girdle of Stability
		32012, //Ultor's Vambraces of Faith
		32100, //Earthen Bracer of Fortitude
		32106, //Jade Hoop of Speed
		32107, //Cord of Invigoration
		32108, //Mace of the Ancients
		32109, //Ring of Farsight
		32110, //Wristband of Icy Vengeance
		4119,  //Earring of Celestial Energy
		5594,  //Earring of Temporal Solstice
		5760,  //Earring of Xaoth Kor
		5975,  //War Charm of Crossed Blades
		7123,  //Silver Hoop of Speed
		7125,  //Earring of Corporeal Essence
		7130,  //Earring of Influxed Gravity
		7767,  //Necklace of Reflected Flames
		7769,  //Talisman of the Elements
		8773,  //Gemstone Choker
		8774,  //Talisman of Tainted Energy
		8780,  //Entropy Pendant
		8781,  //Twisted Twig Charm
		8782,  //Necklace of Celestial Energy
		8977,  //Collar of Catastrophe
		9289,  //Necklace of Eternal Visions
		9435,  //Veil of the Inferno
		9444,  //Mask of Conceptual Energy
		9462,  //Mask of the Insightful
		9468,  //Scintillating Feather Mask
		9488,  //Abalone Engraved Tribal Mask
		9574,  //Eye of Dreams
		9812,  //Trydan's Helm of Nobility
		9815,  //Grimror's Helm of the Plagues
		9818,  //Rizlona's Fiery Helm
		9821,  //Askr's Thunderous Helm
		9824,  //Dumul's Cap of the Brute
		9827,  //Ultor's Helm of Faith
		9830,  //Rosrak's Helm of the Primal
		9833,  //Kerasha's Sylvan Cap
		9836,  //Romar's Circlet of Visions
		9944,  //Magi`Kot's Tiara of Convergence
		9947,  //Miragul's Crown of Risen Souls
		9950,  //Maelin's Skullcap of Lore
		9955,  //Harmony of the Soul
		9959,  //Band of Swirling Air
	}

	for i := int64(32969); i < 99212; i++ {
		ids = append(ids, i)
	}
	for i := int64(102000); i < 132486; i++ {
		ids = append(ids, i)
	}
	return
}
