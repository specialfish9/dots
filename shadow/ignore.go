package main

import (
	"fmt"
	"os"
	"path/filepath"
	"strings"
)

func readIgnoreFile(file string) ([]string, error) {
	b, err := os.ReadFile(file)
	if os.IsNotExist(err) {
		// If the file doesnt exists then return empty slice
		return nil, nil
	}
	if err != nil {
		return nil, fmt.Errorf("parsing ignore file: `%s`", err)
	}

	lines := strings.Split(string(b), "\n")

	absLines := make([]string, 0)

	for i := range len(lines) {
		if lines[i] == "" {
			continue
		}
		abs, err := filepath.Abs(lines[i])
		if err != nil {
			return nil, fmt.Errorf("parsing ignore file: invalid line `%s`", abs)
		}

		debug("ignoring folder %s", abs)

		absLines = append(absLines, abs)
	}

	return absLines, nil
}
