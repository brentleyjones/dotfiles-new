#!/usr/bin/env bash

set -uo pipefail

cd "${BASH_SOURCE[0]%/*}" || exit 1

source ../scripts/functions.sh

mkdir -p ~/Library/Preferences

src="$(osx_realpath .)"
dst="$(osx_realpath ~/Library/Preferences)"

info "setting up Bartender"

find . -name "*.plist" | cut -c3- | while read -r fn; do
    symlink "$src/$fn" "$dst/$fn"
done
clear_broken_symlinks "$dst"

success "successfully set up Bartender"
