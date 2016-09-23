<?php defined('SYSPATH') or die('No direct script access.');


// -- Environment setup --------------------------------------------------------

// Load the core Kohana class
require SYSPATH.'classes/Kohana/Core'.EXT;

if (is_file(APPPATH.'classes/Kohana'.EXT))
{
	// Application extends the core
	require APPPATH.'classes/Kohana'.EXT;
}
else
{
	// Load empty core extension
	require SYSPATH.'classes/Kohana'.EXT;
}

/**
 * Set the default time zone.
 *
 * @link http://kohanaframework.org/guide/using.configuration
 * @link http://www.php.net/manual/timezones
 */
date_default_timezone_set('America/Los_Angeles');

/**
 * Set the default locale.
 *
 * @link http://kohanaframework.org/guide/using.configuration
 * @link http://www.php.net/manual/function.setlocale
 */
setlocale(LC_ALL, 'en_US.utf-8');

/**
 * Enable the Kohana auto-loader.
 *
 * @link http://kohanaframework.org/guide/using.autoloading
 * @link http://www.php.net/manual/function.spl-autoload-register
 */
spl_autoload_register(array('Kohana', 'auto_load'));

/**
 * Optionally, you can enable a compatibility auto-loader for use with
 * older modules that have not been updated for PSR-0.
 *
 * It is recommended to not enable this unless absolutely necessary.
 */
//spl_autoload_register(array('Kohana', 'auto_load_lowercase'));

/**
 * Enable the Kohana auto-loader for unserialization.
 *
 * @link http://www.php.net/manual/function.spl-autoload-call
 * @link http://www.php.net/manual/var.configuration#unserialize-callback-func
 */
ini_set('unserialize_callback_func', 'spl_autoload_call');

/**
 * Set the mb_substitute_character to "none"
 *
 * @link http://www.php.net/manual/function.mb-substitute-character.php
 */
mb_substitute_character('none');

// -- Configuration and initialization -----------------------------------------

/**
 * Set the default language
 */
I18n::lang('en-us');

if (isset($_SERVER['SERVER_PROTOCOL']))
{
	// Replace the default protocol.
	HTTP::$protocol = $_SERVER['SERVER_PROTOCOL'];
}

/**
 * Set Kohana::$environment if a 'KOHANA_ENV' environment variable has been supplied.
 *
 * Note: If you supply an invalid environment name, a PHP warning will be thrown
 * saying "Couldn't find constant Kohana::<INVALID_ENV_NAME>"
 */
if (isset($_SERVER['KOHANA_ENV']))
{
	Kohana::$environment = constant('Kohana::'.strtoupper($_SERVER['KOHANA_ENV']));
}

//Verify production or development
if (!empty($_SERVER['HTTP_HOST']) && //make sure host is set
	(strtolower($_SERVER['HTTP_HOST']) == "xackery.com" ||
	strtolower($_SERVER['HTTP_HOST']) == "www.xackery.com")) {

	Kohana::$environment = Kohana::PRODUCTION;
} else if (strtolower(gethostname()) == "gigaplox" && PHP_SAPI == 'cli') {

	//command line request
	Kohana::$environment = Kohana::PRODUCTION;
} else {

	//Fallback to development otherwise.
	Kohana::$environment = Kohana::DEVELOPMENT;
}

/**
 * Initialize Kohana, setting the default options.
 *
 * The following options are available:
 *
 * - string   base_url    path, and optionally domain, of your application   NULL
 * - string   index_file  name of your index file, usually "index.php"       index.php
 * - string   charset     internal character set used for input and output   utf-8
 * - string   cache_dir   set the internal cache directory                   APPPATH/cache
 * - integer  cache_life  lifetime, in seconds, of items cached              60
 * - boolean  errors      enable or disable error handling                   TRUE
 * - boolean  profile     enable or disable internal profiling               TRUE
 * - boolean  caching     enable or disable internal caching                 FALSE
 * - boolean  expose      set the X-Powered-By header                        FALSE
 */
Kohana::init(array(
	'base_url'   => '/',
	'index_file' => '',
));

/**
 * Attach the file write to logging. Multiple writers are supported.
 */
Kohana::$log->attach(new Log_File(APPPATH.'logs'));

/**
 * Attach a file reader to config. Multiple readers are supported.
 */
Kohana::$config->attach(new Config_File);

/**
 * Enable modules. Modules are referenced by a relative or absolute path.
 */
Kohana::modules(array(

	'everquest'	=> MODPATH.'everquest',		 //Everquest related files
	'smarty'		=> MODPATH.'smarty',	 //Smarty
	// 'auth'       => MODPATH.'auth',       // Basic authentication
	// 'cache'      => MODPATH.'cache',      // Caching with multiple backends
	// 'codebench'  => MODPATH.'codebench',  // Benchmarking tool
	 'database'   => MODPATH.'database',   // Database access
	// 'image'      => MODPATH.'image',      // Image manipulation
	// 'minion'     => MODPATH.'minion',     // CLI Tasks
	// 'unittest'   => MODPATH.'unittest',   // Unit testing
	// 'userguide'  => MODPATH.'userguide',  // User guide and API documentation
	));

Route::set('rest', 'rest(/<controller>(/<action>(/<id>(/<field>))))')
    ->defaults(array(
        'directory' => 'Rest',
        'controller' => 'index',
        'action'     => 'index',
    ));

/*Route::set('buildskill', 'builds(/<class>/skill(/<skillindex>))')
	->defaults(array(
		'directory' => 'Web',
		'controller' => 'Builds',
		'action'     => 'Skill',
	));
*/
/*
Route::set('items', 'items(/<itemname>)')
	->defaults(array(
		'directory' => 'Web',
		'controller' => 'Items',
		'action'     => 'index',
	));
*/
Route::set('buildpage', 'builds/<class>/skill(/<skillid>)')
	->defaults(array(
		'directory' => 'Web',
		'controller' => 'BuildSkill',
		'action'     => 'index',
	));

Route::set('builds', 'builds(/<class>(/<session>))')
	->defaults(array(
		'directory' => 'Web',
		'controller' => 'Builds',
		'action'     => 'index',
	));

	Route::set('account', 'account(/<action>(/<session>))')
	->defaults(array(
		'directory' => 'Web',
		'controller' => 'Account',
		'action'     => 'index',
	));

Route::set('default', '(<controller>(/<action>(/<id>(/<sort>))))')
	->defaults(array(
		'directory' => 'Web',
		'controller' => 'index',
		'action'     => 'index',
	));
Kohana_Cookie::$salt = md5('¬˙ƒl˙ˆ¬ß˙ƒˆhwo8o˙høßˆƒ˙ø'); 
Kohana_Cookie::$expiration = 1209600; // 14 days
Kohana_Cookie::$domain = (empty($_SERVER["HTTP_HOST"])) ? "eqemu.lc" : $_SERVER["HTTP_HOST"];
Session::$default = 'cookie';
