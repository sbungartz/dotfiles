from talon import actions, Module, Context

mod = Module()
ctx = Context()

mod.list("i3wm_port", desc="Maps spoken port name to name (including icon) for i3-msg")
ctx.lists["user.i3wm_port"] = {
  "web": "10:",
  "notes": "11:",
  "term": "20:",
  "code": "30:",
  "screen": "40:",
  "pause": "50:",
  "telly": "60:",
  "meta": "70:",
  "tick": "71:",
  "mail": "80:",
  "plan": "81:",
  "chat": "90:",
  "slack": "91:",
  "tunes": "100:",
}

@mod.action_class
class Actions:
  def i3wm_focus_workspace(port: str):
    """Focus the given workspace"""
    actions.user.system_command(f"i3-msg workspace {port}")

  def i3wm_port_side(port: str):
    "Open given workspace on other screen but keep focus on current workspace"
    actions.user.system_command(f"~/.dotfiles/scripts/i3-port-side {port}")

  def i3wm_move_workspace_to_primary_output():
    """Move the current workspace to the primary output"""
    actions.user.system_command("i3-msg move workspace to output primary")

  def i3wm_move_workspace_to_secondary_output():
    """Move the current workspace to an output other than the primary"""
    actions.user.system_command("i3-msg move workspace to output primary")
    actions.user.i3wm_move_workspace_to_other_output()

  def i3wm_move_workspace_to_other_output():
    """Move the current workspace to the other output"""
    # Moving both left and up to get to other of two screens regardless of setup
    actions.user.system_command("i3-msg move workspace to output left")
    actions.user.system_command("i3-msg move workspace to output up")

  def i3wm_focus_primary_output():
    """Focus the primary output"""
    actions.user.system_command("i3-msg focus output primary")

  def i3wm_focus_secondary_output():
    """Focus the secondary output"""
    actions.user.system_command("i3-msg focus output primary")
    actions.user.i3wm_focus_other_output()

  def i3wm_focus_other_output():
    """Focus the other output"""
    # Focusing both left and up to get to other of two screens regardless of setup
    actions.user.system_command("i3-msg focus output left")
    actions.user.system_command("i3-msg focus output up")

  def i3wm_swap_outputs():
    """Swap both outputs"""
    actions.user.system_command("~/.dotfiles/scripts/i3-swap-outputs")
