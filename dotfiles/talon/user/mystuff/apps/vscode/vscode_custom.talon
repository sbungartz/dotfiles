mode: command
app: vscode
-

line delete: key(ctrl-shift-k)
line below: key(ctrl-enter)
line above: key(ctrl-shift-enter)

notifications clear: key(ctrl-shift-escape)

# result next: user.vscode("search.action.focusNextSearchResult")
# result last: user.vscode("search.action.focusPreviousSearchResult")
result next: key(f4)
result last: key(shift-f4)

# user.vscode currently times out when trying to send commands to vscode code plugin
# therefore we just use keyboard commands here.
# Also we work around the inability do to detect whether we are in terminal right now,
# by forcing the tag on and off when entering or leaving the terminal by voice command.
panel terminal: user.vscode_terminal_focus()
terminal new: user.vscode_terminal_new()
terminal split: user.vscode_terminal_split()
terminal zoom: user.vscode_terminal_zoom()
terminal leave: user.vscode_terminal_leave()
terminal zoom leave:
  user.vscode_terminal_zoom()
  user.vscode_terminal_leave()
terminal <number_small>: user.vscode_terminal(number_small)
