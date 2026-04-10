#!/usr/bin/env bash
mkdir -p /home/node/.codex
cp /usr/local/share/codex-defaults/AGENTS.md /home/node/.codex/AGENTS.md
cp /usr/local/share/codex-defaults/config.toml /home/node/.codex/config.toml
exec codex "$@"

