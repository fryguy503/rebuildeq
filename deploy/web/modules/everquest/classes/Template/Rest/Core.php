<?php defined('SYSPATH') or die('No direct script access.');

class Template_Rest_Core extends Controller {
	protected $rest;
	protected $config;
	public $user;
	
	public function before() {
		$this->config = Kohana::$config->load('core');

		$rest = new stdClass();
		$rest->Status = 0;
		$rest->Message = "";
		$rest->Data = "";
		$this->rest = $rest;
		
		header("Access-Control-Allow-Origin: *");
		
		parent::before();
	}

	public function after() {
		
		parent::after();
		die(json_encode($this->rest));
	}
}