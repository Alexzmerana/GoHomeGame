extends Node

const PLAYER_START_POS : Vector2i = Vector2i(256, 934)
const CAMERA_START_POS : Vector2i = Vector2i(960, 540)
const GROUND_START_POS : Vector2i = Vector2i(0, 984)
const SCREEN_SIZE : Vector2i = Vector2i(1920, 1080)

var player_speed := 400

func ready():
	new_launch()

func new_launch():
	$Camera2D.position = CAMERA_START_POS
	$Player.position = PLAYER_START_POS
	$Ground.position = GROUND_START_POS

	
func _process(delta: float) -> void:
	$Player.position.x += player_speed * delta
	$Camera2D.position.x += player_speed * delta
	
	if (int($Camera2D.position.x) - CAMERA_START_POS.x % SCREEN_SIZE.x) == 0:
		$Ground.position.x += SCREEN_SIZE.x
