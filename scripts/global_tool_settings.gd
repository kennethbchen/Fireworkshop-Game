extends Node

@export var swatch_picker: Control

func get_current_color() -> Color:
	return swatch_picker.selected_color
