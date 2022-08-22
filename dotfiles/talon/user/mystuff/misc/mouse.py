from talon import Module, ctrl

mod = Module()

@mod.action_class
class Actions:
  def mouse_drag_end():
    """Send mouse up event for any button that could be used with drag"""
    # Overriding default logic because talon.mouse_buttons_down() does not report correct numbers on Linux
    for button in [0, 1, 2]:
      ctrl.mouse_click(button, up=True)
