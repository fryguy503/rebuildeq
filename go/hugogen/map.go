package main

import (
	"encoding/csv"
	"fmt"
	"image"
	"image/color"
	"io"
	"io/ioutil"
	"os"
	"path/filepath"
	"strconv"
	"strings"

	"github.com/jmoiron/sqlx"
	"github.com/llgcode/draw2d/draw2dimg"
	"github.com/pkg/errors"
)

type Line struct {
	x1 float64
	y1 float64
	x2 float64
	y2 float64
	color color.RGBA
}

//Map implements the mapImage
type Map struct {
	entries map[string]*MapEntry
}

//MapEntry is each map entry
type MapEntry struct {
	Name    string
	XOffset float64
	YOffset float64
	Aspect float64
	Height float64
	Width float64
	AspectX float64
	AspectY float64
}

func genMaps(db *sqlx.DB, mapSrcPath string, outPath string, total int) (m *Map, err error) {
	m = &Map{
		entries: make(map[string]*MapEntry),
	}
	files := []string{}

	//fmt.Println("walking maps")
	err = filepath.Walk(mapSrcPath, func(path string, info os.FileInfo, err error) error {
		if info.IsDir() {
			return nil
		}
		if filepath.Ext(path) == ".txt" {
			files = append(files, info.Name())
		}
		return nil
	})
	if err != nil {
		err = errors.Wrap(err, "failed to walk path")
		fmt.Println(err)
		return
	}
	if total > len(files) {
		total = len(files)
	}
	//fmt.Println("found", len(files), "files to load")
	counter := 0
	for i, file := range files {
		if i > total {
			break
		}
		if counter%1000 == 0 {
			fmt.Printf("map %d / %d\n", counter, total)
		}
		counter++
		err = processMap(mapSrcPath, m, outPath, file)
		if err != nil {
			err = errors.Wrap(err, "failed to load map")
			return
		}
	}
	fmt.Println(counter, "total maps")
	return
}

func processMap(path string, m *Map, outPath string, filename string) (err error) {
	if strings.Contains(filename, "_2.txt") {
		return
	}
	//fmt.Println("loading map", path+filename)

	bMap, err := ioutil.ReadFile(path + filename)
	if err != nil {
		err = errors.Wrap(err, "failed to read file")
		return
	}

	r := csv.NewReader(strings.NewReader(string(bMap)))

	//outData := ""
	//iterate each entry
	width := float64(600)
	height := float64(600)
	dest := image.NewRGBA(image.Rect(0, 0, int(width), int(height)))
	gc := draw2dimg.NewGraphicContext(dest)
	
	gc.SetLineWidth(0.25)

	bounds := &Line{}
	lines := []Line{}

	for {
		record, err := r.Read()
		if err == io.EOF {
			break
		}
		if err != nil {
			continue
		}
		line, err := processLine(record, bounds)
		if err != nil {
			continue
		}
		lines = append(lines, line)
	}

	

	//aspect ratio of the output is scaled to
	var aspect float64

	xOffset := -bounds.x1
	yOffset := -bounds.y1

	fmt.Println(filename, bounds.x1, bounds.x2, bounds.y1, bounds.y2)
	
	bounds.x1 += xOffset
	bounds.x2 += xOffset
	bounds.y1 += yOffset
	bounds.y2 += yOffset

	farPoint := bounds.x2
	if bounds.y2 > farPoint {
		farPoint = bounds.y2
	}

	longestSide := height
	if width > longestSide {
		longestSide = width
	}

	if longestSide > farPoint {
		aspect = farPoint / longestSide
	} else {
		aspect = longestSide / farPoint
	}
	
	

	for _, srcLine := range lines {
		//gc.SetFillColor(color.RGBA{0x44, 0xff, 0x44, 0xff})
		gc.SetFillColor(srcLine.color)
		gc.SetStrokeColor(srcLine.color)
		//gc.SetStrokeColor(color.RGBA{0x00, 0x00, 0x00, 0xff})
		line := srcLine
		line.x1 += xOffset
		line.x2 += xOffset
		line.y1 += yOffset
		line.y2 += yOffset

		if bounds.x2 > width {
			line.x1 *= aspect
			line.x2 *= aspect
		}
		if bounds.y2 > height {
			line.y1 *= aspect
			line.y2 *= aspect
		}
		gc.MoveTo(line.x1, line.y1)
		gc.LineTo(line.x2, line.y2)
		gc.Close()
		gc.FillStroke()
	}

	gc.SetFillColor(color.RGBA{0xFF, 0x00, 0x00, 0xFF})
	gc.SetStrokeColor(color.RGBA{0xFF, 0x00, 0x00, 0xFF})
	gc.MoveTo(0,0)
	gc.Close()
	gc.FillStroke()

	x :=  -(-163.000000)
	y := -(439.000000)
	x += xOffset
	y += yOffset
	x *= aspect
	y *= aspect
	

	gc.SetFillColor(color.RGBA{0xFF, 0xFF, 0x00, 0xFF})
	gc.SetStrokeColor(color.RGBA{0xFF, 0xFF, 0x00, 0xFF})
	gc.MoveTo(x,y)
	gc.LineTo(x-50, y)
	gc.Close()
	gc.FillStroke()

	filename = strings.Replace(filename, ".txt", "", -1)
	filename = strings.Replace(filename, "_1", "", -1)
	filename = strings.ToLower(filename)

	if err = draw2dimg.SaveToPngFile(outPath+filename+".png", dest); err != nil {
		err = errors.Wrap(err, "Failed to write file")
		return
	}
	entry := &MapEntry{
		Name:    filename,
		XOffset: xOffset,
		YOffset: bounds.y2,
		Aspect: aspect,
		Height: height,
		Width: width,
	}
	m.entries[filename] = entry

	
	//zone := &model.Zone{}
	//zone.ShortName.String = filename
	/*err = cases.GetZoneByShortName(zone, user)
	if err != nil {
		err = errors.Wrap(err, "failed to get zone by shorname")
		return
	}*/

	//zoneImage := &model.ZoneImage{}
	/*zoneLevel := &model.ZoneLevel{
		ZoneID:     zone.ID,
		//Levels:     zone.Levels,
		MapAspect:  aspect,
		MapXOffset: xOffset,
		MapYOffset: yOffset,
	}*/

	/*if err = a.zoneLevelRepo.Edit(zone.ID, zoneLevel, nil); err != nil {
		fmt.Printf("Failed to update %s: %s\n", filename, err.Error())
		err = nil
		//err = errors.Wrap(err, fmt.Sprintf("Failed to update %s", filename))
	}
	//ioutil.WriteFile("out.txt", []byte(outData), 0755)
	*/
	//fmt.Println(xOffset, yOffset, filename, aspect)
	return
}


func processLine(record []string, bounds *Line) (line Line, err error) {
	if len(record) < 1 {
		err = fmt.Errorf("invalid record length")
		return
	}
	entries := strings.Split(record[0], " ")
	if len(entries) < 1 {
		err = fmt.Errorf("not enough entries on line")
		return
	}
	drawType := entries[0]
	if drawType != "L" {
		err = fmt.Errorf("not a valid line")
		return
	}

	line.x1, err = strconv.ParseFloat(strings.TrimSpace(entries[1]), 64) //entries[1]), 64)
	line.y1, err = strconv.ParseFloat(strings.TrimSpace(record[1]), 64)
	line.x2, err = strconv.ParseFloat(strings.TrimSpace(record[3]), 64)
	line.y2, err = strconv.ParseFloat(strings.TrimSpace(record[4]), 64)
	
	var r int64
	var g int64
	var b int64
	r, err = strconv.ParseInt(strings.TrimSpace(record[6]), 10, 64)
	g, err = strconv.ParseInt(strings.TrimSpace(record[7]), 10, 64)
	b, err = strconv.ParseInt(strings.TrimSpace(record[8]), 10, 64)
	//fmt.Println(r,g,b)
	
	line.color = color.RGBA{uint8(r), uint8(g), uint8(b), 0xff}

	if bounds.x1 > line.x1 {
		bounds.x1 = line.x1
	}
	if bounds.x2 < line.x1 {
		bounds.x2 = line.x1
	}
	if bounds.x1 > line.x2 {
		bounds.x1 = line.x2
	}
	if bounds.x2 < line.x2 {
		bounds.x2 = line.x2
	}

	if bounds.y1 > line.y1 {
		bounds.y1 = line.y1
	}
	if bounds.y2 < line.y1 {
		bounds.y2 = line.y1
	}
	if bounds.y1 > line.y2 {
		bounds.y1 = line.y2
	}
	if bounds.y2 < line.y2 {
		bounds.y2 = line.y2
	}
	return
}