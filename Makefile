SHADOW_PATH := ~/.local/bin/shadow
CONFIG_DIR := .config # Path to your configuration directory

install: install-shadow copy
.PHONY: install

install-shadow:
	cd shadow && \
	go build -o $(SHADOW_PATH) .
.PHONY: install-shadow

copy:
	$(SHADOW_PATH) . $(CONFIG_DIR)
.PHONY: copy

uninstall: uninstall-shadow
.PHONY: uninstall

uninstall-shadow:
	rm -f $(SHADOW_PATH)
.PHONY: uninstall-shadow
