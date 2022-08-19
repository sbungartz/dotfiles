from talon import Context, Module, actions

mod = Module()
ctx = Context()

mod.tag('vscode_terminal_active', desc='Work around tag to remember we entered the terminal vscode')

@mod.action_class
class Actions:
  def vscode_terminal_new():
    """Create new terminal by custom shortcut"""
    actions.key('ctrl-shift-alt-5')
    actions.user.vscode_terminal_entered()

  def vscode_terminal_focus():
    """Focus terminal panel by custom shortcut"""
    actions.key('ctrl-alt-5')
    actions.user.vscode_terminal_entered()

  def vscode_terminal_split():
    """Create new terminal split by default shortcut"""
    actions.user.vscoat_terminal_focus()
    actions.key('ctrl-shift-5')
    actions.user.vscode_terminal_entered()

  def vscode_terminal_leave():
    """Leave terminal by custom shortcut, and end forcing terminal tag"""
    actions.key('ctrl-.')
    actions.key(',')
    ctx.tags = []

  def vscode_terminal_entered():
    """Force terminal tag, since it cannot be recognized automatically in vscode"""
    ctx.tags = ['user.vscode_terminal_active']

  def vscode_terminal(number: int):
    """Activate terminal by number. Overriding to work around problems"""
    actions.user.vscode_terminal_leave()
    actions.user.vscode(f"workbench.action.terminal.focusAtIndex{number}")
    actions.user.vscode_terminal_entered()
    