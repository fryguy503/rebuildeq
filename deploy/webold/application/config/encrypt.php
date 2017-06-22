<?php defined('SYSPATH') OR die('No direct script access.');
//Documentation can be found at https://kohanaframework.org/3.3/guide/kohana/security/encryption

return array(

	'default' => array(
		/**
		 * The following options must be set:
		 *
		 * string   key     secret passphrase
		 * integer  mode    encryption mode, one of MCRYPT_MODE_*
		 * integer  cipher  encryption cipher, one of the Mcrpyt cipher constants
		 */
		'key' => 'tue2thiTh3oi1ahng9wiw2eiPha9ohpoolaef5duphae6thu0aiNaigheech3oi',
		'cipher' => MCRYPT_RIJNDAEL_128,
		'mode'   => MCRYPT_MODE_NOFB,
	),

);

/* Usage
$encrypt = Encrypt::instance();

$encrypted_data = $encrypt->encode('Data to Encode');
$decoded_string = $encrypt->decode($encrypted_data)
*/