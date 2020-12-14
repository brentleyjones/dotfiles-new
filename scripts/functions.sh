#!/bin/bash

info () {
  printf "\r  [ \033[00;34m..\033[0m ] $1\n"
}

substep_info () {
  printf "\r  [ \033[00;34m..\033[0m ] - $1\n"
}

user () {
  printf "\r  [ \033[0;33m??\033[0m ] $1\n"
}

substep_user () {
  printf "\r  [ \033[0;33m??\033[0m ] - $1\n"
}

success () {
  printf "\r\033[2K  [ \033[00;32mOK\033[0m ] $1\n"
}

substep_success () {
  printf "\r\033[2K  [ \033[00;32mOK\033[0m ] - $1\n"
}

error () {
  printf "\r\033[2K  [\033[0;31mFAIL\033[0m] $1\n"

  required="$2:-true"
  if [ "$required" == "true" ]; then
    echo ''
    exit 1
  fi
}

substep_error () {
  printf "\r\033[2K  [\033[0;31mFAIL\033[0m] - $1\n"
}

osx_realpath() {
  OURPWD=$PWD
  cd "$(dirname "$1")"
  LINK=$(readlink "$(basename "$1")")
  while [ "$LINK" ]; do
    cd "$(dirname "$LINK")"
    LINK=$(readlink "$(basename "$1")")
  done
  REALPATH="$PWD/$(basename "$1")"
  cd "$OURPWD"
  echo "$REALPATH"
}

overwrite_all=false backup_all=false skip_all=false

symlink () {
  local src=$1 dst=$2

  local overwrite= backup= skip=
  local action=

  if [ -f "$dst" -o -d "$dst" -o -L "$dst" ]; then

    if [ "$overwrite_all" == "false" ] && [ "$backup_all" == "false" ] && [ "$skip_all" == "false" ]; then

      local currentSrc="$(readlink "$dst")"

      if [ "$currentSrc" == "$src" ]; then
        skip=true;
      else
        substep_user "File already exists: $dst ($(basename "$src")), what do you want to do?\n\
        [s]kip, [S]kip all, [o]verwrite, [O]verwrite all, [b]ackup, [B]ackup all?"
        read -n 1 action < /dev/tty

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
    find -L "$1" -type l | while read fn; do
        if rm "$fn"; then
            substep_success "removed broken symlink at $fn"
        else
            substep_error "failed to remove broken symlink at $fn"
        fi
    done
}

# Took these printing functions from https://github.com/Sajjadhosn/dotfiles
coloredEcho() {
    local exp="$1";
    local color="$2";
    local arrow="$3";
    if ! [[ $color =~ '^[0-9]$' ]] ; then
       case $(echo $color | tr '[:upper:]' '[:lower:]') in
        black) color=0 ;;
        red) color=1 ;;
        green) color=2 ;;
        yellow) color=3 ;;
        blue) color=4 ;;
        magenta) color=5 ;;
        cyan) color=6 ;;
        white|*) color=7 ;; # white or invalid color
       esac
    fi
    tput bold;
    tput setaf "$color";
    echo "$arrow $exp";
    tput sgr0;
}
