from talon import Module, ctrl, actions, ui
import inspect

mod = Module()

@mod.action_class
class Actions:
  def mouse_switch_screen():
    """Toggles the primary display and runs calibration"""
    actions.user.system_command("~/.dotfiles/scripts/xrandr-swap-primary")
    # actions.user.mouse_toggle_control_mouse(0) # Turn off mouse, to avoid distracting cursor above calibration view
    actions.user.mouse_calibrate()

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

  def mouse_move_relative_active_window(x: float, y: float):
    """Moves the mouse cursor to a relative position inside the active window.
       Values <= 1 are interpreted as fractions of the total width or height.
       Values > 1 are interpreted as pixels from the left or top respectively.
       Values < 0 are interpreted as pixels from the right or bottom respectively."""
    rect = ui.active_window().rect
    print( inspect.getmembers(rect))

    new_x = relative_place_inside_range(rect.left, rect.right, x)
    new_y = relative_place_inside_range(rect.top, rect.bot, y)

    ctrl.mouse_move(new_x, new_y)

def relative_place_inside_range(min: float, max: float, offset: float):
  if offset < 0:
    # Since offset is already negative, we add it to the max to subtract its absolute value
    return max + offset
  elif offset > 1:
    return min + offset
  else:
    size_of_range = max - min
    return min + (size_of_range * offset)
