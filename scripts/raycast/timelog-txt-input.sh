#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title timelog.txt Input
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🤖

set -e -u -o pipefail

BLOCK_BUTTON=1 "$HOME/.dotfiles/scripts/blocklets/timelog_txt"
