extends Tool

func on_mouse_motion(mouse_position: Vector2, frame: Frame):
	if active:
		frame.set_pixel_from_global_position(mouse_position, Color(0,0,0,0))
