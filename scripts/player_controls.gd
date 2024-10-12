extends Node

@export var frame: Frame

@export var current_tool: Tool

# Called when the node enters the scene tree for the first time.
func _ready():
	Input.use_accumulated_input = false
	

func _input(event):
	if event is InputEventMouseButton and event.button_index == MouseButton.MOUSE_BUTTON_LEFT:
		if event.is_pressed():
			current_tool.on_mouse_pressed(event.position, frame)
			
		if event.is_released():
			current_tool.on_mouse_released(event.position, frame)
		
		return
		
	if event is InputEventMouseMotion: 
		current_tool.on_mouse_motion(event.position, frame)

"""
func _process(delta):
	
	if tool_active:
		frame.set_pixel_from_global_position(get_viewport().get_mouse_position(), Color.BLUE)
"""

