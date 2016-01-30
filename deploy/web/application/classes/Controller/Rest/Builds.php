<?php defined('SYSPATH') or die ('No direct script access.');

class Controller_Rest_Builds extends Template_Rest_Core {

	public function action_update() {

		$session = $this->request->post('session');

		$build = $this->request->post('build');
		$character = DB::select()->from('character_data')
		->where('session', '=', $session)
		->where('session_timeout', '>=', DB::expr('NOW()'))
		->limit(1)
		->as_object()->execute()->current();		
		if (empty($session)) {
			$this->rest->Message = "Missing POST session";
			return;
		}
		if (empty($build)) {
			$this->rest->Message = "Missing POST build";
			return;
		}
		if (empty($character)) {
			$this->rest->Message = "Invalid Session";
			return;
		}
		if (!$this->validate_build($character, $build)) {
			$this->rest->Message = "Invalid Build";
		}

		$this->rest->Status = 1;
		$this->rest->Message = "Success!";
		return;
	}

	public function validate_build($character, $build) {
		if (empty($build)) {
			return false;
		}
		if (empty($character)) {
			return false;
		}
		return true;
	}
}