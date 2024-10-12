extends GridContainer

@export var colors: Array[Color]

var swatch_size: int = 64

var rows: int = 1

var selected_color: Color

# Called when the node enters the scene tree for the first time.
func _ready():
	
	selected_color = colors[0]
	
	columns = colors.size()
	
	for i in range(colors.size()):
		
		var col_rect: ColorRect = ColorRect.new()
		add_child(col_rect)
		col_rect.color = colors[i]
		col_rect.size = Vector2(swatch_size, swatch_size)
		col_rect.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		col_rect.size_flags_vertical = Control.SIZE_EXPAND_FILL
		col_rect.gui_input.connect(func(event): _on_swatch_gui_input(event, i))

func _on_swatch_gui_input(event: InputEvent, ind: int):
	
	if event is InputEventMouseButton and event.is_pressed():
		selected_color = colors[ind]
		print(selected_color)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
