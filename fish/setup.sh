#!/usr/bin/env bash
#
# Fish
#
# This sets up Fish as the default shell and symlinks files to the correct spots in ~/.config/fish/.

set -uo pipefail

cd "$(dirname "$0")"

source ../scripts/functions.sh

src="$(osx_realpath .)"
dst="$(osx_realpath ~/.config/fish)"

info "setting up fish shell"

substep_info "creating fish config folders"
mkdir -p "$dst/functions"
mkdir -p "$dst/completions"

find * -name "*.fish" -o -name "fishfile" | while read fn; do
    symlink "$src/$fn" "$dst/$fn"
done
clear_broken_symlinks "$dst"

set_fish_shell() {
    if grep --quiet fish <<< "$SHELL"; then
        substep_success "fish shell is already set up"
    else
        substep_info "adding fish executable to /etc/shells"
        if grep --fixed-strings --line-regexp --quiet "/usr/local/bin/fish" /etc/shells; then
            substep_success "fish executable already exists in /etc/shells"
        else
            if sudo bash -c "echo /usr/local/bin/fish >> /etc/shells"; then
                substep_success "fish executable added to /etc/shells"
            else
                substep_error "failed adding Fish executable to /etc/shells"
                return 1
            fi
        fi
        substep_info "changing shell to fish"
        if sudo chsh -s /usr/local/bin/fish $(whoami); then
            substep_success "changed shell to fish"
        else
            substep_error "failed changing shell to fish"
            return 2
        fi
        substep_info "running fish initial setup"
        fish -c "setup"
    fi
}

if set_fish_shell; then
    success "successfully set up fish shell"
else
    error "failed setting up fish shell"
fi
