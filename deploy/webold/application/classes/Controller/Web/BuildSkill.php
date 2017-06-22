<?php defined('SYSPATH') or die('No direct script access.');
//This is the builds rendering page, needs to be moved to it's own model soon.
class Controller_Web_BuildSkill extends Template_Web_Core {

	public function before() {
		parent::before();
		$this->template->site->title = "";
		$this->template->site->description = "";
		$this->template->crumbs = array(
			(object)array("name" => "Home", "isActive" => true, "link" => "/"),
			(object)array("name" => "Builds", "isActive" => false, "link" => "/builds")
		);	
	}

	public function action_index() {
		$class =  strtolower($this->request->param('class'));
		$skills = array();


		$skillid = $this->request->param('skillid');
		$build = Build::get_build_info($class);
		$skills = Build::get_skills($class);

		if (empty($class) || empty($build) || empty($build->styles)) {
			$this->redirect('/builds/');
			return;
		}

		$this->template->crumbs[] =	(object)array("name" => ucfirst($class), "link" => "/builds/".$class."/");
		$this->template->crumbs[] =	(object)array("name" => "Skill", "link" => "/builds/".$class."/skill/");
		$this->template->class = $class;
		$this->template->monogram = $build->monogram;
		$this->template->styles = $build->styles;

		$this->template->fullName = $build->fullName;
		$this->template->classDescription = $build->desc;

		//$this->template->site->image = $class->image;
		$this->template->site->title = "Build Skills | ".ucfirst($class);
		$this->template->site->description = strip_tags($build->desc);

		if (strlen($skillid) == 0) {
			$this->template->skills = $skills;
			return;
		}
		$skillid = intval($skillid);

		if (empty($skills[$skillid])) {
			$this->redirect('/builds/');
			return;
		}
		
		

		$skill = $skills[$skillid];
		$this->template->crumbs[] =	(object)array("name" => $skill->title);
		$this->template->skill = $skill;
		$this->template->site->image = $skill->image;
		$this->template->site->title = $skill->title." | ".ucfirst($class);
		$this->template->site->description = strip_tags($skill->title." ".$skill->desc);
	}

}

