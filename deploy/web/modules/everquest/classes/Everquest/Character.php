<?php defined('SYSPATH') or die('No direct script access.');

//Handles Business Logic for comments
//This represents various social network connections.
class Everquest_Character extends Everquest {
	
	protected function rules() {
        return array(
            'id' => [['numeric']], // int(11) NOT NULL DEFAULT '0',
            'account_id' => [['numeric']],
            'name' => [['min_length' => ['value' => 1]],
                        ['max_length' => ['value' => 64]]
                        ], // varchar(64) NOT NULL DEFAULT '',
            'last_name' => [['min_length' => ['value' => 1]],
                        ['max_length' => ['value' => 64]]
                        ], // varchar(64) NOT NULL DEFAULT '',
            'title' => [['min_length' => ['value' => 1]],
                        ['max_length' => ['value' => 32]]
                        ], // varchar(64) NOT NULL DEFAULT '',
            'suffix' => [['min_length' => ['value' => 1]],
                        ['max_length' => ['value' => 32]]
                        ], // varchar(64) NOT NULL DEFAULT '',
        );
	}

      public function find_all_by_name($name, $limit, $offset) {
      
            $character = DB::select("cd.*, cs.name as class_name, g.name as guild_name, g.id as guild_id, gm.rank as guild_rank")
            ->from('character_data cd')
            ->join('class_skill cs')->on('cs.class', '=', 'cd.class')
            
            ->join('guild_members gm', 'left')->on('gm.char_id', '=', 'cd.id')
            ->join('guilds g', 'left')->on('g.id', '=', 'gm.guild_id')

            ->where('cd.Name', 'LIKE', "%$name%")
            ->limit($limit)
            ->offset($offset)
            ->as_object()->execute()->as_array();
            if (empty($character)) return;
            foreach ($character as $char) {

                  $char->last_login_text = $this->nicetime($char->last_login);
            }

            return $character;            
      }

      public function find_total_by_name($name) {
      
            $character = DB::select("count(*)")->from('character_data cd')
            ->where('cd.Name', 'LIKE', "%$name%")
            ->execute()->get('count(*)');

            return $character;            
      }


      public function get_by_character_id($id) {

            $character = DB::select("cd.*, cs.name as class_name")->from('character_data cd')
            ->join('class_skill cs')->on('cs.class', '=', 'cd.class')
            ->where('cd.id', '=', $id)
            ->as_object()->execute()->current();

            return $character;
      }

}
