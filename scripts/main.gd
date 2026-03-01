extends Node

const PLAYER_START_POS : Vector2i = Vector2i(256, 934)
const CAMERA_START_POS : Vector2i = Vector2i(960, 540)
const GROUND_START_POS : Vector2i = Vector2i(0, 984)
const SCREEN_SIZE : Vector2i = Vector2i(1920, 1080)

enum GameState { PRE_LAUNCH, IN_AIR, RECAP, SHOP}

@onready var current_state : GameState
@onready var player := $Player
@onready var cannon := $Cannon
@onready var camera := $Camera2D
@onready var ground := $Ground
@onready var hud := $HUD
@onready var ui_state_machine := $UIStateMachine

func _ready():
	new_launch()

func new_launch():
	print("called")
	current_state = GameState.PRE_LAUNCH
	camera.position = CAMERA_START_POS
	player.position = cannon.launch_point
	player.visible = false
	ground.position = GROUND_START_POS

	
func _process(delta: float) -> void:
	camera.position.x += player.velocity.x * delta
	
	if (camera.position.x - ground.position.x) >= SCREEN_SIZE.x * 1.5:
		ground.position.x += SCREEN_SIZE.x


func _on_player_in_air_signal() -> void:
	current_state = GameState.IN_AIR


func _on_player_stopped_moving() -> void:
	current_state = GameState.RECAP # Replace with function body.
	ui_state_machine.transition_state(current_state)


func _on_recap_screen_restart_signal() -> void:
	current_state = GameState.PRE_LAUNCH
	new_launch()
	ui_state_machine.transition_state(current_state)


func _on_recap_screen_shop_signal() -> void:
	current_state = GameState.SHOP # Replace with function body.
	ui_state_machine.transition_state(current_state)


func _on_shop_menu_continue_pressed() -> void:
	current_state = GameState.PRE_LAUNCH # Replace with function body.
	new_launch()
	ui_state_machine.transition_state(current_state)
