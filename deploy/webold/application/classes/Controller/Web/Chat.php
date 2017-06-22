<?php defined('SYSPATH') or die('No direct script access.');

class Controller_Web_Chat extends Template_Web_Core {


	public function before() {

		parent::before();
		$this->template->site->title = "Chat with the RebuildEQ Community";
		$this->template->site->description = "Chat about RebuildEQ on the Discord server.";
		$this->template->crumbs = array(
			(object)array("name" => "Home", "isActive" => true, "link" => "/"),
			(object)array("name" => "Chat", "isActive" => false, "link" => "/chat/")
		);	
	}

	public function action_index() {

	}

}
