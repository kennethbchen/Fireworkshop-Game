extends HBoxContainer


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _on_current_flipbook_changed(new_flipbook: SpriteFrames):
	
	# Make sure that number of texture_rect children match the new flipbook's frame count
	if get_child_count() > new_flipbook.get_frame_count("default"):
		# Remove excess children
		for i in range(get_child_count() - new_flipbook.get_frame_count("default")):
			var child = get_children().pop_back()
			child.queue_free()
	
	if get_child_count() < new_flipbook.get_frame_count("default"):
		# Add more children
		for i in range(new_flipbook.get_frame_count("default") - get_child_count()):
			
			var child = TextureRect.new()
			add_child(child)
	
	# Display new frames
	for i in range(new_flipbook.get_frame_count("default")):
		get_children()[i].texture = new_flipbook.get_frame_texture("default", i)
	
