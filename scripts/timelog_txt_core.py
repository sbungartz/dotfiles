from os.path import expanduser
import re
import itertools
from collections import defaultdict
from datetime import datetime, date, timedelta
import json

timelog_path = expanduser("~/Meins/Notizen/log/timelog.txt")
icon_config_path = expanduser("~/.config/timelog-txt/project-icons.json")
targets_path = expanduser("~/.config/timelog-txt/project-targets.json")

TIME_FORMAT = '%Y-%m-%d %H:%M:%S'

def pairwise(iterable):
  # pairwise('ABCDEFG') --> AB BC CD DE EF FG
  a, b = itertools.tee(iterable)
  next(b, None)
  return zip(a, b)

def unique_preserving_order(items):
  return list(dict.fromkeys(items))

class InvalidLogDataException(Exception):
  def __init__(self, errors):
    self.errors = errors
    super().__init__("There are errors in the timelog file")

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

def read_project_targets():
  with open(expanduser(targets_path), 'r') as f:
    return json.load(f)

def recent_entries():
  entries = [entry for entry in read_all()]
  entries.reverse()
  return entries

def find_last_entry():
  return list(read_all())[-1]

def find_todays_entries():
  return find_day_entries(date.today())

def find_day_entries(day):
  return filter_entries_of_day(read_all(), day)

def find_this_weeks_entries():
  return filter_entries_of_week(read_all(), date.today())

def find_entries_like(other_entry):
  return [entry for entry in read_all() if entry.original_text == other_entry.original_text]

def filter_entries_of_day(entries, day):
  return [entry for entry in entries if entry.started_at.date() == day]

def filter_entries_of_week(entries, day):
  iso_year_and_week = day.isocalendar()[:2]
  return [entry for entry in entries if entry.started_at.isocalendar()[:2] == iso_year_and_week]

def filter_entries_with_project(entries, project):
  return [entry for entry in entries if entry.project == project]

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

  with open(expanduser(icon_config_path), 'r') as f:
    icon_for_project = json.load(f)

  # Get icon if available or return None
  return icon_for_project.get(entry.project)

  # The last character of the project may be an icon
  last_project_char = entry.project[-1]
  # Treat characters in the Unicode Private Use Area as icons (works for font awesome)
  # or: Emoji can also be icons, this does not match all emoji yet however.
  if last_project_char >= u'\ue000' and last_project_char <= u'\uf8ff' or last_project_char >= u'\U0001f300' and last_project_char <= u'\U0001f5ff':
    return last_project_char
  else:
    return None

def get_ticket_number(entry):
  tp_reference_match = re.match('^([A-Za-z]+)-([0-9]+) ', entry.activity)
  if tp_reference_match:
    return f'{tp_reference_match.group(0)}'.strip()
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

def sum_entry_durations_by_text(entries):
  durations_by_text = defaultdict(timedelta)
  for entry in entries:
    durations_by_text[entry.original_text] += compute_duration(entry)
  return dict(durations_by_text)

def validate_entries(entries):
  errors = []
  for entry in entries:
    if compute_duration(entry) < timedelta(0):
      errors.append(f'Negative duration in entry {entry.started_at.strftime("%H:%M")} {entry.original_text}!')
  return errors

# Output
def print_as_lines(items):
  for item in items:
    print(item)

# Formatting
def format_duration(duration_timedelta, include_seconds=False):
  total_seconds = round(duration_timedelta.total_seconds())
  sign = '-' if total_seconds < 0 else ''
  hours, remainder = divmod(abs(total_seconds), 3600)
  minutes, seconds = divmod(remainder, 60)
  formatted = f'{sign}{hours:02d}:{minutes:02d}'
  if include_seconds:
    formatted = f'{formatted}:{seconds:02d}'
  return formatted

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
    time_separator = '' if ticket_number == '' else ' – '
    duration = compute_duration(entry)

    longtext = f'{icon} {ticket_number}{time_separator}{format_duration(duration)}'
    shorttext = longtext
    color = '#ffffff'
  print(longtext)
  print(shorttext)
  print(color)

def print_current_activity_for_swiftbar():
  entry = current_activity()
  if entry is None:
    longtext = u':cup.and.heat.waves:'
    shorttext = longtext
    color = '#a0a0a0'
  else:
    icon = get_project_icon(entry) or u':briefcase.fill:'
    ticket_number = get_ticket_number(entry) or ''
    time_separator = '' if ticket_number == '' else ' – '
    duration = compute_duration(entry)

    longtext = f'{icon} {ticket_number}{time_separator}{format_duration(duration)}'
    shorttext = longtext
    color = '#000000'
  print(f'{longtext}')

  # Report in Submenu (using refresh=true to avoid very grayed out text due to non interactable menu items)
  print("---")

  entries_for_today = find_todays_entries()
  errors_today = validate_entries(entries_for_today)
  if len(errors_today) > 0:
    print('')
    print('There are errors in todays logs: | color=red refresh=true')
    for error in errors_today:
      print(error)
    return

  last_entry = find_last_entry()
  print(f'Since {last_entry.started_at.strftime("%H:%M")}: {last_entry.original_text}')

  entries_for_activity = find_entries_like(last_entry)
  print(f'Worked on this today for: {format_duration(sum_entry_durations(filter_entries_of_day(entries_for_activity, date.today())), include_seconds=True)} | refresh=true')
  print(f'Worked on this in total for: {format_duration(sum_entry_durations(entries_for_activity), include_seconds=True)} | refresh=true')

  print("---")

  print(f'Logged today for: {format_duration(sum_entry_durations(entries_for_today))} | refresh=true')

  # Report hours for this week per project that was worked on this week
  entries_for_week = find_this_weeks_entries()
  total_for_week = sum_entry_durations(entries_for_week)
  projects_worked_on_this_week = sorted(list({ entry.project for entry in entries_for_week }))
  project_targets = read_project_targets()
  target_sum = timedelta(hours=sum(project_targets.values()))

  print(f'Logged this week: {format_duration(total_for_week)} / {format_duration(target_sum)} | refresh=true')

  print('This weeks totals by project')
  for project in projects_worked_on_this_week:
    total_for_week_and_project = sum_entry_durations(filter_entries_with_project(entries_for_week, project))
    project_target = timedelta(hours=project_targets.get(project, 0))
    projected_duration = (total_for_week_and_project / total_for_week) * target_sum
    print(f'-- {project}: {format_duration(total_for_week_and_project)} / {format_duration(project_target)} – projected: {format_duration(projected_duration)} | refresh=true')


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
  entries_for_today = find_todays_entries()
  errors_today = validate_entries(entries_for_today)
  if len(errors_today) > 0:
    print('')
    print('There are errors in todays logs:')
    for error in errors_today:
      print(error)
    return

  last_entry = find_last_entry()
  print(f'Since {last_entry.started_at.strftime("%H:%M")}: {last_entry.original_text}')
  print('')
  print(f'Current duration: {format_duration(compute_duration(last_entry), include_seconds=True)}')

  entries_for_activity = find_entries_like(last_entry)
  print(f'Worked on this today for: {format_duration(sum_entry_durations(filter_entries_of_day(entries_for_activity, date.today())), include_seconds=True)}')
  print(f'Worked on this in total for: {format_duration(sum_entry_durations(entries_for_activity), include_seconds=True)}')

  print('')
  print(f'Logged today for: {format_duration(sum_entry_durations(entries_for_today))}')

  # Report hours for this week per project that was worked on this week
  entries_for_week = find_this_weeks_entries()
  total_for_week = sum_entry_durations(entries_for_week)
  projects_worked_on_this_week = sorted(list({ entry.project for entry in entries_for_week }))
  project_targets = read_project_targets()
  target_sum = timedelta(hours=sum(project_targets.values()))
  time_remaining_in_week = target_sum - total_for_week

  print(f'Logged this week: {format_duration(total_for_week)} / {format_duration(target_sum)} – remaining: {format_duration(time_remaining_in_week)}')

  print('')
  print('')
  print('This weeks totals by project:')
  for project in projects_worked_on_this_week:
    total_for_week_and_project = sum_entry_durations(filter_entries_with_project(entries_for_week, project))
    project_target = timedelta(hours=project_targets.get(project, 0))
    time_remaining = project_target - total_for_week_and_project
    projected_duration = (total_for_week_and_project / total_for_week) * target_sum
    print(f'{project: <25} {format_duration(total_for_week_and_project)} / {format_duration(project_target)} – remaining: {format_duration(time_remaining):>6} – projected: {format_duration(projected_duration)}')

def compute_durations_by_text_for_day(report_date):
  entries = find_day_entries(report_date)
  errors = validate_entries(entries)
  if len(errors) > 0:
    raise InvalidLogDataException(errors)
  return sum_entry_durations_by_text(entries)

def print_report_for_day(report_date):
  durations_by_text = compute_durations_by_text_for_day(report_date)
  for text, duration in durations_by_text.items():
    print(f'{format_duration(duration)} {text}')

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
