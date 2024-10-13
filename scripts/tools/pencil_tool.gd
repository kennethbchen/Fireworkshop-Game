extends Tool

func on_mouse_pressed(mouse_position: Vector2, drawing_area: DrawingArea):
	super(mouse_position, drawing_area)
	drawing_area.set_pixel_from_global_position(mouse_position, %GlobalToolSettings.get_current_color())

func on_mouse_motion(mouse_position: Vector2, drawing_area: DrawingArea):
	if active:
		drawing_area.set_pixel_from_global_position(mouse_position, %GlobalToolSettings.get_current_color())
