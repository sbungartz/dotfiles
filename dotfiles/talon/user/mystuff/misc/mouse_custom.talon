mouse go:
    user.mouse_toggle_control_mouse(1)

mouse stop:
    user.mouse_toggle_control_mouse(0)

mouse park:
    user.mouse_toggle_control_mouse(0)
    mouse_move(100, 0)

(mid|middle) drag: user.mouse_drag(2)