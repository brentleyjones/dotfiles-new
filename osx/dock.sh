#!/usr/bin/env bash

set -euo pipefail

cd "${BASH_SOURCE[0]%/*}" || exit 1

source ../scripts/functions.sh

info "setting up the dock"

set_dock() {
    if test ! "$(which dockutil)"; then
        substep_error "dockutil not installed"
    fi

    substep_info "removing existing dock items"
    dockutil --remove all --no-restart

    substep_info "adding Applications folder"
    dockutil --add '/Applications' --display folder --view list --section others --sort name --no-restart

    substep_info "adding Downloads folder"
    dockutil --add '~/Downloads' --display folder --view fan --section others --sort datemodified --no-restart

    substep_info "adding Safari"
    dockutil --add /Applications/Safari.app --no-restart

    substep_info "adding Slack"
    dockutil --add /Applications/Slack.app --no-restart

    substep_info "adding Messages"
    dockutil --add /System/Applications/Messages.app --no-restart

    substep_info "adding Things 3"
    dockutil --add /Applications/Things3.app --no-restart

    substep_info "adding a spacer"
    dockutil --add '' --type spacer --section apps --no-restart

    substep_info "adding iTerm"
    dockutil --add /Applications/iTerm.app --no-restart

    substep_info "adding Tower"
    dockutil --add /Applications/Tower.app --no-restart

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
