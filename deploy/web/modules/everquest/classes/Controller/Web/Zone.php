<?php defined('SYSPATH') or die('No direct script access.');

class Controller_Web_Zone extends Template_Web_Core {


	public function before() {

		parent::before();
		$this->template->site->title = "Zone";
	}

	public function action_index() {

		$this->redirect('/zone/search');
	}

	public function action_search() {

		if (empty($this->request->query('q'))) {

			return;
		}
		$this->template->q = $this->request->query('q');

		$limit = min($this->request->query('limit'), 50);
		$this->template->limit = $limit;
		$offset = max($this->request->query('offset'),0);
		$this->template->offset = $offset;

		$characters = Everquest::factory('Character')->find_all_by_name($this->request->query('q'), $limit, $offset);
		$this->template->total = Everquest::factory('Character')->find_all_by_name_count($this->request->query('q'));
		
		$this->template->start = max(1, ($offset*$limit));

		$this->template->end = max(1, ($offset*$limit)+$limit);

		if ($this->template->end > $this->template->total) {

			$this->template->end = $this->template->total;
		}

		$this->template->characters = $characters;

	}

	public function action_inventory() {

		$this->template->site->title = "Player Inventory";
		if (empty($this->request->param('id'))) {

			die("No Character ID Provided");
		}

		$characterID = $this->request->param('id');

		$character = Everquest::factory('Character')->get_by_id($characterID);
		if (empty($character)) {

			die("Invalid Character ID: $characterID");
		}

		$this->template->character = $character;

		$inventory = Everquest::factory('Inventory')->get_all_inventory($characterID);
		$this->template->inventory = $inventory;

	}

}
