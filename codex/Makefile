build:
	docker build -t local/codex .

login:
	docker run --pull=never --rm -it -v codex-home:/home/node local/codex login --device-auth

install:
	sudo cp codex /usr/local/bin/codex

