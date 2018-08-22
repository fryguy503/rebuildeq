<?php defined('SYSPATH') OR die('No direct access allowed.');
if (Kohana::$environment == Kohana::DEVELOPMENT) {

	//Development Settings
	return array
	(
			'default' => array
			(
					'type'       => 'PDO',
					'connection' => array(
							'dsn'        => 'mysql:host=mariadb;dbname=eqemu;charset=utf8',
							'username'   => 'eqemu',
							'password'   => 'eqemupass',
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
							'dsn'        => 'mysql:host=mariadb;dbname=eqemu;charset=utf8',
							'username'   => 'eqemu',
							'password'   => 'eqemupass',
							'persistent' => false,
					),
					'table_prefix' => '',
					'caching'      => TRUE,
			),
	);
}

