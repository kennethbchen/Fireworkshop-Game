extends Control

@export var colors: Array[Color]

@onready var cursor: Control = $SelectionCursor

@onready var swatch_container: GridContainer = $SwatchContainer

var swatch_size: int = 32

var selected_color: Color

func _ready():
	
	selected_color = colors[0]
	
	swatch_container.size.x = swatch_size
	swatch_container.size.y = swatch_size * colors.size()
	
	for i in range(colors.size()):
		
		var col_rect: ColorRect = ColorRect.new()
		swatch_container.add_child(col_rect)
		col_rect.color = colors[i]
		col_rect.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		col_rect.size_flags_vertical = Control.SIZE_EXPAND_FILL
		col_rect.gui_input.connect(func(event): _on_swatch_gui_input(event, i))

func _on_swatch_gui_input(event: InputEvent, ind: int):
	
	if event is InputEventMouseButton and event.is_pressed():
		selected_color = colors[ind]
		
		var tween = get_tree().create_tween()
		tween.set_ease(Tween.EASE_OUT)
		tween.set_trans(Tween.TRANS_CUBIC)
		tween.tween_property(cursor, "position", Vector2(0, swatch_size * ind), 0.25)

