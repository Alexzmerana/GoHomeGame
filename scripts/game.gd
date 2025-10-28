extends Node2D

const GROUND_PIXEL_WIDTH := 2304
@warning_ignore("integer_division")
const GROUND_RESET_POSITION = GROUND_PIXEL_WIDTH / 2

# The starting position of the sprite is at 1152. When the sprite is at postion 0 we are half way 
# through and it needs to be reset to maintain illusion of movement
const GROUND_RESET_POSITION_THRESHHOLD = 0

const MAX_SPEED := 2000
const MAX_ZOOM := Vector2(3.0, 3.0)
const MIN_ZOOM := Vector2(2.5, 2.5)

@export var speed : float = 0.0

@onready var ground := $Ground
@onready var camera := $Player/Camera2D

var screen_size : Vector2i

func _ready() -> void:
	screen_size = get_window().size
	print(screen_size)
	print(ground.position)
	
	
func new_launch() -> void:
	ground.position.x = GROUND_RESET_POSITION

func _process(delta: float) -> void:
	ground.position.x -= speed * delta
	if ground.position.x < GROUND_RESET_POSITION_THRESHHOLD:
		@warning_ignore("integer_division")
		ground.position.x = GROUND_RESET_POSITION
		
	
	var zoom_amount := remap(speed, 0.0, MAX_SPEED, 0.0, 1.0)
	var target_zoom := MAX_ZOOM.lerp(MIN_ZOOM, zoom_amount)
	camera.zoom = camera.zoom.lerp(target_zoom, delta * 5.0)
