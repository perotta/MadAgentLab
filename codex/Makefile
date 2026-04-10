INSTALL_NAME := $(or $(word 2,$(MAKECMDGOALS)),madcodex)

build:
	docker build -t local/codex .

login:
	docker run --pull=never --rm -it -v codex-home:/home/node local/codex login --device-auth

install:
	sudo cp codex /usr/local/bin/$(INSTALL_NAME)

# Allow `make install custom-name` to treat the extra goal as the binary name.
%:
	@:
