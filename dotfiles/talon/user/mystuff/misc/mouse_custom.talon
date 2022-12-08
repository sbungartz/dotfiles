mouse switch screen:
	user.mouse_switch_screen()

mouse go:
  user.mouse_toggle_control_mouse(1)

mouse stop:
	user.mouse_toggle_control_mouse(0)

mouse park:
  user.mouse_toggle_control_mouse(0)
  mouse_move(100, 0)

(mid|middle) drag: user.mouse_drag(2)
drop: user.mouse_drag_end()

<user.modifiers> (left drag | drag):
	key("{modifiers}:down")
	user.mouse_drag(0)
	# close the mouse grid
	user.grid_close()

<user.modifiers> (right drag | righty drag):
	key("{modifiers}:down")
	user.mouse_drag(1)
	# close the mouse grid
	user.grid_close()

<user.modifiers> (mid|middle) drag:
	key("{modifiers}:down")
	user.mouse_drag(2)
	# close the mouse grid
	user.grid_close()
