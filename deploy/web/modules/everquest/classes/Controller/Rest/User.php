<?php defined('SYSPATH') or die('No direct script access.');

class Controller_Rest_User extends Template_Rest_Core {

	public function before() {

		parent::before();
	}

	public function action_index() {

		$this->rest->Message = "login";
	}

	public function action_login() {

		$this->rest->name = $this->request->post('name');
		$params['name'] = $this->rest->name;

		if (empty($this->rest->name)) {

			$this->rest->Message = "Missing POST parameter name";
			return;
		}

		$password = $this->request->post('password');
		$params['password'] = $password;

		if (empty($password)) {

			$this->rest->Message = "Missing POST parameter password";
			return;
		}

		$this->rest->User = Everquest::factory('User')->login($params);

		$this->rest->Status = 1;
	}

	public function action_create() {

		$this->rest->name = $this->request->post('name');
		$params['name'] = $this->rest->name;

		if (empty($this->rest->name)) {

			$this->rest->Message = "Missing POST parameter name";
			return;
		}

		$this->rest->User = Everquest::factory('User')->create($params);

		$this->rest->Status = 1;
	}

}
