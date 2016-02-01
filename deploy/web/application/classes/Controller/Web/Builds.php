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
			$desc = "Bards are awesome.";
			break;
			case "cleric":
			$desc = "Bards are awesome.";
			break;
			case "druid":
			$desc = "Bards are awesome.";
			break;
			case "enchanter":
			$desc = "Bards are awesome.";
			break;
			case "magician":
			$desc = "Bards are awesome.";
			break;
			case "monk":
			$desc = "Bards are awesome.";
			break;
			case "necromancer":
			$desc = "Bards are awesome.";
			break;
			case "paladin":
			$desc = "Bards are awesome.";
			break;
			case "ranger":
			$desc = "Bards are awesome.";
			break;
			case "rogue":
			$desc = "Bards are awesome.";
			break;
			case "shadowknight":
			$desc = "Bards are awesome.";
			break;
			case "shaman":
			$desc = "Bards are awesome.";
			break;
			case "warrior":
			$desc = "Bards are awesome.";
			break;
			case "wizard":
			$desc = "Bards are awesome.";
			break;
			default:
			$class = "shadowknight";
			$desc = "This is still a work in progress.";
			break;
		}
		$this->template->classDescription = $desc;
	}

}
