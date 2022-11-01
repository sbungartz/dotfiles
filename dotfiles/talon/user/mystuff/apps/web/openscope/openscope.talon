tag: browser
title: /openScope Air Traffic Control Simulator/
-

taxi runway <user.icao_runway>:
  "taxi {icao_runway} "

cleared as filed: "caf "
climb via sid: "cvs "
cleared for takeoff: "to "

(climb|descend|maintain) <user.icao_altitude>:
  "a {icao_altitude} "

fly heading <user.icao_heading>:
  "fh {icao_heading} "

cleared ils runway <user.icao_runway>:
  "i {icao_runway}"
