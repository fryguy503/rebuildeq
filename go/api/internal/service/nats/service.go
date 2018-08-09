package nats

import (
	"fmt"

	"github.com/nats-io/go-nats"
	"github.com/pkg/errors"
	"github.com/xackery/eqemuconfig"
)

// Service implements the Service interface with web implementation
type Service struct {
	conn *nats.Conn
}

// NewNatsService initialized
func NewNatsService() (s *Service, err error) {
	s = &Service{}

	config, err := eqemuconfig.GetConfig()
	if err != nil {
		err = errors.Wrap(err, "could not load eqemuconfig")
		return
	}
	if config.NATS.Host != "" && config.NATS.Port != "" {
		s.conn, err = nats.Connect(fmt.Sprintf("nats://%s:%s", config.NATS.Host, config.NATS.Port))
	} else {
		s.conn, err = nats.Connect(nats.DefaultURL)
	}
	if err != nil {
		err = errors.Wrap(err, "could not connect to nats")
		return
	}
	return
}

// ListenAndServe starts a new api service and begins listening
func (s *Service) ListenAndServe(port int) (err error) {
	return
}
