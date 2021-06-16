#!/bin/bash

set -eu

export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-"$HOME"/.config}"

info () {
  # shellcheck disable=SC2059
  printf "\r  [ \033[00;34m..\033[0m ] $1\n"
}

substep_info () {
  # shellcheck disable=SC2059
  printf "\r  [ \033[00;34m..\033[0m ] - $1\n"
}

user () {
  # shellcheck disable=SC2059
  printf "\r  [ \033[0;33m??\033[0m ] $1\n"
}

substep_user () {
  # shellcheck disable=SC2059
  printf "\r  [ \033[0;33m??\033[0m ] - $1\n"
}

success () {
  # shellcheck disable=SC2059
  printf "\r\033[2K  [ \033[00;32mOK\033[0m ] $1\n"
}

substep_success () {
  # shellcheck disable=SC2059
  printf "\r\033[2K  [ \033[00;32mOK\033[0m ] - $1\n"
}

error () {
  # shellcheck disable=SC2059
  printf "\r\033[2K  [\033[0;31mFAIL\033[0m] $1\n"

  required="${2:-true}"
  if [ "$required" == "true" ]; then
    echo ''
    exit 1
  fi
}

substep_error () {
  # shellcheck disable=SC2059
  printf "\r\033[2K  [\033[0;31mFAIL\033[0m] - $1\n"
}

osx_realpath() {
  OURPWD=$PWD
  cd "$(dirname "$1")" || exit 1
  LINK=$(readlink "$(basename "$1")")
  while [ "$LINK" ]; do
    cd "$(dirname "$LINK")" || exit 1
    LINK=$(readlink "$(basename "$1")")
  done
  REALPATH="$PWD/$(basename "$1")"
  cd "$OURPWD" || exit 1
  echo "$REALPATH"
}

overwrite_all=false backup_all=false skip_all=false

symlink () {
  local src=$1 dst=$2

  local overwrite='' backup='' skip=''
  local action=

  if [ -f "$dst" ] || [ -d "$dst" ] || [ -L "$dst" ]; then

    if [ "$overwrite_all" == "false" ] && [ "$backup_all" == "false" ] && [ "$skip_all" == "false" ]; then

      local currentSrc
      currentSrc="$(readlink "$dst")"

      if [ "$currentSrc" == "$src" ]; then
        skip=true;
      else
        substep_user "File already exists: $dst ($(basename "$src")), what do you want to do?\n\
        [s]kip, [S]kip all, [o]verwrite, [O]verwrite all, [b]ackup, [B]ackup all?"
        read -r -n 1 action < /dev/tty

        case "$action" in
          o )
            overwrite=true;;
          O )
            overwrite_all=true;;
          b )
            backup=true;;
          B )
            backup_all=true;;
          s )
            skip=true;;
          S )
            skip_all=true;;
          * )
            ;;
        esac
      fi
    fi

    overwrite=${overwrite:-$overwrite_all}
    backup=${backup:-$backup_all}
    skip=${skip:-$skip_all}

    if [ "$overwrite" == "true" ]; then
      rm -rf "$dst"
      substep_success "removed $dst"
    fi

    if [ "$backup" == "true" ]; then
      mv "$dst" "${dst}.backup"
      substep_success "moved $dst to ${dst}.backup"
    fi

    if [ "$skip" == "true" ]; then
      substep_success "skipped $src"
    fi
  fi

  if [ "$skip" != "true" ]  # "false" or empty
  then
    ln -s "$1" "$2"
    substep_success "linked $1 to $2"
  fi
}

clear_broken_symlinks() {
    find -L "$1" -type l | while read -r fn; do
        if rm "$fn"; then
            substep_success "removed broken symlink at $fn"
        else
            substep_error "failed to remove broken symlink at $fn"
        fi
    done
}
