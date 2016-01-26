<?php defined('SYSPATH') or die('No direct script access.');

/**
 * User Model
 */
class Everquest_User extends Everquest {
	
	protected function rules() {
        return [
            //'name' [[not_empty]]
           /* 'name' => [['min_length' => ['value' => 3]],
                           ['max_length' => ['value' => 30]]],
            'password' => [['min_length' => ['value' => 8]],
                           ['max_length' => ['value' => 32]]],*/
        ];
	}

      public function get_user_by_token($token) {

            $user = DB::select()
                  ->from('account')
                  ->where('user_token', '=', $token)
                  ->limit(1)
                  ->execute()->current();

            if (!empty($user->password)) {

                  unset($user->password);
            }
            return $user;
      }

      public function login($params) {
            /*
            $params['name'] = "test";

            $rules = array(
                  'name' => array(
                         array('not_empty')
                        ),
                  );

            $this->validate($params, $rules);
            $params = $this->get_clean_data($params, $rules);

            exit;
            */
            //$params = $this->get_clean_data($params, $rules);

            $user = DB::select()
                  ->from('users')
                  ->where('name', '=', $params['name'])
                  ->limit(1)
                  ->execute()->current();

            if (empty($user)) {

                   throw new Cam_Validation_Exception(['name' => 'Name not found']);
            }

            echo password_verify($params['password'], '$2y$10$CSlzSL84abtvMlGjzf0kOuEKzsYOWqkvUKXsva8n00TBR.HqqmrCO');
            exit;

            $challengePass = Encrypt::instance()->decode($user->password);

            if (!password_verify($params['password'], $user->password)) {

                  throw new Cam_Validation_Exception(['password' => 'Invalid Password']);
            }

            return $user;
      }

      public function create($params) {

//            $this->validate($params);

            $user = DB::insert('users', array_keys($params))
                  ->values($params)
                  ->execute();

            if (empty($user)) {

                   throw new Cam_Validation_Exception(['username' => 'Username not found']);
            }

            $challengePass = Encrypt::instance()->decode($user->password);

            if ($challengePass != $params['password']) {

                  throw new Cam_Validation_Exception(['password' => 'Invalid Password']);
            }

            return $user;
      }
}
