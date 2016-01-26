<?php defined('SYSPATH') or die('No direct script access.');

class Controller_Web_Account extends Template_Web_Core {


	public function before() {

		parent::before();
		$this->template->site->title = "Account";
	}

	public function action_index() {

		$this->redirect('/player/search');
	}

	public function action_manager() {

	}

}
