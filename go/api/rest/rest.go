package rest

import (
	"encoding/json"
	"encoding/xml"
	"fmt"
	"log"
	"net/http"
	"strings"

	"github.com/go-yaml/yaml"
	"github.com/xackery/rebuildeq/go/api/storage"
	"github.com/xackery/rebuildeq/go/swagger/server"
)

var (
	api          storage.Storage
	mySigningKey = []byte("secret")
)

func StartServer(s storage.Storage) (err error) {
	if s == nil {
		err = fmt.Errorf("Invalid storage type passed, must be pointer reference")
		return
	}
	log.Println("Started server")
	api = s
	router := server.NewRouter()
	ApplyRoutes(router)

	err = http.ListenAndServe(":8080", router)
	return
}

func Index(w http.ResponseWriter, r *http.Request) {
	type Content struct {
		Message string `json:"message"`
	}
	content := Content{
		Message: "Please refer to documentation for more details",
	}
	returnData(w, r, content, http.StatusOK)
}

func returnData(w http.ResponseWriter, r *http.Request, content interface{}, statusCode int) {
	var err error

	vals := r.URL.Query()
	format := "json"
	if formats, ok := vals["format"]; ok {
		if len(formats) >= 1 {
			format = strings.ToLower(formats[0]) // The first `?format=val`
		}
	}

	var data []byte
	switch format {
	default: //json
		w.Header().Set("Content-Type", "application/json; charset=UTF-8")
		if data, err = json.Marshal(content); err != nil {
			http.Error(w, err.Error(), http.StatusInternalServerError)
			return
		}
	case "xml":
		w.Header().Set("Content-Type", "application/xml; charset=UTF-8")
		if data, err = xml.Marshal(content); err != nil {
			http.Error(w, err.Error(), http.StatusInternalServerError)
			return
		}
	case "yaml":
		w.Header().Set("Content-Type", "application/yaml; charset=UTF-8")
		if data, err = yaml.Marshal(content); err != nil {
			http.Error(w, err.Error(), http.StatusInternalServerError)
			return
		}
	}
	w.WriteHeader(statusCode)
	w.Write(data)
}

func returnError(w http.ResponseWriter, r *http.Request, message string, statusCode int) {
	var err error
	type Content struct {
		Message string `json:"message"`
	}
	content := Content{
		Message: message,
	}

	vals := r.URL.Query()
	format := "json"
	if formats, ok := vals["format"]; ok {
		if len(formats) >= 1 {
			format = strings.ToLower(formats[0]) // The first `?format=val`
		}
	}
	data := []byte{}
	switch format {
	default: //json
		w.Header().Set("Content-Type", "application/json; charset=UTF-8")
		if data, err = json.Marshal(content); err != nil {
			http.Error(w, err.Error(), http.StatusInternalServerError)
			return
		}
	case "xml":
		w.Header().Set("Content-Type", "application/xml; charset=UTF-8")
		if data, err = xml.Marshal(content); err != nil {
			http.Error(w, err.Error(), http.StatusInternalServerError)
			return
		}
	case "yaml":
		w.Header().Set("Content-Type", "application/yaml; charset=UTF-8")
		if data, err = yaml.Marshal(content); err != nil {
			http.Error(w, err.Error(), http.StatusInternalServerError)
			return
		}
	}
	http.Error(w, string(data), statusCode)
	return
}
