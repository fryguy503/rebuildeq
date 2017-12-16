package mariadb

import (
	"database/sql"
	"fmt"

	"github.com/xackery/rebuildeq/go/swagger/client"
)

func (s *Storage) GetZone(zoneId int) (zone *client.Zone, err error) {
	if s.db == nil {
		if err = s.Initialize(); err != nil {
			return
		}
	}
	if zoneId == 0 {
		err = fmt.Errorf("Invalid zone id: %d", zoneId)
		return
	}
	zone = &client.Zone{}
	err = s.db.Get(zone, `SELECT zoneidnumber id, long_name name, short_name shortname, levels
		FROM zone 
		WHERE zoneidnumber = ? AND min_status = 0`, zoneId)
	if err != nil {
		if err == sql.ErrNoRows {
			err = nil
			return
		}
		return
	}

	return
}

func (s *Storage) GetZoneChart() (zones []*client.Zone, err error) {
	if s.db == nil {
		if err = s.Initialize(); err != nil {
			return
		}
	}
	rows, err := s.db.Queryx(`SELECT zoneidnumber id, long_name name, short_name shortname, levels
		FROM zone 
		WHERE min_status = 0
		ORDER BY shortname ASC`)
	if err != nil {
		return
	}

	for rows.Next() {
		c := client.Zone{}
		if err = rows.StructScan(&c); err != nil {
			return
		}
		zones = append(zones, &c)
	}

	return
}

func (s *Storage) GetZoneSearch(zone *client.Zone) (zones []*client.Zone, err error) {
	if s.db == nil {
		if err = s.Initialize(); err != nil {
			return
		}
	}
	zone.Name = "%" + zone.Name + "%"

	rows, err := s.db.NamedQuery(`SELECT zoneidnumber id, long_name name, short_name shortname, levels
		FROM zone 
		WHERE min_status = 0 AND (
			long_name LIKE :name OR
			short_name LIKE :shortname OR
			zoneidnumber LIKE :id
			)
		ORDER BY shortname ASC`, zone)
	/*long_name LIKE '%:name%' OR
	short_name LIKE '%:shortname%'
	*/
	if err != nil {
		return
	}

	for rows.Next() {
		c := client.Zone{}
		if err = rows.StructScan(&c); err != nil {
			return
		}
		zones = append(zones, &c)
	}

	return
}
