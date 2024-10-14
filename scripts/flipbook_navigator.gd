extends Control

@onready var frame_parent = $ScrollContainer/VBoxContainer/HBoxContainer

@onready var cursor = $SelectionCursor

var selected_idx: int = 0

func _process(delta):
	cursor.global_position = frame_parent.get_children()[%PlayerData.current_frame_index].global_position
	
func _on_current_flipbook_changed(new_flipbook: SpriteFrames):
	# Make sure that number of texture_rect children match the new flipbook's frame count
	if frame_parent.get_child_count() > new_flipbook.get_frame_count("default"):
		# Remove excess children
		for i in range(frame_parent.get_child_count() - new_flipbook.get_frame_count("default")):
			var child = frame_parent.get_children().pop_back()
			child.queue_free()
	
	if frame_parent.get_child_count() < new_flipbook.get_frame_count("default"):
		
		# Add more children
		var init_children_count: int = frame_parent.get_child_count()
		for i in range(new_flipbook.get_frame_count("default") - frame_parent.get_child_count()):
			var child: TextureRect = TextureRect.new()
			frame_parent.add_child(child)
			
			child.gui_input.connect(func(event): _on_frame_gui_input(event, init_children_count + i))
			
	
	# Display new frames
	for i in range(new_flipbook.get_frame_count("default")):
		frame_parent.get_children()[i].texture = new_flipbook.get_frame_texture("default", i)

func _on_frame_gui_input(event: InputEvent, idx: int):
	
	if event is InputEventMouse and event.is_pressed():
		%PlayerData.select_frame(idx)
