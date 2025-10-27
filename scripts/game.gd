extends Node2D

const GROUND_PIXEL_WIDTH := 2304

# The starting position of the sprite is at 1152. When the sprite is at postion 0 we are half way 
# through and it needs to be reset to maintain illusion of movement
const GROUND_RESET_POSITION = 0

@export var speed : float = 0.0

@onready var ground := $Ground

var screen_size : Vector2i

func _ready() -> void:
	screen_size = get_window().size
	print(screen_size)
	print(ground.position)

func _process(delta: float) -> void:
	ground.position.x -= speed * delta
	if ground.position.x < GROUND_RESET_POSITION:
		ground.position.x = GROUND_PIXEL_WIDTH/2
