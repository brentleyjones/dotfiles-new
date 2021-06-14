#!/usr/bin/env bash

set -uo pipefail

cd "${BASH_SOURCE[0]%/*}" || exit 1

source ../scripts/functions.sh

mkdir -p ~/Library/Developer/Xcode/UserData

src="$(osx_realpath .)"
dst="$(osx_realpath ~/Library/Developer/Xcode/UserData)"

info "setting up Xcode"

mkdir -p "$dst/FontAndColorThemes"

find . -name "*.xccolortheme" | cut -c3- | while read -r fn; do
    symlink "$src/$fn" "$dst/$fn"
done
clear_broken_symlinks "$dst"

success "successfully set up Xcode"
