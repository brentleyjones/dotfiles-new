#!/usr/bin/env bash

set -euo pipefail

cd "${BASH_SOURCE[0]%/*}" || exit 1

source ../scripts/functions.sh

info "setting up gnupg"

mkdir -p "$HOME/.gnupg"

readonly config_path="$HOME/.gnupg/gpg-agent.conf"
if [[ -f "$config_path" ]]; then
    substep_info "gpg-agent.conf already exists"
else
    if [[ "$(uname -m)" == "arm64" ]]; then
        readonly homebrew_path=/opt/homebrew/bin
    else
        readonly homebrew_path=/usr/local/bin
    fi
    echo "pinentry-program $homebrew_path/pinentry-mac" > "$config_path"

    substep_success "created gpg-agent.conf"
fi
