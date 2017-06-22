<?php defined('SYSPATH') or die('No direct script access.');

class Template_Web_Admin extends Template_Web_Core {
	
	public function before() {
		parent::before();

		if (empty($this->user)) {

			Session::instance()->set("info", "You must log in before entering this area.");
			$this->redirect('/login');
		}

		$controller = $this->request->controller();
		$action = $this->request->action();

		$leftMenu = array();
		//$leftMenu[] = $this->add_menu_item("dashboard", "Dashboard", "fa-dashboard", "/admin/retail/dashboard", ("account" == strtolower($controller) && "index" == strtolower($action) ? true : false));
		$leftMenu[] = $this->add_menu_item("profile", "Dashboard", "fa-retail", "/admin/account/", ("dashboard" == strtolower($controller) ? TRUE : FALSE));
		$leftMenu[] = $this->add_menu_item("profile", "Profiles", "fa-retail", "/admin/profile", ("profile" == strtolower($controller) ? TRUE : FALSE));
		
		$leftMenu[] = $this->add_menu_item("connect", "Connections", "fa-connect", "/admin/connect", ("connect" == strtolower($controller) ? TRUE : FALSE));
		$menuItem = $this->add_menu_item("keyword", "Keywords", "fa-connect", "/admin/keyword", ("keyword" == strtolower($controller) ? TRUE : FALSE));
		$leftMenu[] = $menuItem;
		
		$leftMenu[] = $this->add_menu_item("campaign", "Campaigns", "fa-connect", "/admin/campaign", ("campaign" == strtolower($controller) ? TRUE : FALSE));
		//$leftMenu[] = $this->add_menu_item("membership", "Memberships", "fa-connect", "/admin/membership", ("membership" == strtolower($controller) ? true : false));
		$leftMenu[] = $this->add_menu_item("billing", "Billing", "fa-connect", "/admin/billing", ("billing" == strtolower($controller) ? true : false));
		$leftMenu[] = $this->add_menu_item("article", "Articles", "fa-connect", "/admin/article", ("article" == strtolower($controller) ? TRUE : FALSE));
		$leftMenu[] = $this->add_menu_item("coupon", "Coupons", "fa-coupon", "/admin/coupon", ("coupon" == strtolower($controller) ? TRUE : FALSE));
		$leftMenu[] = $this->add_menu_item("gallery", "Gallery", "fa-connect", "/admin/gallery", ("gallery" == strtolower($controller) ? TRUE : FALSE));
		$leftMenu[] = $this->add_menu_item("comment", "Comments", "fa-comment", "/admin/comment", ("comment" == strtolower($controller) ? TRUE : FALSE));
		$leftMenu[] = $this->add_menu_item("directory", "Directory", "fa-connect", "/admin/directory", ("directory" == strtolower($controller) ? TRUE : FALSE));
		$leftMenu[] = $this->add_menu_item("support", "Support", "fa-connect", "/admin/support", ("support" == strtolower($controller) ? TRUE : FALSE));
		
		// $leftMenu[] = $this->add_menu_item("billing", "Billing", "fa-comment", "/admin/billing", ("billing" == strtolower($controller) ? true : false));	
		if (Cobia::factory('User')->has_permission($this->user->id, PERMISSION_ADMIN_USER_CRUD)) {

			$leftMenu[] = $this->add_menu_item("user", "Users", "fa-users", "/admin/user", ("user" == strtolower($controller) ? TRUE : FALSE));
		}

		if (Cobia::factory('User')->has_permission($this->user->id, PERMISSION_ADMIN_LOG_CRUD)) {

			$leftMenu[] = $this->add_menu_item("log", "Logs", "fa-users", "/admin/log", ("log" == strtolower($controller) ? true : false));
		}
		if (Cobia::factory('User')->has_permission($this->user->id, PERMISSION_ADMIN_BLOG_CRUD)) {

			$leftMenu[] = $this->add_menu_item("blog", "Blog", "fa-paper", "/admin/blog", ("blog" == strtolower($controller) ? TRUE : FALSE));
		}

		$this->template->leftMenu = $leftMenu;
		$this->template->controller = $controller;
	}

	private function add_menu_item($id, $name, $icon, $href, $active) {
		$controller = $this->request->controller();
		$menu = new stdClass();
		$menu->name = $name;
		$menu->id = (!empty($id)) ? $id : $name;
		$menu->fa_icon = $icon;
		$menu->href = $href;
		if ($active) {
			$this->template->title = $name;
			$menu->active = $active;
		}
		return $menu;
	}
}