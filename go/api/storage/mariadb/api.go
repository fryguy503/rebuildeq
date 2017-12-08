package mariadb

import (
	"github.com/xackery/rebuildeq/go/swagger/client"
)

type Api struct{}

func (a *Api) GetCharacters() *client.Character {
	c := &client.Character{
		Name: "Test",
	}

	return c
}
