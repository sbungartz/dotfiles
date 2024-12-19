#!/usr/bin/env ruby

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title yabai: Swap windows between displays and focus other window
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🖥️

require "json"

windows = JSON.parse(`yabai -m query --windows`)

focused_window = windows.first
raise "First window does not have focus" unless focused_window.fetch("has-focus") == true

focused_display = focused_window.fetch("display")

windows_on_other_display = windows.select { |window| window.fetch("display") != focused_display }
other_window = windows_on_other_display.first

# Focused window keeps focus and gets moved first

# Move window to other display
`open -g raycast://extensions/raycast/window-management/next-display`
sleep(0.3)

# Focus other window
`yabai -m window --focus #{other_window.fetch("id")}`
sleep(0.1)

# Move window to other display
`open -g raycast://extensions/raycast/window-management/next-display`
