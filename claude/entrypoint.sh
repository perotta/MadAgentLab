#!/usr/bin/env bash
set -euo pipefail

CLAUDE_DIR="/home/node/.claude"
CLAUDE_CONFIG="/home/node/.claude.json"
LEGACY_DIR="/home/node/.claude-legacy"
SETTINGS="$CLAUDE_DIR/settings.json"

mkdir -p "$CLAUDE_DIR"

restore_from_backup() {
  local backup_dir="$1"
  local latest_backup

  if [ ! -d "$backup_dir" ]; then
    return
  fi

  latest_backup="$(find "$backup_dir" -maxdepth 1 -type f -name '.claude.json.backup.*' | sort | tail -n 1)"
  if [ -n "$latest_backup" ] && [ ! -f "$CLAUDE_CONFIG" ]; then
    cp "$latest_backup" "$CLAUDE_CONFIG"
  fi
}

# Migrate state from the legacy volume layout that only persisted /home/node/.claude.
if [ -d "$LEGACY_DIR" ]; then
  if [ ! -f "$SETTINGS" ] && [ -f "$LEGACY_DIR/settings.json" ]; then
    cp "$LEGACY_DIR/settings.json" "$SETTINGS"
  fi

  if [ ! -d "$CLAUDE_DIR/backups" ] && [ -d "$LEGACY_DIR/backups" ]; then
    cp -R "$LEGACY_DIR/backups" "$CLAUDE_DIR/backups"
  fi

  if [ ! -f "$CLAUDE_CONFIG" ] && [ -f "$LEGACY_DIR/.claude.json" ]; then
    cp "$LEGACY_DIR/.claude.json" "$CLAUDE_CONFIG"
  fi

  restore_from_backup "$LEGACY_DIR/backups"
fi

# Recover the main config from Claude's own backup directory when needed.
restore_from_backup "$CLAUDE_DIR/backups"

# Ensure permissive mode is set for containerized usage while preserving user settings.
if [ ! -f "$SETTINGS" ]; then
  echo '{}' > "$SETTINGS"
fi
jq '.permissions.defaultMode = "bypassPermissions"' "$SETTINGS" > "$SETTINGS.tmp" \
  && mv "$SETTINGS.tmp" "$SETTINGS"

exec claude "$@"
