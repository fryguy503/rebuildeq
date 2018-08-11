import * as $ from "jquery";
import 'foundation-sites';
import { OnWindowLoadBuild } from "./build";
import { OnWindowLoadUI } from "./ui";


window.onload = () => {
	OnWindowLoadBuild();
	OnWindowLoadUI();
	$(document).foundation();
}