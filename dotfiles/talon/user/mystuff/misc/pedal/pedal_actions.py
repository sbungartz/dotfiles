from talon import actions, Module
import os

mod = Module()

scripts_folder = os.path.expanduser('~/.dotfiles/scripts')

@mod.action_class
class Actions:
  def pedal_activate_mode(mode: str):
    '''Activate the given mode for pedal'''
    actions.user.run_shell(f"{scripts_folder}/pedal.py {mode} &")
    actions.app.notify(f"Pedal: {mode}")

  def pedal_board_pedal_action(pedal_name: str, pushed_down: bool):
    '''Callback for pedal board pedals, invoked via ~/.talon/bin/repl'''
    if pushed_down:
      if pedal_name == '1':
        actions.speech.toggle()
      elif pedal_name == '2':
        actions.user.set_pop_scroll_active(0)
        actions.user.mouse_toggle_control_mouse()
