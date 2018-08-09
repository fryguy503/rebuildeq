package storage

import (
	"github.com/xackery/rebuildeq/go/eqproto"
)

// Storage is used for all storing implementations
type Storage interface {
	GetBuild(build *eqproto.Build, user *eqproto.User) (err error)
	EditBuild(build *eqproto.Build, user *eqproto.User) (err error)
}
