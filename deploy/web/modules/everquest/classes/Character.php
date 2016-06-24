 <?php defined('SYSPATH') OR die('No direct script access.');

class Character {

	public static function count() {
 		$count = DB::select('count(last_login)')->from('character_data')
		->where('last_login', '<=', DB::expr('UNIX_TIMESTAMP(NOW())-600'))
		->execute()->current();
		if (empty($count)) return 0;
		return intval($count['count(last_login)']);
	}

}