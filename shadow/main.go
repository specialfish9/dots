package main

import (
	"encoding/json"
	"errors"
	"fmt"
	"os"
	"path/filepath"
)

const lockFile = "shadow.lock"

type args struct {
	base  string
	out   string
	clean bool
	debug bool
}

// parseArgs parses args in a cumbersome, manual way. For now it works fairly
// well, we have just a bunch of arguments.
func parseArgs() (*args, error) {
	if len(os.Args) == 2 {
		if os.Args[1] != "clean" {
			return nil, fmt.Errorf("invalid command '%s'", os.Args[1])
		}

		return &args{
			debug: os.Getenv("DEBUG") == "1",
			clean: true,
		}, nil
	}

	if len(os.Args) < 3 {
		return nil, errors.New("missing base path argument")
	}

	absPath, err := filepath.Abs(os.Args[1])
	if err != nil {
		return nil, fmt.Errorf("invalid absolute path: %w", err)
	}

	return &args{
		base:  absPath,
		out:   os.Args[2],
		debug: os.Getenv("DEBUG") == "1",
	}, nil
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

func create(args *args) {
	debug("Reading folder: %s", args.base)

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

	lock := newLock(lockFile)

	for _, child := range tree.children {
		err = errors.Join(err, replicate(args.out, child, lock))
	}
	if err != nil {
		fmt.Println("Error replicatig tree:", err)
		os.Exit(1)
	}

	if err := lock.Write(); err != nil {
		fmt.Println("Error writing lock file: ", err)
		os.Exit(1)
	}
}

func clean() error {
	// Reconstruct lock
	var lockEntries []lockEntry

	// TODO: prompt "are u sure?"
	fmt.Println("Warn! This will remove all the symlinks created by shadow!")

	lockFileContent, err := os.ReadFile(lockFile)
	if err != nil {
		return fmt.Errorf("can't open lockfile: %w", err)
	}

	if err := json.Unmarshal(lockFileContent, &lockEntries); err != nil {
		return fmt.Errorf("cant parse lock file: %w", err)
	}

	for _, entry := range lockEntries {
		fmt.Printf("Cleaning %s (%s)\n", entry.Name, entry.Path)
		err := os.Remove(entry.Path)
		if err != nil {
			// Log the error directly. Do not stop the process
			fmt.Printf("Error cleaning %s: %v\n", entry.Name, err)
		}
	}

	// Finally, generate a new lock file
	if err = newLock(lockFile).Write(); err != nil {
		return fmt.Errorf("cant update lockfile: %w", err)
	}

	return nil
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

	if args.clean {
		if err := clean(); err != nil {
			fmt.Println("Error cleaning:", err)
			os.Exit(1)
		}
	} else {
		create(args)
	}
}
