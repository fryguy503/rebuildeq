<?php defined('SYSPATH') or die('No direct script access.');
//This is the builds rendering page, needs to be moved to it's own model soon.
class Controller_Web_Builds extends Template_Web_Core {

	public function before() {
		parent::before();
		$this->template->site->title = "Shadow Knight Build";
		$this->template->site->description = "Shadow Knight Custom Build For RebuildEQ";
		
	}

	public function action_index() {

		$class =  strtolower($this->request->param('class'));
		$skills = array();		

		//Validate Session
		$session = $this->request->param('session');

		if (!empty($session)) {
			//First see if session exists
			$sessionObject = DB::select('session')->from('character_data')->where('session', '=', $session)->as_object()->execute()->current();
			if (empty($sessionObject)) {
				$this->template->errorMessage = "Invalid Session Provided. Go in game and type #builds to create a new session.";
			}

			$tmpChar = DB::select('name, last_name, class, level, build_data')->from('character_data')->where('session', '=', $session)->where('session_timeout', '>=', DB::expr('UNIX_TIMESTAMP(NOW())'))->limit(1)->as_object()->execute()->current();
			if (empty($tmpChar)) {
				$this->template->errorMessage = "Expired Session provided. Go in game and type #builds to create a new session.";
			} else {
				$character = new stdClass();
				$character->name = $tmpChar->name;
				if (!empty($tmpChar->last_name)) {
					$character->name .= " ".$tmpChar->last_name;
				}
				$character->level = $tmpChar->level;
				$class = Build::convert_class($tmpChar->class);
				if ($class == "unknown") {
					$this->redirect("/builds/");
					return;
				} else {
					if (!empty($tmpChar->build_data)) {
						$build = Build::clean($tmpChar->build_data);
						if (!Build::validate($build, $tmpChar->level)) {
							$oldBuild = $build;						
							$build = "00000000000000000000000000000000000000000000000000000";
							$build = Build::clean($build);
							//mail("rebuildeq@gmail.com", "Invalid Build for ".$tmpChar->name, "The build raw:".$tmpChar->build_data."\nOld Build: $oldBuild\nResetting it to:".$build);
							$data = array('build_data' => $build);
							DB::update('character_data')->set($data)->where('session', "=", $session)->limit(1)->execute();
						}
						$this->template->hash = $build;
					}
					//guildname invalid
					$this->template->character = $character;
					$this->template->session = $session;
				}
			}
		}

		//Validate Build
		$buildHash = $this->request->query('build');
		if (empty($character) && !empty($buildHash)) {
			//ValidateHash
			if (!Build::validate($buildHash)) {
				die("Invalid build");
			}
			$this->template->hash = $buildHash;
		}
		if ($class == "") {
			$class = "shadowknight";
		}

		$build = Build::get_build_info($class);
		$skills = Build::get_skills($class);

		$this->template->skills = $skills;
		$this->template->monogram = $build->monogram;
		$this->template->styles = $build->styles;
		$this->template->class = $class;
		$this->template->site->image = "http://rebuildeq.com/images/monograms/".$build->monogram.".gif";
		$this->template->site->title = $build->fullName;
		$this->template->fullName = $build->fullName;
		$this->template->classDescription = $build->desc;
		$this->template->site->description = strip_tags($build->desc);
	}

}

