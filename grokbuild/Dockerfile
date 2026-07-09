FROM debian:trixie-slim

# Latest stable Grok Build CLI as of 2026-07-08 (https://x.ai/build/changelog)
# Override at build time with: --build-arg GROK_VERSION=0.2.22 (or leave empty to fetch latest on build)
ARG GROK_VERSION="0.2.92"
ARG GROK_CHANNEL=stable

ENV GROK_CHANNEL=${GROK_CHANNEL}
ENV GROK_BIN_DIR=/usr/local/bin

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        bash \
        ca-certificates \
        curl \
        wget \
        git \
        gnupg \
        unzip \
        zip \
        xz-utils \
        file \
        imagemagick \
        ripgrep \
        fd-find \
        jq \
        tree \
        xauth \
        xclip \
        x11-utils \
        build-essential \
        pkg-config \
        cmake \
        ninja-build \
        python3 \
        python3-pip \
        python3-venv \
        nodejs \
        npm \
        strace \
        gdb \
        lsof \
        procps \
        diffutils \
        patch \
        bat \
        delta \
        perl \
        autoconf \
        automake \
        libtool \
        php \
        golang \
        poppler-utils \
        perltidy \
        bubblewrap \
        vim-tiny \
        less \
        openssh-client \
    && rm -rf /var/lib/apt/lists/*

RUN groupadd -g 1000 node \
    && useradd -m -u 1000 -g 1000 -s /bin/bash node

ENV EDITOR=vim
ENV PAGER=less
ENV LANG=C.UTF-8
ENV SHELL=/bin/bash
ENV TERM=xterm-256color

RUN git config --system core.pager delta

RUN mkdir -p /usr/local/share/grokbuild

RUN if [ -n "$GROK_VERSION" ]; then \
        curl -fsSL https://x.ai/cli/install.sh | HOME=/usr/local/share/grokbuild bash -s "$GROK_VERSION"; \
    else \
        curl -fsSL https://x.ai/cli/install.sh | HOME=/usr/local/share/grokbuild bash; \
    fi

RUN npm install -g prettier@3.8.3
RUN npm install -g typescript@6.0.3

RUN curl -L https://github.com/PHP-CS-Fixer/PHP-CS-Fixer/releases/download/v3.95.4/php-cs-fixer.phar \
    -o /usr/local/bin/php-cs-fixer \
    && chmod +x /usr/local/bin/php-cs-fixer

RUN mkdir -p /agent-workspace /home/node/.grok \
    && chown -R node:node /agent-workspace /home/node/.grok

COPY entrypoint.sh /usr/local/bin/entrypoint
RUN chmod +x /usr/local/bin/entrypoint

COPY bashrc /home/node/.bashrc
RUN chown node:node /home/node/.bashrc

USER node
WORKDIR /agent-workspace

ENTRYPOINT ["/usr/local/bin/entrypoint"]
