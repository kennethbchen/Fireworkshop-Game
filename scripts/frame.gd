extends TextureRect

class_name Frame

var width: int = 16
var height: int = 16

var img: Image

func _ready():
	
	img = Image.create(width, height, false, Image.FORMAT_BPTC_RGBA)
	
	# Image starts as compressed I guess
	img.decompress()
	
	for i in range(width):
		img.set_pixel(i, i, Color.RED)
	
	
	texture = ImageTexture.create_from_image(img)
	
	size = Vector2(width, height)

func set_pixel_from_global_position(pos: Vector2, color: Color):
	
	if not is_global_position_in_bounds(pos):
		return
	
	var pix_position: Vector2 = get_pix_from_global_position(pos)
	img.set_pixel(pix_position.x, pix_position.y, color)
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
	print(get_rect().has_point(pos))
	return get_rect().has_point(pos)
	
func is_pix_in_bounds(pos: Vector2) -> bool:
	
	if pos.x < 0 or pos.y < 0 or \
	   pos.x >= width or pos.y >= height:
		
		return false
	
	return true

func _process(delta):
	pass
