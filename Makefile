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
	@IGNORE=""; \
	if [ "$$(uname -s)" = "Linux" ]; then \
		IGNORE=".shadowignore"; \
	elif [ "$$(uname -s)" = "Darwin" ]; then \
		IGNORE="macos.shadowignore"; \
	fi; \
	$(SHADOW_PATH) $(CONFIG_DIR) $(TARGET_DIR) "$$IGNORE"
.PHONY: copy

uninstall: uninstall-shadow
.PHONY: uninstall

uninstall-shadow:
	rm -f $(SHADOW_PATH)
.PHONY: uninstall-shadow
