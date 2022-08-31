tag: terminal
-

clear mode off: "cmoff\n"

open notes work: "cd ~/Notes && vim -c GTDWork\n"

think <user.prose>:
  insert("think '{user.prose}'")

task add: "t a "
task add work: "t a +Work "
task add work friends: "t a +Work +Pfreundt "

task (remove|delete): "t rm "
task do: "t do "

task sort: "t p "
task schedule: "t schedule "

task all: "cmt\n"
task today: "cmte\n"
task next: "cmts\n"

task external work: "cm tpw\n"
task external home: "cm tph\n"

at office: "@Office"
at home: "@Home"
at desk: "@Desk"
at errands: "@Besorgungen"
at creation: "@Creation"
at agenda: "@Agenda"
at waiting: "@Warten"

plus work: "+Work"
plus friends: "+Pfreundt"
