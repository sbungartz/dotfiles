mode: dictation
language: de_DE
-

Befehlsmodus:
  user.dictation_format_reset()
  user.german_mode_deactivate()

<user.raw_prose>: auto_insert(raw_prose)

^doch nicht$: user.clear_last_phrase()
^(Wort | Worte) links löschen$:
  edit.extend_word_left()
  edit.delete()
^alles löschen$:
  edit.select_all()
  edit.delete()

^rückgängig machen$: edit.undo()
^wiederherstellen$: edit.redo()

^(Eingabetaste | klatsch)$: key("enter")
neue Zeile: edit.line_insert_down()
^neuer Absatz$:
  edit.line_insert_down()
  edit.line_insert_down()
^mehr einrücken$: edit.indent_more()
^weniger einrücken$: edit.indent_less()

# Escape, type things that would otherwise be commands
^brich aus <user.text>$: auto_insert(user.text)
