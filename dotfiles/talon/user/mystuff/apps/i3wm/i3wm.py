from talon import actions, Module, Context

mod = Module()
ctx = Context()

# Map for spoken name of i3 workspace to both workspace number and the associated key, split by colon
i3_ports = {
  "web": "10:1",
  "notes": "11:f2",
  "term": "20:2",
  "code": "30:3",
  "screen": "40:4",
  "pause": "50:5",
  "telly": "60:6",
  "meta": "70:7",
  "tick": "71:u",
  "mail": "80:8",
  "plan": "81:i",
  "chat": "90:9",
  "slack": "91:o",
  "tunes": "100:0",
}

i3_port_numbers = { name: v.split(":")[0] for name, v in i3_ports.items()}
i3_port_keys = { name: v.split(":")[1] for name, v in i3_ports.items()}

mod.list("i3wm_port", desc="Spoken name for i3 workspaces")
ctx.lists["user.i3wm_port"] = i3_ports.keys()

@mod.action_class
class Actions:
  def i3wm_focus_workspace(port: str):
    """Focus the given workspace"""
    actions.key(f"super-{i3_port_keys[port]}")

  def i3wm_port_side(port: str):
    "Open given workspace on other screen but keep focus on current workspace"
    actions.user.system_command(f"~/.dotfiles/scripts/i3-port-side {i3_port_numbers[port]}")

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
