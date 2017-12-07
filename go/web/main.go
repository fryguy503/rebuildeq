package main

import (
	"fmt"

	"github.com/xackery/rebuildeq/go/web/swagger"
)

func main() {
	cfg := &swagger.Configuration{
		Host: "localhost:8901",
	}

	api := swagger.NewAPIClient(cfg)
	api.ItemApi
	//api.InventoryApi.
	fmt.Println(api)
	//http.ListenAndServe(":8080", static.Handler)
	//fmt.Println("Started")
	//select {}
}
