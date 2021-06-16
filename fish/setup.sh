#!/usr/bin/env bash
#
# Fish
#
# This sets up Fish as the default shell and symlinks files to the correct spots in $XDG_CONFIG_HOME/fish/.

set -uo pipefail

cd "${BASH_SOURCE[0]%/*}" || exit 1

source ../scripts/functions.sh

mkdir -p "$XDG_CONFIG_HOME"

src="$(osx_realpath .)"
dst="$(osx_realpath "$XDG_CONFIG_HOME/fish")"

info "setting up fish shell"

substep_info "creating config folders"
mkdir -p "$dst/functions"
mkdir -p "$dst/completions"

substep_info "creating symlinks"
find . -name "*.fish" -o -name "fish_plugins" | cut -c3- | while read -r fn; do
    symlink "$src/$fn" "$dst/$fn"
done
clear_broken_symlinks "$dst"

set_fish_shell() {
    if grep --quiet fish <<< "$SHELL"; then
        substep_success "fish shell is already set up"
    else
        fish_path="$(which fish)"
        if [ "$fish_path" == "" ]; then
            substep_error "fish is not installed"
            return 1
        fi

        if grep --fixed-strings --line-regexp --quiet "$fish_path" /etc/shells; then
            substep_success "fish executable already exists in /etc/shells"
        else
            if sudo bash -c "echo $fish_path >> /etc/shells"; then
                substep_success "fish executable added to /etc/shells"
            else
                substep_error "failed adding Fish executable to /etc/shells"
                return 2
            fi
        fi
        substep_info "changing shell to fish"
        if sudo chsh -s "$fish_path" "$(whoami)"; then
            substep_success "changed shell to fish"
        else
            substep_error "failed changing shell to fish"
            return 3
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
