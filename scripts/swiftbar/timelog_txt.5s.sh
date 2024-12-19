#!/usr/bin/env bash
set -e -u -o pipefail

function timelog_script() {
  "$HOME/.dotfiles/scripts/timelog-txt.py" "$@"
}

timelog_script current-for-swiftbar
