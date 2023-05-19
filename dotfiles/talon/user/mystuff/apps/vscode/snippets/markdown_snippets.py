from talon import Context

ctx = Context()
ctx.matches = r"""
app: vscode
tag: user.markdown
"""
# short name -> ide clip name
ctx.lists["user.snippets"] = {
  # built in snippets:
  "code block": "fenced codeblock",

  # User snippets
}
