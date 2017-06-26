<?php defined('SYSPATH') or die('No direct script access.');

class Controller_Web_Index extends Template_Web_Core {


	public function before() {

		parent::before();
		$this->template->site->title = "Rebuild EQ";
		$this->template->site->description = "Rebuild EQ is an Everquest Private Server Project based on classic Everquest rebuilt to give a new enhanced experience.";
	}

	public function action_index() {
		$this->redirect('/about/');
	}

}
