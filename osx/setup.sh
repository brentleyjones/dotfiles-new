#!/usr/bin/env bash

set -euo pipefail

cd "${BASH_SOURCE[0]%/*}" || exit 1

# Defaults for the system and all apps
./defaults.sh

# Setup finder sidebar
mkdir -p ~/Developer
./edit_sidebar.py

# Setup dock
./dock.sh
