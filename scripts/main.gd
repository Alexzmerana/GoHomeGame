extends Node

const PLAYER_START_POS : Vector2i = Vector2i(256, 934)
const CAMERA_START_POS : Vector2i = Vector2i(960, 540)
const GROUND_START_POS : Vector2i = Vector2i(0, 984)
const SCREEN_SIZE : Vector2i = Vector2i(1920, 1080)

enum GameState { PRE_LAUNCH, IN_AIR, RECAP, SHOP}
@onready var current_state : GameState
@onready var player := $Player
@onready var camera := $Camera2D
@onready var ground := $Ground
@onready var hud := $HUD

func ready():
	new_launch()

func new_launch():
	current_state = GameState.PRE_LAUNCH
	camera.position = CAMERA_START_POS
	player.position = PLAYER_START_POS
	player.visible = false
	ground.position = GROUND_START_POS

	
func _process(delta: float) -> void:
	camera.position.x += player.velocity.x * delta
	
	if (camera.position.x - ground.position.x) >= SCREEN_SIZE.x * 1.5:
		ground.position.x += SCREEN_SIZE.x


func _on_player_in_air_signal() -> void:
	current_state = GameState.IN_AIR


func _on_player_stopped_moving() -> void:
	current_state = GameState.SHOP # Replace with function body.
