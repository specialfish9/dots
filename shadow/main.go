package main

import (
	"errors"
	"fmt"
	"io/fs"
	"os"
	"path/filepath"
	"strings"
)

type args struct {
	base  string
	out   string
	debug bool
}

func parseArgs() (*args, error) {
	if len(os.Args) < 3 {
		return nil, errors.New("missing base path argument")
	}

	return &args{
		base:  os.Args[1],
		out:   os.Args[2],
		debug: os.Getenv("DEBUG") == "1",
	}, nil
}

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

func replicate(out string, t *treeNode) error {
	if t.isFile {
		symLinkPath := filepath.Join(out, t.name)

		debug("Creating symlink at %s -> %s", symLinkPath, t.path)

		if err := os.Symlink(t.path, symLinkPath); err != nil {
			return fmt.Errorf("creating symlink: %w")
		}
	} else {
		dirPath := filepath.Join(out, t.name)

		debug("Creating dir at %s -> %s", dirPath, t.path)

		if err := os.Mkdir(dirPath, fs.ModePerm); err != nil {
			return fmt.Errorf("replicating directory: %w", err)
		}

		for _, child := range t.children {
			if err := replicate(dirPath, child); err != nil {
				return err
			}
		}
	}
	return nil
}

// createOutDir if not exitsts
func createOutDir(out string) error {
	_, err := os.Open(out)
	if errors.Is(err, os.ErrNotExist) {
		// dir doesnt exists
		if err := os.Mkdir(out, os.ModePerm); err != nil {
			return fmt.Errorf("creating output directory '%s': %w", out, err)
		}
		return nil
	}

	if err != nil {
		return fmt.Errorf("opening output directory '%s': %w", out, err)
	}

	return nil
}

// d is the debug toggle
var d bool

func debug(format string, args ...any) {
	if d {
		fmt.Printf("DEBUG: "+format+"\n", args...)
	}
}

func main() {
	args, err := parseArgs()
	if err != nil {
		fmt.Println("Error parsing arguments:", err)
		fmt.Println("Usage: shadow <base_path> <output_path>")
		os.Exit(1)
	}

	d = args.debug
	debug("debug on")

	tree, err := mkTree(args.base, "")
	if err != nil {
		fmt.Println("Error creating tree:", err)
		os.Exit(1)
	}

	debug("Constructed tree \n%v", tree.String())

	if err := createOutDir(args.out); err != nil {
		fmt.Println("Error:", err)
		os.Exit(1)
	}

	for _, child := range tree.children {
		err = errors.Join(err, replicate(args.out, child))
	}
	if err != nil {
		fmt.Println("Error replicatig tree:", err)
		os.Exit(1)
	}

	// path := "/tmp/rolfl/symexample"
	// target := "symtarget.txt"
	// os.MkdirAll(path, 0755)
	// ioutil.WriteFile(filepath.Join(path, "symtarget.txt"), []byte("Hello\n"), 0644)
	// symlink := filepath.Join(path, "symlink")
	// os.Symlink(target, symlink)
}
