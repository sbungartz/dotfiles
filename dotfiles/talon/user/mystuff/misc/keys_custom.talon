hold <user.key>: user.hold_key(key)
hold <user.modifiers>: user.hold_key(modifiers)
release <user.key>: user.release_key(key)
release <user.modifiers>: user.release_key(modifiers)
release all: user.release_keys()

reveal down:
  key(down:15)
  key(up:15)

reveal downer:
  key(down:30)
  key(up:30)

reveal up:
  key(up:15)
  key(down:15)

reveal upper:
  key(up:30)
  key(down:30)
