extends Node2D

@export var firework_scene: PackedScene

@export var rocket_animations: Array[SpriteFrames]
@export var explosion_animations: Array[SpriteFrames]

@export var rocket_sounds: Array[AudioStream]
@export var explosion_sounds: Array[AudioStream]

var enabled: bool = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if enabled and cumulative_probability(0.75, delta):
		launch_firework()

# https://en.wikipedia.org/wiki/Exponential_distribution
# Cumulative probability of an event of probability [chance] happening over [delta] seconds
func cumulative_probability(chance: float, delta: float) -> bool:
	
	var probability_at_least_one: float = 1 - exp(-chance * delta)
	
	if probability_at_least_one >= 1:
		return true
	elif probability_at_least_one < 0:
		return false
	else:
		return randf() < probability_at_least_one

func launch_firework():
	
	var new_firework = firework_scene.instantiate()
	add_child(new_firework)
	new_firework.position.x = randi_range(-32, 32)
	new_firework.init(rocket_animations.pick_random(), explosion_animations.pick_random(), rocket_sounds.pick_random(), explosion_sounds.pick_random())

func enable():
	enabled = true
	
	explosion_animations = %PlayerData.flipbooks
	
func disable():
	enabled = false
