extends Camera2D


func _ready():
	position = _get_draw_mode_position()

func goto_draw_mode():
	position = _get_draw_mode_position()
	
func goto_play_mode():
	position = _get_play_mode_position()

func _get_draw_mode_position() -> Vector2:
	return get_viewport_rect().size / 2
	
func _get_play_mode_position() -> Vector2:
	return _get_draw_mode_position() * Vector2(1, -1)
