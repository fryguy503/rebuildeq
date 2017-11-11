<?php defined('SYSPATH') or die('No direct script access.');

class Controller_Web_Donate extends Template_Web_Core {


	public function before() {

		parent::before();
		$this->template->site->title = "Donate to Rebuild EQ";
		$this->template->site->description = "Rebuild EQ uses Patreon to help cover server costs. Donate today!";
	}

	public function action_index() {

	}

}
