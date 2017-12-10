package mariadb

import (
	"fmt"

	"github.com/xackery/rebuildeq/go/swagger/client"
)

func (s *Storage) GetChangelog(changelogId int) (changelog *client.Changelog, err error) {
	if s.db == nil {
		if err = s.Initialize(); err != nil {
			return
		}
	}
	if changelogId == 0 {
		err = fmt.Errorf("Invalid changelog id: %d", changelogId)
		return
	}
	changelog = &client.Changelog{}
	err = s.db.Get(changelog, `SELECT title, date, id, body, image
		FROM changelog 
		WHERE id = ?`, changelogId)
	if err != nil {
		return
	}

	return
}

func (s *Storage) GetChangelogs() (changelogs []*client.Changelog, err error) {
	if s.db == nil {
		if err = s.Initialize(); err != nil {
			return
		}
	}
	rows, err := s.db.Queryx(`SELECT title, date, id, body, image
		FROM changelog 
		ORDER BY date DESC LIMIT 15`)
	if err != nil {
		return
	}

	for rows.Next() {
		c := client.Changelog{}
		if err = rows.StructScan(&c); err != nil {
			return
		}
		changelogs = append(changelogs, &c)
	}
	return
}
