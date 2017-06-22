<?php defined('SYSPATH') or die('No direct script access.');
//ABout us page
class Controller_Web_About extends Template_Web_Core {


	public function before() {

		parent::before();
		$this->template->site->title = "About the Game";
		$this->template->site->description = "Imagine Everquest simplified.  The annoyances streamlined, to make grouping and living.. simpler and more memorable. That's the mission statement of Rebuild EQ.";
		$this->template->crumbs = array(
			(object)array("name" => "Home", "isActive" => true, "link" => "/"),
			(object)array("name" => "About")
		);
	}

	public function action_index() {

	}

}
