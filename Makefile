SHADOW_PATH := ~/.local/bin/shadow
CONFIG_DIR := ./home
TARGET_DIR := ~/ # Path to your configuration directory

install: install-shadow copy
.PHONY: install

install-shadow:
	cd shadow && \
	go build -o $(SHADOW_PATH) .
.PHONY: install-shadow

copy:
	UNAME_S := $(shell uname -s)
	IGNORE := ""
	ifeq ($(UNAME_S),Linux)
		IGNORE = ".shadowignore"
	endif
	ifeq ($(UNAME_S),Darwin)
		IGNORE = "macos.shadowignore"
	endif
	$(SHADOW_PATH) $(CONFIG_DIR) $(TARGET_DIR) $(IGNORE)
.PHONY: copy

uninstall: uninstall-shadow
.PHONY: uninstall

uninstall-shadow:
	rm -f $(SHADOW_PATH)
.PHONY: uninstall-shadow
