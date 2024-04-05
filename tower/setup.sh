#!/usr/bin/env bash

set -euo pipefail

cd "${BASH_SOURCE[0]%/*}" || exit 1

source ../scripts/functions.sh

mkdir -p "$HOME/Library/Application Support/com.fournova.Tower3/Themes"

src="$(osx_realpath .)"
dst="$(osx_realpath "$HOME/Library/Application Support/com.fournova.Tower3")"

info "setting up Tower"

find . -name "*.towertheme" | cut -c3- | while read -r fn; do
    symlink "$src/$fn" "$dst/$fn"
done
clear_broken_symlinks "$dst"

success "successfully set up Tower"
