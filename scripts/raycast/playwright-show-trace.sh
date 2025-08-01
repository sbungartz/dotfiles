#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Playwright Show Trace
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🎭

export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"
npx playwright show-trace
