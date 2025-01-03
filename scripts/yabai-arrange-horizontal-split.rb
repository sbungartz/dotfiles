#!/usr/bin/env ruby

require "json"

LAYOUTS = {
  half_half: ["left-half", "right-half"],
  large_small: ["first-two-thirds", "last-third"],
  small_large: ["first-third", "last-two-thirds"],
}

def classify_ratio(ratio)
  case ratio
  when 0.30..0.38
    :one_third
  when 0.48..0.52
    :half
  when 0.65..0.68
    :two_thirds
  else
    :unknown
  end
end

def classify_layout(focused_ratio, other_ratio, focused_window_left_of_other)
  left_ratio = focused_window_left_of_other ? focused_ratio : other_ratio
  right_ratio = focused_window_left_of_other ? other_ratio : focused_ratio
  left_class = classify_ratio(left_ratio)
  right_class = classify_ratio(right_ratio)
  if left_class == :one_third && right_class == :two_thirds
    :small_large
  elsif left_class == :two_thirds && right_class == :one_third
    :large_small
  elsif left_class == :half && right_class == :half
    :half_half
  else
    :unknown
  end
end

def layout_sequence(target_split_direction)
  # Make focused side large at first
  if target_split_direction == :left
    [:half_half, :large_small, :small_large]
  else
    [:half_half, :small_large, :large_small]
  end
end

def find_next_layout(current_layout, target_split_direction)
  sequence = layout_sequence(target_split_direction)
  current_layout_index = sequence.index(current_layout)
  return sequence.first if current_layout_index.nil?
  sequence[(current_layout_index + 1) % sequence.size]
end

def mirror_layout(current_layout)
  case current_layout
  when :large_small
    :small_large
  when :small_large
    :large_small
  else
    :half_half
  end
end

direction = ARGV[0]
raise "Invalid direction: #{direction}" unless ["left", "right"].include?(direction)
direction = direction.to_sym

displays = JSON.parse(`yabai -m query --displays`)
windows = JSON.parse(`yabai -m query --windows`)

focused_window = windows.first
raise "First window does not have focus" unless focused_window.fetch("has-focus") == true

focused_display_index = focused_window.fetch("display")

windows_on_same_display = windows.select { |window| window.fetch("display") == focused_display_index }
other_window = windows_on_same_display[1]

focused_display = displays.find { |display| display.fetch("index") == focused_display_index }
display_width = focused_display.fetch("frame").fetch("w")

focused_window_ratio = focused_window.fetch("frame").fetch("w") / display_width
other_window_ratio = other_window.fetch("frame").fetch("w") / display_width
focused_window_left_of_other = focused_window.fetch("frame").fetch("x") < other_window.fetch("frame").fetch("x")

current_layout = classify_layout(focused_window_ratio, other_window_ratio, focused_window_left_of_other)
next_layout = find_next_layout(current_layout, direction)

if current_layout != :unknown
  focused_window_in_target_direction = direction == :left ? focused_window_left_of_other : !focused_window_left_of_other
  unless focused_window_in_target_direction
    next_layout = mirror_layout(current_layout)
  end
end

left_command, right_command = LAYOUTS.fetch(next_layout)


# Focus other window
`yabai -m window --focus #{other_window.fetch("id")}`

# Resize window using the non target side command
`open -g raycast://extensions/raycast/window-management/#{direction == :left ? right_command : left_command}`

# Focus original window
`yabai -m window --focus #{focused_window.fetch("id")}`

# Resize window using the target side command
`open -g raycast://extensions/raycast/window-management/#{direction == :left ? left_command : right_command}`
