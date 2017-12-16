package server

import (
	"html/template"
	"log"
	"net/http"
	"strconv"

	"github.com/gorilla/mux"
	"github.com/xackery/rebuildeq/go/swagger/client"
)

func GetZone(w http.ResponseWriter, r *http.Request) {
	var err error
	site := NewSite()
	site.Page = "zone"
	vars := mux.Vars(r)
	ctx := GetContext(r)
	var zId int64
	if zId, err = strconv.ParseInt(vars["zoneId"], 10, 0); err != nil {
		show404(w, r, err.Error())
	}
	zoneId := int32(zId)

	zone, resp, err := api.ZoneApi.GetZone(ctx, zoneId)
	if err != nil {
		log.Println(err.Error())
		//this is a 404, but let's handle it gracefully.
		//return
	}

	//if resp.StatusCode != 200 {
	//showError(w, r, "Unhandled Response", resp.StatusCode)
	//	return
	//}
	if resp.StatusCode == 200 {
		//Todo
	}
	tmp := getTemplate("")
	if tmp == nil {

		if tmp, err = loadTemplate(nil, "body", "zone.tpl"); err != nil {
			show500(w, r, err.Error())
			return
		}

		if tmp, err = loadStandardTemplate(tmp); err != nil {
			show500(w, r, err.Error())
			return
		}
		setTemplate("zone", tmp)
	}
	type Content struct {
		Site Site
		Zone interface{}
	}
	content := Content{
		Site: site,
		Zone: zone,
	}

	site.Title = zone.Name

	w.WriteHeader(http.StatusOK)
	if err = tmp.Execute(w, content); err != nil {
		show500(w, r, err.Error())
		return
	}
	return
}

func ListZoneChart(w http.ResponseWriter, r *http.Request) {
	site := NewSite()
	site.Page = "zone"
	ctx := GetContext(r)

	zones, err := api.ZoneApi.ListZoneChart(ctx)
	if err != nil {
		show500(w, r, err.Error())
		return
	}

	tmp := getTemplate("")
	if tmp == nil {

		funcMap := template.FuncMap{"iszonelevel": isZoneLevel}

		tmp = template.New("body").Funcs(funcMap)

		if tmp, err = loadTemplate(tmp, "body", "zone_chart.tpl"); err != nil {
			show500(w, r, err.Error())
			return
		}

		if tmp, err = loadStandardTemplate(tmp); err != nil {
			show500(w, r, err.Error())
			return
		}
		setTemplate("zone", tmp)
	}
	type Content struct {
		Site  Site
		Zones interface{}
	}
	content := Content{
		Site:  site,
		Zones: zones,
	}

	if err = tmp.Execute(w, content); err != nil {
		show500(w, r, err.Error())
		return
	}

	w.WriteHeader(http.StatusOK)
	return
}

func ListZoneSearch(w http.ResponseWriter, r *http.Request) {
	var err error
	site := NewSite()
	site.Page = "zone"
	tmp := getTemplate("")

	vars := mux.Vars(r)
	var zones []client.Zone
	var zone client.Zone

	if len(vars["query"]) > 0 || len(vars["zoneId"]) > 0 {
		ctx := GetContext(r)
		req := make(map[string]interface{})
		for key, val := range vars {
			req[key] = val
		}
		zones, _, err = api.ZoneApi.ListZoneSearch(ctx, req)
		if err != nil {
			show500(w, r, err.Error())
			return
		}
		log.Println(zones)

	}
	if len(zones) == 1 { //only one result, just show result page
		zone = zones[0]
		tmp := getTemplate("")
		if tmp == nil {

			if tmp, err = loadTemplate(nil, "body", "zone.tpl"); err != nil {
				show500(w, r, err.Error())
				return
			}

			if tmp, err = loadStandardTemplate(tmp); err != nil {
				show500(w, r, err.Error())
				return
			}
			setTemplate("zone", tmp)
		}
		type Content struct {
			Site Site
			Zone interface{}
		}
		content := Content{
			Site: site,
			Zone: zone,
		}

		site.Title = zone.Name

		w.WriteHeader(http.StatusOK)
		if err = tmp.Execute(w, content); err != nil {
			show500(w, r, err.Error())
			return
		}
		return
	}

	if tmp == nil {
		funcMap := template.FuncMap{"iszonelevel": isZoneLevel}

		tmp = template.New("body").Funcs(funcMap)

		if tmp, err = loadTemplate(tmp, "body", "zone_search.tpl"); err != nil {
			show500(w, r, err.Error())
			return
		}

		if tmp, err = loadStandardTemplate(tmp); err != nil {
			show500(w, r, err.Error())
			return
		}
		setTemplate("zone", tmp)
	}
	type Content struct {
		Site   Site
		Zones  interface{}
		Search string
	}
	content := Content{
		Site:   site,
		Zones:  zones,
		Search: vars["id"],
	}

	w.WriteHeader(http.StatusOK)
	if err = tmp.Execute(w, content); err != nil {
		show500(w, r, err.Error())
		return
	}
	return
}
func isZoneLevel(level int32, levels int32) bool {
	return ((levels & level) == level)
}
