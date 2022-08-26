from talon import Module, ctrl, actions

mod = Module()

@mod.action_class
class Actions:
  def mouse_drag(button: int):
    """Press and hold/release a specific mouse button for dragging"""
    # Clear any existing drags
    actions.user.clear_drag()

    # Start drag
    ctrl.mouse_click(button=button, down=True)

  def clear_drag():
    """Send mouse up event for any button that could be used with drag"""
    # Overriding default logic because talon.mouse_buttons_down() does not report correct numbers on Linux
    for button in [0, 1, 2]:
      ctrl.mouse_click(button, up=True)

  def mouse_drag_end():
    """Stopped dragging and release any other held down keys"""
    actions.user.clear_drag()

    # Also release any modifier keys
    for modifier in ['ctrl', 'alt', 'super', 'shift']:
      actions.key(f"{modifier}:up")

    # Also release any held down keys
    actions.user.release_keys()
