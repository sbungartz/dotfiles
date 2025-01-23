#!/bin/bash
set -eu -o pipefail

echo "source $HOME/.dotfiles/local-bundle/aliases.zsh" >> "$HOME/.zshrc"
