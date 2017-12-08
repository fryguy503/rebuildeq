package mariadb

import (
	"fmt"

	"github.com/xackery/rebuildeq/go/swagger/client"
)

func (s *Storage) UpdateBuild(characterId int, buildPoints *client.BuildPoints) (err error) {
	if s.db == nil {
		if err = s.Initialize(); err != nil {
			return
		}
	}

	_, err = s.db.Exec(`UPDATE character_data 
		SET build_data = ? 
		WHERE id = ?
		`, characterId, buildPoints.Build)
	if err != nil {
		return
	}
	return
}

func (s *Storage) GetSpentBuildPoints(characterId int) (buildPoints *client.BuildPoints, err error) {
	if s.db == nil {
		if err = s.Initialize(); err != nil {
			return
		}
	}
	if characterId == 0 {
		err = fmt.Errorf("Invalid character id: %d", characterId)
		return
	}

	buildPoints = &client.BuildPoints{}
	err = s.db.Get(buildPoints, `SELECT build_data build
		FROM character_data
		WHERE id = ?`, characterId)
	if err != nil {
		return
	}
	return
}
