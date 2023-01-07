from talon import Module, Context

mod = Module()
ctx = Context()

# Symbol keys
mod.list("mystuff_symbol_key", desc="alternate names for symbol keys")
ctx.lists["user.mystuff_symbol_key"] = {
    "brick": "`",
    "stroke": "/",
    "backstroke": "\\",
    "equal": "=",
    "plus": "+",
    "tilde": "~",
    "bang": "!",
    "score": "_",
    "quest": "?",
    "single": "'",
    "double": '"',
    "leper": "(",
    "repper": ")",
    "lacker": "[",
    "racker": "]",
    "lacer": "{",
    "racer": "}",
    "langle": "<",
    "wrangle": ">",
    "snow": "*",
    "pound": "#",
    "percy": "%",
    "tangle": "^",
    "amper": "&",
    "pipe": "|",
    "dollar": "$",
    "semi": ";",
    "stack": ":",
    "drip": ",",
}

@ctx.capture("user.symbol_key", rule="{user.symbol_key} | {user.mystuff_symbol_key}")
def symbol_key(m):
    return str(m)

# Special keys
mod.list("mystuff_special_key", desc="alternate names for special keys")
ctx.lists["user.mystuff_special_key"] = {
  "clap": "enter",
  "drill": "backspace",
  "scrape": "escape",
  "slurp": "delete",
  "void": "space",
}

@ctx.capture("user.special_key", rule="{user.special_key} | {user.mystuff_special_key}")
def special_key(m):
    return str(m)
