<?php defined('SYSPATH') or die('No direct script access.');

class Controller_Web_Index extends Template_Web_Core {


	public function before() {

		parent::before();
		$this->template->site->title = "Dashboard";
	}

	public function action_index() {

	}

}
