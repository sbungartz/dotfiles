pop scrolling on:
	user.set_pop_scroll_active(1)

pop scrolling here:
	tracking.control_toggle(false)
	user.mouse_move_center_active_window()
	user.set_pop_scroll_active(1)

pop scrolling off:
	user.set_pop_scroll_active(0)

mouse switch screen:
	user.mouse_switch_screen()

mouse go:
	user.set_pop_scroll_active(0)
  tracking.control_toggle(true)

mouse stop:
	tracking.control_toggle(false)

mouse park:
  tracking.control_toggle(false)
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
