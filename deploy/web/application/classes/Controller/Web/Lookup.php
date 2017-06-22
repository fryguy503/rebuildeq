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

		$rawItems = DB::select('items.era', 'items.icon', 'npc_id', 'npc.name npc_name', 'items.name', 'item_id', 'zone_id', 'zone.long_name zone_name')->from('zone_drops')->join('items')->on('items.id', '=', 'item_id')->join('npc_types npc')->on('npc.id', '=', 'npc_id')->join('zone')->on('zone.zoneidnumber', '=', $id)->where('zone_id', '=', $id)->as_object()->execute();
		if (count($rawItems) == 0) {
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

		$rawMobs = DB::select('items.*', 'npc_id', 'npc.name npc_name', 'item_id', 'zone_id', 'zone_short_name')->from('zone_drops')->join('items')->on('items.id', '=', 'item_id')->join('npc_types npc')->on('npc.id', '=', 'npc_id')->where('item_id', '=', $id)->as_object()->execute();
		if (count($rawMobs) == 0) {
			return;
		}

		$this->template->zone = new stdClass();
		$this->template->zone->short_name = $rawMobs[0]->zone_short_name;
		$this->template->zone->id = $rawMobs[0]->zone_id;
		$npcs = array();
		foreach ($rawMobs as $i) {
			if (empty($this->template->focus)) {
				$this->template->focus = $i;
			}
			if (empty($npcs[$i->npc_id])) {
				$npcs[$i->npc_id] = new stdClass();
			}
			//if (empty($items[$i->item_id])) {
			//	$items[$i->item_id]->npcs = array();
			//}
			$npcs[$i->npc_id] = $i;
		}
		$this->template->npcs = $npcs;
	}

	public function action_npc() {
		$id =  strtolower($this->request->param('id')); //zone
		$sort = strtolower($this->request->param('sort')); //npc

		$rawItems = DB::select('items.era', 'items.icon', 'npc_id', 'npc.name npc_name', 'items.name', 'item_id', 'zone_id', 'zone_short_name')->from('zone_drops')->join('items')->on('items.id', '=', 'item_id')->join('npc_types npc')->on('npc.id', '=', 'npc_id')->where('zone_id', '=', $id)->where('npc_id', '=', $sort)->as_object()->execute();
		if (count($rawItems) == 0) {
			return;
		}

		$this->template->zone = new stdClass();
		$this->template->zone->short_name = $rawItems[0]->zone_short_name;
		$this->template->zone->id = $rawItems[0]->zone_id;
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
