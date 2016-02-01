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
		switch ($class) {
			case "bard":
			$fullName = "Bard";
			$this->template->monogram = 8;
			$desc = "Bards sing songs to aid allies in battle.<br> Their 3 styles focus on group, melee, or solo.";
			$styles[0] = "Virtuoso";
			$styles[1] = "Swordsinger";
			$styles[2] = "Maestro";
			break;
			case "cleric":
			$fullName = "Cleric";
			$this->template->monogram = 2;
			$desc = "Clerics are classically known as the best healers in the game.<br> Their 3 styles focus on melee, healing, or protection.";
			$styles[0] = "Templar";
			$styles[1] = "Bishop";
			$styles[2] = "Archon";
			break;
			case "druid":
			$fullName = "Druid";
			$this->template->monogram = 6;
			$desc = "Druids are a mix of healer and damage dealer.<br> Their 3 styles focus on either Crowd Control, Heals, or Offense.";
			$styles[0] = "Preserver";
			$styles[1] = "Warden";
			$styles[2] = "Hierophant";
			break;
			case "enchanter":
			$fullName = "Enchanter";
			$this->template->monogram = 14;
			$desc = "Enchanters have had a heavy modification on Rebuild EQ.<br> Due to illusions no longer being easily accessible, illusions are now more offensive. Their builds focus on either debuffs, domination, or inspiration.";
			$styles[0] = "Illusionist";
			$styles[1] = "Entrancer";
			$styles[2] = "Beguiler";
			break;
			case "magician":
			$fullName = "Magician";
			$this->template->monogram = 13;
			$desc = "Magicians are conjurers of creatures from other planes or offensive specialists.<br> Their 3 styles focus on either stronger pets, area of effect damage, or empowering their utility skills";
			$styles[0] = "Conjurer";
			$styles[1] = "Elementalist";
			$styles[2] = "Geomancer";
			break;
			case "monk":
			$fullName = "Monk";
			$this->template->monogram = 7;
			$desc = "Monks are disciplined fighters.<br> Their 3 styles focus on either melee dps, supporting others with chakra abilities, or utility pulling.";
			$styles[0] = "Master";
			$styles[1] = "Transcendant";
			$styles[2] = "Ashenhand";
			break;
			case "necromancer":
			$fullName = "Necromancer";
			$this->template->monogram = 11;
			$desc = "Necromancers are master of the dead.<br> They have the best DoTs of any class with one focus. The other 2 focus on debuffs, and tanking.";
			$styles[0] = "Heretic";
			$styles[1] = "Lich";
			$styles[2] = "Warlock";
			break;
			case "paladin":
			$this->template->monogram = 3;
			$fullName = "Paladin";
			$desc = "Paladins are the holy knights.<br> Their 3 styles focus on better healing and support, tanking, or damage dealing.";
			$styles[0] = "Protector";
			$styles[1] = "Knight";
			$styles[2] = "Crusader";
			break;
			case "ranger":
			$fullName = "Ranger";
			$this->template->monogram = 4;
			$desc = "Rangers are friends with beasts.<br> Their 3 styles focus on either better archery, enabling and strengthening a beast companion, or supporting others.";
			$styles[0] = "Archer";
			$styles[1] = "Hunter";
			$styles[2] = "Plainswalker";
			break;
			case "rogue":
			$fullName = "Rogue";
			$this->template->monogram = 9;
			$desc = "Rogues are thieves who specialize in deception.<br> Their 3 styles focus on dealing damage, being an evasive tank, or stealing.";
			$styles[0] = "Assassin";
			$styles[1] = "Deceiver";
			$styles[2] = "Bandit";
			break;
			
			case "shaman":
			$fullName = "Shaman";
			$this->template->monogram = 10;
			$desc = "Shamans are one with spirits, specializing in buffing.<br> Their 3 styles focus on giving buffs among other utility bonuses, being a focused healer, or enchanting themselves to be more viable in melee.";
			$styles[0] = "Prophet";
			$styles[1] = "Oracle";
			$styles[2] = "Elder";
			break;
			case "warrior":
			$fullName = "Warrior";
			$this->template->monogram = 1;
			$desc = "Warriors are hearty duelists.<br> Gladiators will hone their blade mastery to allow them to deal damage unheard of before, Brawlers live off the thrill of battle, and Champions seek glory with their ability to survive.";
			$styles[0] = "Gladiator";
			$styles[1] = "Brawler";
			$styles[2] = "Champion";
			break;
			case "wizard":
			$fullName = "Wizard";
			$this->template->monogram = 12;
			$desc = "Wizards are masters of the elements.<br> Evokers deal high elemental damage. Channelers focus on utility, while Sage is focused on support.";
			$styles[0] = "Evoker";
			$styles[1] = "Channeler";
			$styles[2] = "Sage";
			break;
			case "shadowknight":
			default:
			$fullName = "Shadow Knight";
			$this->template->monogram = 5;
			$desc = "Shadow Knights are unholy knights.<br> Their 3 styles focus tanking by taking blood of their victims, dealing damage with spears and other abilities, or crowd control pulling.";
			$styles[0] = "Bloodreaver";
			$styles[1] = "Defiler";
			$styles[2] = "Revenant";
			break;
		}	
		$this->template->styles = $styles;
		$this->template->site->image = "http://rebuildeq.com/images/monograms/".$this->template->monogram.".gif";
		$this->template->site->title = $fullName;
		$this->template->fullName = $fullName;
		$this->template->classDescription = $desc;
		$this->template->site->description = $desc;
	}

}
