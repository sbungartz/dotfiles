#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title timelog.txt Report
# @raycast.mode fullOutput

# Optional parameters:
# @raycast.icon 🤖

set -e -u -o pipefail

function timelog_script() {
  "$HOME/.dotfiles/scripts/timelog-txt.py" "$@"
}

timelog_script current-report
