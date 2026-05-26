#!/usr/bin/env bash
set -euo pipefail

mkdir -p /home/node/.grok

exec grok "$@"
