#!/usr/bin/env bash

set -uo pipefail

cd "${BASH_SOURCE[0]%/*}" || exit 1

source ../scripts/functions.sh

info "setting up the dock"

set_dock() {
    if test ! "$(which dockutil)"; then
        substep_info "installing dockutil"
        sudo installer -pkg ~/.dotfiles/dock/dockutil-2.0.5.pkg -target /

        if sudo installer -pkg ~/.dotfiles/dock/dockutil-2.0.5.pkg -target /; then
            substep_success "installed dockutil"
        else
            substep_error "failed to install docutil"
            return 2
        fi
    fi

    substep_info "removing existing dock items"
    dockutil --remove all --no-restart

    substep_info "adding Applications folder"
    dockutil --add '/Applications' --display folder --view list --section others --sort name --no-restart

    substep_info "adding Downloads folder"
    dockutil --add '~/Downloads' --display folder --view fan --section others --sort datemodified --no-restart

    substep_info "adding Outlook"
    dockutil --add '/Applications/Microsoft Outlook.app' --no-restart

    substep_info "adding Safari"
    dockutil --add /Applications/Safari.app --no-restart

    substep_info "adding Safari"
    dockutil --add /Applications/Slack.app --no-restart

    substep_info "adding Messages"
    dockutil --add /System/Applications/Messages.app --no-restart

    substep_info "adding Zoom"
    dockutil --add /Applications/zoom.us.app --no-restart

    substep_info "adding OmniFocus"
    dockutil --add /Applications/OmniFocus.app --no-restart

    substep_info "adding a spacer"
    dockutil --add '' --type spacer --section apps --no-restart

    substep_info "adding iTerm"
    dockutil --add /Applications/iTerm.app --no-restart

    substep_info "adding Tower"
    dockutil --add /Applications/Tower.app --no-restart

    substep_info "adding Xcode"
    dockutil --add /Applications/Xcode.app --no-restart

    substep_info "adding Visual Studio Code"
    dockutil --add '/Applications/Visual Studio Code.app' --no-restart

    substep_info "restarting dock"
    killall Dock
}

if set_dock; then
    success "successfully set up dock"
else
    error "failed setting up dock"
fi
