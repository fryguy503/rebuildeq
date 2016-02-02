<?php defined('SYSPATH') or die('No direct script access.');

class Build {
	public static function clean($build) {
		$skipElements = array(1, 3, 5, 7,9, 11, 12, 14, 15, 17, 19, 21, 23, 25, 27, 29, 30, 32, 33, 35, 37, 39, 41, 42, 44, 45, 47, 49, 51, 53);
		$skipElements = array_flip($skipElements);
		//Validate For tier-reqs TOTALS
		for ($i = 0; $i < 53; $i++) {
			if (strlen($build) <= $i) { //if an element doesn't exist, pad it with 0
				$build[$i] = "0";
			} else if (isset($skipElements[$i])) { //if an element is an invalid element, skip it
				$build[$i] = "0";
			}
		}
		$build = substr($build, 0, 53); //trim it to max 53
		return $build;
	}

	public static function validate($build, $level) {
		$tier1 = 0;
		$tier2 = 0;
		$tier3 = 0;
		$tier4 = 0;
		$tier5 = 0;
		$tier6 = 0;
		$level = intval($level);
		if ($level > 60 || $level < 1) {
			return false;
		}
		
		//Validate For tier-reqs TOTALS
		for ($i = 0; $i < 53; $i++) {
			if (strlen($build) <= $i) {
				$val = 0;
			} else {
				$val = intval($build[$i]);
			}
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

		if (($tier1+$tier2+$tier3+$tier4+$tier5+$tier6) > $level) { //Too many points spent
			return false;
		}

		return true;
	}

}
