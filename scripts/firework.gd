extends Node2D

@export var rocket_animation: SpriteFrames
@export var explosion_animation: SpriteFrames

@export var rocket_sound: AudioStream
@export var explosion_sound: AudioStream

@onready var rocket_sprite: AnimatedSprite2D = $RocketSprite
@onready var explosion_sprite: AnimatedSprite2D = $ExplosionSprite

@onready var audio_player: AudioStreamPlayer2D = $AudioStreamPlayer2D

var children_remaining: int = 3

func init(rocket_animation: SpriteFrames, explosion_animation: SpriteFrames, rocket_sound: AudioStream, explosion_sound: AudioStream):
	
	rocket_sound = rocket_sound
	explosion_sound = explosion_sound
	
	audio_player.pitch_scale = randf_range(0.9, 1.1)
	
	audio_player.stream = rocket_sound
	audio_player.play()
	
	rocket_sprite.sprite_frames = rocket_animation
	rocket_sprite.offset.y = -rocket_animation.get_frame_texture("default", 0).get_size().y / 2
	rocket_sprite.play()
	
	explosion_sprite.sprite_frames = explosion_animation
	explosion_sprite.offset.y = -rocket_animation.get_frame_texture("default", 0).get_size().y
	explosion_sprite.hide()
	
	rocket_sprite.animation_finished.connect(func():
		
		rocket_sprite.hide()
		explosion_sprite.show()
		explosion_sprite.play()
		
		audio_player.stream = explosion_sound
		audio_player.play()
		audio_player.finished.connect(func():
			children_remaining -= 1
		)
		
		children_remaining -= 1
		
		explosion_sprite.animation_finished.connect(func():
			var tween = get_tree().create_tween()
			tween.tween_property(explosion_sprite, "self_modulate", Color(1,1,1,0), 0.5)
			tween.tween_callback(func():
				explosion_sprite.hide()
				
				children_remaining -= 1
				
				)
			)
		)

func _process(delta):
	if children_remaining <= 0:
		queue_free()
