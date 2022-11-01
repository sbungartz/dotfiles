from talon import Module, Context

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
