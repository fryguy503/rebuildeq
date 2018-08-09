package service

// Service is service
type Service interface {
	ListenAndServe(port int) (err error)
}
