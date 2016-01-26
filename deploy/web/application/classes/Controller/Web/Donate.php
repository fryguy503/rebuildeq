<?php defined('SYSPATH') or die('No direct script access.');

class Controller_Web_Donate extends Template_Web_Core {


	public function before() {

		parent::before();
		$this->template->site->title = "Donate";
	}

	public function action_index() {

	}

}
