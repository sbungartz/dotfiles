from talon import actions, imgui, ui, Module, Context

mod = Module()
ctx = Context()

mod.list("icao_digit", desc="ICAO Digit")
icao_digit_names = ["zero", "one", "two", "three", "four", "five", "six", "seven", "eight", "niner"]
ctx.lists["user.icao_digit"] = { word: str(value) for value, word in enumerate(icao_digit_names)}

mod.list("icao_runway_modifier", desc="ICAO Runway Modifier")
ctx.lists["user.icao_runway_modifier"] = {
  "left": "L",
  "right": "R",
  "center": "C",
}

mod.list("icao_turn_direction", desc="ICAO Turn Direction")
ctx.lists["user.icao_turn_direction"] = {
  "left": "l",
  "right": "r",
}

@mod.capture(rule="{user.icao_digit} {user.icao_digit} [{user.icao_runway_modifier}]")
def icao_runway(m) -> str:
    """
    Captures a runway definition and returns it in openScope format
    """
    return "".join(list(m))

@mod.capture(rule="{user.icao_digit} [{user.icao_digit}] thousand")
def icao_altitude(m) -> str:
    """
    Captures an altitude in thousand feet and returns it in hundreds of feet
    """
    return "".join(list(m.icao_digit_list)) + "0"

@mod.capture(rule="{user.icao_digit} {user.icao_digit} {user.icao_digit}")
def icao_heading(m) -> str:
    """
    Captures a three digit heading
    """
    return "".join(list(m.icao_digit_list))

# UI overlay for controlling using eye mouse
@imgui.open(x=ui.active_window().screen.x, y=ui.active_window().screen.rect.bot - 500)
def gui_openscope_controls(gui: imgui.GUI):
  if gui.button("taxi 33"):
    actions.insert("taxi 33\n")
  if gui.button("std clr + to"):
    actions.insert("caf cvs to\n")
  if gui.button("a 70"):
    actions.insert("a 70\n")
  if gui.button("a 60"):
    actions.insert("a 60\n")
  if gui.button("a 50"):
    actions.insert("a 50\n")
  if gui.button("a 40"):
    actions.insert("a 40\n")
  if gui.button("a 30"):
    actions.insert("a 30\n")
  if gui.button("a 20"):
    actions.insert("a 20\n")
  if gui.button("fh 360"):
    actions.insert("fh 360\n")
  if gui.button("fh 090"):
    actions.insert("fh 090\n")
  if gui.button("fh 140"):
    actions.insert("fh 140\n")
  if gui.button("fh 180"):
    actions.insert("fh 180\n")
  if gui.button("fh 270"):
    actions.insert("fh 270\n")
  if gui.button("fh 320"):
    actions.insert("fh 320\n")
  if gui.button("ils 23"):
    actions.insert("ils 23\n")
  if gui.button("Hide"):
    gui_openscope_controls.hide()

@mod.action_class
class Actions:
  def openscope_controls_show():
    """Show onscreen controls for openscope"""
    gui_openscope_controls.show()

  def openscope_controls_hide():
    """Hide onscreen controls for openscope"""
    gui_openscope_controls.hide()
