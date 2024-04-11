#!/usr/bin/env bash

set -e

cd "${BASH_SOURCE[0]%/*}" || exit 1

source ../scripts/functions.sh

# Check for Homebrew
if test ! "$(which brew)"; then
    info "installing Homebrew"

    if ! /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)" </dev/null; then
        error "failed to install Homebrew"
    fi
fi

# Install xcodes
if test ! "$(which xcodes)"; then
    info "installing xcodes"

    if ! brew install robotsandpencils/made/xcodes; then
        error "failed to install xcodes"
    fi
fi

# Install Xcode if needed
if [ "$(xcode-select -p)" == "/Library/Developer/CommandLineTools" ]; then
    info "installing Xcode"

    if ! xcodes install --latest; then
        error "failed to install latest Xcode"
    fi

    xcode_path="$(mdfind kind:application -onlyin /Applications -name 'Xcode-' | tail -n 1)"
    if ! sudo xcode-select -s "$xcode_path"; then
        error "failed to set xcode-select to latest Xcode"
    fi

    sudo xcodebuild -runFirstLaunch
fi

info "installing required Homebrew packages"
if brew bundle --file Brewfile-required; then
    success "finished installing required Homebrew packages"
else
    error "failed to install required Homebrew packages"
fi

install_mas_packages() {
    # Install the packages
    if ! brew bundle --file Brewfile-mas; then
        substep_error "failed to install Brewfile-mas packages"
        return 3
    fi
}

info "installing Mac App Store apps"
if install_mas_packages; then
    success "finished installing Mac App Store apps"
else
    error "failed to install Mac App Store apps" false
fi

info "installing remaining Homebrew packages"
if brew bundle --file Brewfile; then
    success "finished installing remaining Homebrew packages"
else
    error "failed to install remaining Homebrew packages" false
fi

find . -name "*.list" | cut -c3- | while read -r fn; do
    cmd="${fn%.*}"
    set -- "${cmd[@]}"
    info "installing $1 packages"
    while read -r package; do
        if [[ -z $package ]]; then
            continue
        fi
        substep_info "installing $package"
        if ! $cmd "${package[@]}"; then
            substep_error "failed to install $package"
        fi
    done < "$fn"
    success "finished installing $1 packages"
done

exit 0
