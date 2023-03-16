#!/usr/bin/env python3

import os
from os.path import expanduser
import re
import itertools
from datetime import datetime
import sys

timelog_path = expanduser("~/Notes/log/timelog.txt")

def pairwise(iterable):
  # pairwise('ABCDEFG') --> AB BC CD DE EF FG
  a, b = itertools.tee(iterable)
  next(b, None)
  return zip(a, b)

def unique_preserving_order(items):
  return list(dict.fromkeys(items))

class TimeLogEntry:
  def __init__(self, started_at, finished_at, activity, project, original_text):
    self.started_at = started_at
    self.finished_at = finished_at
    self.activity = activity
    self.project = project
    self.original_text = original_text

  def __repr__(self) -> str:
    return f'TimeLogEntry(started_at={self.started_at}, finished_at={self.finished_at}, activity={self.activity}, project={self.project}, original_text={self.original_text})'

REGEX_ENTRY = re.compile('^(\d\d\d\d-\d\d-\d\d \d\d:\d\d:\d\d) (.*)$')
def parse_entry(line_entry, line_next):
  match_entry = REGEX_ENTRY.match(line_entry)
  match_next = REGEX_ENTRY.match(line_next)

  if match_entry is None:
    return None

  started_at = datetime.strptime(match_entry.group(1), '%Y-%m-%d %H:%M:%S')
  finished_at = datetime.strptime(match_next.group(1), '%Y-%m-%d %H:%M:%S') if match_next is not None else None
  original_text = match_entry.group(2)

  if original_text == "STOP":
    return None

  original_text_split = original_text.split("@")
  activity = original_text_split[0]
  project = "@".join(original_text_split[1:])

  return TimeLogEntry(started_at, finished_at, activity, project, original_text)

def read_all():
  with open(expanduser(timelog_path), 'r') as f:
    lines = itertools.chain((line.strip() for line in f), [''])
    for (line_entry, line_next) in pairwise(lines):
      entry = parse_entry(line_entry, line_next)
      if entry is not None:
        yield entry

def recent_entry_texts():
  entries = [entry.original_text for entry in read_all()]
  entries.reverse()
  return unique_preserving_order(entries)

command = sys.argv[1] if len(sys.argv) >= 2 else None
if command == "recent-entries":
  for line in recent_entry_texts():
    print(line)
else:
  print(list(read_all()))
