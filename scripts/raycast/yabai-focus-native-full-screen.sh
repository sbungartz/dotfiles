#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title yabai: Focus the (only) native full screen window
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🖥️

set -e -u -o pipefail

window_id="$(yabai -m query --windows | jq -r '.[] | select(.["is-native-fullscreen"] == true) | .id' | head -n 1)"

if [ -n "$window_id" ]; then
  yabai -m window --focus "$window_id"
fi
