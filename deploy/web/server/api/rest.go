package api

import ()

type Rest struct {
	Status  int64       `json:""`
	Message string      `json:",omitempty"`
	Data    interface{} `json:",omitempty"`
}
