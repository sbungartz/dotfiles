from talon import Module
import os

mod = Module()

@mod.action_class
class Actions:
  def run_shell(cmd: str):
    """Run given command using os.system"""
    os.system(cmd)

  def run_from_wm(cmd: str):
    """Run given command using window manager"""
    os.system(f"i3-msg 'exec {cmd}'")
