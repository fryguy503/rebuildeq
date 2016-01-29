<?php defined('SYSPATH') or die('No direct script access.');

class Controller_Web_Updates extends Template_Web_Core {


	public function before() {
		parent::before();
		$this->template->site->title = "Updates for RebuildEQ";
		$this->template->site->description = "Check out RebuildEQ's twitter account for updates.";
	}

	public function action_index() {

	}

}
