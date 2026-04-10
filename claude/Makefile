UNAME_S := $(shell uname -s)
INSTALL_NAME := $(or $(word 2,$(MAKECMDGOALS)),madclaude)

ifeq ($(UNAME_S),Darwin)
DEFAULT_PREFIX := $(if $(wildcard /opt/homebrew/bin),/opt/homebrew/bin,/usr/local/bin)
else
DEFAULT_PREFIX := /usr/local/bin
endif

PREFIX ?= $(DEFAULT_PREFIX)

.PHONY: build login install

build:
	docker build -t local/claude .

login:
	@echo 'Start Claude Code and run /login if it does not prompt for authentication.'
	docker run --pull=never --rm -it -v claude-home:/home/node/.claude local/claude

install:
	@if [ -w "$(PREFIX)" ]; then \
		install -m 0755 claude "$(PREFIX)/$(INSTALL_NAME)"; \
	elif command -v sudo >/dev/null 2>&1; then \
		sudo install -d "$(PREFIX)" && sudo install -m 0755 claude "$(PREFIX)/$(INSTALL_NAME)"; \
	else \
		echo "Cannot write to $(PREFIX) and sudo is not available. Set PREFIX to a writable directory."; \
		exit 1; \
	fi

# Allow `make install custom-name` to treat the extra goal as the binary name.
%:
	@:
