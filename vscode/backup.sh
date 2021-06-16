#!/usr/bin/env bash

set -euo pipefail

cd "${BASH_SOURCE[0]%/*}" || exit 1

source ../scripts/functions.sh

info "backing up Visual Studio Code"

if code --list-extensions > "$HOME/.dotfiles/packages/code --install-extension.list"; then
    success "backed up Visual Studio Code"
else
    error "failed to back up Visual Studio Code"
fi
