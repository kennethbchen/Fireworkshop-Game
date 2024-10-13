extends Node


@export var flipbooks: Array[SpriteFrames] = []

const frame_height: int = 32
const frame_width: int = 32

var current_flipbook_index = 0
var current_frame_index = 0

signal current_flipbook_changed(flipbook_index: int)
signal current_frame_changed(frame_index: int)

func _ready():
	
	if flipbooks.size() <= 0:
		append_blank_flipbook()
	
	select_flipbook(0)
	select_frame(0)
		
	$'TempSprite'.texture = get_current_frame()

func get_current_flipbook() -> SpriteFrames:
	return flipbooks[current_flipbook_index]

func get_current_frame() -> ImageTexture:
	
	
	if get_current_flipbook().get_frame_texture("default", current_frame_index) is CompressedTexture2D:
		# Decompress so that we can edit
		var new_texture = ImageTexture.create_from_image(get_current_flipbook().get_frame_texture("default", current_frame_index).get_image())
		
		get_current_flipbook().set_frame("default", current_frame_index, new_texture)
		
	return get_current_flipbook().get_frame_texture("default", current_frame_index)
	
func select_flipbook(flip_idx: int):
	if flip_idx >= 0 and flip_idx < flipbooks.size() :
		current_flipbook_index = flip_idx
		current_flipbook_changed.emit(flip_idx)
		
		select_frame(0)

func select_frame(frame_idx: int):
	if frame_idx >= 0 and frame_idx < get_current_flipbook().get_frame_count("default"):
		current_frame_index = frame_idx
		current_frame_changed.emit(frame_idx)

func append_blank_flipbook():
	
	var new_flipbook: SpriteFrames = SpriteFrames.new()
	new_flipbook.add_frame("default", create_new_frame())
	flipbooks.append(new_flipbook)

func create_new_frame(flipbook_index: int = current_flipbook_index) -> ImageTexture:
	
	var img = Image.create(frame_width, frame_height, false, Image.FORMAT_BPTC_RGBA)
	
	# Image starts as compressed I guess
	img.decompress()
	
	return ImageTexture.create_from_image(img)
	

