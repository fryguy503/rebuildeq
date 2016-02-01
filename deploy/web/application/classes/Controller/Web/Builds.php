<?php defined('SYSPATH') or die('No direct script access.');

class Controller_Web_Builds extends Template_Web_Core {


	public function before() {

		parent::before();
		$this->template->site->title = "Shadow Knight Build";
		$this->template->site->description = "Shadow Knight Custom Build For RebuildEQ";
		
	}

	public function action_index() {
		$class =  strtolower($this->request->param('class'));
		$styles = array();
		$skills = array();
		switch ($class) {
			//==================BARD======================
			case "bard":
			$fullName = "Bard";
			$this->template->monogram = 8;
			$desc = "Bards sing songs to aid allies in battle.<br> Their 3 styles focus on group, melee, or solo.";
			$styles[0] = "Virtuoso";
			$styles[1] = "Swordsinger";
			$styles[2] = "Maestro";
			break;
			//==================CLERIC======================
			case "cleric":
			$fullName = "Cleric";
			$this->template->monogram = 2;
			$desc = "Clerics are classically known as the best healers in the game.<br> Their 3 styles focus on melee, healing, or protection.";
			$styles[0] = "Templar";
			$styles[1] = "Bishop";
			$styles[2] = "Archon";
			break;
			//==================DRUID======================
			case "druid":
			$fullName = "Druid";
			$this->template->monogram = 6;
			$desc = "Druids are a mix of healer and damage dealer.<br> Their 3 styles focus on either Crowd Control, Heals, or Offense.";
			$styles[0] = "Preserver";
			$styles[1] = "Warden";
			$styles[2] = "Hierophant";
			break;
			//==================ENCHANTER======================
			case "enchanter":
			$fullName = "Enchanter";
			$this->template->monogram = 14;
			$desc = "Enchanters have had a heavy modification on Rebuild EQ.<br> Due to illusions no longer being easily accessible, illusions are now more offensive. Their builds focus on either debuffs, domination, or inspiration.";
			$styles[0] = "Illusionist";
			$styles[1] = "Entrancer";
			$styles[2] = "Beguiler";
			break;
			//==================MAGICIAN======================
			case "magician":
			$fullName = "Magician";
			$this->template->monogram = 13;
			$desc = "Magicians are conjurers of creatures from other planes or offensive specialists.<br> Their 3 styles focus on either stronger pets, area of effect damage, or empowering their utility skills";
			$styles[0] = "Conjurer";
			$styles[1] = "Elementalist";
			$styles[2] = "Geomancer";
			break;
			//==================MONK======================
			case "monk":
			$fullName = "Monk";
			$this->template->monogram = 7;
			$desc = "Monks are disciplined fighters.<br> Their 3 styles focus on either melee dps, supporting others with chakra abilities, or utility pulling.";
			$styles[0] = "Master";
			$styles[1] = "Transcendant";
			$styles[2] = "Ashenhand";
			break;
			//==================NECROMANCER======================
			case "necromancer":
			$fullName = "Necromancer";
			$this->template->monogram = 11;
			$desc = "Necromancers are master of the dead.<br> They have the best DoTs of any class with one focus. The other 2 focus on debuffs, and tanking.";
			$styles[0] = "Heretic";
			$styles[1] = "Lich";
			$styles[2] = "Warlock";
			break;
			//==================PALADIN======================
			case "paladin":
			$this->template->monogram = 3;
			$fullName = "Paladin";
			$desc = "Paladins are the holy knights.<br> Their 3 styles focus on better healing and support, tanking, or damage dealing.";
			$styles[0] = "Protector";
			$styles[1] = "Knight";
			$styles[2] = "Crusader";
			break;
			//==================RANGER======================
			case "ranger":
			$fullName = "Ranger";
			$this->template->monogram = 4;
			$desc = "Rangers are friends with beasts.<br> Their 3 styles focus on either better archery, enabling and strengthening a beast companion, or supporting others.";
			$styles[0] = "Archer";
			$styles[1] = "Hunter";
			$styles[2] = "Plainswalker";
			break;
			//==================ROGUE======================
			case "rogue":
			$fullName = "Rogue";
			$this->template->monogram = 9;
			$desc = "Rogues are thieves who specialize in deception.<br> Their 3 styles focus on dealing damage, being an evasive tank, or stealing.";
			$styles[0] = "Assassin";
			$styles[1] = "Deceiver";
			$styles[2] = "Bandit";
			break;
			//==================SHAMAN======================
			case "shaman":
			$fullName = "Shaman";
			$this->template->monogram = 10;
			$desc = "Shamans are one with spirits, specializing in buffing.<br> Their 3 styles focus on giving buffs among other utility bonuses, being a focused healer, or enchanting themselves to be more viable in melee.";
			$styles[0] = "Prophet";
			$styles[1] = "Oracle";
			$styles[2] = "Elder";
			break;
			//==================WARRIOR======================
			case "warrior":
			$fullName = "Warrior";
			$this->template->monogram = 1;
			$desc = "Warriors are hearty duelists.<br> Gladiators will hone their blade mastery to allow them to deal damage unheard of before, Brawlers live off the thrill of battle, and Champions seek glory with their ability to survive.";
			$styles[0] = "Gladiator";
			$styles[1] = "Brawler";
			$styles[2] = "Champion";
			break;
			//==================WIZARD======================
			case "wizard":
			$fullName = "Wizard";
			$this->template->monogram = 12;
			$desc = "Wizards are masters of the elements.<br> Evokers deal high elemental damage. Channelers focus on utility, while Sage is focused on support.";
			$styles[0] = "Evoker";
			$styles[1] = "Channeler";
			$styles[2] = "Sage";
			break;
			//==================SHADOWKNIGHT======================
			case "shadowknight":
			default:
			$fullName = "Shadow Knight";
			$this->template->monogram = 5;
			$desc = "Shadow Knights are unholy knights.<br> Their 3 styles focus tanking by taking blood of their victims, dealing damage with spears and other abilities, or crowd control pulling.";
			$styles[0] = "Bloodreaver";
			$styles[1] = "Defiler";
			$styles[2] = "Revenant";
			//0
			$newSkill = new stdClass();
			$newSkill->title = "Soul Link";
			$newSkill->desc = 'Improves lifetap damage by <em data-base="+4">+4</em>% and a <em data-base="+1">+1</em>% chance to critical heal<span class="perLevel"> per level</span>.';
			$newSkill->image = "/images/builds/icons/gunzerker-gunlust-0.png";	
			$skills[0] = $newSkill;
			//1
			//2
			$newSkill = new stdClass();
			$newSkill->title = "Gouging Skin";
			$newSkill->desc = 'When attacked, causes a <em data-base="+6">+6</em> point damage shield and <em data-base="+20">+20</em> hate<span class="perLevel"> per level</span>.';
			$newSkill->image = "/images/builds/icons/gunzerker-gunlust-0.png";	
			$skills[2] = $newSkill;
			//3
			//4
			$newSkill = new stdClass();
			$newSkill->title = "Hungering Aura";
			$newSkill->desc = 'Improves lifetaps by <em data-base="+6">+6</em>% healing for each enemy attacking you with a maximum of <em data-base="+1">+1</em> enemies<span class="perLevel"> per level</span>.';
			$newSkill->image = "/images/builds/icons/gunzerker-gunlust-3.png";	
			$skills[4] = $newSkill;
			//5
			//6
			$newSkill = new stdClass();
			$newSkill->title = "Deathbringer";
			$newSkill->desc = 'Improves pet by increasing level by <em data-base="+6">+6</em>, HP by <em data-base="+200">+200</em>, and AC by <em data-base="+40">+40</em><span class="perLevel"> per level</span>.';
			$newSkill->image = "/images/builds/icons/gunzerker-gunlust-7.png";	
			$skills[6] = $newSkill;
			//7
			//8
			$newSkill = new stdClass();
			$newSkill->title = "Zevfeer's Feast";
			$newSkill->desc = 'Improves Zevfeer\'s Bite to give an additional <em data-base="+100">+100</em>% health and an additional <em data-base="+100">+100</em> mana<span class="perLevel"> per level</span>.';
			$newSkill->image = "/images/builds/icons/gunzerker-gunlust-9.png";	
			$skills[8] = $newSkill;
			//9
			//10
			$newSkill = new stdClass();
			$newSkill->title = "Sworn Enemy";
			$newSkill->desc = 'Causes intense hatred of target, where any spell damage dealt causes an additional <em data-base="+400">+400</em> hate<span class="perLevel"> per level</span>.';
			$newSkill->image = "/images/builds/icons/gunzerker-gunlust-10.png";	
			$skills[10] = $newSkill;
			//11
			//12
			//13
			$newSkill = new stdClass();
			$newSkill->title = "Banshee's Mirror";
			$newSkill->desc = 'Improves Damage Mitigation by <em data-base="+6">+6</em>% for <em data-base="+30">30</em> seconds <span class="perLevel"> per level</span>.';
			$newSkill->image = "/images/builds/icons/gunzerker-gunlust-1.png";	
			$skills[13] = $newSkill;
			//14
			//15
			//16
			$newSkill = new stdClass();
			$newSkill->title = "Aura of Vampirism";
			$newSkill->desc = 'Grants the entire group <em data-base="+4">+4</em>% spell vampirism and <em data-base="+10">+10</em>% melee vampirism<span class="perLevel"> per level</span>.';
			$newSkill->image = "/images/builds/icons/gunzerker-gunlust-2.png";	
			$skills[16] = $newSkill;
			//17
			break;
		}
		$this->template->skills = $skills;
		$this->template->styles = $styles;
		$this->template->site->image = "http://rebuildeq.com/images/monograms/".$this->template->monogram.".gif";
		$this->template->site->title = $fullName;
		$this->template->fullName = $fullName;
		$this->template->classDescription = $desc;
		$this->template->site->description = $desc;
	}
}
