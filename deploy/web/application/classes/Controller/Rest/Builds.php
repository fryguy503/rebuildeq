<?php defined('SYSPATH') or die ('No direct script access.');

class Controller_Rest_Builds extends Template_Rest_Core {

	public function action_index() {
		die("index");
	}
	
	public function action_update() {
		$this->rest->session = $this->request->post('session');

		$build = $this->request->post('build');
		$character = DB::select()->from('character_data')
		->where('session', '=', $session)
		->limit(1)
		->as_object()->execute()->current();
		print_r($character);
		if (empty($this->rest->session)) {
			$this->rest->Message = "Missing POST session";
			return;
		}
		if empty($build) {
			$this->rest->Message = "Missing POST build";
			return;
		}
		return;
	}

	public function validate_build($character, $build) {
		if (empty($build)) {
			return false;
		}
		if empty($character) {
			return false;
		}
		return true;
	}
}