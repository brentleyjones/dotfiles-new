#!/usr/bin/env bash
#
# Run all dotfiles backups.

set -e

cd "$(dirname "$0")"

# find the backups and run them iteratively
find . -name backup.sh | while read backup ; do sh -c "${backup}" ; done
