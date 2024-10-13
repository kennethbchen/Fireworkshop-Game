extends TextureRect

class_name DrawingArea

@export var width: int = 32
@export var height: int = 32

var img: Image

func _ready():
	
	size = Vector2(%PlayerData.frame_width, %PlayerData.frame_height)

func get_current_frame_texture() -> Texture2D:
	return %PlayerData.get_current_frame()

func set_pixel_from_global_position(pos: Vector2, color: Color):
	
	if not is_global_position_in_bounds(pos):
		return
	
	var pix_position: Vector2 = get_pix_from_global_position(pos)
	img.set_pixel(pix_position.x, pix_position.y, color)
	
	# Update both the current frame in PlayerData and this object's image"res://main.tscn::SpriteFrames_dev2h"
	get_current_frame_texture().update(img)
	texture.update(img)
	
# NOTE: 0 Indexed
func get_pix_from_global_position(pos: Vector2) -> Vector2:
	
	if not is_global_position_in_bounds(pos):
		# Out of bounds
		return Vector2(-1, -1)
		
	var relative_position: Vector2 = pos - global_position
	
	# Account for scale of frame
	relative_position /= scale
	relative_position = relative_position.floor()

	return relative_position
		

		
# NOTE: Probably doesn't work if frame is rotated
func is_global_position_in_bounds(pos: Vector2) -> bool:
	return get_rect().has_point(pos)
	
func is_pix_in_bounds(pos: Vector2) -> bool:
	
	if pos.x < 0 or pos.y < 0 or \
	   pos.x >= width or pos.y >= height:
		
		return false
	
	return true

func _on_current_frame_changed(new_idx: int):
	
	img = get_current_frame_texture().get_image()
		
	texture = get_current_frame_texture()
