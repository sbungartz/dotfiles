#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import requests

import os
import re
import json
from os.path import expanduser
from datetime import datetime, timedelta, date
import timelog_txt_core

NOKO_TOKEN = os.environ.get('NOKO_TOKEN')
date_str = os.environ.get('EXPORT_DATE') or datetime.now().strftime('%Y-%m-%d')


DRY_RUN = False
if NOKO_TOKEN is None:
    DRY_RUN = True
    print('DRY RUN: not actually uploading anything.')
    print('Set environment variable NOKO_TOKEN to actually upload data.')

with open(expanduser('~/.config/timelog-txt/projects.json'), 'r') as f:
    noko_project_id_for_category = json.load(f)

export_date = date.fromtimestamp(datetime.strptime(date_str, "%Y-%m-%d").timestamp())

try:
    durations_by_text = timelog_txt_core.compute_durations_by_text_for_day(export_date)
except timelog_txt_core.InvalidLogDataException as e:
    print('')
    print("Aborting export because there are errors in the log file:")
    for error in e.errors:
        print(error)
    exit(1)

print(f'uploading entries for {export_date}')
entries_url = 'https://api.nokotime.com/v2/entries'
api_headers = {
        'X-NokoToken': NOKO_TOKEN
}

total_time_for_day = timedelta(0)
total_time_unskipped_for_day = timedelta(0)

for entry_text, total_time in durations_by_text.items():
    activity, project = entry_text.split("@")
    noko_project_id = noko_project_id_for_category.get(project)

    total_time_for_day += total_time

    if noko_project_id is None:
        print(f'skipping {total_time} of "{entry_text}" because no project id is mapped')
        continue

    total_time_unskipped_for_day += total_time

    tp_reference_match = re.match('^[tT][pP]-([0-9]+) (.*)', activity)
    if tp_reference_match:
        noko_description = '#{} {}'.format(tp_reference_match.group(1), tp_reference_match.group(2))
    else:
        noko_description = activity

    total_minutes = int(round((total_time.total_seconds()) / 60))

    print(f'logging {total_time} for "{entry_text}" as {total_minutes} minutes on "{noko_description}@{noko_project_id}"')

    if not DRY_RUN:
        payload = {
            'date': date_str,
            'project_id': int(noko_project_id),
            'description': noko_description,
            'minutes': total_minutes,
        }

        response = requests.post(entries_url, json=payload, headers=api_headers)
        print(response.status_code)

print('-----------------')
print(f'Logged: {total_time_for_day}')
print(f'Worked: {total_time_unskipped_for_day}')
