tag: terminal
-

clear mode off: "cmoff\n"

open notes work: "cd ~/Notes && vim -c GTDWork\n"

think:
  insert("think ''")
  key(left)

think <user.prose>:
  insert("think '{user.prose}'")
  key(left)

task add: "t a "
task add work: "t a +Work "

task (remove|delete): "t rm "
task do: "t do "

task sort: "t p "
task unsort: "t depri "
task schedule: "t schedule "

task all: "cmt\n"
task today: "cmte\n"
task next: "cmts\n"

task context show: "tcr\n"
task context desk: "tcs @Desk\n"
task context home: "tcs @Home\n"
task context errands: "tcs @Besorgungen\n"
task context creation: "tcs @Creation\n"
task context office: "tcs @Office\n"

task list home: "cm th\n"
task list errands: "cm tb\n"

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
