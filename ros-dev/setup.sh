#!/bin/sh

# Safely creates AI agent state files/folders before first docker compose up.

. ./.env

mkdir -p "$WORKSPACE/.docker-data/.claude" "$WORKSPACE/.docker-data/.codex-data" "$WORKSPACE/.docker-data/.vscode-server"

if [ ! -s "$WORKSPACE/.docker-data/.claude.json" ]; then
    echo '{}' > "$WORKSPACE/.docker-data/.claude.json"
fi

if [ ! -s "$WORKSPACE/.docker-data/.codex-data/config.toml" ]; then
    echo 'sandbox_mode = "danger-full-access"' > "$WORKSPACE/.docker-data/.codex-data/config.toml"
fi