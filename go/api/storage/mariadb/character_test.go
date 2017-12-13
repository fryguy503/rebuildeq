package mariadb

import (
	"testing"
)

func TestCharacter(t *testing.T) {

	var err error
	s := Storage{}
	err = s.Initialize()
	if err != nil {
		t.Fatal("Expected no error on initialize")
	}

	character, err := s.GetCharacter(0)
	if err == nil {
		t.Fatal("Expected error with 0 recipe get")
	}

	character, err = s.GetCharacter(661801)
	if err != nil {
		t.Fatalf("Expected no errors, got: %s", err.Error())
	}
	if character.Name != "Shin" {
		t.Fatalf("Expected Shin, got %s", character.Name)
	}
}
