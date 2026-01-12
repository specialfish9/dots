package main

import (
	"fmt"
	"os"
	"regexp"
	"strings"
)

func readIgnoreFile(file string) ([]*regexp.Regexp, error) {
	b, err := os.ReadFile(file)
	if os.IsNotExist(err) {
		// If the file doesnt exists then return empty slice
		return nil, nil
	}
	if err != nil {
		return nil, fmt.Errorf("parsing ignore file: `%s`", err)
	}

	lines := strings.Split(string(b), "\n")

	absLines := make([]*regexp.Regexp, 0)

	for i := range len(lines) {
		if lines[i] == "" {
			continue
		}
		debug("Ignoring %s", lines[i])

		r, err := regexp.Compile(lines[i])
		if err != nil {
			return nil, fmt.Errorf("parsing ignore file: invalid regex `%s`", lines[i])
		}

		absLines = append(absLines, r)
	}

	return absLines, nil
}
