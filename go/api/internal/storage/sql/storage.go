package sql

// Storage implements the storage interface using SQL
type Storage struct {
}

// NewSQLStorage creates a new sql storage interface
func NewSQLStorage() (s *Storage, err error) {
	s = &Storage{}
	return
}
