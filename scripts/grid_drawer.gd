extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	size = get_parent().size
	
func _draw():
	
	# Draw Background Grid
	for col in range(4):
		for row in range(4):
			var rect = Rect2(Vector2(col, row) * (size / 4), size / 4)
			draw_rect(rect, Color.GRAY if (col + row) % 2 == 0 else Color.DIM_GRAY)
