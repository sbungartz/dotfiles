from talon import Module, Context

mod = Module()
ctx = Context()

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
