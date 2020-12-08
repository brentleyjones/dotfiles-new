#!/usr/bin/env bash

set -uo pipefail

cd "$(dirname "$0")"

source ../scripts/functions.sh

mkdir -p ~/Library/Application\ Support/Code/User

src="$(osx_realpath .)"
dst="$(osx_realpath ~/Library/Application\ Support/Code/User)"

info "setting up Visual Studio Code"

find * -name "*.json" | while read fn; do
    symlink "$src/$fn" "$dst/$fn"
done
clear_broken_symlinks "$dst"

success "successfully set up Visual Studio Code"
