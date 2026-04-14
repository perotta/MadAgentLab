#FROM node:20-alpine
FROM debian:trixie-slim

RUN apt-get update
RUN apt-get install -y --no-install-recommends \  
   ca-certificates curl wget git gnupg \
   unzip zip xz-utils file \
   ripgrep fd-find jq tree \
   build-essential pkg-config cmake ninja-build \
   python3 python3-pip python3-venv \
   nodejs npm \
   strace gdb lsof procps \
   diffutils patch \
   bat delta \
   perl \
   autoconf \
   automake \
   libtool \
   php \
   golang perltidy \
   bubblewrap \
 && rm -rf /var/lib/apt/lists/*

RUN groupadd -g 1000 node \
 && useradd -m -u 1000 -g 1000 -s /bin/bash node


ENV EDITOR=vim
ENV PAGER=less
ENV LANG=C.UTF-8

RUN git config --system core.pager delta
   
RUN npm install -g @openai/codex@0.120.0
RUN npm install -g prettier@3.6.2
RUN npm install -g typescript@5.9.3 

RUN curl -L https://github.com/PHP-CS-Fixer/PHP-CS-Fixer/releases/download/v3.90.0/php-cs-fixer.phar \
    -o /usr/local/bin/php-cs-fixer \
 && chmod +x /usr/local/bin/php-cs-fixer


RUN mkdir -p /agent-workspace
RUN chown -R node:node /agent-workspace

COPY AGENTS.md /usr/local/share/codex-defaults/AGENTS.md
COPY config.toml /usr/local/share/codex-defaults/config.toml
COPY entrypoint.sh /usr/local/bin/entrypoint
RUN chmod +x /usr/local/bin/entrypoint

USER node
WORKDIR /agent-workspace

ENTRYPOINT ["/usr/local/bin/entrypoint"]

