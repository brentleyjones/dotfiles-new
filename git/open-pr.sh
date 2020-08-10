#!/bin/sh

_get_host_and_repo() {
  echo "$1" | sed -E "s/.git$//g;s/(git@|https?:\/\/)(.*)[:\/](.*\/.*)/\2\/\3/g"
}

_build_url() {
  # shellcheck disable=SC2039
  local branch host_and_repo url
  url="$(git ls-remote --get-url)"
  branch="$(git symbolic-ref --short HEAD)"
  host_and_repo="$(_get_host_and_repo "$url")"
  echo "https://$host_and_repo/pull/new/$branch"
}

# shellcheck disable=SC2039
open-pr() {
  # shellcheck disable=SC2039
  local url
  url="$(_build_url "$*")"
  if [ "$(uname -s)" = "Darwin" ]; then
    echo "Opening $url in browser"
    open "$url" 2> /dev/null
  else
    xdg-open "$url" > /dev/null 2> /dev/null
  fi
}
