package sql

import (
	"fmt"

	"github.com/pkg/errors"
	"github.com/xackery/rebuildeq/go/eqproto"
)

//GetBuild gets a build by provided buildID
func (s *Storage) GetBuild(build *eqproto.Build, user *eqproto.User) (err error) {
	err = s.prepareBuild(build, user)
	if err != nil {
		err = errors.Wrap(err, "failed to prepare build")
		return
	}

	err = s.validateBuild(build)
	if err != nil {
		err = errors.Wrap(err, "failed to validate build")
		return
	}

	//query

	//err = s.sanitizeBuild(build, user)
	return
}

//EditBuild edits an existing build
func (s *Storage) EditBuild(build *eqproto.Build, user *eqproto.User) (err error) {
	err = s.prepareBuild(build, user)
	if err != nil {
		err = errors.Wrap(err, "failed to prepare build")
		return
	}

	err = s.validateBuild(build)
	if err != nil {
		err = errors.Wrap(err, "failed to validate build")
		return
	}

	//query

	//err = s.sanitizeBuild(build, user)
	return
}

func (s *Storage) prepareBuild(build *eqproto.Build, user *eqproto.User) (err error) {
	if build == nil {
		err = fmt.Errorf("empty build")
		return
	}
	if user == nil {
		err = fmt.Errorf("empty user")
		return
	}
	return
}

func (s *Storage) validateBuild(build *eqproto.Build) (err error) {
	hash := build.Hash
	if len(hash) < 53 {
		err = fmt.Errorf("build hash is too short")
		return
	}

	return
}

func (s *Storage) sanitizeBuild(build *eqproto.Build, user *eqproto.User) (err error) {
	return
}
