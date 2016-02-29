<?php defined('SYSPATH') or die('No direct script access.');

class Build {
	public static function clean($build) {
		$skipElements = array(1, 3, 5, 7,9, 11, 12, 14, 15, 17, 19, 21, 23, 25, 27, 29, 30, 32, 33, 35, 37, 39, 41, 43, 45, 47, 48, 50, 51,  53);
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
		$tier11 = 0;
		$tier12 = 0;
		$tier13 = 0;
		$tier14 = 0;
		$tier15 = 0;
		$tier16 = 0;
		$tier21 = 0;
		$tier22 = 0;
		$tier23 = 0;
		$tier24 = 0;
		$tier25 = 0;
		$tier26 = 0;
		$tier31 = 0;
		$tier32 = 0;
		$tier33 = 0;
		$tier34 = 0;
		$tier35 = 0;
		$tier36 = 0;
		$level = intval($level);
		if ($level > 60 || $level < 1) {
			return false;
		}
		

		$grandTotal = 0;
		//Validate For tier-reqs TOTALS
		for ($i = 0; $i < 53; $i++) {
			if (strlen($build) <= $i) {
				$val = 0;
			} else {
				$val = intval($build[$i]);
			}
			if ($val > 5 || $val < 0) return false;

			if ($i >= 0 && $i <= 2) $tier11 += $val;
			if ($i >= 18 && $i <= 20) $tier21 += $val;
			if ($i >= 36 && $i <= 38) $tier31 += $val;

			if ($i >= 3 && $i <= 5) $tier12 += $val;
			if ($i >= 21 && $i <= 23) $tier22 += $val; 
			if ($i >= 39 && $i <= 41) $tier32 += $val;

			if ($i >= 6 && $i <= 8) $tier13 += $val;
			if ($i >= 24 && $i <= 26) $tier23 += $val;
			if ($i >= 42 && $i <= 44) $tier33 += $val;

			if ($i >= 9 && $i <= 11) $tier14 += $val;
			if ($i >= 27 && $i <= 29) $tier24 += $val;
			if ($i >= 45 && $i <= 47) $tier34 += $val;

			if ($i >= 12 && $i <= 14) $tier15 += $val;
			if ($i >= 30 && $i <= 32) $tier25 += $val;
			if ($i >= 48 && $i <= 50) $tier35 += $val;


			if ($i >= 15 && $i <= 17) $tier16 += $val;
			if ($i >= 33 && $i <= 35) $tier26 += $val;
			if ($i >= 51 && $i <= 53) $tier36 += $val;
			$grandTotal += $val;
		}

		$tierTotal = 0;
		if ($tier12 >= 1 && $tier11 < 5) return false;
		$tierTotal += $tier12 + $tier11;
		if ($tier13 >= 1 && $tierTotal < 10) return false;
		$tierTotal += $tier13;
		if ($tier14 >= 1 && $tierTotal < 15) return false;
		$tierTotal += $tier14;
		if ($tier15 >= 1 && $tierTotal < 20) return false;
		$tierTotal += $tier15;
		if ($tier16 >= 1 && $tierTotal < 25) return false;

		$tierTotal = 0;
		if ($tier22 >= 1 && $tier21 < 5) return false;
		$tierTotal += $tier21 + $tier22;
		if ($tier23 >= 1 && $tierTotal < 10) return false;
		$tierTotal += $tier23;
		if ($tier24 >= 1 && $tierTotal < 15) return false;
		$tierTotal += $tier24;
		if ($tier25 >= 1 && $tierTotal < 20) return false;
		$tierTotal += $tier25;
		if ($tier26 >= 1 && $tierTotal < 25) return false;		

		$tierTotal = 0;
		if ($tier32 >= 1 && $tier31 < 5) return false;
		$tierTotal += $tier32 + $tier31;
		if ($tier33 >= 1 && $tierTotal < 10) return false;
		$tierTotal += $tier33;
		if ($tier34 >= 1 && $tierTotal < 15) return false;
		$tierTotal += $tier34;
		if ($tier35 >= 1 && $tierTotal < 20) return false;
		$tierTotal += $tier35;
		if ($tier36 >= 1 && $tierTotal < 25) return false;		
		if ($grandTotal > $level) {
			return false;
		}

		return true;
	}

}
