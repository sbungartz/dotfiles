#!/usr/bin/env python3
# Required packages:
# sudo pip3 install pulsectl

import pulsectl
import sys

class Mode:
    def __init__(self, mode, stream_names):
        self.mode = mode
        self.stream_names = stream_names
    
    def should_mute(self, stream):
        if self.mode == 'mute-only':
            return stream.name in self.stream_names
        elif self.mode == 'mute-all-except':
            return not stream.name in self.stream_names
        else:
            raise 'unknown mode'

def build_handler():
    if len(sys.argv) < 2:
        print('No command provided. Provide one of these commands:')
        print('  mute-only [stream name]...')
        print('  mute-all-except [stream name]...')
        exit(1)

    command = sys.argv[1]
    stream_names = sys.argv[2:]
    return Mode(command, stream_names)

pulse = pulsectl.Pulse()
handler = build_handler()

for stream in pulse.source_output_list():
    should_mute = handler.should_mute(stream)
    print(should_mute)
    pulse.mute(stream, 1 if should_mute else 0)
