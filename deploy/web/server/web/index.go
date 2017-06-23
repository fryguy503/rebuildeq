package web

import (
	"log"
	//	"fmt"
	//	"html/template"
	"net/http"
	//	"os"
)

func Index(w http.ResponseWriter, r *http.Request) (err error) {
	type templateData struct {
		*SiteData
		Content string
	}
	data := templateData{
		Content: "Shinshop!",
	}
	RenderTemplate(w, "index", data)
	log.Println("Rendered template")
	return
}

/*
//this stores the template, should be written once. (Dev can cause race conditions)
var indexTemplate *template.Template

func Index(w http.ResponseWriter, r *http.Request) (err error) {

	//Load templates only once (unless dev)
	if indexTemplate == nil || os.Getenv("SHINDEV") == "1" {
		//Which templates to load
		paths := []string{
			"_header.tpl",
			"index.tpl",
			"_sidebar.tpl",
			"_footer.tpl",
		}
		indexTemplate = template.New("index")

		for _, path := range paths {
			if err = ParseTemplateData(indexTemplate, path); err != nil {
				err = fmt.Errorf("error parsing: %s", err.Error())
				return
			}
		}
	}

	//Prepare template data
	type templateData struct {
		*SiteData
		Content string
	}

	//Custom index page content
	data := &templateData{
		Content: "Shinshop!",
	}

	//prepare general content
	if data.SiteData, err = NewSiteData(); err != nil {
		err = fmt.Errorf("error loading new site data: %s", err.Error())
		return
	}

	//set any overrides to general content
	data.Title = "Shinshop | Index"

	if err = indexTemplate.ExecuteTemplate(w, "index.tpl", data); err != nil {
		err = fmt.Errorf("error rendering %s: %s", "index.tpl", err.Error())
		return
	}
	return
}
*/
