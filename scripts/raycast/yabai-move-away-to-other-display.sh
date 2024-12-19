#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title yabai: Move window away to other display
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🖥️

set -e -u -o pipefail

# Move focused window to other display
open -g raycast://extensions/raycast/window-management/next-display
sleep 0.3

# Bring focus back to original display
yabai -m display --focus recent
