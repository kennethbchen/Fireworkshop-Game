extends Node2D

@export var rocket_animation: SpriteFrames
@export var explosion_animation: SpriteFrames

@onready var rocket_sprite: AnimatedSprite2D = $RocketSprite
@onready var explosion_sprite: AnimatedSprite2D = $ExplosionSprite

var children_remaining: int = 2

func init(rocket_animation: SpriteFrames, explosion_animation: SpriteFrames):
	
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
