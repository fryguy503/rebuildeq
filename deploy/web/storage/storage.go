package storage

import (
	"github.com/xackery/eqemuconfig"
)

var config *eqemuconfig.Config

func GetConfig() (*eqemuconfig.Config, error) {
	var err error
	if config != nil {
		return config, nil
	}
	if config, err = eqemuconfig.GetConfig(); err != nil {
		return nil, err
	}
	return config, nil
}
