extends Node


@export var flipbooks: Array[SpriteFrames]

var current_flipbook_index = 0
var current_frame_index = 0

var current_flipbook: SpriteFrames:
	get:
		return flipbooks[current_flipbook_index]
		
var current_frame: Texture2D:
	get:
		return current_flipbook.get_frame_texture("default", current_frame_index)

signal current_flipbook_changed(new_index: int)
signal current_frame_changed(new_index: int)

func _ready():
	pass # Replace with function body.


