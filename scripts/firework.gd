extends Node2D

@export var rocket_animation: SpriteFrames
@export var explosion_animation: SpriteFrames

@onready var rocket_sprite: AnimatedSprite2D = $RocketSprite
@onready var explosion_sprite: AnimatedSprite2D = $ExplosionSprite

# Called when the node enters the scene tree for the first time.
func _ready():
	init(rocket_animation, explosion_animation)

func init(rocket_animation: SpriteFrames, explosion_animation: SpriteFrames):
	
	rocket_sprite.sprite_frames = rocket_animation
	rocket_sprite.offset.y = -rocket_animation.get_frame_texture("default", 0).get_size().y / 2
	rocket_sprite.play()
	
	explosion_sprite.sprite_frames = explosion_animation
	explosion_sprite.offset.y = -rocket_animation.get_frame_texture("default", 0).get_size().y
	explosion_sprite.hide()
	
	rocket_sprite.animation_finished.connect(func():
		
		rocket_sprite.queue_free()
		explosion_sprite.show()
		explosion_sprite.play()
		
		explosion_sprite.animation_finished.connect(func():
			explosion_sprite.queue_free()	
			
			)
		
		)
	
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
