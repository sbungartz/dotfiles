from talon import Module, actions

mod = Module()

@mod.action_class
class TabsCustomActions:
  def tab_move_left():
    """Moves current tab to the left"""
    actions.key("ctrl-shift-pageup")

  def tab_move_right():
    """Moves current tab to the right"""
    actions.key("ctrl-shift-pagedown")
