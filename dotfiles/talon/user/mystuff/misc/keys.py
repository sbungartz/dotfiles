from talon import Module, actions, imgui

mod = Module()

# Holding and releasing keys:
pressed_keys = set()

@imgui.open(x=150, y=0)
def gui_keys_held(gui: imgui.GUI):
    gui.text(f"Keys held: {pressed_keys}")

@mod.action_class
class Actions:
  def hold_key(key: str):
    """Hold down the given key"""
    pressed_keys.add(key)
    gui_keys_held.show()
    actions.key(f"{key}:down")

  def release_key(key: str):
    """Release the given key"""
    pressed_keys.add(key)
    if len(pressed_keys) > 0:
      gui_keys_held.hide()
    actions.key(f"{key}:up")

  def release_keys():
    """Release all keys previously"""
    for key in pressed_keys:
      actions.key(f"{key}:up")
    pressed_keys.clear()
    gui_keys_held.hide()
