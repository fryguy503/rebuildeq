<?php defined('SYSPATH') or die ('No direct script access.');

class Controller_Rest_Builds extends Template_Rest_Core {

	public function action_update() {
		$this->rest->session = $this->request->post('session');
		if (empty($this->rest->session)) {
			$this->rest->Message = "Missing POST session";
		}
		return;
	}

}