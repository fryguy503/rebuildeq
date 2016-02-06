<?php defined('SYSPATH') or die('No direct script access.');

class Controller_Web_Builds extends Template_Web_Core {


	public function before() {

		parent::before();
		$this->template->site->title = "Shadow Knight Build";
		$this->template->site->description = "Shadow Knight Custom Build For RebuildEQ";
		
	}

	public function action_index() {

		$class =  strtolower($this->request->param('class'));
		$skills = array();		

		//Validate Session
		$session = $this->request->param('session');

		if (!empty($session)) {
			//First see if session exists
			$sessionObject = DB::select('session')->from('character_data')->where('session', '=', $session)->as_object()->execute()->current();
			if (empty($sessionObject)) {
				$this->template->errorMessage = "Invalid Session Provided. Go in game and type #builds to create a new session.";
			}

			$tmpChar = DB::select('name, last_name, class, level, build_data')->from('character_data')->where('session', '=', $session)->where('session_timeout', '>=', DB::expr('NOW()'))->limit(1)->as_object()->execute()->current();
			if (empty($tmpChar)) {
				$this->template->errorMessage = "Expired Session provided. Go in game and type #builds to create a new session.";
			} else {
				$character = new stdClass();
				$character->name = $tmpChar->name;
				if (!empty($tmpChar->last_name)) {
					$character->name .= " ".$tmpChar->last_name;
				}
				$character->level = $tmpChar->level;
				$class = $this->convert_class($tmpChar->class);
				if (!empty($tmpChar->build_data)) {
					$build = Build::clean($tmpChar->build_data);
					if (!Build::validate($build, $tmpChar->level)) {
						$oldBuild = $build;						
						$build = "00000000000000000000000000000000000000000000000000000";
						$build = Build::clean($build);
						//mail("rebuildeq@gmail.com", "Invalid Build for ".$tmpChar->name, "The build raw:".$tmpChar->build_data."\nOld Build: $oldBuild\nResetting it to:".$build);
						$data = array('build_data' => $build);
						DB::update('character_data')->set($data)->where('session', "=", $session)->limit(1)->execute();
					}
					$this->template->hash = $build;
				}
				//guildname invalid
				$this->template->character = $character;
				$this->template->session = $session;
			}
		}

		//Validate Build
		$buildHash = $this->request->query('build');
		if (empty($character) && !empty($buildHash)) {
			//ValidateHash
			if (!Build::validate($buildHash)) {
				die("Invalid build");
			}
			$this->template->hash = $buildHash;
		}

		$build = $this->get_build_info($class);
		$skills = $this->get_skills($class);

		$this->template->skills = $skills;
		$this->template->monogram = $build->monogram;
		$this->template->styles = $build->styles;
		$this->template->site->image = "http://rebuildeq.com/images/monograms/".$build->monogram.".gif";
		$this->template->site->title = $build->fullName;
		$this->template->fullName = $build->fullName;
		$this->template->classDescription = $build->desc;
		$this->template->site->description = $build->desc;
	}

	private function convert_class($class) {
		if ($class == 1) return "warrior";
		if ($class == 2) return "cleric";
		if ($class == 3) return "paladin";
		if ($class == 4) return "ranger";
		if ($class == 5) return "shadowknight";
		if ($class == 6) return "druid";
		if ($class == 7) return "monk";
		if ($class == 8) return "bard";
		if ($class == 9) return "rogue";
		if ($class == 10) return "shaman";
		if ($class == 11) return "necromancer";
		if ($class == 12) return "wizard";
		if ($class == 13) return "magician";
		if ($class == 14) return "enchanter";
		return "shadowknight";
	}

	private function get_build_info($class) {
		$build = new stdClass();
		$build->styles = array();
		switch ($class) {
			//==================BARD======================
			case "bard":
			$build->fullName = "Bard";
			$build->monogram = 8;
			$build->desc = "Bards sing songs to aid allies in battle.<br> Their 3 styles focus on group, melee, or solo.";
			$build->styles[0] = "Virtuoso";
			$build->styles[1] = "Swordsinger";
			$build->styles[2] = "Maestro";
			break;
			//==================CLERIC======================
			case "cleric":
			$build->fullName = "Cleric";
			$build->monogram = 2;
			$build->desc = "Clerics are classically known as the best healers in the game.<br> Their 3 styles focus on melee, healing, or protection.";
			$build->styles[0] = "Templar";
			$build->styles[1] = "Bishop";
			$build->styles[2] = "Archon";
			break;
			//==================DRUID======================
			case "druid":
			$build->fullName = "Druid";
			$build->monogram = 6;
			$build->desc = "Druids are a mix of healer and damage dealer.<br> Their 3 styles focus on either Crowd Control, Heals, or Offense.";
			$build->styles[0] = "Preserver";
			$build->styles[1] = "Warden";
			$build->styles[2] = "Hierophant";
			break;
			//==================ENCHANTER======================
			case "enchanter":
			$build->fullName = "Enchanter";
			$build->monogram = 14;
			$build->desc = "Enchanters have had a heavy modification on Rebuild EQ.<br> Due to illusions no longer being easily accessible, illusions are now more offensive. Their builds focus on either debuffs, domination, or inspiration.";
			$build->styles[0] = "Illusionist";
			$build->styles[1] = "Entrancer";
			$build->styles[2] = "Beguiler";
			break;
			//==================MAGICIAN======================
			case "magician":
			$build->fullName = "Magician";
			$build->monogram = 13;
			$build->desc = "Magicians are conjurers of creatures from other planes or offensive specialists.<br> Their 3 styles focus on either stronger pets, area of effect damage, or empowering their utility skills";
			$build->styles[0] = "Conjurer";
			$build->styles[1] = "Elementalist";
			$build->styles[2] = "Geomancer";
			break;
			//==================MONK======================
			case "monk":
			$build->fullName = "Monk";
			$build->monogram = 7;
			$build->desc = "Monks are disciplined fighters.<br> Their 3 styles focus on either melee dps, supporting others with chakra abilities, or utility pulling.";
			$build->styles[0] = "Master";
			$build->styles[1] = "Transcendant";
			$build->styles[2] = "Ashenhand";
			break;
			//==================NECROMANCER======================
			case "necromancer":
			$build->fullName = "Necromancer";
			$build->monogram = 11;
			$build->desc = "Necromancers are master of the dead.<br> They have the best DoTs of any class with one focus. The other 2 focus on debuffs, and tanking.";
			$build->styles[0] = "Heretic";
			$build->styles[1] = "Lich";
			$build->styles[2] = "Warlock";
			break;
			//==================PALADIN======================
			case "paladin":
			$build->monogram = 3;
			$build->fullName = "Paladin";
			$build->desc = "Paladins are the holy knights.<br> Their 3 styles focus on better healing and support, tanking, or damage dealing.";
			$build->styles[0] = "Protector";
			$build->styles[1] = "Knight";
			$build->styles[2] = "Crusader";
			break;
			//==================RANGER======================
			case "ranger":
			$build->fullName = "Ranger";
			$build->monogram = 4;
			$build->desc = "Rangers are friends with beasts.<br> Their 3 styles focus on either better archery, enabling and strengthening a beast companion, or supporting others.";
			$build->styles[0] = "Archer";
			$build->styles[1] = "Hunter";
			$build->styles[2] = "Plainswalker";
			break;
			//==================ROGUE======================
			case "rogue":
			$build->fullName = "Rogue";
			$build->monogram = 9;
			$build->desc = "Rogues are thieves who specialize in deception.<br> Their 3 styles focus on dealing damage, being an evasive tank, or stealing.";
			$build->styles[0] = "Assassin";
			$build->styles[1] = "Deceiver";
			$build->styles[2] = "Bandit";
			break;
			//==================SHAMAN======================
			case "shaman":
			$build->fullName = "Shaman";
			$build->monogram = 10;
			$build->desc = "Shamans are one with spirits, specializing in buffing.<br> Their 3 styles focus on giving buffs among other utility bonuses, being a focused healer, or enchanting themselves to be more viable in melee.";
			$build->styles[0] = "Prophet";
			$build->styles[1] = "Oracle";
			$build->styles[2] = "Elder";
			break;
			//==================WARRIOR======================
			case "warrior":
			$build->fullName = "Warrior";
			$build->monogram = 1;
			$build->desc = "Warriors are hearty duelists.<br> Gladiators will hone their blade mastery to allow them to deal damage unheard of before, Brawlers live off the thrill of battle, and Champions seek glory with their ability to survive.";
			$build->styles[0] = "Gladiator";
			$build->styles[1] = "Brawler";
			$build->styles[2] = "Champion";
			break;
			//==================WIZARD======================
			case "wizard":
			$build->fullName = "Wizard";
			$build->monogram = 12;
			$build->desc = "Wizards are masters of the elements.<br> Evokers deal high elemental damage. Channelers focus on utility, while Sage is focused on support.";
			$build->styles[0] = "Evoker";
			$build->styles[1] = "Channeler";
			$build->styles[2] = "Sage";
			break;
			//==================SHADOWKNIGHT======================
			case "shadowknight":
			default:
			$class = "shadowknight";
			$build->fullName = "Shadow Knight";
			$build->monogram = 5;
			$build->desc = "Shadow Knights are unholy knights.<br> Their 3 styles focus tanking by taking blood of their victims, dealing damage with spears and other abilities, or crowd control pulling.";
			$build->styles[0] = "Bloodreaver";
			$build->styles[1] = "Defiler";
			$build->styles[2] = "Revenant";
			break;
		}
		return $build;
	}

	private function get_skills($class) {

		$skills = array();
		switch($class) {
			//==================BARD======================
			case "bard":
			break;
			//==================CLERIC======================
			case "cleric":
			//0
			$newSkill = new stdClass();
			$newSkill->title = "Divine Bash";
			$newSkill->desc = 'Bash now has a chance to heal nearby group members for <em data-base="2">2</em>% of your maximum health<span class="perLevel"> per level</span>.';
			$newSkill->image = "/images/builds/icons/gunzerker-gunlust-0.png";	
			$skills[0] = $newSkill;
			break;

			//4
			$newSkill = new stdClass();
			$newSkill->title = "Harken the Gods";
			$newSkill->desc = 'Yaulp now also grants <em data-base="5">5</em> accuracy, <em data-base="5">5</em> attack, and <em data-base="2">2</em> mana regen<span class="perLevel"> per level</span>.';
			$newSkill->image = "/images/builds/icons/gunzerker-gunlust-0.png";	
			$skills[4] = $newSkill;

			//6
			$newSkill = new stdClass();
			$newSkill->title = "Blessing of Haste";
			$newSkill->desc = 'All spell haste you cast is now <em data-base="5">5</em> accuracy, <em data-base="5">5</em> attack, and <em data-base="2">2</em> mana regen<span class="perLevel"> per level</span>.';
			$newSkill->image = "/images/builds/icons/gunzerker-gunlust-0.png";	
			$skills[6] = $newSkill;

			//8
			$newSkill = new stdClass();
			$newSkill->title = "Hammer of Justice";
			$newSkill->desc = 'Empowers the summoned hammer line with stronger versions<span class="perLevel"> per level</span>.';
			$newSkill->image = "/images/builds/icons/gunzerker-gunlust-0.png";	
			$skills[8] = $newSkill;
			break;


			//==================DRUID======================
			case "druid":
			break;
			//==================ENCHANTER======================
			case "enchanter":
			break;
			//==================MAGICIAN======================
			case "magician":
			break;
			//==================MONK======================
			case "monk":
			break;
			//==================NECROMANCER======================
			case "necromancer":
			break;
			//==================PALADIN======================
			case "paladin":
			break;
			//==================RANGER======================
			case "ranger":
			break;
			//==================ROGUE======================
			case "rogue":
			break;
			//==================SHAMAN======================
			case "shaman":
			//0
			$newSkill = new stdClass();
			$newSkill->title = "Spirit of Speed";
			$newSkill->desc = 'Spirit of Wolf lasts <em data-base="20">20</em>% longer<span class="perLevel"> per level</span>.';
			$newSkill->image = "/images/builds/icons/gunzerker-gunlust-0.png";	
			$skills[0] = $newSkill;
			//1
			//2
			$newSkill = new stdClass();
			$newSkill->title = "Whispering Chant";
			$newSkill->desc = 'Slows and heals now generate <em data-base="5">5</em>% less hate<span class="perLevel"> per level</span>.';
			$newSkill->image = "/images/builds/icons/gunzerker-gunlust-1.png";	
			$skills[2] = $newSkill;
			//3
			//4
			$newSkill = new stdClass();
			$newSkill->title = "Extended Haste";
			$newSkill->desc = 'Improves Haste Spell duration by <em data-base="30">30</em>%<span class="perLevel"> per level</span>.';
			$newSkill->image = "/images/builds/icons/gunzerker-gunlust-3.png";
			$skills[4] = $newSkill;
			//5
			//6
			$newSkill = new stdClass();
			$newSkill->title = "Turgur's Echo";
			$newSkill->desc = 'When a slow resists, gives a <em data-base="5">5</em>% chance it will still land<span class="perLevel"> per level</span>.';
			$newSkill->image = "/images/builds/icons/gunzerker-gunlust-4.png";
			$skills[6] = $newSkill;
			//17
			// TIER 2
			//18
			$newSkill = new stdClass();
			$newSkill->title = "Spiritual Healing";
			$newSkill->desc = 'Heals recover an additional <em data-base="20">20</em>% health<span class="perLevel"> per level</span>.';
			$newSkill->image = "/images/builds/icons/gunzerker-gunlust-8.png";	
			$skills[18] = $newSkill;
			//19
			//20
			$newSkill = new stdClass();
			$newSkill->title = "Focus";
			$newSkill->desc = 'Each rank causes Inner Fire and greater Focus-like spells to inherit statistic buff effects as well<span class="perLevel"> per level</span>.';
			$newSkill->image = "/images/builds/icons/gunzerker-gunlust-1.png";	
			$skills[20] = $newSkill;
			//21
			//22
			$newSkill = new stdClass();
			$newSkill->title = "Cannibalize";
			$newSkill->desc = 'Cannibalize grants <em data-base="10">10</em>% additional conversion<span class="perLevel"> per level</span>.';
			$newSkill->image = "/images/builds/icons/gunzerker-gunlust-2.png";	
			$skills[22] = $newSkill;
			//23
			//24
			$newSkill = new stdClass();
			$newSkill->title = "Mending Cure";
			$newSkill->desc = 'When a disease, poison, or curse is cured, a heal over time is applied to the target for <em data-base="6">6</em> seconds<span class="perLevel"> per level</span>.';
			$newSkill->image = "/images/builds/icons/gunzerker-gunlust-3.png";	
			$skills[24] = $newSkill;
			//25
			//26
			/*$newSkill = new stdClass();
			$newSkill->title = "Blood Oath";
			$newSkill->desc = 'Increases damage by <em data-base="+10">+10</em>%, while decreasing healing effects by -<em data-base="10">10</em>%, AC by -<em data-base="10">10</em>, and all resistances by -<em data-base="20">20</em>.<span class="perLevel"> per level</span>.';
			$newSkill->image = "/images/builds/icons/gunzerker-gunlust-4.png";	
			$skills[26] = $newSkill;					*/
			//27
			//28
			/*$newSkill = new stdClass();
			$newSkill->title = "Gift of Urash";
			$newSkill->desc = 'Increases all skill modifiers by <em data-base="+5">+5</em>%, stacks up to <em data-base="1">1</em> times<span class="perLevel"> per level</span>.';
			$newSkill->image = "/images/builds/icons/gunzerker-gunlust-5.png";	
			$skills[28] = $newSkill;*/
			//29
			//30
			//31
			$newSkill = new stdClass();
			$newSkill->title = "Reinforce Torpor";
			$newSkill->desc = 'Reduces Torpor snare by <em data-base="20">20</em>%<span class="perLevel"> per level</span>.';
			$newSkill->image = "/images/builds/icons/gunzerker-gunlust-6.png";	
			$skills[31] = $newSkill;
			//32
			//33
			//34
			/*$newSkill = new stdClass();
			$newSkill->title = "Bash of Death";
			$newSkill->desc = 'Causes a harm touch chance when bashing a target, damage is improved based on stacks of Gift of Urash by <em data-base="+20">+20</em>% damage<span class="perLevel"> per level</span>.';
			$newSkill->image = "/images/builds/icons/gunzerker-gunlust-8.png";	
			$skills[34] = $newSkill;*/
			//35
			// TIER 3
			//36
			$newSkill = new stdClass();
			$newSkill->title = "Fury";
			$newSkill->desc = 'Fleeting Fury now grants a self-only proc line that deals <em data-base="50">50</em> damage<span class="perLevel"> per level</span>.';
			$newSkill->image = "/images/builds/icons/gunzerker-gunlust-0.png";	
			$skills[36] = $newSkill;
			//37
			//38
			$newSkill = new stdClass();
			$newSkill->title = "Poison";
			$newSkill->desc = 'All poison based DoTs deal <em data-base="10">10</em>% more damage<span class="perLevel"> per level</span>.';
			$newSkill->image = "/images/builds/icons/gunzerker-gunlust-1.png";
			$skills[38] = $newSkill;
			//39
			//40
			$newSkill = new stdClass();
			$newSkill->title = "Companion";
			$newSkill->desc = 'Summons a spiritual companion equal to your level with <em data-base="5">5</em>% statistic bonus<span class="perLevel"> per level</span>.';
			$newSkill->image = "/images/builds/icons/gunzerker-gunlust-2.png";	
			$skills[40] = $newSkill;
			//41
			//42
			$newSkill = new stdClass();
			$newSkill->title = "Reinforce";
			$newSkill->desc = 'Statistic Buffs now grant non-stackable bonus procs with<em data-base="20">20</em>% power<span class="perLevel"> per level</span>.';
			$newSkill->image = "/images/builds/icons/gunzerker-gunlust-3.png";	
			$skills[42] = $newSkill;
			//43
			/*$newSkill = new stdClass();
			$newSkill->title = "Reinforce";
			$newSkill->desc = 'Statistic Buffs now grant non-stackable bonus procs with<em data-base="20">20</em>% power<span class="perLevel"> per level</span>.';
			$newSkill->image = "/images/builds/icons/gunzerker-gunlust-3.png";	
			$skills[43] = $newSkill;*/
			//44
			$newSkill = new stdClass();
			$newSkill->title = "Form of the Bear";
			$newSkill->desc = 'Form of the Bear grants <em data-base="2">2</em>% additional accuracy, attack, and double attack<span class="perLevel"> per level</span>.';
			$newSkill->image = "/images/builds/icons/gunzerker-gunlust-4.png";	
			$skills[44] = $newSkill;					
			//45
			//46
			/*$newSkill = new stdClass();
			$newSkill->title = "Form of the Bear";
			$newSkill->desc = 'Form of the Bear grants <em data-base="2">2</em>% additional accuracy, attack, and double attack<span class="perLevel"> per level</span>.';
			$newSkill->image = "/images/builds/icons/gunzerker-gunlust-4.png";	
			$skills[46] = $newSkill;					*/
			//47
			//48
			/*$newSkill = new stdClass();
			$newSkill->title = "Nightmare";
			$newSkill->desc = 'Fear now causes target to freeze in panic and lasta an additional <em data-base="4">4</em> seconds<span class="perLevel"> per level</span>.';
			$newSkill->image = "/images/builds/icons/gunzerker-gunlust-5.png";	
			$skills[48] = $newSkill;					
			//49
			//50
			$newSkill = new stdClass();
			$newSkill->title = "Mini Minion";
			$newSkill->desc = 'Causes your pet to summon a pet and attack target with a <em data-base="2">2</em>% chance <span class="perLevel"> per level</span> the target will not bring allies.';
			$newSkill->image = "/images/builds/icons/gunzerker-gunlust-6.png";	
			$skills[50] = $newSkill;*/
			//51
			//52
			$newSkill = new stdClass();
			$newSkill->title = "Avatar";
			$newSkill->desc = 'Avatar grants a temporary buff allowing triple attack and a spirit strike proc when used on self with <em data-base="2">2</em> attacks<span class="perLevel"> per level</span>.';
			$newSkill->image = "/images/builds/icons/gunzerker-gunlust-7.png";
			$skills[52] = $newSkill;
			//53
			break;
			//==================WARRIOR======================
			case "warrior":

			break;
			//==================WIZARD======================
			case "wizard":

			break;
			//==================SHADOWKNIGHT======================
			case "shadowknight":
			default:
			//0
			$newSkill = new stdClass();
			$newSkill->title = "Soul Link";
			$newSkill->desc = 'Improves lifetap damage by <em data-base="4">4</em>% and <em data-base="1">1</em>% chance to critical heal<span class="perLevel"> per level</span>.';
			$newSkill->image = "/images/builds/icons/gunzerker-gunlust-0.png";	
			$skills[0] = $newSkill;
			//1
			//2
			$newSkill = new stdClass();
			$newSkill->title = "Gouging Skin";
			$newSkill->desc = 'When attacked, causes a <em data-base="+4">+4</em> point damage shield and <em data-base="+20">+20</em> hate<span class="perLevel"> per level</span>.';
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
			// TIER 2
			//18
			$newSkill = new stdClass();
			$newSkill->title = "Festering Spear";
			$newSkill->desc = 'Improve spear type spells by<em data-base="20">20</em>% damage and <em data-base="+1">+1</em>% critical blast chance<span class="perLevel"> per level</span>.';
			$newSkill->image = "/images/builds/icons/gunzerker-gunlust-8.png";
			$skills[18] = $newSkill;
			//19
			//20
			$newSkill = new stdClass();
			$newSkill->title = "Festering Wound";
			$newSkill->desc = 'Improves DoT damage by <em data-base="+4">+4</em>%<span class="perLevel"> per level</span>.';
			$newSkill->image = "/images/builds/icons/gunzerker-gunlust-1.png";	
			$skills[20] = $newSkill;
			//21
			//22
			$newSkill = new stdClass();
			$newSkill->title = "Rotten Core";
			$newSkill->desc = 'Increases attack by <em data-base="+8">+8</em>% for a short duration each time a target dies nearby with a maximum of <em data-base="+1">+1</em> enemies<span class="perLevel"> per level</span>.';
			$newSkill->image = "/images/builds/icons/gunzerker-gunlust-2.png";	
			$skills[22] = $newSkill;
			//23
			//24
			$newSkill = new stdClass();
			$newSkill->title = "Lingering Pain";
			$newSkill->desc = 'All direct damage spells have a <em data-base="+4">+4</em>% chance to cause bonus damage over time<span class="perLevel"> per level</span>.';
			$newSkill->image = "/images/builds/icons/gunzerker-gunlust-3.png";	
			$skills[24] = $newSkill;
			//25
			//26
			$newSkill = new stdClass();
			$newSkill->title = "Blood Oath";
			$newSkill->desc = 'Increases damage by <em data-base="+10">+10</em>%, while decreasing healing effects by -<em data-base="10">10</em>%, AC by -<em data-base="10">10</em>, and all resistances by -<em data-base="20">20</em>.<span class="perLevel"> per level</span>.';
			$newSkill->image = "/images/builds/icons/gunzerker-gunlust-4.png";	
			$skills[26] = $newSkill;					
			//27
			//28
			$newSkill = new stdClass();
			$newSkill->title = "Gift of Urash";
			$newSkill->desc = 'Increases all skill modifiers by <em data-base="+5">+5</em>%, stacks up to <em data-base="1">1</em> times<span class="perLevel"> per level</span>.';
			$newSkill->image = "/images/builds/icons/gunzerker-gunlust-5.png";	
			$skills[28] = $newSkill;
			//29
			//30
			//31
			$newSkill = new stdClass();
			$newSkill->title = "Unholy Focus";
			$newSkill->desc = 'Causes all direct damage spells to be <em data-base="+10">+10</em>% more unresistable<span class="perLevel"> per level</span>.';
			$newSkill->image = "/images/builds/icons/gunzerker-gunlust-6.png";	
			$skills[31] = $newSkill;
			//32
			//33
			//34
			$newSkill = new stdClass();
			$newSkill->title = "Bash of Death";
			$newSkill->desc = 'Causes a harm touch chance when bashing a target, damage is improved based on stacks of Gift of Urash by <em data-base="+20">+20</em>% damage<span class="perLevel"> per level</span>.';
			$newSkill->image = "/images/builds/icons/gunzerker-gunlust-8.png";	
			$skills[34] = $newSkill;
			//35
			// TIER 3
			//36
			$newSkill = new stdClass();
			$newSkill->title = "Embrace Death";
			$newSkill->desc = 'Grants you the ability to use Feign Death, as well as causes the ability to heal you for <em data-base="+2">+2</em>% maximum health on use<span class="perLevel"> per level</span>.';
			$newSkill->image = "/images/builds/icons/gunzerker-gunlust-0.png";	
			$skills[36] = $newSkill;
			//37
			//38
			$newSkill = new stdClass();
			$newSkill->title = "Darkness";
			$newSkill->desc = 'All darkness type spells slow movement for an additional <em data-base="4">4</em>%<span class="perLevel"> per level</span>.';
			$newSkill->image = "/images/builds/icons/gunzerker-gunlust-1.png";	
			$skills[38] = $newSkill;
			//39
			//40
			$newSkill = new stdClass();
			$newSkill->title = "Empathetic Soul";
			$newSkill->desc = 'Improves Dark Empathy by granting an additional <em data-base="+40">+40</em> hitpoints healed and <em data-base="+0.5">+0.5</em>% max mana <span class="perLevel"> per level</span>.';
			$newSkill->image = "/images/builds/icons/gunzerker-gunlust-2.png";	
			$skills[40] = $newSkill;
			//41
			//42
			//43
			$newSkill = new stdClass();
			$newSkill->title = "Embrace Shadow";
			$newSkill->desc = 'Each time you feign death, grants a <em data-base="20">20</em>% chance<span class="perLevel"> per level</span> to instantly be invisible to both living and undead creatures.';
			$newSkill->image = "/images/builds/icons/gunzerker-gunlust-3.png";	
			$skills[43] = $newSkill;
			//44
			//45
			//46
			$newSkill = new stdClass();
			$newSkill->title = "Crippling Pain";
			$newSkill->desc = 'Shroud of Pain causes target to deal <em data-base="1">1</em>% less maximum damage<span class="perLevel"> per level</span>.';
			$newSkill->image = "/images/builds/icons/gunzerker-gunlust-4.png";	
			$skills[46] = $newSkill;					
			//47
			//48
			$newSkill = new stdClass();
			$newSkill->title = "Nightmare";
			$newSkill->desc = 'Fear now causes target to freeze in panic and lasta an additional <em data-base="4">4</em> seconds<span class="perLevel"> per level</span>.';
			$newSkill->image = "/images/builds/icons/gunzerker-gunlust-5.png";	
			$skills[48] = $newSkill;					
			//49
			//50
			$newSkill = new stdClass();
			$newSkill->title = "Mini Minion";
			$newSkill->desc = 'Causes your pet to summon a pet and attack target with a <em data-base="2">2</em>% chance <span class="perLevel"> per level</span> the target will not bring allies.';
			$newSkill->image = "/images/builds/icons/gunzerker-gunlust-6.png";	
			$skills[50] = $newSkill;
			//51
			//52
			$newSkill = new stdClass();
			$newSkill->title = "Cry of the Banshee";
			$newSkill->desc = 'Causes all nearby targets to be mesmerized for <em data-base="10">10</em> while feigning death. Grants a <em data-base="2">2</em>% chance for a burst of <em data-base="2">2</em> seconds, then forget all aggressions.';
			$newSkill->image = "/images/builds/icons/gunzerker-gunlust-7.png";
			$skills[52] = $newSkill;
			//53
		
			break;
		}
		return $skills;
	}
}

