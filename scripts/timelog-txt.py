#!/usr/bin/env python3
# -*- coding: utf-8 -*-

from os.path import expanduser
from datetime import datetime, date
import sys

from timelog_txt_core import *

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
elif command == "report-for-day":
  date_str = sys.argv[2]
  # report_date = date.fromisoformat(date_str)
  report_date = date.fromtimestamp(datetime.strptime(date_str, "%Y-%m-%d").timestamp())
  print_report_for_day(report_date)
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
