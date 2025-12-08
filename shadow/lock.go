package main

import (
	"encoding/json"
	"fmt"
	"os"
)

type lockEntry struct {
	Name string `json:"name"`
	Path string `json:"path"`
}

type lock struct {
	entries  []lockEntry
	fileName string
}

func newLock(fileName string) *lock {
	return &lock{
		fileName: fileName,
		// initialize entries with an empty slice
		entries: []lockEntry{},
	}
}

func (l *lock) Add(name string, path string) {
	l.entries = append(l.entries, lockEntry{
		Name: name,
		Path: path,
	})
}

func (l *lock) Write() error {
	content, err := json.Marshal(l.entries)
	if err != nil {
		return err
	}

	file, err := os.Create(l.fileName)
	if err != nil {
		return fmt.Errorf("cant create file: %w", err)
	}

	defer file.Close()

	if _, err := file.Write(content); err != nil {
		return err
	}

	return nil
}
