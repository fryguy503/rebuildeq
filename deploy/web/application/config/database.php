<?php defined('SYSPATH') OR die('No direct access allowed.');
if (Kohana::$environment == Kohana::DEVELOPMENT) {

	//Development Settings
	return array
	(
			'default' => array
			(
					'type'       => 'PDO',
					'connection' => array(
							'dsn'        => 'mysql:host=127.0.0.1;dbname=peq;charset=utf8',
							'username'   => 'root',
							'password'   => '',
							'persistent' => false,
					),
					'table_prefix' => '',
					'caching'      => TRUE,
			),
	);

} else {

	//Production Settings
	return array
	(
			'default' => array
			(
					'type'       => 'PDO',
					'connection' => array(
							//Live uses a custom port
							'dsn'        => 'mysql:host=127.0.0.1;dbname=peq;charset=utf8',
							'username'   => 'root',
							'password'   => '',
							'persistent' => false,
					),
					'table_prefix' => '',
					'caching'      => TRUE,
			),
	);
}

