<?php defined('SYSPATH') OR die('No direct script access.');

abstract class Everquest {
	protected $name;
    protected $fields;

    public static function factory($name)
    {
        // Add the model suffix
        $class = 'Everquest_'.$name;
        //Spawn Class
        $class = new $class;
        //Set Class's Name field to the Name.
        $class->name = $name;
        return $class;
    }

    /**
     * By default, rules is empty as it's an inherited method utilized for validation. 
     * Use extended classes for defining rules, overriding this method
     * @return array
     */
    protected function rules() {
        return array();
    }

    
    /**
	 * Get Validation of data, based on rules() method as well as any extra rules passed with $rules argument
	 *
	 * @param array $data
	 * @param array $rules
	 * @throws Everquest_Validation_Exception
	 */
    protected function validate($data, $rules) {
        $valid = Validation::factory($data);

    	//Bind class name to validation
    	$valid->bind(':model', $this->name);
    	
        //build primary validation rules
    	foreach ($this->rules() as $field => $newRules) {
            if (empty($field)) {

                continue;
            }
            $valid->rule($field, $newRules);
		}

		//add argument rules
		foreach ($rules as $field => $newRules) {
			$valid->rule($field, $newRules);
		}

		//is it invalid?
		if (!$valid->check()) {

			//yep. throw an exception, using the name as the message extension
            $data = $valid->errors($this->name);
            $errors = new stdClass();
            foreach ($data as $key => $value) {
                $errors->$key = $value;
            }
			throw new Everquest_Validation_Exception("Everquest", $errors);
		}
    }
    
     /**
     * Get clean data of data, based on rules() method as well as any extra rules passed with $rules argument
     *
     * @param array $data
     * @param array $rules
     * @throws Everquest_Validation_Exception
     */
    protected function get_clean_data($data, $rules) {
        $newData = array();
        foreach ($data as $key => $value) {
            if (isset($rules[$key])) $newData[$key] = $value;
        }
        return $newData;
    }

    protected function nicetime($date) {
        
        if (empty($date)) {
            return "No date provided";
        }
        
        $periods         = array("second", "minute", "hour", "day", "week", "month", "year", "decade");
        $lengths         = array("60","60","24","7","4.35","12","10");
        
        $now             = time();
        $unix_date = $date;
        //$unix_date       = strtotime($date);
        
           // check validity of date
        if (empty($unix_date)) {

            return "Bad date";
        }

        // is it future date or past date
        if($now > $unix_date) {    
            $difference     = $now - $unix_date;
            $tense         = "ago";
            
        } else {
            $difference     = $unix_date - $now;
            $tense         = "from now";
        }
        
        for ($j = 0; $difference >= $lengths[$j] && $j < count($lengths)-1; $j++) {
            $difference /= $lengths[$j];
        }
        
        $difference = round($difference);
        
        if ($difference != 1) {
            $periods[$j].= "s";
        }
        
        return "$difference $periods[$j] {$tense}";
    }

}
