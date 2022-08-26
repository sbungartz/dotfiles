from talon import Module, ctrl, actions

mod = Module()

@mod.action_class
class Actions:
  def mouse_drag(button: int, modifier: str = None):
    """Press and hold/release a specific mouse button for dragging"""
    # Clear any existing drags
    actions.user.mouse_drag_end()

    if modifier is not None:
      actions.key(f"{modifier}:down")

    # Start drag
    ctrl.mouse_click(button=button, down=True)

  def mouse_drag_end():
    """Send mouse up event for any button that could be used with drag"""
    # Overriding default logic because talon.mouse_buttons_down() does not report correct numbers on Linux
    for button in [0, 1, 2]:
      ctrl.mouse_click(button, up=True)

    # Also release any modifier keys
    for modifier in ['ctrl', 'alt', 'super', 'shift']:
      actions.key(f"{modifier}:up")
