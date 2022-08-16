#!/usr/bin/env python3
# Required packages:
# sudo apt install python3-mido python3-rtmidi

import mido
import os

print(mido.get_input_names())

input_name = 'MPK mini 3:MPK mini 3 MIDI 1'

class Mode:
    def __init__(self):
        self.on_launch = r"./toggle-pulseaudio-recording-streams.py mute-only 'voice activity' 'noise recognition'"
        self.on_down = r"./toggle-pulseaudio-recording-streams.py mute-all-except 'voice activity' 'noise recognition'"
        self.on_up = r"./toggle-pulseaudio-recording-streams.py mute-only 'voice activity' 'noise recognition'"
        self.on_exit = r"./toggle-pulseaudio-recording-streams.py mute-only"

mode = Mode()

print('running on_launch command')
os.system(mode.on_launch)

try:
    with mido.open_input(input_name) as port:
        for message in port:
            print(message)
            if message.type == 'control_change' and message.control == 64:
                if message.value > 63:
                    print('pedal down')
                    os.system(mode.on_down)
                else:
                    print('pedal up')
                    os.system(mode.on_up)
finally:
    print('running on_exit command')
    os.system(mode.on_exit)