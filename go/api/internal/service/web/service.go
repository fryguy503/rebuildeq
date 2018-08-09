package web

import (
	"encoding/json"
	"encoding/xml"
	"fmt"
	"net/http"
	"strconv"
	"strings"

	"github.com/go-yaml/yaml"
	"github.com/gorilla/mux"
	"github.com/gorilla/sessions"
	"github.com/pkg/errors"
	"github.com/rs/zerolog/log"
	"github.com/xackery/rebuildeq/go/api/internal/storage"
	"github.com/xackery/rebuildeq/go/eqproto"
)

const (
	//JSON is a constant string representing json
	JSON = "json"
	//XML is a constant string representing xml
	XML = "xml"
	//YAML is a constant string representing yaml
	YAML = "yaml"
)

var ()

type loginResponse struct {
	APIKey string
	User   *eqproto.User
}

// Service implements the Service interface with web implementation
type Service struct {
	cookieStore  *sessions.CookieStore
	mySigningKey []byte
	sql          storage.Storage
}

// NewWebService initializes an API endpoint with the implemented storage.
// config can be empty, it will initialize based on environment variables
// or by default values.
func NewWebService(sql storage.Storage, key []byte) (s *Service, err error) {
	s = &Service{
		cookieStore:  sessions.NewCookieStore([]byte("™£ˆø®™£ˆ∆®lewifjwofij")),
		mySigningKey: key,
		sql:          sql,
	}
	return
}

// ListenAndServe starts a new api service and begins listening
func (s *Service) ListenAndServe(port int) (err error) {
	return
}

func (s *Service) writeData(w http.ResponseWriter, r *http.Request, content interface{}, statusCode int) {

	var err error
	if w == nil || r == nil {
		log.Error().Err(err).Int("statusCode", statusCode).
			Msg("writeData called with invalid writer/request")
		return
	}
	if content == nil {
		w.WriteHeader(statusCode)
		return
	}
	vals := r.URL.Query()
	format := JSON
	if formats, ok := vals["format"]; ok {
		if len(formats) >= 1 {
			format = strings.ToLower(formats[0]) // The first `?format=val`
		}
	}

	accept := strings.ToLower(r.Header.Get("accept"))
	if len(accept) == 0 {
		accept = format
	} else {
		if strings.Index(accept, "application/") >= 0 {
			accept = accept[strings.Index(accept, "application/")+12:]
		}
	}
	var data []byte

	switch accept {
	case XML:
		w.Header().Set("Content-Type", "application/xml; charset=UTF-8")
		if data, err = xml.Marshal(content); err != nil {
			http.Error(w, err.Error(), http.StatusInternalServerError)
			return
		}
	case YAML:
		w.Header().Set("Content-Type", "application/yaml; charset=UTF-8")
		if data, err = yaml.Marshal(content); err != nil {
			http.Error(w, err.Error(), http.StatusInternalServerError)
			return
		}
	default: //json
		w.Header().Set("Content-Type", "application/json; charset=UTF-8")

		if data, err = json.Marshal(content); err != nil {
			http.Error(w, err.Error(), http.StatusInternalServerError)
			return
		}
	}
	w.WriteHeader(statusCode)
	w.Write(data)
}

func (s *Service) writeError(w http.ResponseWriter, r *http.Request, err error, statusCode int) {
	logErr := log.Error().Err(err).Int("statusCode", statusCode)

	type Content struct {
		Message string            `json:"message"`
		Fields  map[string]string `json:"fields,omitempty"`
	}

	content := Content{
		Message: fmt.Sprintf("%s", errors.Cause(err).Error()),
	}

	switch errors.Cause(err).(type) {
	case *errNoContent:
		statusCode = http.StatusNoContent
	case *errDecodeBody:
		statusCode = http.StatusBadRequest
		content.Message = "failed to decode body: " + content.Message
	case *errPermission:
		statusCode = http.StatusUnauthorized
	default:
		statusCode = http.StatusInternalServerError
	}

	logErr.Msg("failed request")
	s.writeData(w, r, content, statusCode)
	return
}

// decodeBody is used to convert raw json body content into a specified struct
func (s *Service) decodeBody(r *http.Request, data interface{}) (err error) {
	decoder := json.NewDecoder(r.Body)
	err = decoder.Decode(data)
	if err != nil {
		err = &errDecodeBody{
			Message: err.Error(),
		}
		return
	}
	return
}

// getIntQuery parses query parameters based on key and returns as an int64
func (s *Service) getIntQuery(r *http.Request, key string) int64 {
	var val int64
	vals := r.URL.Query()
	keyTypes, ok := vals[key]
	if ok {
		if len(keyTypes) > 0 {
			val, _ = strconv.ParseInt(keyTypes[0], 10, 64)
			return val
		}
	}
	return 0
}

// getQuery parses query parameters based on key and returns as a string
func (s *Service) getQuery(r *http.Request, key string) string {
	vals := r.URL.Query()
	keyTypes, ok := vals[key]
	if ok {
		if len(keyTypes) > 0 {
			return keyTypes[0]
		}
	}
	return ""
}

// getIntVar parses a variable from the routing pattern and returns it as an int64
func (s *Service) getIntVar(r *http.Request, key string) int64 {
	vars := mux.Vars(r)
	val, err := strconv.ParseInt(vars[key], 10, 64)
	if err != nil {
		return 0
	}
	return val
}

// getVar  returns with a variable inside the request based on a routing pattern assigned variable
func (s *Service) getVar(r *http.Request, key string) string {
	vars := mux.Vars(r)
	return vars[key]
}
