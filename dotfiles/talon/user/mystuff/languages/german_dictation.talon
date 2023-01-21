mode: dictation
language: de_DE
-

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
