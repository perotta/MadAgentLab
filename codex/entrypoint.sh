#!/usr/bin/env bash
mkdir -p /home/node/.codex
cp /usr/local/share/codex-defaults/AGENTS.md /home/node/.codex/AGENTS.md
cp /usr/local/share/codex-defaults/config.toml /home/node/.codex/config.toml
mkdir -p /home/node/.agents/skills
cp -R /usr/local/share/codex-defaults/skills/impeccable /home/node/.agents/skills/
exec codex "$@"
