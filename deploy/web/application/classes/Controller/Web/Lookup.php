<?php defined('SYSPATH') or die('No direct script access.');

class Controller_Web_Lookup extends Template_Web_Core {
	public function before() {

		parent::before();
		$this->template->site->title = "Lookup";
		$this->template->site->description = "Testing item system";
		$this->template->crumbs = array(
            (object)array("name" => "Home", "isActive" => true, "link" => "/"),
            (object)array("name" => "Lookup", "isActive" => false, "link" => "/lookup/")
        );  
	}

	public function action_index() {
		$this->template->site->title = "Browse By Zone";
		$this->template->site->description = "Browse RebuildEQ by zone";
		$this->template->zones = DB::select()
			->from('zone')
			->where('min_status', '=', 0)
			->where('levels', '>', 0)
			//->order_by('long_name', 'asc')
			->order_by('levels', 'asc')
			->as_object()->execute();
	}

	public function action_zone() {

		$id =  strtolower($this->request->param('id'));
		$sort =  strtolower($this->request->param('sort'));
		$category = strtolower($this->request->query('category'));
		if ($category != "gear" &&
			$category != "weapon" &&
			$category != "item") {
			$category = "";
		}
		if ($sort != "item" &&
			$sort != "era" && 
			$sort != "npc" && 
			$sort != "quest") {
			$sort = "item";
		}
		$this->template->category = $category;

		$this->template->crumbs[] = (object)array("name" => "Zone", "link" => "/lookup/zone/");
		$limit = 100;
		$offset = 0;
		$page = $this->request->query('page'); 
		if (!is_numeric($page) || $page < 1) {
			$page = 1;
		}
		
		if (empty($id) || !is_numeric($id)) {
			//die("Redirect, empty/!isnmber");
			$this->redirect("/lookup/");
			return;
		}

		$query = DB::select('item_id')
			->from('zone_drops')
			->join('items')->on('items.id', '=', 'item_id')
			->join('npc_types npc')->on('npc.id', '=', 'npc_id')
			->join('zone')->on('zone.zoneidnumber', '=', $id)
			->where('zone_id', '=', $id)
			->where('description', '!=', "");

		if ($sort == "item") $query = $query->order_by("items.Name");
		if ($sort == "npc") $query = $query->order_by("npc.name");
		if ($sort == "quest") $query = $query->order_by("is_quest_reward", "desc");
		if ($sort == "quest") $query = $query->order_by("is_quest_item", "desc");

		$countRows = $query->group_by('item_id')	
			->limit(2500)
			->execute();
		$count = sizeof($countRows);
		if (count($count) < 1) {
			$this->redirect("/lookup/");
			return;
		}		

		$this->template->totalPages = ceil($count /  $limit);		
		if ($this->template->totalPages < 1) $this->template->totalPages = 1;
		if ($this->template->totalPages > 25) $this->template->totalPages = 25;
		if ($page > $this->template->totalPages) {
			$page = $this->template->totalPages;
		}

		$offset = $page * $limit;
		
		$this->template->currentPage = $page;
		$this->template->count = $count;

		$query = DB::select('items.*', 'items.icon', 'npc_id', 'npc.name npc_name', 'items.name', 'item_id', 'zone_id', 'zone.long_name zone_name', 'zone.description', 'zone_drops.is_quest_reward', 'zone_drops.is_quest_item')
			->from('zone_drops')
			->join('items')->on('items.id', '=', 'item_id')
			->join('npc_types npc')->on('npc.id', '=', 'npc_id')
			->join('zone')->on('zone.zoneidnumber', '=', $id)
			->where('zone_id', '=', $id)
			->where('description', '!=', "");

		if ($sort == "item") $query = $query->order_by("items.Name");
		if ($sort == "npc") $query = $query->order_by("npc.name");
		if ($sort == "quest") $query = $query->order_by("is_quest_reward", "desc");
		if ($sort == "quest") $query = $query->order_by("is_quest_item", "desc");

		$rawItems = $query->group_by('item_id')
			->limit($limit)
			->offset($offset)
			->as_object()->execute();

		
		if (count($rawItems) == 0) {
			//die("no results");
			$this->redirect("/lookup/");
			return;
		}

		
		
		$this->template->site->title = $rawItems[0]->zone_name;
		$this->template->site->description = $rawItems[0]->description;
		$this->template->zone = new stdClass();
		$this->template->zone->name = $rawItems[0]->zone_name;
		$this->template->zone->description = $rawItems[0]->description;
		$this->template->zone->id = $rawItems[0]->zone_id;
		$this->template->crumbs[] = (object)array("name" => $this->template->zone->name, "link" => "/lookup/zone/".$this->template->zone->id."/");

		$items = array();
		foreach ($rawItems as $i) {
			$i = Item::get_attributes($i);
			if ($category == "gear" && $i->category != "Gear") continue;
			if ($category == "item" && $i->category != "Item") continue;
			if ($category == "weapon" && $i->category != "Weapon") continue;

			if (empty($items[$i->item_id])) {
				$items[$i->item_id] = new stdClass();
			}
			//if (empty($items[$i->item_id])) {
			//	$items[$i->item_id]->npcs = array();
			//}

			
			$items[$i->item_id]->entry = $i;
			$items[$i->item_id]->npcs[] = (object)array('id' => $i->npc_id, 'name' => str_replace("_", " ", $i->npc_name));
		}

		//since it's post-filtered, gotta recount
		if ($category != "") {
			$this->template->count = sizeof($items);
			$this->template->page = 1;
			$this->template->totalPages = 1;
		}
		$this->template->items = $items;
		

		//echo count($items);
	}

	public function action_item() {
		$id =  strtolower($this->request->param('id'));
		$sort =  strtolower($this->request->param('sort'));

		$this->template->crumbs[] = (object)array("name" => "Item", "link" => "/lookup/item/");
		if ($sort != "item" &&
			$sort != "era" && 
			$sort != "npc" && 
			$sort != "quest") {
			$sort = "item";
		}


		//First, get item by id
		$this->template->focus = DB::select()->from('items')->where('id', '=', $id)->as_object()->execute()->current();
		if (empty($this->template->focus)) {
			if (empty($id)) {
				$id = $this->request->query('name');
				if (empty($id)) {
					//$this->template->errorMessage = "Item ID not found: ".$id;
					return;
				}
			}


			//try with name param
			$query = DB::select()
				->from('items')
				->join('zone_drops')->on('zone_drops.item_id', '=', 'items.id')
				->where('name', 'like', "%".$id."%");
			if ($sort == "item") $query = $query->order_by("items.Name");
			if ($sort == "npc") $query = $query->order_by("npc.name");
			if ($sort == "quest") $query = $query->order_by("is_quest_reward");
			if ($sort == "quest") $query = $query->order_by("is_quest_item");
			$query = $this->template->focus->limit(1)->as_object()->execute()->current();
			$this->template->focus = $query;
			
			if (empty($this->template->focus)) {
				$this->template->errorMessage = "Item not found: ".$id;
				return;
			}

			//see if additional results
			$itemList = DB::select('items.*')
				->from('items')
				->join('zone_drops')->on('zone_drops.item_id', '=', 'items.id')
				->where('name', 'like', "%".$id."%")
				->group_by('item_id')
				->limit(100)
				->as_object()->execute();

			if (count($itemList) > 0) {
				$this->template->items = $itemList;
				$this->template->resultMessage = "Found ".count($itemList)." results for items matching '" . $id . "'";
				if (count($itemList) > 100) $this->template->resultMessage .= ", limited to first 100 results.";
				return;
			}
			
		}
		$this->template->crumbs[] = (object)array("name" => $this->template->focus->Name);
		$this->template->site->title = $this->template->focus->Name;
		
		$this->template->focus = Item::get_attributes($this->template->focus);
		$this->template->itemfocus = $this->template->focus;
		
		//Next, get zones and mobs it drops from.
		$rawMobs = DB::select()
			->from('zone_drops')
			->join('npc_types npc')->on('npc.id', '=', 'npc_id')
			->join('zone')->on('zone.zoneidnumber', '=', 'zone_id')
			->where('item_id', '=', $id)
			->limit(500)
			->as_object()->execute();
		if (count($rawMobs) == 0) {
			return;
		}

		//Now let's merge NPCs by zone to be in same list
		$npcs = array();
		$quests = array();
		foreach ($rawMobs as $i) {
			$i->clean_name = str_replace("_", " ", $i->name);
			if (Tier::get_tier_by_npc($i->npc_id) >= 0) $i->level = "T".Tier::get_tier_by_npc($i->npc_id);

			if ($i->is_quest_reward == 1 || $i->is_quest_item == 1) {
				if (empty($quests[$i->zone_id])) $quests[$i->zone_id] = array();
				if (empty($quests[$i->zone_id][$i->name])) $quests[$i->zone_id][$i->name] = new stdClass();
				$quests[$i->zone_id][$i->name] = $i;
			} else {
				if (empty($npcs[$i->zone_id])) $npcs[$i->zone_id] = array();
				if (empty($npcs[$i->zone_id][$i->name])) $npcs[$i->zone_id][$i->name] = new stdClass();
			 	$npcs[$i->zone_id][$i->name] = $i;
			}
		}
		$this->template->npcs = $npcs;
		$this->template->quests = $quests;

	}

	
	public function action_npc() {
		$id =  strtolower($this->request->param('id')); //zone
		$sort = strtolower($this->request->param('sort')); //npc
		

		$this->template->focus = DB::select()->from('npc_types')->where('id', '=', $sort)->as_object()->execute()->current();
		if (empty($this->template->focus)) {
			return;
		}
		$this->template->focus->clean_name = str_replace("_", " ", $this->template->focus->name);



		$rawItems = DB::select('items.era', 'items.icon', 'npc_id', 'npc.name npc_name', 'items.name', 'item_id', 'zone_id','zone.long_name zone_name', "zone_drops.is_quest_reward", "zone_drops.is_quest_item")
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