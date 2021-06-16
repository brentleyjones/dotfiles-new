#!/usr/bin/env bash
#
# Run all dotfiles installers.

set -e

cd "${BASH_SOURCE[0]%/*}" || exit 1

# find the installers and run them iteratively
find . -name setup.sh | while read setup ; do sh -c "${setup}" ; done
