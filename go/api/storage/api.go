package storage

import (
	"github.com/xackery/rebuildeq/go/swagger/client"
)

type Api interface {
	GetCharacters() (characters []*client.Character, err error)
}
