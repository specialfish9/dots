package main

import (
	"fmt"
	"io/fs"
	"os"
	"path/filepath"
	"strings"
)

type treeNode struct {
	path     string
	name     string
	isFile   bool
	children []*treeNode
}

func (t *treeNode) String() string {
	return t.path + t.string(0)
}

func (t *treeNode) string(level int) string {
	spacing := ""
	for i := 0; i < level; i++ {
		spacing += "  "
	}
	splitted := strings.Split(t.path, "/")
	out := splitted[len(splitted)-1]
	for _, c := range t.children {
		out += "\n"
		out += spacing
		out += "|-"
		out += c.string(level + 1)
	}

	return out
}

func mkTree(root string, name string) (*treeNode, error) {
	entries, err := os.ReadDir(root)
	if err != nil {
		return nil, fmt.Errorf("reading directory %s: %w", root, err)
	}

	children := make([]*treeNode, len(entries))
	for i, e := range entries {
		if e.IsDir() {
			children[i], err = mkTree(filepath.Join(root, e.Name()), e.Name())
			if err != nil {
				return nil, err
			}
		} else {
			// Add file to tree
			children[i] = &treeNode{
				path:   filepath.Join(root, e.Name()),
				name:   e.Name(),
				isFile: true,
			}
		}
	}

	return &treeNode{
		path:     root,
		name:     name,
		isFile:   false,
		children: children,
	}, nil
}

func replicate(out string, t *treeNode, l *lock) error {
	if t.isFile {
		symLinkPath := filepath.Join(out, t.name)

		debug("Creating symlink at %s -> %s", symLinkPath, t.path)

		// Remove symlink. Ignore errors. TODO add force flace
		os.Remove(symLinkPath)

		if err := os.Symlink(t.path, symLinkPath); err != nil {
			return fmt.Errorf("creating symlink: %w", err)
		}

		l.Add(t.name, symLinkPath)
	} else {
		dirPath := filepath.Join(out, t.name)

		debug("Creating dir at %s -> %s", dirPath, t.path)

		if err := os.MkdirAll(dirPath, fs.ModePerm); err != nil {
			return fmt.Errorf("replicating directory: %w", err)
		}

		for _, child := range t.children {
			if err := replicate(dirPath, child, l); err != nil {
				return err
			}
		}
	}
	return nil
}
