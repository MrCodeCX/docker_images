#!/bin/sh

# Safely creates AI agent state files/folders before first docker compose up.

. ./.env

mkdir -p "$WORKSPACE/.docker-data/.claude" "$WORKSPACE/.docker-data/.codex" "$WORKSPACE/.docker-data/.vscode-server"
[ ! -s "$WORKSPACE/.docker-data/.claude.json" ] && echo '{}' > "$WORKSPACE/.docker-data/.claude.json"