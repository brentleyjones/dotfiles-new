#!/usr/bin/env bash

set -euo pipefail

cd "${BASH_SOURCE[0]%/*}" || exit 1

source ../scripts/functions.sh

mkdir -p "$XDG_CONFIG_HOME"

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

# Symlink for VS Code settings.json
if [[ "$(uname -m)" == "arm64" ]]; then
    mkdir -p "/usr/local/bin"
    symlink "/opt/homebrew/bin/nvim" "/usr/local/bin/vscode-nvim"
else
    symlink "/usr/local/bin/nvim" "/usr/local/bin/vscode-nvim"
fi

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
