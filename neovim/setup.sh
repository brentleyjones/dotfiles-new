#!/usr/bin/env bash

set -uo pipefail

cd "${BASH_SOURCE[0]%/*}" || exit 1

source ../scripts/functions.sh

src="$(osx_realpath .)"
dst="$(osx_realpath "$XDG_CONFIG_HOME/nvim")"

info "setting up neovim"

substep_info "creating config folders"
mkdir -p "$dst/lua"

substep_info "creating symlinks"
find . -not -name 'setup.sh' -type f  | cut -c3- | while read -r fn; do
    symlink "$src/$fn" "$dst/$fn"
done
clear_broken_symlinks "$dst"

packer="$HOME/.local/share/nvim/site/pack/packer/start/packer.nvim"
if [ ! -d "$packer" ]; then
    substep_info "installing packer.nvim"

    git clone https://github.com/wbthomason/packer.nvim "$packer"

    substep_info "installing plugins"
    nvim -u NONE --headless +luafile\ lua/plugins.lua +PackerCompile +PackerInstall +qa
else
    substep_info "updating plugins"
    nvim -u NONE --headless +luafile\ lua/plugins.lua +PackerUpdate +qa
fi
