#!/bin/sh

# Safely creates AI agent state files/folders before first docker compose up.

. ./.env

mkdir -p "$WORKSPACE/.claude" "$WORKSPACE/.codex"
[ ! -s "$WORKSPACE/.claude.json" ] && echo '{}' > "$WORKSPACE/.claude.json"