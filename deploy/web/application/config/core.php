<?php defined('SYSPATH') OR die('No direct access allowed.');

return array
(
	//This should be updated ONLY by the "pusher", the person designated to patch live. During dev, we'll use 0.1 version
	'major_version' => 0,
	'minor_version' => 1,	

	'whitelist' => array( //Whitelist of allowed IPs for errors and admin
		'127.0.0.1', //LAN
	),

	//Site related info
	'site' => array(
		'name' => 'ShinShop',
		'title' => 'Index',
		'image' => '/images/blog/xackpack.png',
		'description' => 'Shin Shop Tools',
		'keywords' => 'everquest, tool, editor',
	),
);
