#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import os
from os.path import expanduser
import re
import itertools
from datetime import datetime, timedelta
import sys

timelog_path = expanduser("~/Notes/log/timelog.txt")

TIME_FORMAT = '%Y-%m-%d %H:%M:%S'

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

  started_at = datetime.strptime(match_entry.group(1), TIME_FORMAT)
  finished_at = datetime.strptime(match_next.group(1), TIME_FORMAT) if match_next is not None else None
  original_text = match_entry.group(2)

  if original_text == "STOP":
    return None

  original_text_split = original_text.split("@")
  activity = original_text_split[0]
  project = "@".join(original_text_split[1:])
  if len(project) == 0:
    project = None

  return TimeLogEntry(started_at, finished_at, activity, project, original_text)


# Loading and subsets
def read_all():
  with open(expanduser(timelog_path), 'r') as f:
    lines = itertools.chain((line.strip() for line in f), [''])
    for (line_entry, line_next) in pairwise(lines):
      entry = parse_entry(line_entry, line_next)
      if entry is not None:
        yield entry

def recent_entries():
  entries = [entry for entry in read_all()]
  entries.reverse()
  return entries

def find_last_entry():
  return list(read_all())[-1]

def find_todays_entries():
  return filter_entries_of_today(read_all())

def find_entries_like(other_entry):
  return [entry for entry in read_all() if entry.original_text == other_entry.original_text]

def filter_entries_of_today(entries):
  return [entry for entry in entries if entry.started_at.date() == datetime.today().date()]

def current_activity():
  last_entry = find_last_entry()
  if last_entry is None:
    return None

  if last_entry.finished_at is not None:
    return None

  return last_entry

# Recent field extractions
def recent_entry_texts():
  recent_texts = [entry.original_text for entry in recent_entries()]
  return unique_preserving_order(recent_texts)

def recent_projects():
  recent_projects = [entry.project for entry in recent_entries()]
  return unique_preserving_order(recent_projects)

# Field calculations
def get_project_icon(entry):
  if entry.project is None:
    return None

  # The last character of the project may be an icon
  last_project_char = entry.project[-1]
  # Treat characters in the Unicode Private Use Area as icons (works for font awesome)
  if last_project_char >= u'\ue000' and last_project_char <= u'\uf8ff':
    return last_project_char
  else:
    return None

def get_ticket_number(entry):
  tp_reference_match = re.match('^tp-([0-9]+) ', entry.activity)
  if tp_reference_match:
    return f'#{tp_reference_match.group(1)}'
  else:
    return None

def compute_duration(entry):
  started_at = entry.started_at
  finished_at = entry.finished_at or datetime.now()
  return finished_at - started_at

def sum_entry_durations(entries):
  return sum_durations([compute_duration(entry) for entry in entries])

def sum_durations(durations):
  return sum(durations, timedelta(0))

# Output
def print_as_lines(items):
  for item in items:
    print(item)

# Formatting
def format_duration(duration_timedelta):
  total_seconds = round(duration_timedelta.total_seconds())
  hours, remainder = divmod(total_seconds, 3600)
  minutes, _seconds = divmod(remainder, 60)
  return f'{hours:02d}:{minutes:02d}'

# Very special functions
def print_current_activity_for_blocklet():
  entry = current_activity()
  if entry is None:
    longtext = u''
    shorttext = longtext
    color = '#a0a0a0'
  else:
    icon = get_project_icon(entry) or u''
    ticket_number = get_ticket_number(entry) or ''
    time_separator = '' if ticket_number == '' else ' - '
    duration = compute_duration(entry)

    longtext = f'{icon} {ticket_number}{time_separator}{format_duration(duration)}'
    shorttext = longtext
    color = '#ffffff'
  print(longtext)
  print(shorttext)
  print(color)

def print_current_activity_for_rofi():
  entry = current_activity()
  if entry is None:
    print('STOP')
  else:
    print(f'{entry.original_text} ({format_duration(compute_duration(entry))})')

def print_last_entry_stop_time():
  entry = find_last_entry()
  print(f'{entry.finished_at}')

def print_current_activity_report():
  last_entry = find_last_entry()
  print(f'Since {last_entry.started_at.strftime("%H:%M")}: {last_entry.original_text}')
  print(f'Current duration: {format_duration(compute_duration(last_entry))}')

  entries_for_activity = find_entries_like(last_entry)
  print(f'Worked on this today for: {format_duration(sum_entry_durations(filter_entries_of_today(entries_for_activity)))}')
  print(f'Worked on this in total for: {format_duration(sum_entry_durations(entries_for_activity))}')

  print('')
  print(f'Logged today for: {format_duration(sum_entry_durations(find_todays_entries()))}')

# Editing
def start_new_activity(activity_text, started_at):
  line = f'{started_at.strftime(TIME_FORMAT)} {activity_text}\n'
  with open(timelog_path, 'a') as f:
    f.write(line)

def start_new_activity_now(activity_text):
  start_new_activity(activity_text, datetime.now())

def start_new_activity_since_last_stop(activity_text):
  last_entry = find_last_entry()
  if last_entry is None or last_entry.finished_at is None:
    start_new_activity_now(activity_text)
  else:
    with open(timelog_path, 'rb+') as f:
      f.seek(0, 2)
      f.seek(-5, 2) # Replace the trailing STOP\n with the new test, keeping its timestamp
      if str(f.peek(5), 'utf-8') != 'STOP\n':
        raise RuntimeError("Unexpected file situation")
      f.write(bytes(f'{activity_text}\n', 'utf-8'))

def stop_current_activity():
  if current_activity() is not None:
    start_new_activity_now("STOP")

# CLI Commands
command = sys.argv[1] if len(sys.argv) >= 2 else None
if command == "recent-entries":
  print_as_lines(recent_entry_texts())
elif command == "recent-projects":
  print_as_lines(recent_projects())
elif command == "current":
  print(current_activity() or "STOP")
elif command == "current-for-blocklet":
  print_current_activity_for_blocklet()
elif command == "current-report":
  print_current_activity_report()
elif command == "current-for-rofi":
  print_current_activity_for_rofi()
elif command == "last-stop-time":
  print_last_entry_stop_time()
elif command == "start-now":
  start_new_activity_now(' '.join(sys.argv[2:]))
elif command == "start-since-last-stop":
  start_new_activity_since_last_stop(' '.join(sys.argv[2:]))
elif command == "stop":
  stop_current_activity()
else:
  print(list(read_all()))
