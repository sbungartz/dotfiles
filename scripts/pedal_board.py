#!/usr/bin/env python3
# Required packages:
# sudo apt install python3-mido python3-rtmidi

import threading
import time
import mido
import os
import sys

print(mido.get_input_names())

input_name = 'PACER:PACER MIDI 1'

scrolls_per_second = 0
last_scroll_at = None

def scroll_once():
  mouse_button = 5 if scrolls_per_second > 0 else 4
  # os.system(f"xdotool mousedown {mouse_button}")
  # os.system(f"xdotool mouseup {mouse_button}")
  os.system(f"xdotool click {mouse_button}")

def scroll_if_necessary():
  global last_scroll_at
  global scrolls_per_second

  if scrolls_per_second == 0:
    last_scroll_at = None
    return

  now = time.monotonic()
  if last_scroll_at is None:
    last_scroll_at = now
    return

  seconds_per_scroll = 1 / abs(scrolls_per_second)
  scrolls_needed = (now - last_scroll_at) / seconds_per_scroll
  scrolls_to_perform = int(scrolls_needed)

  for i in range(scrolls_to_perform):
    scroll_once()

  last_scroll_at += scrolls_to_perform * seconds_per_scroll

def scroll_loop():
  global scrolls_per_second
  while True:
    scroll_if_necessary()
    sleep_time = 0.8 if scrolls_per_second == 0 else 0.05
    time.sleep(sleep_time)

scroll_thread = threading.Thread(target=scroll_loop, daemon=True)
# scroll_thread.start()

mode = 'bidirectional'

pedal_mute_toggle = False

pedal_names_for_cc = {
  64: '1',
  65: '2',
  66: '3',
  67: '4',
}

keys_for_cc = {
  64: 'F1',
  65: 'F2',
  66: 'F3',
  67: 'F4',
  # 68: 'F5', # pedal for pedal.py
  # 69: 'F6', # pedal_mute_toggle handled specially below
}

with mido.open_input(input_name) as port:
  for message in port:
    # print(message)
    if message.type == 'control_change' and message.control == 11:
      if mode == 'single':
        scrolls_per_second = (message.value / 127) * 25
      elif mode == 'bidirectional':
        half = 127 / 2
        inverted_polarity = 127 - message.value
        converted_value = (inverted_polarity - half) / half
        if abs(converted_value) < 0.2:
          scrolls_per_second = 0
        else:
          scrolls_per_second = converted_value * 10
        print(f'{message.value} -> {inverted_polarity} -> {converted_value} -> {scrolls_per_second}')
    elif message.type == 'control_change' and message.control == 69 and message.value > 63:
      print('pedal down')
      if pedal_mute_toggle:
        print('pedal mute toggle')
        os.system('xdotool key super+ctrl+shift+alt+F12')
      else:
        print('pedal mute')
        os.system('xdotool key super+ctrl+shift+alt+F6')
      pedal_mute_toggle = not pedal_mute_toggle
    elif message.type == 'control_change' and message.control in pedal_names_for_cc:
      key = pedal_names_for_cc[message.control]
      #print(f'pressing combo with {key}')
      #os.system(f'xdotool keydown super+ctrl+shift+alt+{key}')
      #os.system(f'xdotool keyup super+ctrl+shift+alt+{key}')
      os.system(f'echo "actions.user.pedal_board_pedal_action(\'{key}\', { message.value > 63 })" | ~/.talon/bin/repl')
