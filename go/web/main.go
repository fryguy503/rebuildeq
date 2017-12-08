package main

import (
	"fmt"

	"github.com/xackery/rebuildeq/go/swagger/client"
)

func main() {
	cfg := &client.Configuration{
		Host: "localhost:8901",
	}

	api := client.NewAPIClient(cfg)
	fmt.Println(api)
}
