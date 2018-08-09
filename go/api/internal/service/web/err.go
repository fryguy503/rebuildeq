package web

type errPermission struct {
	Message string
}

func (e *errPermission) Error() string {
	return e.Message
}

type errNoContent struct {
	Message string
}

func (e *errNoContent) Error() string {
	return e.Message
}

type errDecodeBody struct {
	Message string
}

func (e *errDecodeBody) Error() string {
	return e.Message
}
