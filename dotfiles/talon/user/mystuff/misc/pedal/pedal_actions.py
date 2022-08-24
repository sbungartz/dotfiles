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
