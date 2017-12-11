package utils

import (
	"regexp"
	"strings"
)

func CleanName(name string) (cleanName string) {
	var re = regexp.MustCompile(`[^0-9A-Za-z_]+`)
	cleanName = strings.Replace(name, " ", "_", -1)
	cleanName = strings.Replace(cleanName, "#", "", -1)
	cleanName = strings.TrimSpace(re.ReplaceAllString(cleanName, ""))
	cleanName = strings.Replace(cleanName, "_", " ", -1)
	return
}
