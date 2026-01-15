package main

import (
	"fmt"
	"io/fs"
	"os"
	"path/filepath"
	"regexp"
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

func mkTree(root string, name string, ignore []*regexp.Regexp) (*treeNode, error) {
	entries, err := os.ReadDir(root)
	if err != nil {
		return nil, fmt.Errorf("reading directory %s: %w", root, err)
	}

	children := make([]*treeNode, 0, len(entries))
	for _, e := range entries {
		if e.IsDir() {
			path := filepath.Join(root, e.Name())

			// Check if directory is ignored
			skip := false
			for _, r := range ignore {
				debug("Checking ignore pattern %s against %s", r.String(), path)
				if r.MatchString(path) {
					debug("Ignoring directory %s", path)
					skip = true
				}
			}

			if skip {
				continue
			}

			node, err := mkTree(path, e.Name(), ignore)
			if err != nil {
				return nil, err
			}

			children = append(children, node)
		} else {
			relPath := filepath.Join(root, e.Name())
			absPath, err := filepath.Abs(relPath)
			if err != nil {
				return nil, fmt.Errorf("invalid absolute path: %w", err)
			}

			// Add file to tree
			node := &treeNode{
				path:   absPath,
				name:   e.Name(),
				isFile: true,
			}

			children = append(children, node)
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
