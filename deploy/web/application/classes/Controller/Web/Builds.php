<?php defined('SYSPATH') or die('No direct script access.');

class Controller_Web_Builds extends Template_Web_Core {


	public function before() {

		parent::before();
		$this->template->site->title = "Builds";
		$this->template->site->description = "Shadow Knight Build on RebuildEQ";
	}

	public function action_index() {

	}

}
