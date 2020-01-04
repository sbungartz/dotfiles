#!/usr/bin/env python3

from icalendar import Calendar
from datetime import date, datetime, timedelta, timezone

filename = 'Aufgaben.ics'
with open(filename, 'r') as file:
    content = file.read()

cal = Calendar.from_ical(content)
now = datetime.now(tz=timezone.utc)

def is_dt_in_future(dt):
    if isinstance(dt, date):
        next_day = dt + timedelta(1)
        dt = datetime(next_day.year, next_day.month, next_day.day, tzinfo=timezone.utc)
    return dt > now

def is_in_future(event):
    if event.get('rrule'):
        if event.get('rrule').get('until'):
            return is_dt_in_future(event.get('rrule').get('until')[0])
        else:
            return True
    else:
        return is_dt_in_future(event.get('dtend').dt)

def normalized_datetime(dt):
    if isinstance(dt, date):
        return datetime(dt.year, dt.month, dt.day, tzinfo=timezone.utc)
    else:
        return dt

def next_start(event):
    start_time = normalized_datetime(event.get('dtstart').dt)
    return start_time

def format_event(event):
    output = ''
    output += '{:25} '.format(str(event.get('dtstart').dt))
    output += event.get('summary')
    if event.get('rrule') is not None:
        output += ' ({})'.format(event.get('rrule'))
    return output

future_events = sorted([event for event in cal.walk('vevent') if is_in_future(event)], key=next_start)

print('--------------------------------------------------')
for event in future_events:
    print(format_event(event))
