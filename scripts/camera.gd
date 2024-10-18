extends Camera2D

var transitioning = false

func _ready():
	position = _get_draw_mode_position()

func goto_draw_mode():
	
	if not transitioning:
		transitioning = true
		
		var tween = get_tree().create_tween()
		tween.set_ease(Tween.EASE_OUT)
		tween.set_trans(Tween.TRANS_QUART)
		tween.tween_property(self, "position", _get_draw_mode_position(), 0.5)
		tween.tween_callback(func(): transitioning = false)
	
func goto_play_mode():
	
	if not transitioning:
		transitioning = true
		var tween = get_tree().create_tween()
		tween.set_ease(Tween.EASE_OUT)
		tween.set_trans(Tween.TRANS_QUART)
		tween.tween_property(self, "position", _get_play_mode_position(), 0.5)
		tween.tween_callback(func(): transitioning = false)

func _get_draw_mode_position() -> Vector2:
	return get_viewport_rect().size / 2
	
func _get_play_mode_position() -> Vector2:
	return _get_draw_mode_position() * Vector2(1, -1)
