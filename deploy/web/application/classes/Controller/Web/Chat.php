<?php defined('SYSPATH') or die('No direct script access.');

class Controller_Web_Chat extends Template_Web_Core {


	public function before() {

		parent::before();
		$this->template->site->title = "Chat";
	}

	public function action_index() {

	}

}
