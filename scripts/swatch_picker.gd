extends Control

@export var colors: Array[Color]

@onready var grid_container: GridContainer = $SwatchContainer

var swatch_size: int = 32

var rows: int = 1

var selected_color: Color

func _ready():
	
	selected_color = colors[0]
	
	grid_container.size.x = swatch_size
	grid_container.size.y = swatch_size * colors.size()
	
	for i in range(colors.size()):
		
		var col_rect: ColorRect = ColorRect.new()
		grid_container.add_child(col_rect)
		col_rect.color = colors[i]
		col_rect.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		col_rect.size_flags_vertical = Control.SIZE_EXPAND_FILL
		col_rect.gui_input.connect(func(event): _on_swatch_gui_input(event, i))

func _on_swatch_gui_input(event: InputEvent, ind: int):
	
	if event is InputEventMouseButton and event.is_pressed():
		print(colors[ind])
		selected_color = colors[ind]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
