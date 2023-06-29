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
  os.system(f"xdotool mousedown {mouse_button}")
  os.system(f"xdotool mouseup {mouse_button}")

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
  while True:
    scroll_if_necessary()
    time.sleep(0.05)

scroll_thread = threading.Thread(target=scroll_loop, daemon=True)
scroll_thread.start()

mode = 'bidirectional'

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
