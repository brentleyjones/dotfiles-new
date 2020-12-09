#! /usr/bin/env sh

set -e

cd "${BASH_SOURCE[0]%/*}"

source ../scripts/functions.sh

# Check for Homebrew
if test ! $(which brew); then
    info "installing Homebrew"

    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)" </dev/null
fi

# Install xcodes
if test ! $(which xcodes); then
    info "installing xcodes"

    brew install robotsandpencils/made/xcodes
fi

# Install Xcode if needed
if [ "$(xcode-select -p)" == "/Library/Developer/CommandLineTools" ]; then
    info "installing Xcode"

    xcodes install --latest
    xcode_path = "$(mdfind kind:application -onlyin /Applications -name 'Xcode-' | tail -n 1)"
    sudo xcode-select -s "$xcode_path"
    sudo xcodebuild -runFirstLaunch
fi

# Ensure we are signed into mas
if test ! $(which mas); then
    brew install mas
fi

if ! mas account > /dev/null; then
    substep_info "signing into the Mac App Store"
    substep_user ' - What is your Apple ID?'
    read -e apple_id
    if mas signin $apple_id; then
        substep_success "signed into the Mac App Store"
    else
        substep_error "failed to sign into the Mac App Store"
    fi
fi

info "installing Brewfile packages"
if brew bundle; then
    success "finished installing Brewfile packages"
else
    error "failed to install Brewfile packages"
fi

find * -name "*.list" | while read fn; do
    cmd="${fn%.*}"
    set -- $cmd
    info "installing $1 packages"
    while read package; do
        if [[ $package == $COMMENT ]]; then
            continue
        fi
        substep_info "installing $package"
        $cmd $package
    done < "$fn"
    success "finished installing $1 packages"
done

exit 0
