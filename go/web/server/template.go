package server

import (
	"html/template"
	"io/ioutil"
)

type Template struct {
	template *template.Template
}

var (
	templates map[string]*Template = map[string]*Template{}
)

func getTemplate(key string) (value *template.Template) {

	if tmp, ok := templates[key]; ok {
		value = tmp.template
		return
	}
	return
}

func setTemplate(key string, value *template.Template) {
	tmp := &Template{
		template: value,
	}
	templates[key] = tmp
}

func loadTemplate(oldTemplate *template.Template, key string, path string) (tmp *template.Template, err error) {
	var bData []byte
	if bData, err = ioutil.ReadFile("template/" + path); err != nil {
		return
	}

	if oldTemplate == nil {
		tmp, err = template.New(key).Parse(string(bData))
	} else {
		tmp, err = oldTemplate.New(key).Parse(string(bData))
	}
	return
}
