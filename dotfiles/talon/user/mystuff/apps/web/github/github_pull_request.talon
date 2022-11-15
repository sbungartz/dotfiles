tag: browser
title: /· Pull Request #/
-

file first unread:
  key("escape")
  key("ctrl-l")
  sleep(50ms)
  insert("javascript:")
  user.paste('(() => {{ const box = document.querySelectorAll(".js-reviewed-checkbox:not([checked])")[0]; box.focus(); box.scrollIntoView(true); }})()')
  key("enter")
  key("up:2")

yip:
  key("space")
  sleep(2s)
  key("escape")
  key("ctrl-l")
  sleep(50ms)
  insert("javascript:")
  user.paste('(() => {{ const box = document.querySelectorAll(".js-reviewed-checkbox:not([checked])")[0]; box.focus(); box.scrollIntoView(true); }})()')
  key("enter")
  key("up:2")
