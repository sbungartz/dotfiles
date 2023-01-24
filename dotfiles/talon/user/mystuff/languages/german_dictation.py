from talon import Context

# Relies on extra catpure in knausj-fork in german context for raw_prose.
# Having that over there, avoids copying all of the formatting code over here.

ctx = Context()
ctx.matches = """
language: de_DE
"""

ctx.lists["self.punctuation"] = {
  "Komma": ",",
  "Punkt": ".",
  "Ausrufezeichen": "!",
  "Fragezeichen": "?",
  "Doppelpunkt": ":",
  "Semikolon": ";",
  "Slash": "/",
  "Backslash": "\\",
  "Sternchen": "*",
  "Prozentzeichen": "%",
  "Hash Zeichen": "#",
  "at Zeichen": "@",
  "Affenschaukel": "@",
  "und Zeichen": "&",
  "Dollarzeichen": "$",
  "Eurozeichen": "€",
  "Klammer auf": "(",
  "Klammer zu": ")",
  "nachdenkliche Punkte": "...",
}

# ctx.lists["user.prose_modifiers"] = {
#   "groß schreiben": "cap",
#   "klein schreiben": "no_cap",
#   "ohne Leerzeichen": "no_space",
# }

ctx.lists["user.prose_snippets"] = {
    # "new line": "\n",
    # "new paragraph": "\n\n",
    # Curly quotes are used to obtain proper spacing for left and right quotes, but will later be straightened.
    "Zitat Anfang": "“",
    "Zitat anfangen": "“",
    "Zitat Ende": "”",
    # "smiley": ":-)",
    # "winky": ";-)",
    # "frowny": ":-(",
}
