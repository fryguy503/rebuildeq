<?php defined('SYSPATH') or die ('No direct script access.');

class Controller_Rest_Character extends Template_Rest_Core {

	//Count always suceeds, just returns 0 when there's any form of failure
	public function action_count() {
		$this->rest->Status = 1;
		$this->rest->Message = "Success";
		$this->rest->Data = 0;
		try {
			$count = Character::count();
			$this->rest->Data = $count;
		} catch (exception $e) {
			return;
		}		
		return;
	}
}