from talon import Context

ctx = Context()
ctx.matches = r"""
app: vscode
tag: user.ruby
"""
# short name -> ide clip name
ctx.lists["user.snippets"] = {
  # built in snippets:
  "begin": "begin",
  "class": "class",
  "do": "do",
  "dope": "dop", # Do block with params
  "funky": "def",
  "if else": "if else",
  "if": "if",
  "try": "try",

  # User snippets
  "require": "require",

  ## RSpec
  "context": "context",
  "describe": "describe",
  "before": "before",
  "expect": "expect",
  "expect not": "expect not",
  "expect block": "expect block",
  "expect not block": "expect not block",
  "expect content": "expect content",
  "expect not content": "expect not content",
  "expect selector": "expect selector",
  "expect not selector": "expect not selector",
  "it does": "it do",
  "let": "let",
  "let bang": "let!",
}
