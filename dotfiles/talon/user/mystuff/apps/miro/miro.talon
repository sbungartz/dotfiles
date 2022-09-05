tag: browser
title: /Online Whiteboard for Visual Collaboration/
-

zoom in: user.miro_control_key("+")
zoom out: user.miro_control_key("-")

tool hand: user.miro_control_key("v")
tool select:
  user.miro_control_key("v")
  key("v")
tool pen: user.miro_control_key("p")
tool eraser: user.miro_control_key("e")

toggle map: user.miro_control_key("m")
toggle grid: user.miro_control_key("g")

insert text: user.miro_control_key("t")
insert note: user.miro_control_key("n")
insert shape: user.miro_control_key("s")
insert rectangle: user.miro_control_key("r")
insert oval: user.miro_control_key("o")
insert (connection|line): user.miro_control_key("l")
insert comment: user.miro_control_key("c")
insert frame: user.miro_control_key("f")

clone this: key("ctrl-d")
group this: key("ctrl-g")
ungroup this: key("ctrl-shift-g")
toggle lock: key("ctrl-l")
toggle protected lock: key("ctrl-shift-l")
send this to front: key("pageup")
send this to back: key("pagedown")

pan <user.arrow_key>:
  key("escape")
  key("{arrow_key}:down")
  sleep(1200ms)
  key("{arrow_key}:up")

# pan <user.arrow_key> <number_small>:
#   key("escape")
#   key("{arrow_key}:down")
#   sleep(float(number_small))
#   key("{arrow_key}:up")

pan <user.arrow_key> tiny:
  key("escape")
  key("{arrow_key}:down")
  sleep(400ms)
  key("{arrow_key}:up")
