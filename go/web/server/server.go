package server

import (
	"context"
	"fmt"
	"log"
	"net/http"

	"github.com/xackery/rebuildeq/go/swagger/client"
)

var (
	api *client.APIClient
)

//Global variables loaded to most templates
type Site struct {
	Title       string //Title of site
	Page        string
	Section     string
	Description string //Description for oprop
}

func StartServer() {

	cfg := client.NewConfiguration()
	cfg.BasePath = "http://127.0.0.1:8081"
	api = client.NewAPIClient(cfg)
	router := NewRouter()
	router.StrictSlash(false)

	log.Fatal(http.ListenAndServe(":8080", router))
}

func GetContext(r *http.Request) context.Context {
	tokens, ok := r.Header["Authorization"]
	token := ""
	if ok && len(tokens) >= 1 {
		token = tokens[0]
	}
	if len(token) == 0 { //try cookie
		cookie, err := r.Cookie("access_token")
		if err == nil {
			token = cookie.Value
		}
	}
	return context.WithValue(context.Background(), client.ContextAPIKey, client.APIKey{
		Key: token,
		//Prefix: "Bearer", // Omit if not necessary.
	})
}

func NewSite() (site Site) {
	site = Site{
		Title:       "RebuildEQ",
		Description: "RebuildEQ rocks.",
	}
	return
}

func show404(w http.ResponseWriter, r *http.Request, message string) {
	showError(w, r, message, http.StatusNotFound)
}

func show500(w http.ResponseWriter, r *http.Request, message string) {
	showError(w, r, message, http.StatusInternalServerError)
}

func showError(w http.ResponseWriter, r *http.Request, message string, statusCode int) {
	var err error
	status := fmt.Sprintf("%d", statusCode)
	tmp := getTemplate(status)
	if tmp == nil {

		if tmp, err = loadTemplate(nil, "body", "error.tpl"); err != nil {
			//this is a major error
			log.Println("Failed to load body on showerror:", err.Error())
			return
		}

		if tmp, err = loadStandardTemplate(tmp); err != nil {
			//this is a major error
			log.Println("Failed to load standard on showerror:", err.Error())
			return
		}
		setTemplate(status, tmp)
	}
	type Content struct {
		Site Site
		Url  string
	}
	site := NewSite()
	site.Page = status
	site.Description = message
	content := Content{
		Site: site,
		Url:  r.URL.String(),
	}

	log.Println(fmt.Sprintf("%s: %s", r.URL, message))

	w.WriteHeader(statusCode)
	if err = tmp.Execute(w, content); err != nil {
		log.Println("Failed to execute template:", err.Error())
		return
	}
}
