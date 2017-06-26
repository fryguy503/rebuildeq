<?php defined('SYSPATH') or die('No direct script access.');

class Controller_Web_Guide extends Template_Web_Core {


	public function before() {

		parent::before();
		$this->template->site->title = "Guide List";
		$this->template->site->description = "Learn how to play Rebuild EQ by following these guides.";
        $this->template->crumbs = array(
            (object)array("name" => "Home", "isActive" => true, "link" => "/"),
            (object)array("name" => "Guide", "isActive" => false, "link" => "/guide/")
        );  
	}

    public function action_zone() {
        $this->template->favicon = "/favicon/zone.ico";
        $this->template->crumbs[] = (object)array("name" => "Disabled Zone List");
        $this->template->site->title = "Disabled Zones";
        $this->template->site->description = "List of zones disabled on RebuildEQ.";
        
    }

	public function action_index() {

	}


    public function action_card() {
        $this->template->favicon = "/favicon/card.ico";
        $this->template->crumbs[] = (object)array("name" => "Card Augment List");
    	$this->template->site->title = "Card Augment List";
    	$this->template->site->description = "RebuildEQ features a custom set of cards that fit as augments, and this page lists all of them.";
    	$this->template->site->image = "http://rebuildeq.com/images/cards/card.png";
    	$maxId = 100143;
		$dbItems = DB::select('id, name, lore, slots')->from('items')->where('id', '>', 100099)->where('id', '<', $maxId)->order_by('slots', 'asc')->as_object()->execute()->as_array();
		
		$this->template->cards = $dbItems;
    }

}
