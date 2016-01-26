<?php defined('SYSPATH') or die('No direct script access.');

//Handles Business Logic for comments
//This represents various social network connections.
class Everquest_Inventory extends Everquest {
	
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
	public function get_all_by_character_id($characterID) {

		$inventory = DB::select()->from('inventory i')
			->join('items')->on('i.itemid', '=', 'items.id')
			->where('i.charid', '=', $characterID)
			->order_by('i.slotid', 'asc')
			->as_object()->execute()->as_array();
		return $inventory;
	}

	public function add_item($characterID, $itemID, $slotID, $quantity) {

		$insert = array('charid' => $characterID, 'itemid' => $itemID, 'slotid' => $slotID, 'charges' => $quantity);
		$inventory = DB::insert('inventory', array_keys($insert))->values($insert)->execute();
	}

      public function update_item($characterID, $itemID, $slotID, $oldQuantity, $quantity) {

            $inventory = DB::update('inventory')
            ->set(array('charges' => $quantity))
            ->where('charid', '=', $characterID)
            ->where('itemid', '=', $itemID)
            ->where('slotid', '=', $slotID)
            ->where('charges', '=', $oldQuantity)
            ->limit(1)
            ->execute();
      }

	public function move_item($characterID, $itemID, $slotID, $oldSlotID) {

		$inventory = DB::update('inventory')
		->set(array('slotid' => $slotID))
		->where('charid', '=', $characterID)
		->where('itemid', '=', $itemID)
		->where('slotid', '=', $oldSlotID)
		->limit(1)
		->execute();
	}
	public function remove_item($characterID, $itemID, $slotID) {

		$inventory = DB::delete('inventory')
		->where('charid', '=', $characterID)
		->where('slotid', '=', $slotID)
		->where('itemid', '=', $itemID)
		->limit(1)
		->execute();
	}

	public function find_all_by_item_id($itemid, $limit, $offset) {
      
            $character = DB::select("cd.*, cs.name as class_name, g.name as guild_name, g.id as guild_id, gm.rank as guild_rank")
            ->from('character_data cd')
            ->join('class_skill cs')->on('cs.class', '=', 'cd.class')
            ->join('guild_members gm', 'left')->on('gm.char_id', '=', 'cd.id')
            ->join('guilds g', 'left')->on('g.id', '=', 'gm.guild_id')
            ->join('inventory i')->on('i.charid', '=', 'cd.id')
            
            ->where('i.itemid', '=', $itemid)
            ->limit($limit)
            ->offset($offset)
            ->as_object()->execute()->as_array();
            if (empty($character)) return;
            foreach ($character as $char) {

                  $char->last_login_text = $this->nicetime($char->last_login);
            }

            return $character;            
      }

      public function find_total_by_item_id($itemid) {
      
            $character = DB::select("count(*)")
            ->from('character_data cd')
            ->join('class_skill cs')->on('cs.class', '=', 'cd.class')
            ->join('guild_members gm', 'left')->on('gm.char_id', '=', 'cd.id')
            ->join('guilds g', 'left')->on('g.id', '=', 'gm.guild_id')
            ->join('inventory i')->on('i.charid', '=', 'cd.id')
            
            ->where('i.itemid', '=', $itemid)->execute()->get('count(*)');

            return $character;            
      }
}