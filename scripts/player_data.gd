extends Node


@export var flipbooks: Array[SpriteFrames] = []

const frame_height: int = 32
const frame_width: int = 32

var current_flipbook_index = 0
var current_frame_index = 0

signal current_flipbook_changed(new_flipbook: SpriteFrames)
signal current_frame_changed(new_frame: ImageTexture)

func _ready():
	
	if flipbooks.size() <= 0:
		append_blank_flipbook()
	else:
		# Make sure that all flipbooks have ImageTextures that can be edited
		
		for flipbook in flipbooks:
			for i in range(flipbook.get_frame_count("default")):
				if flipbook.get_frame_texture("default", i) is CompressedTexture2D:
					var new_texture = ImageTexture.create_from_image(flipbook.get_frame_texture("default", i).get_image())
					
					flipbook.set_frame("default", i, new_texture)
	
	select_flipbook(0)
	select_frame(0)


func get_current_flipbook() -> SpriteFrames:
	return flipbooks[current_flipbook_index]

func get_current_frame() -> ImageTexture:
	
	if get_current_flipbook().get_frame_texture("default", current_frame_index) is CompressedTexture2D:
		# Decompress so that it can be edited
		var new_texture = ImageTexture.create_from_image(get_current_flipbook().get_frame_texture("default", current_frame_index).get_image())
		
		get_current_flipbook().set_frame("default", current_frame_index, new_texture)
		
	return get_current_flipbook().get_frame_texture("default", current_frame_index)
	
func select_flipbook(flip_idx: int):
	if flip_idx >= 0 and flip_idx < flipbooks.size() :
		current_flipbook_index = flip_idx
		current_flipbook_changed.emit(get_current_flipbook())
		
		select_frame(0)

func select_frame(frame_idx: int):
	if frame_idx >= 0 and frame_idx < get_current_flipbook().get_frame_count("default"):
		current_frame_index = frame_idx
		current_frame_changed.emit(get_current_frame())

func move_selected_left():
	
	if current_frame_index <= 0:
		return
		
	var temp = get_current_frame()
	get_current_flipbook().set_frame("default", current_frame_index, get_current_flipbook().get_frame_texture("default", current_frame_index - 1))
	get_current_flipbook().set_frame("default", current_frame_index - 1, temp)
	select_frame(current_frame_index - 1)
	current_flipbook_changed.emit(get_current_flipbook())
	
func move_selected_right():
	
	if current_frame_index + 1 >= get_current_flipbook().get_frame_count("default"):
		return
		
	var temp = get_current_frame()
	get_current_flipbook().set_frame("default", current_frame_index, get_current_flipbook().get_frame_texture("default", current_frame_index + 1))
	get_current_flipbook().set_frame("default", current_frame_index + 1, temp)
	select_frame(current_frame_index + 1)
	current_flipbook_changed.emit(get_current_flipbook())

func append_blank_flipbook():
	
	var new_flipbook: SpriteFrames = SpriteFrames.new()
	new_flipbook.add_frame("default", create_new_frame())
	new_flipbook.set_animation_speed("default", 10)
	new_flipbook.set_animation_loop("default", false)
	flipbooks.append(new_flipbook)
	

func delete_frame(frame_index: int = current_frame_index):

	# Leave at least one frame in flipbook
	if get_current_flipbook().get_frame_count("default") <= 1 or \
		current_frame_index < 0 or \
		current_frame_index > get_current_flipbook().get_frame_count("default"):
		return
	
	get_current_flipbook().remove_frame("default", frame_index)
	
	select_frame(max(0, current_frame_index - 1))
	
	current_flipbook_changed.emit(get_current_flipbook())
	

func append_new_frame():
	get_current_flipbook().add_frame("default", create_new_frame())
	
	current_flipbook_changed.emit(get_current_flipbook())
	
	select_frame(get_current_flipbook().get_frame_count("default") - 1)
	
func create_new_frame(flipbook_index: int = current_flipbook_index) -> ImageTexture:
	
	var img = Image.create(frame_width, frame_height, false, Image.FORMAT_RGBA8)
	
	if img.is_compressed():
		# Probably don't need this
		img.decompress()
	
	return ImageTexture.create_from_image(img)
	

