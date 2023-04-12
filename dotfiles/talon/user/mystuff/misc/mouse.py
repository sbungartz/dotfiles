from talon import Module, ctrl, actions, ui, imgui
import time
import inspect

mod = Module()

pop_scroll_active = False
pop_scroll_currently_scrolling = False
pop_scrolling_direction = "down"
last_pop_at = None

@imgui.open(x=700, y=0)
def gui_pop_scroll_active(gui: imgui.GUI):
    gui.text(f"Pop scrolling active")
    gui.line()
    if gui.button("pop scrolling off"):
        actions.user.set_pop_scroll_active(False)

@mod.action_class
class Actions:
  def set_pop_scroll_active(active: bool):
    """Activates or deactivates pop scrolling"""
    global pop_scroll_active
    global pop_scroll_currently_scrolling
    global pop_scrolling_direction

    pop_scroll_active = active
    if pop_scroll_active:
      gui_pop_scroll_active.show()
    else:
      pop_scroll_active = False
      pop_scroll_currently_scrolling = False
      pop_scrolling_direction = "down"
      actions.user.mouse_scroll_stop()
      gui_pop_scroll_active.hide()

  def mouse_on_pop():
    """On pop callback for mouse related stuff"""
    global last_pop_at
    global pop_scroll_currently_scrolling
    global pop_scrolling_direction

    is_double = False
    if last_pop_at is not None and time.perf_counter() - last_pop_at < 0.25:
      is_double = True

    last_pop_at = time.perf_counter()

    if pop_scroll_active:
      if is_double:
        # Set currently_scrolling to False, so that it will always be started again in the next if statement
        pop_scroll_currently_scrolling = False
        pop_scrolling_direction = "up" if pop_scrolling_direction == "down" else "down"

      if pop_scroll_currently_scrolling == False:
        if pop_scrolling_direction == "down":
          actions.user.mouse_scroll_down_continuous()
        else:
          actions.user.mouse_scroll_up_continuous()
        pop_scroll_currently_scrolling = True
      else:
        actions.user.mouse_scroll_stop()
        pop_scroll_currently_scrolling = False

  def mouse_switch_screen():
    """Toggles the primary display and runs calibration"""
    actions.user.system_command("~/.dotfiles/scripts/xrandr-swap-primary")
    actions.sleep("200ms")
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
