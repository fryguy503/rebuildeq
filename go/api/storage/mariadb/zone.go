package mariadb

import (
	"fmt"

	"github.com/xackery/rebuildeq/go/swagger/client"
)

func (a *Api) GetZone(zoneId int) (zone *client.Zone, err error) {
	if a.db == nil {
		if err = a.Initialize(); err != nil {
			return
		}
	}
	if zoneId == 0 {
		err = fmt.Errorf("Invalid zone id: %d", zoneId)
		return
	}
	zone = &client.Zone{}
	err = a.db.Get(zone, `SELECT id, long_name name, short_name shortname 
		FROM zone 
		WHERE id = ?`, zoneId)
	if err != nil {
		return
	}

	return
}
