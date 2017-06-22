<?php defined('SYSPATH') or die('No direct script access.');

//Smarty inspired View override for Cobia
class View extends Kohana_View { 

	/**
	 * Captures the output that is generated when a view is included.
	 * The view data will be extracted to make local variables. This method
	 * is static to prevent object scope resolution.
	 *
	 * @param   string  filename
	 * @param   array   variables
	 * @return  string
	 */
	protected static function capture($template, array $data)
	{
		if ($template == '') return;
		
		// Load Ksmarty only if it's activated and the template-extension matches
		$config = Kohana::$config->load('smarty');
		if (($config->integration) && (substr(strrchr($template, '.'), 1) == $config->template_ext)) {
			// Get the Smarty instance
			$smarty = Ksmarty::instance();
			
			// Assign all the variables
			foreach ($data as $key => $value)
				$smarty->assign($key, $value);

			// Fetch the template output
			$output = $smarty->fetch($template);
		} else {
			$output = parent::capture($template, $data);			
		}
		
		// Return the parsed output
		return $output;
	}
	
	/**
	 * Sets the view filename.
	 *
	 * @throws  View_Exception
	 * @param   string  filename
	 * @return  View
	 */
	public function set_filename($file)
	{
		// Get the correct file extension
		$config = Kohana::$config->load('smarty');

		$ext = (($config->integration) && ($ext = $config->template_ext)) ? $ext : NULL;
		
		//whitelist of kohana views that are OK to be PHP
		$kohanaList = array("kohana/error", "minion/help/list");
		foreach ($kohanaList as $kohanaFile) {
			if ($file == $kohanaFile) {
				$ext = "php";
			}
		}

		$isFound = FALSE;
		// Search for the template file
		foreach ($config->template_dir as $directory) {
			
			if (($path = Kohana::find_file($directory, $file, $ext)) === FALSE) {
				if (($path = Kohana::find_file($directory, $file)) === FALSE) {
					continue;
				}
			}
			$isFound = TRUE;
		}
		if (!$isFound) {

			throw new Kohana_View_Exception('The requested view :file could not be found', array(
						':file' => $file,
					));
		}

		//Hard coding web dir as per our template structure.
		if (($path = Kohana::find_file("templates", $file, $ext)) === FALSE) {
			throw new Kohana_View_Exception('The requested view :file could not be found', array(
				':file' => $file,
			));
		}
		// Store the file path locally
		$this->_file = $path;

		return $this;
	}
} // End View
