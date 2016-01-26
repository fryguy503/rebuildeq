<?php defined('SYSPATH') or die('No direct script access.');

class Controller_Web_About extends Template_Web_Core {


	public function before() {

		parent::before();
		$this->template->site->title = "About";
	}

	public function action_index() {

	}

}
