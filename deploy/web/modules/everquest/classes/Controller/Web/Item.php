<?php defined('SYSPATH') or die('No direct script access.');

class Controller_Web_Item extends Template_Web_Core {


	public function before() {

		parent::before();
		$this->template->site->title = "Item";
	}

	public function action_index() {

		$this->redirect('/item/search');
	}

	public function action_search() {

		if (empty($this->request->query('q'))) {

			return;
		}
		$this->template->q = $this->request->query('q');

		$limit = min(max($this->request->query('limit'), 5), 50);
		$this->template->limit = $limit;
		$offset = max($this->request->query('offset'), 0);
		$this->template->offset = $offset;


		$items = Everquest::factory('Item')->find_all_by_name($this->request->query('q'), $limit, $offset);
		$this->template->total = Everquest::factory('Item')->find_total_by_name($this->request->query('q'));
		
		$this->template->start = max(1, ($offset*$limit));

		$this->template->end = max(1, ($offset*$limit)+$limit);

		if ($this->template->end > $this->template->total) {

			$this->template->end = $this->template->total;
		}

		$this->template->items = $items;
		$this->template->searchResults = TRUE;

	}

	public function action_editor() {

		$this->template->site->title = "Item Editor";
		if (empty($this->request->param('id'))) {

			die("No Item ID Provided");
		}

		$itemID = $this->request->param('id');

		$item = Everquest::factory('Item')->get_by_item_id($itemID);
		if (empty($item)) {

			die("Invalid Item ID: $itemID");
		}

		$this->template->item = $item;

	}

	public function action_player() {

		$this->template->site->title = "Item Editor";
		if (empty($this->request->param('id'))) {

			die("No Item ID Provided");
		}

		$itemID = $this->request->param('id');

		$item = Everquest::factory('Item')->get_by_item_id($itemID);
		if (empty($item)) {

			die("Invalid Item ID: $itemID");
		}

		$this->template->item = $item;

		$limit = min($this->request->query('limit'), 50);
		$this->template->limit = $limit;
		
		$offset = max($this->request->query('offset'),0);
		$this->template->offset = $offset;

		$characters = Everquest::factory('Inventory')->find_all_by_item_id($itemID, $limit, $offset);
		$this->template->total = Everquest::factory('Inventory')->find_total_by_item_id($itemID);
		
		$this->template->start = $offset;

		$this->template->end = $offset+$limit;

		if ($this->template->end > $this->template->total) {

			$this->template->end = $this->template->total;
		}

		$this->template->characters = $characters;
		$this->template->searchResults = TRUE;

	}

}
