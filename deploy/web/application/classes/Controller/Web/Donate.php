<?php defined('SYSPATH') or die('No direct script access.');

class Controller_Web_Donate extends Template_Web_Core {


	public function before() {

		parent::before();
		$this->template->site->title = "Donate to Rebuild EQ";
		$this->template->site->description = "There is no donation system up currently, however we have a philosophy that donations only should reward in aesthetic ways.";
		$this->template->crumbs = array(
			(object)array("name" => "Home", "isActive" => true, "link" => "/"),
			(object)array("name" => "Donate", "isActive" => false, "link" => "/donate/")
		);	
	}

	public function action_index() {

	}

}
