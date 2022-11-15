from talon import actions, ui, cron

def vscode_poll_terminal_state():
  if ui.active_app().name == "Code" and not ui.active_window().title.startswith("Keyboard Shortcuts -"):
    # actions.key("help")
    actions.user.run_shell(f"xdotool key XF86Search")

cron.interval("1000ms", vscode_poll_terminal_state)
