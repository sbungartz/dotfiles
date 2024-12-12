#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title timelog.txt Current Activity
# @raycast.mode inline
# @raycast.refreshTime 10s

# Optional parameters:
# @raycast.icon 🤖

set -e -u -o pipefail

function timelog_script() {
  "$HOME/.dotfiles/scripts/timelog-txt.py" "$@"
}

echo -ne '\033[30m' # Make Text
timelog_script current-for-rofi
