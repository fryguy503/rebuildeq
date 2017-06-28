<?php defined('SYSPATH') or die ('No direct script access.');

class Controller_Rest_Lookup extends Template_Rest_Core {

	//Count always suceeds, just returns 0 when there's any form of failure
	public function action_item() {
		$id = $this->request->post('item_id');
		$item = DB::select()
			->from('zone_drops')
			->join('items')->on('items.id', '=', 'item_id')
			->where('item_id', '=', $id)
			->limit(1)
			->as_object()->execute()->current();
		if (empty($item)) return;

		$item = Item::get_attributes($item);
		
		$this->rest->Status = 1;
		$this->rest->Message = "Success";
		$this->rest->Data = $item;
		return;
	}
}