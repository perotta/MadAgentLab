UNAME_S := $(shell uname -s)
INSTALL_NAME := $(or $(word 2,$(MAKECMDGOALS)),madcodex)

ifeq ($(UNAME_S),Darwin)
DEFAULT_PREFIX := $(if $(wildcard /opt/homebrew/bin),/opt/homebrew/bin,/usr/local/bin)
else
DEFAULT_PREFIX := /usr/local/bin
endif

PREFIX ?= $(DEFAULT_PREFIX)

.PHONY: build login install

build:
	docker build -t madagentlab/codex .

login:
	docker run --pull=never --rm -it -v codex-home:/home/node madagentlab/codex login --device-auth

install:
	@if [ -w "$(PREFIX)" ]; then \
		install -m 0755 codex "$(PREFIX)/$(INSTALL_NAME)"; \
	elif command -v sudo >/dev/null 2>&1; then \
		sudo install -d "$(PREFIX)" && sudo install -m 0755 codex "$(PREFIX)/$(INSTALL_NAME)"; \
	else \
		echo "Cannot write to $(PREFIX) and sudo is not available. Set PREFIX to a writable directory."; \
		exit 1; \
	fi

# Allow `make install custom-name` to treat the extra goal as the binary name.
%:
	@:
