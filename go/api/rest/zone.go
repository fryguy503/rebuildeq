package rest

import (
	"encoding/json"
	"fmt"
	"net/http"
	"strconv"

	"github.com/gorilla/mux"
	"github.com/xackery/rebuildeq/go/swagger/client"
)

func GetZone(w http.ResponseWriter, r *http.Request) {
	var err error

	vars := mux.Vars(r)
	if vars["id"] == "chart" {
		GetZoneChart(w, r)
		return
	}
	if vars["id"] == "search" || len(vars["query"]) > 0 {
		fmt.Println("search")
		GetZoneSearch(w, r)
		return
	}
	id, err := strconv.Atoi(vars["id"])
	if err != nil {
		err = nil
		GetZoneSearch(w, r)
		return
	}

	c, err := api.GetZone(id)
	if err != nil {
		returnError(w, r, err.Error(), http.StatusExpectationFailed)
		return
	}
	if c == nil || c.Name == "" {
		returnError(w, r, "No results found", http.StatusNotFound)
	}

	js := []byte{}
	if js, err = json.Marshal(c); err != nil {
		returnError(w, r, err.Error(), http.StatusExpectationFailed)
		return
	}
	w.WriteHeader(http.StatusOK)
	w.Write(js)
}

func GetZoneChart(w http.ResponseWriter, r *http.Request) {
	var err error

	c, err := api.GetZoneChart()
	if err != nil {
		returnError(w, r, err.Error(), http.StatusExpectationFailed)
		return
	}

	js := []byte{}
	if js, err = json.Marshal(c); err != nil {
		returnError(w, r, err.Error(), http.StatusExpectationFailed)
		return
	}
	w.WriteHeader(http.StatusOK)
	w.Write(js)
}

func GetZoneSearch(w http.ResponseWriter, r *http.Request) {
	var err error

	vars := mux.Vars(r)
	zone := &client.Zone{
		Name:      vars["query"],
		Shortname: vars["query"],
	}

	fmt.Println(zone)

	c, err := api.GetZoneSearch(zone)
	if err != nil {
		returnError(w, r, err.Error(), http.StatusExpectationFailed)
		return
	}

	js := []byte{}
	if js, err = json.Marshal(c); err != nil {
		returnError(w, r, err.Error(), http.StatusExpectationFailed)
		return
	}
	w.WriteHeader(http.StatusOK)
	w.Write(js)
}
