from talon import Context, Module, actions

mod = Module()

@mod.action_class
class Actions:
  def miro_control_key(key: str):
    """Press escape multiple times and then the given key, to ensure there is no selection"""
    actions.key("escape")
    actions.key("escape")
    actions.key(key)
