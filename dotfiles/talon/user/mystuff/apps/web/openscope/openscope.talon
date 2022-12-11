tag: browser
title: /openScope Air Traffic Control Simulator/
-

controls show: user.openscope_controls_show()
controls hide: user.openscope_controls_hide()

taxi runway <user.icao_runway>:
  "taxi {icao_runway} "

cleared as filed: "caf "
climb via sid: "cvs "
cleared for takeoff: "to "

(climb|descend|maintain) <user.icao_altitude>:
  "a {icao_altitude} "

descend via star <user.icao_altitude>:
  "dvs {icao_altitude} "

proceeded direct: "pd "

fly present heading: "fph "

fly heading <user.icao_heading>:
  "fh {icao_heading} "

turn {user.icao_turn_direction} heading <user.icao_heading>:
  "t {icao_turn_direction} {icao_heading} "

speed: "sp "

expect runway <user.icao_runway>:
  "e {icao_runway} "

cleared ils runway <user.icao_runway>:
  "i {icao_runway} "
