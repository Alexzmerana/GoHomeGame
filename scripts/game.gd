extends Node2D

@onready var ground := $Ground
@onready var player := $Player
@onready var camera := $Camera2D
@onready var cannon := $Cannon

const GROUND_PIXEL_WIDTH := 2304

@warning_ignore("integer_division")
const GROUND_START_POSITION = Vector2(1152.0, 40.0)


# The starting position of the sprite is at 1152. When the sprite is at postion 0 we are half way 
# through and it needs to be reset to maintain illusion of movement
const GROUND_RESET_POSITION_THRESHHOLD = 0

const CANNON_START_POSITION := Vector2(-22, 0)

const PLAYER_START_POITION := Vector2(24, 0)
const MAX_SPEED := 2000
const MAX_ZOOM := Vector2(2.5, 2.5)
const MIN_ZOOM := Vector2(2.0, 2.0)

@export var speed : float = 0.0
@export var launched := false



var screen_size : Vector2i

func _ready() -> void:
	launched = false
	screen_size = get_window().size
	print(ground.position)
	print(player.position)
	
	
func new_launch() -> void:
	launched = false
	player.visible = false
	ground.position = GROUND_START_POSITION
	cannon.position = CANNON_START_POSITION
	player.position = PLAYER_START_POITION


func _process(delta: float) -> void:
	print(player.position)
	ground.position.x -= speed * delta
	cannon.position.x -= speed * delta
	if ground.position.x < GROUND_RESET_POSITION_THRESHHOLD:
		@warning_ignore("integer_division")
		ground.position = GROUND_START_POSITION
		
		
	var zoom_amount := remap(speed, 0.0, MAX_SPEED, 0.0, 1.0)
	var target_zoom := MAX_ZOOM.lerp(MIN_ZOOM, zoom_amount)
	camera.zoom = camera.zoom.lerp(target_zoom, delta * 5.0)
