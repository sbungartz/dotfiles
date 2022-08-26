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
	user.mouse_drag(0, "{modifiers}")
	# close the mouse grid
	user.grid_close()

<user.modifiers> (right drag | righty drag):
	user.mouse_drag(1, "{modifiers}")
	# close the mouse grid
	user.grid_close()

<user.modifiers> (mid|middle) drag:
	user.mouse_drag(2, "{modifiers}")
	# close the mouse grid
	user.grid_close()
