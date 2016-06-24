<?php defined('SYSPATH') or die('No direct script access.');

class Template_Web_Core extends Controller_Template {
	public $template;
	protected $config;
	protected $user;

	public function before() {

		$this->config = Kohana::$config->load('core');

		$directory = strtolower($this->request->directory());
		$this->template = "$directory/_template";

		$this->get_user_token();

		parent::before();
		
		$pageAlerts = array();

		foreach (array('info', 'success', 'warning', 'danger') as $field) {

			$message = Session::instance()->get($field, '');
			if (!empty($message)) {

				$alert = new stdClass();
				$alert->type = $field;
				$alert->message = $message;

				$pageAlerts[] = $alert;
				Session::instance()->delete($field);
			}
		}
		
		$this->template->pageAlerts = $pageAlerts;

		//Default template variables
		$this->template->page = "index";
		$this->template->site = (object)$this->config['site'];
		$this->template->domain = Kohana_Cookie::$domain;
		//$this->template->characterCount = Character::count();

		if (!empty($userToken)) {

			$this->template->userToken = $userToken;
		}

		$this->template->user = $this->user;
		$this->template->copyright = date('Y');
		$this->template->page = strtolower($this->request->controller());
		
	}

	/**
	 * Get User Token
	 */
	private function get_user_token() {

		if (!empty($this->user)) {

			return;
		}

		$userToken = Session::instance()->get('user_token', '');

		if (empty($userToken)){

			return;
		}
		$this->user = Everquest::factory('User')->get_by_user_token($userToken);
		if (empty($this->user)) {

			return;
		}

		Everquest::factory('User')->update_activity($this->user->id);
	}

	//All rendering is done.
	public function after() {
		//Store the request into easy variables.
		$directory = str_replace("_", "/", strtolower($this->request->directory()));
		$controller = str_replace("_", "/", strtolower($this->request->controller()));
		$action = strtolower($this->request->action());
	
		//No content set in action, let's guestimate it based on request route
		if (empty($this->template->content)) {
			$this->template->content = View::factory("$directory/$controller/$action");
		}
		
		//auto load _template_top_js if exists and none previously set in action
		if (empty($this->template->jsTopTemplate) && Kohana::find_file("templates", "$directory/_template_top_js", "tpl")) {
			$this->template->jsTopTemplate = View::factory("$directory/_template_top_js");
		}

		//auto load _template_bot_js if exists and none previously set in action
		if (empty($this->template->jsBotTemplate) && Kohana::find_file("templates", "$directory/_template_bot_js", "tpl")) {
			$this->template->jsBotTemplate = View::factory("$directory/_template_bot_js");
		}

		//auto load action_top_js if exists and none previously set in action
		if (empty($this->template->jsTopPage) && Kohana::find_file("templates", "$directory/$controller/{$action}_top_js", "tpl")) {
			$this->template->jsTopPage = View::factory("$directory/$controller/{$action}_top_js");
		}

		//auto load action_bot_js if exists and none previously set in action
		if (empty($this->template->jsBotPage) && Kohana::find_file("templates", "$directory/$controller/{$action}_bot_js", "tpl")) {
			$this->template->jsBotPage = View::factory("$directory/$controller/{$action}_bot_js");
		}
		parent::after();
	}
}