extends Node2D

@export var drawing_area: DrawingArea

@export var tools: Dictionary

@export var current_tool: Tool

func _ready():
	Input.use_accumulated_input = false

func _input(event):
	if event is InputEventMouseButton and event.button_index == MouseButton.MOUSE_BUTTON_LEFT:
		if event.is_pressed():
			current_tool.on_mouse_pressed(get_global_mouse_position(), drawing_area)
			
		if event.is_released():
			current_tool.on_mouse_released(get_global_mouse_position(), drawing_area)

		return

	if event is InputEventMouseMotion:
		current_tool.on_mouse_motion(get_global_mouse_position(), drawing_area)

	
func change_tool_from_name(tool_name: String):
	if tool_name in tools:
		change_tool(get_node(tools[tool_name]))
	

func change_tool(new_tool: Tool):
	current_tool.on_tool_unselected()
	current_tool = new_tool
	new_tool.on_tool_selected()

