#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title yabai: Display focus recent
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🖥️

set -e -u -o pipefail

yabai -m display --focus recent
