<?php defined('SYSPATH') or die('No direct script access.');

class Controller_Web_Builds extends Template_Web_Core {


	public function before() {

		parent::before();
		$this->template->site->title = "Shadow Knight Build";
		$this->template->site->description = "Shadow Knight Custom Build For RebuildEQ";
		$this->template->site->image = "http://rebuildeq.com/images/monograms/5.gif";
		
	}

	public function action_index() {
		$class =  strtolower($this->request->param('class'));
		switch ($class) {
			case "bard":
			$fullName = "Bard";
			$this->template->monogram = 8;
			$desc = "Bards are awesome.";
			break;
			case "cleric":
			$fullName = "Cleric";
			$this->template->monogram = 2;
			$desc = "Bards are awesome.";
			break;
			case "druid":
			$fullName = "Druid";
			$this->template->monogram = 6;
			$desc = "Bards are awesome.";
			break;
			case "enchanter":
			$fullName = "Enchanter";
			$this->template->monogram = 14;
			$desc = "Bards are awesome.";
			break;
			case "magician":
			$fullName = "Magician";
			$this->template->monogram = 13;
			$desc = "Bards are awesome.";
			break;
			case "monk":
			$fullName = "Monk";
			$this->template->monogram = 7;
			$desc = "Bards are awesome.";
			break;
			case "necromancer":
			$fullName = "Necromancer";
			$this->template->monogram = 11;
			$desc = "Bards are awesome.";
			break;
			case "paladin":
			$this->template->monogram = 3;
			$fullName = "Paladin";
			$desc = "Bards are awesome.";
			break;
			case "ranger":
			$fullName = "Ranger";
			$this->template->monogram = 4;
			$desc = "Bards are awesome.";
			break;
			case "rogue":
			$fullName = "Rogue";
			$this->template->monogram = 9;
			$desc = "Bards are awesome.";
			break;
			case "shadowknight":
			$fullName = "Shadow Knight";
			$this->template->monogram = 5;
			$desc = "Bards are awesome.";
			break;
			case "shaman":
			$fullName = "Shaman";
			$this->template->monogram = 10;
			$desc = "Bards are awesome.";
			break;
			case "warrior":
			$fullName = "Warrior";
			
			$this->template->monogram = 1;
			$desc = "Bards are awesome.";
			break;
			case "wizard":
			$fullName = "Wizard";
			$this->template->monogram = 12;
			$desc = "Bards are awesome.";
			break;
			default:
			$class = "shadowknight";
			$fullName = "Shadow Knight";
			$desc = "This is still a work in progress.";
			$this->template->monogram = 5;
			break;
		}	
		$this->template->site->title = $fullName;
		$this->template->fullName = $fullName;
		$this->template->classDescription = $desc;
	}

}
