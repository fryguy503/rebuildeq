<?php defined('SYSPATH') or die('No direct script access.');

class Controller_Web_Guide extends Template_Web_Core {


	public function before() {

		parent::before();
		$this->template->site->title = "Guide List";
		$this->template->site->description = "Learn how to play Rebuild EQ by following these guides.";
	}

	public function action_index() {

	}

	public function action_setup() {

	}

    public function action_newbie() {

    }

    public function action_command() {

    }

    public function action_card() {

    }

    public function action_encounter() {

    }

    public function action_rested() {

    }
}
