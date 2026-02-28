extends Node

const PLAYER_START_POS : Vector2i = Vector2i(256, 934)
const CAMERA_START_POS : Vector2i = Vector2i(960, 540)
const GROUND_START_POS : Vector2i = Vector2i(0, 984)
const SCREEN_SIZE : Vector2i = Vector2i(1920, 1080)

enum GameState { PRE_LAUNCH, IN_AIR, RECAP, SHOP}
@onready var current_state : GameState

var player_speed := 0

func ready():
	new_launch()

func new_launch():
	current_state = GameState.PRE_LAUNCH
	$Camera2D.position = CAMERA_START_POS
	$Player.position = PLAYER_START_POS
	$Player.visible = false
	$Ground.position = GROUND_START_POS

	
func _process(delta: float) -> void:
	$Player.position.x += player_speed * delta
	$Camera2D.position.x += player_speed * delta
	
	if ($Camera2D.position.x - $Ground.position.x) >= SCREEN_SIZE.x * 1.5:
		$Ground.position.x += SCREEN_SIZE.x
