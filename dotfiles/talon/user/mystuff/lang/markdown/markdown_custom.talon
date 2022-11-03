tag: user.markdown
-

check: user.vscode("markdown.extension.checkTaskList")
check next:
  user.vscode("markdown.extension.checkTaskList")
  key("down")

preview split: user.vscode("markdown.showPreviewToSide")
preview full: user.vscode("markdown.showPreview")
preview close: user.vscode("markdown.extension.closePreview")

preview refresh: user.vscode("markdown.preview.refresh")
preview lock toggle: user.vscode("markdown.preview.toggleLock")

state check: "- [ ] "
