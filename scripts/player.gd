extends CharacterBody2D

@onready var game_node = $".."
@onready var camera: Camera2D = $Camera2D

const SPEED := 1 
const JUMP_VELOCITY := -400.0
const GRAVITY := 30.0
const MAX_Y_POSITION := 160.0
const MIN_SPEED := .01
var launched := false
var launch_velocity := Vector2(100, -25)
var player_velocity : Vector2
var friction_scalar := 0.5

func check_and_apply_bounce() -> void:
	if position.y > MAX_Y_POSITION: 
		position.y = MAX_Y_POSITION
		player_velocity.y *= -1
		player_velocity *= friction_scalar 
		if player_velocity.x <= MIN_SPEED:
			player_velocity *= 0

func _physics_process(delta: float) -> void:
	print(game_node.speed)
	position.y += player_velocity.y * delta
	check_and_apply_bounce()
	player_velocity.y += GRAVITY * delta
	game_node.speed = player_velocity.x
	
func _input(event: InputEvent) -> void:
	if event.is_action("launch_action") and not launched:
		player_velocity += launch_velocity
		game_node.speed = player_velocity.x
		
		launched = true  
