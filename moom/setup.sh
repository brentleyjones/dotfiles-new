#!/usr/bin/env bash

set -uo pipefail

cd "${BASH_SOURCE[0]%/*}"

source ../scripts/functions.sh

src="$(osx_realpath .)"
dst="$(osx_realpath ~/Library/Application\ Support/Code/User)"

info "setting up Moom"

if defaults import com.manytricks.Moom defaults.plist; then
    success "successfully set up Moon"
else
    error "failed to set up Moon"
fi
