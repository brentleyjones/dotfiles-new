#!/usr/bin/env bash
#
# Run all dotfiles backups.

set -e

cd "${BASH_SOURCE[0]%/*}" || exit 1

# find the backups and run them iteratively
find . -name backup.sh -not -path './backup.sh' | while read -r backup ; do sh -c "${backup}" ; done
