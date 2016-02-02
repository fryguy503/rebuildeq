<?php defined('SYSPATH') or die('No direct script access.');

class Build {

	public static function validate($build) {
		if (strlen($build) < 53) {
			$build = str_pad($build, 53, "0");
			return false;
		}
		$tier1 = 0;
		$tier2 = 0;
		$tier3 = 0;
		$tier4 = 0;
		$tier5 = 0;
		$tier6 = 0;
		for ($i = 0; $i < 53; $i++) {
			$val = intval($build[$i]);
			if ($val > 5 || $val < 0) return false;
			if (($i >= 0 && $i <= 2) || ($i >= 18 && $i <= 20) || ($i >= 36 && $i <= 38)) $tier1 += $val;
			if (($i >= 3 && $i <= 5) || ($i >= 21 && $i <= 24) || ($i >= 39 && $i <= 41)) $tier2 += $val;
			if (($i >= 6 && $i <= 8) || ($i >= 25 && $i <= 27) || ($i >= 42 && $i <= 44)) $tier3 += $val;
			if (($i >= 9 && $i <= 11) ||($i >= 28 && $i <= 30) || ($i >= 45 && $i <= 47)) $tier4 += $val;
			if (($i >= 12 && $i <= 14) || ($i >= 31 && $i <= 33) || ($i >= 48 && $i <= 50)) $tier5 += $val;
			if (($i >= 15 && $i <= 17) || ($i >= 34 && $i <= 36) || ($i >= 51 && $i <= 53)) $tier6 += $val;
		}
		if ($tier6 >= 1 && ($tier5 < 5 || $tier4 < 5 || $tier3 < 5 || $tier2 < 5 || $tier1 < 5)) return false;
		else if ($tier5 >= 1 && ($tier4 < 5 || $tier3 < 5 || $tier2 < 5 || $tier1 < 5)) return false;
		else if ($tier4 >= 1 && ($tier3 < 5 || $tier2 < 5 || $tier1 < 5)) return false;
		else if ($tier3 >= 1 && ($tier2 < 5 || $tier1 < 5)) return false;
		else if ($tier2 >= 1 && ($tier1 < 5)) return false;
		return true;
	}

}
