<?php defined('SYSPATH') or die('No direct script access.');

class Template_Rest_Admin extends Template_Rest_Core {
	
	public function before()
	{
		
		parent::before();
		$post = $this->request->post();

		if (empty($this->user)) {

			if (empty($post['cobia_token'])) {

				$this->rest->Message = "You must pass a valid cobia_token POST variable to authenticate.";
				die(json_encode($this->rest));
			}
			$this->user = Cobia::factory('User')->get_user_by_cobia_token($post['cobia_token']);
		
		}
		if (empty($this->user)) {

			$this->rest->Status = 401;
			$this->rest->Message = "Invalid Token Passed";
			die(json_encode($this->rest));
		}

		//Get list of retail fronts for user.
		$retails = Cobia::factory('Retail')->get_retails_by_user($this->user->id);
		
		//First check instance has set the current retail being selected
		$retail = Session::instance()->get('retail', '');
		if (empty($retail) && count($retails) > 0) {

			//Fallback to first_retail
			$retail = $retails[0]->id;
		}
		
		
		$this->retail = (!empty($retail)) ? Cobia::factory('Retail')->get_retail($retail) : null ;
	}
}