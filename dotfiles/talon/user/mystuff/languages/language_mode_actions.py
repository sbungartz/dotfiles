from talon import imgui, actions, Module

mod = Module()

@imgui.open(x=700, y=0)
def gui_german_mode_active(gui: imgui.GUI):
    gui.text(f"German mode active")
    gui.line()
    if gui.button("Command mode"):
        actions.user.german_mode_deactivate()

@mod.action_class
class Actions:
  def german_mode_activate():
    """Activates german mode, to allow dictation in german language"""
    actions.mode.disable("command")
    actions.mode.enable("dictation")
    actions.mode.enable("user.german")
    gui_german_mode_active.show()

  def german_mode_deactivate():
    """Deactivates german mode and goes back to command mode in english"""
    actions.mode.disable("user.german")
    actions.mode.disable("dictation")
    actions.mode.enable("command")
    gui_german_mode_active.hide()
