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
  "if else": "if else",
  "if": "if",
  "try": "try",

  # User snippets
  "require": "require",

  ## RSpec
  "context": "context",
  "describe": "describe",
  "expect": "expect",
  "it does": "it do",
}
