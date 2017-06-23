<?php defined('SYSPATH') or die('No direct script access.');

class Controller_Web_Changelog extends Template_Web_Core {


	public function before() {

		parent::before();
		$this->template->site->title = "Changelog";
		$this->template->site->description = "Chat about RebuildEQ on the Discord server.";
		$this->template->crumbs = array(
			(object)array("name" => "Home", "isActive" => true, "link" => "/"),
			(object)array("name" => "Changelog", "isActive" => false, "link" => "/changelog/")
		);	
	}

	public function action_index() {
		$this->template->entries = DB::select()->from('changelog')->order_by('date', 'desc')->as_object()->execute();
		return;
	}

	public function action_entry() {
		$entrytitle = $this->request->param('id');
		$entrytitle = str_replace("-", " ", $entrytitle);
		$this->template->entry = DB::select()->from('changelog')->where('title', '=', $entrytitle)->as_object()->execute()->current();
		if (!empty($this->template->entry)) {
			$this->template->site->title = $this->template->entry->title;
			$this->template->site->description = $this->template->entry->body;
			$this->template->site->image = "http://rebuildeq.com" . $this->template->entry->image;
		}
	}

}
