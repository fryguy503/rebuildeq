<?php defined('SYSPATH') or die('No direct script access.');

class Controller_Rest_Inventory extends Template_Rest_Core {

	public function before() {

		parent::before();
	}

	public function action_index() {

		$this->rest->Message = "add, update, move, remove, get_by_character_id";
	}

	public function action_get_by_character_id() {

		$this->rest->id = $this->request->post('id');
		if (empty($this->rest->id)) {

			$this->rest->Message = "Missing POST parameter id";
			return;
		}

		$this->rest->Inventory = Everquest::factory('Inventory')->get_all_by_character_id($this->rest->id);
		if (!empty($this->rest->Inventory)) {
			$this->rest->Status = 1;
		}
	}

	public function action_add() {

		$requiredFields = array_flip(array('slotid', 'itemid', 'charid', 'refid', 'quantity'));
		$post = new stdClass();

		foreach ($requiredFields as $field => $val) {

			if ($this->request->post($field) == null) {

				$this->rest->Message = "Missing POST parameter: $field";
				return;
			}
			if ($this->request->post($field) == 'undefined') {

				$this->rest->Message = "Invalid POST parameter: $field";
				return;
			}

			$post->$field = $this->request->post($field);
			$this->rest->$field = $this->request->post($field);
		}

		try {

			Everquest::factory('Inventory')->add_item($post->charid, $post->itemid, $post->slotid, $post->quantity);
		} catch (Exception $e) {

			$this->rest->Message = $e->getMessage();
			return;
		}
		$this->rest->Status = 1;
		$this->rest->Message = "Success";
	}

	public function action_update() {

		$requiredFields = array_flip(array('slotid', 'itemid', 'charid', 'oldquantity', 'quantity', 'refid'));
		$post = new stdClass();

		foreach ($requiredFields as $field => $val) {

			if ($this->request->post($field) == null) {

				$this->rest->Message = "Missing POST parameter: $field";
				return;
			}
			if ($this->request->post($field) == 'undefined') {

				$this->rest->Message = "Invalid POST parameter: $field";
				return;
			}

			$post->$field = $this->request->post($field);
			$this->rest->$field = $this->request->post($field);
		}

		try {

			Everquest::factory('Inventory')->update_item($post->charid, $post->itemid, $post->slotid, $post->oldquantity, $post->quantity);
		} catch (Exception $e) {

			$this->rest->Message = $e->getMessage();
			return;
		}
		$this->rest->Status = 1;
		$this->rest->Message = "Success";
	}

	public function action_move() {

		$requiredFields = array_flip(array('slotid', 'itemid', 'charid', 'oldslotid', 'refid'));
		$post = new stdClass();

		foreach ($requiredFields as $field => $val) {

			if ($this->request->post($field) == null) {

				$this->rest->Message = "Missing POST parameter: $field";
				return;
			}
			if ($this->request->post($field) == 'undefined') {

				$this->rest->Message = "Invalid POST parameter: $field";
				return;
			}

			$post->$field = $this->request->post($field);
			$this->rest->$field = $this->request->post($field);
		}

		try {

			Everquest::factory('Inventory')->move_item($post->charid, $post->itemid, $post->slotid, $post->oldslotid);
		} catch (Exception $e) {

			$this->rest->Message = $e->getMessage();
			return;
		}
		$this->rest->Status = 1;
		$this->rest->Message = "Success";
	}

	public function action_remove() {

		$requiredFields = array_flip(array('slotid', 'itemid', 'charid', 'refid'));
		$post = new stdClass();

		foreach ($requiredFields as $field => $val) {

			if ($this->request->post($field) == null) {

				$this->rest->Message = "Missing POST parameter: $field";
				return;
			}
			if ($this->request->post($field) == 'undefined') {

				$this->rest->Message = "Invalid POST parameter: $field";
				return;
			}

			$post->$field = $this->request->post($field);
			$this->rest->$field = $this->request->post($field);
		}

		try {

			Everquest::factory('Inventory')->remove_item($post->charid, $post->itemid, $post->slotid);
		} catch (Exception $e) {

			$this->rest->Message = $e->getMessage();
			return;
		}
		$this->rest->Status = 1;
		$this->rest->Message = "Success";
	}


}
