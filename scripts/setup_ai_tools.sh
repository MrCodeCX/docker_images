#!/bin/sh

# Installs claude code for the CURRENT user.

curl -fsSL https://claude.ai/install.sh | bash

# Installs codex for the CURRENT user.

curl -fsSL https://chatgpt.com/codex/install.sh | CODEX_NON_INTERACTIVE=1 sh

touch "${HOME}/.codex/config.toml"
grep -q '^sandbox_mode' "${HOME}/.codex/config.toml" || {
    { echo 'sandbox_mode = "danger-full-access"'; cat "${HOME}/.codex/config.toml" 2>/dev/null; } > "${HOME}/.codex/config.toml.tmp"
    mv "${HOME}/.codex/config.toml.tmp" "${HOME}/.codex/config.toml"
}

# Setup path export

grep -q 'export PATH="${HOME}/.local/bin:$PATH"' "${HOME}/.zshrc" || echo 'export PATH="${HOME}/.local/bin:$PATH"' >> "${HOME}/.zshrc"