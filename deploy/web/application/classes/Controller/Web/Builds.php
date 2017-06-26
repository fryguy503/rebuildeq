<?php defined('SYSPATH') or die('No direct script access.');
//This is the builds rendering page, needs to be moved to it's own model soon.
class Controller_Web_Builds extends Template_Web_Core {

	public function before() {
		parent::before();
		$this->template->site->title = "Builds";
		$this->template->site->description = "Shadow Knight Custom Build For RebuildEQ";
		$this->template->crumbs = array(
			(object)array("name" => "Home", "isActive" => true, "link" => "/"),
			(object)array("name" => "Builds", "link" => "/builds/")
		);
		
	}

	public function action_index() {
		$this->template->showHeader = false;
		$this->template->showFooter = false;
		$class =  strtolower($this->request->param('class'));
		if ($class == "") {
			return;			
		}
		$buildinfo = Build::get_build_info($class);
		if (empty($buildinfo)) {
			$this->redirect("/builds/");
		}
		$skills = array();
		$skills = Build::get_skills($class);
		

		//Validate Session
		$session = $this->request->param('session');

		$this->template->crumbs[] = (object)array('name' => ucfirst($class));

		if (!empty($session)) {
			//First see if session exists
			$sessionObject = DB::select('session')->from('character_data')->where('session', '=', $session)->as_object()->execute()->current();
			if (empty($sessionObject)) {
				$this->template->errorMessage = "Invalid Session Provided. Go in game and type #builds to create a new session.";
			}

			$tmpChar = DB::select('name, last_name, class, level, build_data')->from('character_data')
			->where('session', '=', $session)
			//->where('session_timeout', '>=', DB::expr('UNIX_TIMESTAMP(NOW())'))
			->limit(1)->as_object()->execute()->current();
			if (empty($tmpChar)) {
				$this->template->errorMessage = "Expired Session provided. Go in game and type #builds to create a new session.";
				return;
			} else {

				
				$character = new stdClass();
				$character->name = $tmpChar->name;

				if (!empty($tmpChar->last_name)) {
					$character->name .= " ".$tmpChar->last_name;
				}
				$this->template->crumbs[] = (object)array('name' => $character->name);
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

		$this->template->favicon = "/favicon/".strtolower($buildinfo->shortName).".ico";

		$this->template->skills = $skills;
		$this->template->monogram = $buildinfo->monogram;
		$this->template->styles = $buildinfo->styles;
		$this->template->class = $class;
		$this->template->site->image = "http://rebuildeq.com/images/monograms/".$buildinfo->monogram.".gif";
		$this->template->site->title = $buildinfo->fullName;
		$this->template->fullName = $buildinfo->fullName;
		$this->template->classDescription = $buildinfo->desc;
		$this->template->site->description = strip_tags($buildinfo->desc);
	}

}

