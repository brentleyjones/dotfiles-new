#!/usr/bin/env bash

set -uo pipefail

cd "${BASH_SOURCE[0]%/*}"

mkdir -p ~/Developer

./edit_sidebar.py
