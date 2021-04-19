#!/usr/bin/env bash

set -uo pipefail

cd "${BASH_SOURCE[0]%/*}" || exit 1

source ../scripts/functions.sh

mkdir -p ~/Library/Application\ Support/Code/User

src="$(osx_realpath .)"
dst="$(osx_realpath ~/Library/Application\ Support/Code/User)"

info "setting up Visual Studio Code"

find . -name "*.json" | cut -c3- | while read -r fn; do
    symlink "$src/$fn" "$dst/$fn"
done
clear_broken_symlinks "$dst"

success "successfully set up Visual Studio Code"
