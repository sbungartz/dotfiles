mode: dictation
language: de_DE
-

port min launch:
  user.i3wm_focus_workspace(i3wm_port)
  user.i3wm_launch_apps_for_workspace(i3wm_port)

^command mode$:
  user.dictation_format_reset()
  user.german_mode_deactivate()

Befehlsmodus:
  user.dictation_format_reset()
  user.german_mode_deactivate()

<user.raw_prose>: auto_insert(raw_prose)

^doch nicht$: user.clear_last_phrase()
^alles löschen$:
  edit.select_all()
  edit.delete()

^rückgängig machen$: edit.undo()
^wiederherstellen$: edit.redo()

^(Eingabetaste | klatsch)$: key("enter")
^neue Zeile$: edit.line_insert_down()
^neuer Absatz$:
  edit.line_insert_down()
  edit.line_insert_down()
