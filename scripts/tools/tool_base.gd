extends Node

class_name Tool

var active: bool = false

func on_tool_selected():
	pass

func on_mouse_pressed(mouse_position: Vector2, drawing_area: DrawingArea):
	active = true
	
func on_mouse_released(mouse_position: Vector2, drawing_area: DrawingArea):
	active = false

func on_mouse_motion(mouse_position: Vector2, drawing_area: DrawingArea):
	pass

func on_tool_unselected():
	active = false
