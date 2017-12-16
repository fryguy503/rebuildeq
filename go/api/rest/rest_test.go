package rest

import (
	"encoding/json"
	"fmt"
	"io/ioutil"
	"net/http"
	"strconv"
	"strings"
	"testing"

	"github.com/xackery/rebuildeq/go/api/storage/mariadb"
)

func TestStartServer(t *testing.T) {
	var err error
	err = StartServer(nil)
	if err == nil || err.Error() != "Invalid storage type passed, must be pointer reference" {
		t.Errorf("Failed to get expected result from StartServer")
	}

	s := &mariadb.Storage{}
	go StartServer(s)

}

func TestEndpoints(t *testing.T) {
	var err error
	apiKey := ""
	type Endpoint struct {
		name            string
		path            string
		method          string
		body            string
		responseCode    int
		response        string
		useAuth         bool
		isLoginResponse bool
	}
	tests := []Endpoint{
		Endpoint{
			name:         "Index",
			path:         "/",
			method:       "GET",
			body:         "",
			responseCode: 200,
			response:     `{"message":"Please refer to documentation for more details"}`,
			useAuth:      false,
		},
		Endpoint{
			name:            "Login",
			path:            "/login",
			method:          "POST",
			body:            "",
			responseCode:    200,
			response:        ``,
			useAuth:         false,
			isLoginResponse: true,
		},
		Endpoint{
			name:         "BuildsInvalidCharacterID",
			path:         "/builds/0",
			method:       "GET",
			body:         "",
			responseCode: 417,
			response:     `{"message":"Invalid character id: 0"}`,
			useAuth:      false,
		},
		Endpoint{
			name:         "Builds",
			path:         "/builds/661801",
			method:       "GET",
			body:         "",
			responseCode: 200,
			response:     `{"build":"55555555555555555555555555555555555555555555555555555"}`,
			useAuth:      false,
		},
		Endpoint{
			name:         "GetCharactersNoAuth",
			path:         "/characters",
			method:       "GET",
			body:         "",
			responseCode: 401,
			response:     `{"message":"No Token Provided"}`,
			useAuth:      false,
		},
		Endpoint{
			name:         "GetCharacters",
			path:         "/characters",
			method:       "GET",
			body:         "",
			responseCode: 200,
			response:     `[{"classId":6,"name":"Druid","id":661776,"level":60,"zoneid":22},{"classId":14,"name":"Enchanter","id":661778,"level":60,"zoneid":105},{"classId":12,"name":"Wizard","id":661787,"level":60,"zoneid":66},{"classId":8,"name":"Shin","id":661801,"level":60,"zoneid":201},{"classId":3,"name":"Pally","id":661808,"level":60,"zoneid":12},{"classId":9,"name":"Wynn","id":661960,"level":60,"zoneid":22},{"classId":5,"name":"Devtank","id":662555,"level":60,"zoneid":119},{"classId":7,"name":"Nagafen","id":662738,"level":25,"zoneid":66},{"classId":14,"name":"Enchtwo","id":662799,"level":60,"zoneid":201},{"classId":6,"name":"Deviant","id":662824,"level":16,"zoneid":46},{"classId":5,"name":"Xackery","id":662866,"level":36,"zoneid":90},{"classId":11,"name":"Necromancer","id":662925,"level":10,"zoneid":201}]`,
			useAuth:      true,
		},
		Endpoint{
			name:         "GetCharactersYaml",
			path:         "/characters?format=yaml",
			method:       "GET",
			body:         "",
			responseCode: 200,
			response:     `- classid: 6`,
			useAuth:      true,
		},
		Endpoint{
			name:         "GetCharactersXML",
			path:         "/characters?format=xml",
			method:       "GET",
			body:         "",
			responseCode: 200,
			response:     `<Character><ClassId>6</ClassId><Name>Druid</Name><Id>661776</Id><Level>60</Level><Zoneid>22</Zoneid></Character><Character><ClassId>14</ClassId><Name>Enchanter</Name><Id>661778</Id><Level>60</Level><Zoneid>105</Zoneid></Character><Character><ClassId>12</ClassId><Name>Wizard</Name><Id>661787</Id><Level>60</Level><Zoneid>66</Zoneid></Character><Character><ClassId>8</ClassId><Name>Shin</Name><Id>661801</Id><Level>60</Level><Zoneid>201</Zoneid></Character><Character><ClassId>3</ClassId><Name>Pally</Name><Id>661808</Id><Level>60</Level><Zoneid>12</Zoneid></Character><Character><ClassId>9</ClassId><Name>Wynn</Name><Id>661960</Id><Level>60</Level><Zoneid>22</Zoneid></Character><Character><ClassId>5</ClassId><Name>Devtank</Name><Id>662555</Id><Level>60</Level><Zoneid>119</Zoneid></Character><Character><ClassId>7</ClassId><Name>Nagafen</Name><Id>662738</Id><Level>25</Level><Zoneid>66</Zoneid></Character><Character><ClassId>14</ClassId><Name>Enchtwo</Name><Id>662799</Id><Level>60</Level><Zoneid>201</Zoneid></Character><Character><ClassId>6</ClassId><Name>Deviant</Name><Id>662824</Id><Level>16</Level><Zoneid>46</Zoneid></Character><Character><ClassId>5</ClassId><Name>Xackery</Name><Id>662866</Id><Level>36</Level><Zoneid>90</Zoneid></Character><Character><ClassId>11</ClassId><Name>Necromancer</Name><Id>662925</Id><Level>10</Level><Zoneid>201</Zoneid></Character>`,
			useAuth:      true,
		},
	}

	s := &mariadb.Storage{}
	if err = s.Initialize(); err != nil {
		t.Fatalf("Failed to initialize: %s", err.Error())
	}
	go StartServer(s)

	url := "http://localhost:8081"

	client := &http.Client{}
	for _, test := range tests {
		var req *http.Request
		var err error
		if test.method == "POST" || test.method == "PUT" {
			req, err = http.NewRequest(test.method, url+test.path, strings.NewReader(test.body))
			req.Header.Add("Content-Length", strconv.Itoa(len(test.body)))
		} else {
			req, err = http.NewRequest(test.method, url+test.path, nil)
		}
		if test.useAuth {
			req.Header.Add("Authorization", fmt.Sprintf("Bearer %s", apiKey))
		}
		req.Header.Add("Content-Type", "application/json; charset=UTF-8")

		resp, err := client.Do(req)
		if err != nil {
			t.Fatalf("%s %s %s failed: %s", test.name, test.method, test.path, err.Error())
		}

		if test.isLoginResponse {
			loginResp := LoginResponse{}

			decoder := json.NewDecoder(resp.Body)

			err = decoder.Decode(&loginResp)
			if err != nil {
				t.Fatalf("Failed to decode login response: %s", err.Error())
			}
			apiKey = loginResp.ApiKey
			continue
		}

		actual, err := ioutil.ReadAll(resp.Body)
		if err != nil {
			t.Fatalf("%s %s %s failed getting body: %s", test.name, test.method, test.path, err.Error())
		}
		actualStr := strings.TrimSpace(string(actual))
		if resp.StatusCode != test.responseCode {
			t.Fatalf("%s %s %s failed response: Expected %d, got %d (%s)", test.name, test.method, url+test.path, test.responseCode, resp.StatusCode, actualStr)
		}

		if strings.Index(actualStr, test.response) != 0 {
			t.Fatalf("%s %s %s failed body: Expected \"%s\", got \"%s\"", test.name, test.method, test.path, test.response, actualStr)
		}
	}
}
