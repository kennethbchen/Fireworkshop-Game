extends Control

@export var selected_x_offset: int = -12

@onready var pencil = $PencilButton
@onready var eraser = $EraserButton

var pencil_selected: bool = true

func _ready():
	
	pencil_selected = false
	_on_pencil_pressed()
	
	pencil.pressed.connect(_on_pencil_pressed)
	eraser.pressed.connect(_on_eraser_pressed)

func _on_pencil_pressed():
	
	if pencil_selected:
		return
	
	pencil_selected = true
	pencil.position.x = selected_x_offset
	eraser.position.x = -selected_x_offset
	
func _on_eraser_pressed():
	
	if not pencil_selected:
		return
	
	pencil_selected = false
	pencil.position.x = -selected_x_offset
	eraser.position.x = selected_x_offset
