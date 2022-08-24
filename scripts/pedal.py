#!/usr/bin/env python3
# Required packages:
# sudo apt install python3-mido python3-rtmidi

from typing import NamedTuple
import signal
import time
import mido
import os
import sys

print(mido.get_input_names())

input_name = 'MPK mini 3:MPK mini 3 MIDI 1'
scripts_folder = os.path.expanduser('~/.dotfiles/scripts')

class PIDLock:
    def __init__(self):
        self.pid_file = os.path.expanduser('~/.config/pedal_actions.pid')

    def __enter__(self):
        signal.signal(signal.SIGTERM, self.handle_sigterm)
        # If another instance is already running, kill at first and wait for it to stop.
        while self.other_instance_running():
            self.interrupt_other()
            time.sleep(0.3)
        self.write_own_pid_file()
        return self

    def __exit__(self, type, value, traceback):
        self.clear_pid_file()

    def handle_sigterm(self, *args):
        # Raise InterruptedError on SIGTERM to exit gracefully using finally
        raise InterruptedError

    def other_instance_running(self):
        return os.path.exists(self.pid_file)

    def interrupt_other(self):
        try:
            other_pid = self.load_other_pid()
            # Use SIGTERM since SIGINT since it is not received when launched by talon for some reason
            os.kill(other_pid, signal.SIGTERM)
        except ProcessLookupError:
            # If the process is no longer running, just delete the file.
            self.clear_pid_file()

    def load_other_pid(self):
        with open(self.pid_file, 'r') as file:
            return int(file.read())
    
    def write_own_pid_file(self):
        with open(self.pid_file, 'x') as file:
            file.write(str(os.getpid()))

    def clear_pid_file(self):
        os.remove(self.pid_file)
    
class Mode(NamedTuple):
    on_launch: str = ''
    on_down: str = ''
    on_up: str = ''
    on_exit: str = ''

def get_mode_by_name(name):
    if name == 'off':
        return Mode()
    elif name == 'mute-toggle':
        return Mode(
            on_launch = f"{scripts_folder}/toggle-pulseaudio-recording-streams.py mute-only 'voice activity' 'noise recognition'",
            on_down = f"{scripts_folder}/toggle-pulseaudio-recording-streams.py mute-all-except 'voice activity' 'noise recognition'",
            on_up = f"{scripts_folder}/toggle-pulseaudio-recording-streams.py mute-only 'voice activity' 'noise recognition'",
            on_exit = f"{scripts_folder}/toggle-pulseaudio-recording-streams.py mute-only",
        )
    elif name == 'mute-talon':
        return Mode(
            on_launch = f"{scripts_folder}/toggle-pulseaudio-recording-streams.py mute-only 'voice activity' 'noise recognition'",
            on_down = f"{scripts_folder}/toggle-pulseaudio-recording-streams.py mute-only",
            on_up = f"{scripts_folder}/toggle-pulseaudio-recording-streams.py mute-only 'voice activity' 'noise recognition'",
            on_exit = f"{scripts_folder}/toggle-pulseaudio-recording-streams.py mute-only",
        )
    elif name == 'mouse':
        return Mode(
            on_launch = f"echo none",
            on_down = f"xdotool mousedown 1",
            on_up = f"xdotool mouseup 1",
            on_exit = f"echo none",
        )
    else:
        raise AttributeError(f"Unknown mode {name}")

if len(sys.argv) < 2:
    print("Missing mode name.")
    exit(1)

mode_name = sys.argv[1]
mode = get_mode_by_name(mode_name)

with PIDLock():
    if mode_name == 'off':
        exit(0)

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