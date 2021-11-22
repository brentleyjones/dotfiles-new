#!/usr/bin/env bash

set -euo pipefail

cd "${BASH_SOURCE[0]%/*}" || exit 1

source ../scripts/functions.sh

src="$(osx_realpath plugins)"
dst="$(osx_realpath "$HOME/bitbar-plugins")"

info "setting up bitbar"
mkdir -p "$dst"

plugins=()
while IFS=  read -r -d $'\0'; do
    plugins+=("${REPLY#plugins/}")
done < <(find plugins -type f -print0)

for plugin in "${plugins[@]}"; do
  example="$src/$plugin"
  final="$dst/$plugin"
  if [[ -f "$final" ]]; then
    substep_success "$plugin already setup"
  else
    placeholders=()
    while IFS=  read -r; do
      placeholders+=("$REPLY")
    done < <(sed -n 's/.*__REPLACE_\(.*\)__.*/\1/p' "$example")

    if [[ "${#placeholders[@]}" -eq 0 ]]; then
      cp "$example" "$final"
    else
      substep_info "gathering replacements for $plugin"
      args=()
      for placeholder in "${placeholders[@]}"; do
        user " - $placeholder"
        read -er replacement
        args+=("-e" "s/__REPLACE_${placeholder}__/$replacement/g")
      done

      sed "${args[@]}" "$example" > "$final"
    fi
    chmod +x "$final"

    substep_success "set up $plugin"
  fi
done
