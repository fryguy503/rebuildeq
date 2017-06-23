package web

import (
	//"bytes"
	"fmt"
	"html/template"
	"io"
	"io/ioutil"
	"log"
	"net/http"
)

type TemplateData struct {
	files            []string
	preparedTemplate *template.Template
	isStatic         bool
	renderedTemplate string
}

var templates map[string]TemplateData

func RenderTemplate(w http.ResponseWriter, endpoint string, data interface{}) (err error) {
	//if templates[endpoint] == nil {
	//	err = fmt.Errorf("Endpoint Template not found", endpoint)
	//	return
	//}

	if templates[endpoint].isStatic {
		io.WriteString(w, templates[endpoint].renderedTemplate)
		return
	}

	if err = templates[endpoint].preparedTemplate.ExecuteTemplate(w, "index.tpl", data); err != nil {
		err = fmt.Errorf("error executing template %s: %s", endpoint, err.Error())
		return
	}
	return
}

func ReloadTemplates() (err error) {
	templates = map[string]TemplateData{
		"index": TemplateData{
			isStatic: false,
			files: []string{
				"_header.tpl",
				"index.tpl",
				//"_sidebar.tpl",
				//"_footer.tpl",
			},
		},
	}

	for k, v := range templates {
		if !v.isStatic { //don't bother prerendering dynamic ones
			continue
		}
		v.preparedTemplate = template.New(k)
		if err = parseTemplateData(k, &v); err != nil {
			err = fmt.Errorf("error parsing: %s", err.Error())
			return
		}
		/*if v.isStatic {
			buf := new(bytes.Buffer)

			if err = templates[k].preparedTemplate.ExecuteTemplate(buf, k, data); err != nil {
				err = fmt.Errorf("error executing template %s: %s", k, err.Error())
				return
			}
			templates[k].renderedTemplate = buf.String()
			fmt.Println(templates[k].renderedTemplate)
		}*/
	}

	log.Println("Loaded", len(templates), "templates")

	return
}

func parseTemplateData(endpoint string, t *TemplateData) (err error) {
	for _, f := range t.files {
		var data string
		var bData []byte
		if bData, err = ioutil.ReadFile("template/" + f); err != nil {
			err = fmt.Errorf("failed to find file (template) %s: %s", f, err.Error())
			return
		}
		data = string(bData)

		if t.preparedTemplate, err = t.preparedTemplate.New(endpoint).Parse(data); err != nil {
			err = fmt.Errorf("failed parsing %s template: %s", f, err.Error())
			return
		}
	}
	return
}
