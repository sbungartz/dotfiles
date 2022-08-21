from talon import Module
import os

mod = Module()

@mod.action_class
class Actions:
  def run_shell(cmd: str):
    """Run given command using os.system"""
    os.system(cmd)