package server

import (
	"net/http"
	"strconv"

	"github.com/gorilla/mux"
)

func GetCharacter(w http.ResponseWriter, r *http.Request) {
	var err error
	site := NewSite()
	site.Page = "character"
	vars := mux.Vars(r)
	ctx := GetContext(r)
	var cId int64
	if cId, err = strconv.ParseInt(vars["characterId"], 10, 0); err != nil {
		show404(w, r, err.Error())
	}
	characterId := int32(cId)
	character, resp, err := api.CharacterApi.GetCharacter(ctx, characterId)
	if err != nil {
		show500(w, r, err.Error())
		return
	}
	if resp.StatusCode != 200 {
		show500(w, r, err.Error())
		return
	}

	tmp := getTemplate("")
	if tmp == nil {

		if tmp, err = loadTemplate(nil, "body", "character.tpl"); err != nil {
			show500(w, r, err.Error())
			return
		}

		if tmp, err = loadStandardTemplate(tmp); err != nil {
			show500(w, r, err.Error())
			return
		}
		setTemplate("character", tmp)

	}
	site.Title = character.Name
	type Content struct {
		Site      Site
		Character interface{}
	}
	content := Content{
		Site:      site,
		Character: character,
	}

	w.WriteHeader(http.StatusOK)
	if err = tmp.Execute(w, content); err != nil {
		show500(w, r, err.Error())
		return
	}
	return
}

func ListCharacter(w http.ResponseWriter, r *http.Request) {
	site := NewSite()
	site.Page = "character"
	ctx := GetContext(r)
	characters, resp, err := api.CharacterApi.ListCharacter(ctx)
	if err != nil {
		show500(w, r, err.Error())
		return
	}
	if resp.StatusCode != 200 {
		show500(w, r, err.Error())
		return
	}
	tmp := getTemplate("characters")
	if tmp == nil {

		if tmp, err = loadTemplate(nil, "body", "characters.tpl"); err != nil {
			show500(w, r, err.Error())
			return
		}

		if tmp, err = loadStandardTemplate(tmp); err != nil {
			show500(w, r, err.Error())
			return
		}
		setTemplate("characters", tmp)

	}
	type Content struct {
		Site       Site
		Characters interface{}
	}
	content := Content{
		Site:       site,
		Characters: characters,
	}
	w.WriteHeader(http.StatusOK)
	if err = tmp.Execute(w, content); err != nil {
		show500(w, r, err.Error())
		return
	}
	return
}
