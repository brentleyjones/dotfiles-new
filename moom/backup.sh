#!/usr/bin/env bash

set -uo pipefail

cd "${BASH_SOURCE[0]%/*}" || exit 1

source ../scripts/functions.sh

info "backing up Moom"

if defaults export com.manytricks.Moom "$HOME/.dotfiles/moom/defaults.plist" && plutil -convert xml1 "$HOME/.dotfiles/moom/defaults.plist"; then
    success "backed up Moom"
else
    error "failed to back up Moom"
fi
