mode: command
app: vscode
-

downer:
  key(down:30)
  # key(ctrl+down:30)

upper:
  key(up:30)
  # key(ctrl+up:30)

termilize line: user.vscode("termilizer.pasteLineToTerminal")
termilize block: user.vscode("termilizer.pasteBlockToTerminal")

collapse folders: user.vscode("workbench.files.action.collapseExplorerFolders")

bar tabs: user.vscode("workbench.files.action.focusOpenEditorsView")


fold deep: user.vscode("editor.foldRecursively")
unfold deep: user.vscode("editor.unfoldRecursively")

line delete: key(ctrl-shift-k)
line below: key(ctrl-enter)
line above: key(ctrl-shift-enter)

view smaller: user.vscode("workbench.action.decreaseViewSize")
view bigger: user.vscode("workbench.action.increaseViewSize")
split max: user.vscode("workbench.action.toggleEditorWidths")

run all (spec|specs): user.vscode("extension.runAllFileSpecs")
run file (spec|specs): user.vscode("extension.runFileSpecs")
run last (spec|specs): user.vscode("extension.runLastSpec")
run line (spec|specs): user.vscode("extension.runSpecLine")
go to spec: user.vscode("extension.goToSpec")

mark toggle: user.vscode("bookmarks.toggle")
mark last: user.vscode("bookmarks.jumpToPrevious")
mark next: user.vscode("bookmarks.jumpToNext")

(copilot | your controls): user.vscode("editor.action.inlineSuggest.trigger")

source stage selection: user.vscode("git.stageSelectedRanges")
source unstage selection: user.vscode("git.unstageSelectedRanges")
source revert selection: user.vscode("git.revertSelectedRanges")
source open change: user.vscode("git.openChange")
source open all changes: user.vscode("git.openAllChanges")
source blame: user.vscode("gitlens.toggleFileBlame")
source blame before: user.vscode("gitlens.openBlamePriorToChange")
source diff last: user.vscode("gitlens.diffWithPrevious")
source diff line last: user.vscode("gitlens.diffLineWithPrevious")
source open commit on remote: user.vscode("gitlens.openCommitOnRemote")

conflict next: user.vscode("merge-conflict.next")
conflict last: user.vscode("merge-conflict.previous")
conflict compare: user.vscode("merge-conflict.compare")
conflict accept current: user.vscode("merge-conflict.accept.current")
conflict accept incoming: user.vscode("merge-conflict.accept.incoming")
conflict accept both: user.vscode("merge-conflict.accept.both")
conflict accept selection: user.vscode("merge-conflict.accept.selection")

# result next: user.vscode("search.action.focusNextSearchResult")
# result last: user.vscode("search.action.focusPreviousSearchResult")
result next: key(f4)
result last: key(shift-f4)
search clear: user.vscode("search.action.clearSearchResults")

# Reveal current file in explorer and press up/down, space to open next/previous file
file next:
  user.vscode("workbench.files.action.showActiveFileInExplorer")
  key("down")
  key("space")
  user.vscode("workbench.action.focusActiveEditorGroup")
file last:
  user.vscode("workbench.files.action.showActiveFileInExplorer")
  key("up")
  key("space")
  user.vscode("workbench.action.focusActiveEditorGroup")

# user.vscode currently times out when trying to send commands to vscode code plugin
# therefore we just use keyboard commands here.
# Also we work around the inability do to detect whether we are in terminal right now,
# by forcing the tag on and off when entering or leaving the terminal by voice command.
panel terminal: user.vscode_terminal_focus()
terminal new: user.vscode_terminal_new()
terminal <number_small>: user.vscode_terminal(number_small)
terminal zoom <number_small>:
  user.vscode_terminal(number_small)
  user.vscode_terminal_zoom()
terminal split: user.vscode_terminal_split()
terminal zoom: user.vscode_terminal_zoom()
terminal leave: user.vscode_terminal_leave()
terminal zoom leave:
  user.vscode_terminal_zoom()
  user.vscode_terminal_leave()
terminal close:
  user.vscode_terminal_leave()
  user.vscode("workbench.action.togglePanel")
terminal zoom close:
  user.vscode_terminal_zoom()
  user.vscode_terminal_leave()
  user.vscode("workbench.action.togglePanel")

(scroll | school) downer bar:
  user.mouse_move_relative_active_window(140, 0.5)
  user.mouse_scroll_down_continuous()
(scroll | school) upper bar:
  user.mouse_move_relative_active_window(140, 0.5)
  user.mouse_scroll_up_continuous()

(scroll | school) downer panel:
  user.mouse_move_relative_active_window(0.5, -140)
  user.mouse_scroll_down_continuous()
(scroll | school) upper panel:
  user.mouse_move_relative_active_window(0.5, -140)
  user.mouse_scroll_up_continuous()
