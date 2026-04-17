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
   vim-tiny less \
   openssh-client \
 && rm -rf /var/lib/apt/lists/*

RUN groupadd -g 1000 node \
 && useradd -m -u 1000 -g 1000 -s /bin/bash node

ENV EDITOR=vim
ENV PAGER=less
ENV LANG=C.UTF-8
ENV SHELL=/bin/bash
ENV TERM=xterm-256color
ENV CLAUDE_CODE_DISABLE_AUTO_UPDATE=1

RUN git config --system core.pager delta

RUN curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg \
    -o /usr/share/keyrings/githubcli-archive-keyring.gpg \
 && echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" \
    > /etc/apt/sources.list.d/github-cli.list \
 && apt-get update && apt-get install -y gh && rm -rf /var/lib/apt/lists/*

RUN npm install -g @anthropic-ai/claude-code@2.1.112
RUN npm install -g prettier@3.6.2
RUN npm install -g typescript@5.9.3

RUN curl -L https://github.com/PHP-CS-Fixer/PHP-CS-Fixer/releases/download/v3.90.0/php-cs-fixer.phar \
    -o /usr/local/bin/php-cs-fixer \
 && chmod +x /usr/local/bin/php-cs-fixer

RUN mkdir -p /agent-workspace /home/node/.claude
RUN chown -R node:node /agent-workspace /home/node/.claude

COPY entrypoint.sh /usr/local/bin/entrypoint
RUN chmod +x /usr/local/bin/entrypoint

COPY bashrc /home/node/.bashrc
RUN chown node:node /home/node/.bashrc

USER node
WORKDIR /agent-workspace

ENTRYPOINT ["/usr/local/bin/entrypoint"]
