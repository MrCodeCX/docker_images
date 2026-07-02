#!/bin/sh

# Installs oh-my-zsh + plugins + theme for the CURRENT user.
# Run as the target non-root user (packages must be installed before calling this).

ZSH_THEME="${1:-af-magic}"
ZSH_PLUGINS="${HOME}/.oh-my-zsh/custom/plugins"

RUNZSH=no sh -c "$(wget -qO- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

git clone https://github.com/zsh-users/zsh-autosuggestions "${ZSH_PLUGINS}/zsh-autosuggestions"
git clone https://github.com/zsh-users/zsh-completions "${ZSH_PLUGINS}/zsh-completions"
git clone https://github.com/Aloxaf/fzf-tab "${ZSH_PLUGINS}/fzf-tab"

sed -i "s/plugins=(git)/plugins=(git zsh-autosuggestions zsh-completions fzf-tab)/g" "${HOME}/.zshrc"
sed -i "s/ZSH_THEME=\"robbyrussell\"/ZSH_THEME=\"${ZSH_THEME}\"/g" "${HOME}/.zshrc"
