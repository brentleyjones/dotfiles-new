#!/usr/bin/env bash
#
# bootstrap installs things.

set -e

cd "${BASH_SOURCE[0]%/*}"
DOTFILES_ROOT=$(pwd -P)

echo ''

source scripts/functions.sh

setup_gitconfig () {
  if ! [ -f git/gitconfig.symlink ]; then
    info 'setting up gitconfig'

    git_credential='cache'
    if [ "$(uname -s)" == "Darwin" ]; then
      git_credential='osxkeychain'
    fi

    user ' - What is your github author name?'
    read -er git_authorname
    user ' - What is your github author email?'
    read -er git_authoremail

    sed -e "s/AUTHORNAME/$git_authorname/g" -e "s/AUTHOREMAIL/$git_authoremail/g" -e "s/GIT_CREDENTIAL_HELPER/$git_credential/g" git/gitconfig.symlink.example > git/gitconfig.symlink

    success 'set up gitconfig'
  fi
}

install_dotfiles () {
  info 'installing dotfiles'

  for src in $(find -H "$DOTFILES_ROOT" -maxdepth 2 -name '*.symlink'); do
    dst="$HOME/.$(basename "${src%.*}")"
    symlink "$src" "$dst"
  done
}

info "prompting for sudo password"
if sudo -v; then
    # Keep-alive: update existing `sudo` time stamp until `bootstrap.sh` has finished
    while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &
    success "sudo credentials updated"
else
    error "failed to obtain sudo credentials"
fi

info "installing Xcode Command Line Tools"
if xcode-select --print-path &>/dev/null; then
    success "Xcode Command Line Tools already installed"
elif xcode-select --install &>/dev/null; then
    success "finished installing Xcode Command Line Tools"
else
    error "failed to install Xcode Command Line Tools"
fi

setup_gitconfig
install_dotfiles

# Package control must be executed first in order for the rest to work
./packages/setup.sh

# Run the rest of the setups
find . -name "setup.sh" -not -wholename "packages*" | cut -c3- | while read -r setup; do
    "./$setup" || true
done

echo ''
echo '  All installed!'
