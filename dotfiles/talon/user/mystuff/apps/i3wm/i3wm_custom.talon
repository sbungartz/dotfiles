mode: command
-

port {user.i3wm_port}: user.i3wm_focus_workspace(i3wm_port)
port {user.i3wm_port} launch:
  user.i3wm_focus_workspace(i3wm_port)
  user.i3wm_launch_apps_for_workspace(i3wm_port)

port {user.i3wm_port} mouse:
  user.i3wm_focus_workspace(i3wm_port)
  user.i3wm_move_workspace_to_primary_output()

port {user.i3wm_port} keys:
  user.i3wm_focus_workspace(i3wm_port)
  user.i3wm_move_workspace_to_secondary_output()

port {user.i3wm_port} side: user.i3wm_port_side(i3wm_port)

port {user.i3wm_port} swap:
  user.i3wm_focus_workspace(i3wm_port)
  user.i3wm_swap_outputs()

port mouse: user.i3wm_move_workspace_to_primary_output()
port keys: user.i3wm_move_workspace_to_secondary_output()

port side:
  user.i3wm_move_workspace_to_other_output()
  user.i3wm_focus_other_output()

screen swap: user.i3wm_swap_outputs()
screen swap away:
  user.i3wm_focus_other_output()
  user.i3wm_swap_outputs()

screen mouse: user.i3wm_focus_primary_output()
screen keys: user.i3wm_focus_secondary_output()
screen next: user.i3wm_focus_other_output()

win take {user.i3wm_port}: user.i3wm_take_window_to_workspace(i3wm_port)
win send {user.i3wm_port}: user.i3wm_send_window_to_workspace(i3wm_port)

port take right: key(super-ctrl-)
port take left: key(super-ctrl-h)
port take up: key(super-ctrl-k)
port take down: key(super-ctrl-j)

floating koopa: key(super-shift-enter)
