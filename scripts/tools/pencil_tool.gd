extends Tool

func on_mouse_pressed(mouse_position: Vector2, frame: Frame):
	super(mouse_position, frame)
	frame.set_pixel_from_global_position(mouse_position, Color.BLUE)

func on_mouse_motion(mouse_position: Vector2, frame: Frame):
	if active:
		frame.set_pixel_from_global_position(mouse_position, Color.BLUE)
