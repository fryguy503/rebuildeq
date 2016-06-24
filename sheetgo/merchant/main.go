package main

import (
	"fmt"
	"github.com/xackery/rebuildeq/sheetgo/sheet"
)

func main() {
	srv, err := sheet.NewService()
	if err != nil {
		fmt.Println("error starting service", err.Error())
		return
	}

	sheetId := "1c2s3kNZ-O-SaKKoos6dUrLblqbV53NGbIGQ42TmDmL0"

	readRange := "Armor!D7:I100"
	resp, err := srv.Spreadsheets.Values.Get(sheetId, readRange).Do()
	if err != nil {
		fmt.Printf("Unable to retrieve data from sheet. %v\n", err)
		return
	}

	if len(resp.Values) > 0 {
		for _, row := range resp.Values {
			newid := fmt.Sprintf("%s", row[0])
			oldid := fmt.Sprintf("%s", row[4])
			price := fmt.Sprintf("%s", row[5])
			if len(newid) > 0 {
				fmt.Printf("%s => %s, %s\n", oldid, newid, price)
			}
		}
	} else {
		fmt.Print("No data found.")
	}

}
