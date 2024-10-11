extends Control

@onready var display: TextureRect = $TextureRect

var width: int = 16
var height: int = 16

var img: Image
var texture: ImageTexture

# Called when the node enters the scene tree for the first time.
func _ready():
	
	img = Image.create(width, height, false, Image.FORMAT_BPTC_RGBA)
	
	# Image starts as compressed I guess
	img.decompress()
	
	for i in range(width):
		img.set_pixel(i, i, Color.RED)
	
	
	texture = ImageTexture.create_from_image(img)
	
	print(texture.get_image().get_pixel(0,0))
	
	display.texture = texture
	display.size= Vector2(width, height)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
