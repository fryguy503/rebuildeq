<?php defined('SYSPATH') or die('No direct script access.');

class Controller_Web_Lookup extends Template_Web_Core {
	public function before() {

		parent::before();
		$this->template->site->title = "Item System";
		$this->template->site->description = "Testing item system";
		$this->template->crumbs = array(
            (object)array("name" => "Home", "isActive" => true, "link" => "/"),
            (object)array("name" => "Lookup", "isActive" => false, "link" => "/lookup/")
        );  
	}

	public function action_index() {
		$this->template->zones = DB::select()->from('zone')->where('min_status', '=', 0)->as_object()->execute();
	}

	public function action_zone() {
		$id =  strtolower($this->request->param('id'));
		$this->template->crumbs[] = (object)array("name" => "Zone", "link" => "/lookup/zone/");
		if (empty($id)) {
			$this->redirect("/lookup/");
			return;
		}
		$rawItems = DB::select('items.era', 'items.icon', 'npc_id', 'npc.name npc_name', 'items.name', 'item_id', 'zone_id', 'zone.long_name zone_name')
			->from('zone_drops')
			->join('items')->on('items.id', '=', 'item_id')
			->join('npc_types npc')->on('npc.id', '=', 'npc_id')
			->join('zone')->on('zone.zoneidnumber', '=', $id)
			->where('zone_id', '=', $id)->as_object()->execute();
		if (count($rawItems) == 0) {
			$this->redirect("/lookup/");
			return;
		}
		
		

		$this->template->zone = new stdClass();
		$this->template->zone->name = $rawItems[0]->zone_name;
		$this->template->zone->id = $rawItems[0]->zone_id;
		$this->template->crumbs[] = (object)array("name" => $this->template->zone->name, "link" => "/lookup/zone/".$this->template->zone->id."/");

		$items = array();
		foreach ($rawItems as $i) {
			if (empty($items[$i->item_id])) {
				$items[$i->item_id] = new stdClass();
			}
			//if (empty($items[$i->item_id])) {
			//	$items[$i->item_id]->npcs = array();
			//}
			$items[$i->item_id]->entry = $i;
			$items[$i->item_id]->npcs[] = (object)array('id' => $i->npc_id, 'name' => str_replace("_", " ", $i->npc_name));
		}
		$this->template->items = $items;
		

		//echo count($items);
	}

	public function action_item() {
		$id =  strtolower($this->request->param('id'));
		$this->template->crumbs[] = (object)array("name" => "Item", "link" => "/lookup/item/");

		//First, get item.
		$this->template->focus = DB::select()->from('items')->where('id', '=', $id)->as_object()->execute()->current();
		if (empty($this->template->focus)) {
			return;
		}
		$this->template->crumbs[] = (object)array("name" => $this->template->focus->Name);

		
		//Next, get zones and mobs it drops from.
		$rawMobs = DB::select()
			->from('zone_drops')
			->join('npc_types npc')->on('npc.id', '=', 'npc_id')
			->join('zone')->on('zone.zoneidnumber', '=', 'zone_id')
			->where('item_id', '=', $id)
			->as_object()->execute();
		if (count($rawMobs) == 0) {
			return;
		}

		//Now let's merge NPCs by zone to be in same list
		$npcs = array();
		foreach ($rawMobs as $i) {
			if (empty($npcs[$i->zone_id])) $npcs[$i->zone_id] = array();
			if (empty($npcs[$i->zone_id][$i->name])) $npcs[$i->zone_id][$i->name] = new stdClass();
			$i->clean_name = str_replace("_", " ", $i->name);
			if (Tier::get_tier_by_npc($i->npc_id) >= 0) $i->level = "T".Tier::get_tier_by_npc($i->npc_id);
			$npcs[$i->zone_id][$i->name] = $i;

		}
		$this->template->npcs = $npcs;

	}

	
	public function action_npc() {
		$id =  strtolower($this->request->param('id')); //zone
		$sort = strtolower($this->request->param('sort')); //npc
		

		$this->template->focus = DB::select()->from('npc_types')->where('id', '=', $sort)->as_object()->execute()->current();
		if (empty($this->template->focus)) {
			return;
		}
		$this->template->focus->clean_name = str_replace("_", " ", $this->template->focus->name);



		$rawItems = DB::select('items.era', 'items.icon', 'npc_id', 'npc.name npc_name', 'items.name', 'item_id', 'zone_id','zone.long_name zone_name')
			->from('zone_drops')
			->join('items')->on('items.id', '=', 'item_id')
			->join('npc_types npc')->on('npc.id', '=', 'npc_id')
			->join('zone')->on('zone.zoneidnumber', '=', 'zone_id')
			->where('zone_id', '=', $id)->where('npc_id', '=', $sort)
			->as_object()->execute();
		if (count($rawItems) == 0) {
			return;
		}

		$this->template->zone = new stdClass();
		$this->template->zone->short_name = $rawItems[0]->zone_name;
		$this->template->zone->id = $rawItems[0]->zone_id;

		$this->template->crumbs[] = (object)array("name" => "Zone", "link" => "/lookup/zone/");
		$this->template->crumbs[] = (object)array("name" => $rawItems[0]->zone_name, "link" => "/lookup/zone/".$rawItems[0]->zone_id);
		$this->template->crumbs[] = (object)array("name" => "NPC", "link" => "/lookup/npc/");
		$this->template->crumbs[] = (object)array("name" => $this->template->focus->clean_name);

		$items = array();
		foreach ($rawItems as $i) {
			if (empty($items[$i->item_id])) {
				$items[$i->item_id] = new stdClass();
			}
			//if (empty($items[$i->item_id])) {
			//	$items[$i->item_id]->npcs = array();
			//}
			$items[$i->item_id]->entry = $i;
			$items[$i->item_id]->npcs[] = (object)array('id' => $i->npc_id, 'name' => str_replace("_", " ", $i->npc_name));
		}
		$this->template->items = $items;

		//echo count($items);
	}


}
