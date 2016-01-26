<?php defined('SYSPATH') or die('No direct script access.');

class Controller_Rest_Item extends Template_Rest_Core {

	public function before() {

		parent::before();
	}

	public function action_index() {

		$this->rest->Message = "find_all_by_name, get_by_item_id";
	}

	 public function action_find_all_by_name() {

        if (empty($this->request->post('q'))) {

            $this->rest->Message = "Missing POST parameter: q";
            return;
        }

        $query = $this->request->post('q');
        $offset = (empty($this->request->post('offset')) ? 0 : $this->request->post('offset')) ;
        $limit = min(max(5, $this->request->post('limit')), 50);

        $this->rest->q = $query;
        $this->rest->Offset = $offset;
        $this->rest->Limit = $limit;

        $items = Everquest::factory('Item')->find_all_by_name($query, $limit, $offset);
        $this->rest->Items = $items;

        $total = Everquest::factory('Item')->find_total_by_name($query);
        $this->rest->Total = $total;
        $this->rest->Status = 1;
    }

    public function action_get_by_item_id() {

        if (empty($this->request->post('id'))) {

            $this->rest->Message = "Missing POST parameter: id";
            return;
        }

        $query = $this->request->post('id');
        $this->rest->id = $query;

        $item = Everquest::factory('Item')->get_by_item_id($query);
        if ($item != null) $this->rest->Status = 1;
        $this->rest->Item = $item;
    }
}
