#!/usr/bin/env bash

set -uo pipefail

cd "$(dirname "$0")"

source ../scripts/functions.sh

info "backing up fish shell"

substep_info "backing up abbreviations"
fish -c "abbr" > functions/set_abbr.fish
substep_success "backed up abbreviations"

success "successfully backed up fish shell"
