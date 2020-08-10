#!/usr/bin/env bash

set -uo pipefail

cd "$(dirname "$0")"

source ../scripts/functions.sh

info "installing fonts"

find * -name "*.otf" | while read fn; do
    if cp "$fn" "$HOME/Library/Fonts/"; then
        substep_success "installed $(basename "$fn")"
    else
        substep_error "failed to install $(basename "$fn")"
    fi
done
