extends Node

@export var frame: Frame

var tool_active: bool
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _input(event):
	if event is InputEventMouseButton and event.button_index == MouseButton.MOUSE_BUTTON_LEFT:
		if event.is_pressed():
			tool_active = true
			
		if event.is_released():
			tool_active = false


func _process(delta):
	
	if tool_active:
		frame.set_pixel_from_global_position(get_viewport().get_mouse_position(), Color.BLUE)


