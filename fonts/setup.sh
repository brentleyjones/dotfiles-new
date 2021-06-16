#!/usr/bin/env bash

set -euo pipefail

cd "${BASH_SOURCE[0]%/*}" || exit 1

source ../scripts/functions.sh

info "installing fonts"

find . -name "*.otf" | cut -c3- | while read -r fn; do
    if cp "$fn" "$HOME/Library/Fonts/"; then
        substep_success "installed $(basename "$fn")"
    else
        substep_error "failed to install $(basename "$fn")"
    fi
done
