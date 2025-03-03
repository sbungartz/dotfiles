#!/usr/bin/env ruby

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title yabai: Maximise last two windows (unsplit)
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🖥️

require "json"

windows = JSON.parse(`yabai -m query --windows`)

focused_window = windows.first
raise "First window does not have focus" unless focused_window.fetch("has-focus") == true

focused_display = focused_window.fetch("display")

windows_on_same_display = windows.select { |window| window.fetch("display") == focused_display }
other_window = windows_on_same_display[1]

# Focus other window
`yabai -m window --focus #{other_window.fetch("id")}`

# Move window to other display
`open -g raycast://extensions/raycast/window-management/maximize`

# Focus original window
`yabai -m window --focus #{focused_window.fetch("id")}`

# Move window to left half
`open -g raycast://extensions/raycast/window-management/maximize`
