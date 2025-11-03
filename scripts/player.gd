extends CharacterBody2D

@onready var game_node = $".."
@onready var cannon_shaft = $"../Cannon/cannon_shaft"
@onready var cannon = $"../Cannon"

const SPEED := 1 
const JUMP_VELOCITY := -400.0
const GRAVITY := 30.0
const MAX_Y_POSITION := 0
const MIN_SPEED := .01

var launch_velocity := Vector2(100, -5)
var player_velocity := Vector2(0,0)
var friction_scalar := 0.5
var account_balance := 0

func _ready() -> void:
	visible = false

func check_and_apply_bounce() -> void:
	if position.y > MAX_Y_POSITION: 
		position.y = MAX_Y_POSITION
		player_velocity.y *= -1
		player_velocity *= friction_scalar 
		if player_velocity.x <= MIN_SPEED:
			player_velocity *= 0
			game_node.launched = false

func get_launch_angle() -> Vector2:
	var direction_vector = Vector2(cos(cannon_shaft.rotation), sin(cannon_shaft.rotation)).normalized()
	return direction_vector
	
func _physics_process(delta: float) -> void:
	if not game_node.launched:
			position = get_launch_angle()
	else:
		position.y += player_velocity.y * delta
		check_and_apply_bounce()
		player_velocity.y += GRAVITY * delta
		game_node.speed = player_velocity.x
	
func _input(event: InputEvent) -> void:
	if event.is_action("launch_action") and not game_node.launched:
		var launch_angle := get_launch_angle()
		position = cannon_shaft.position + launch_angle * cannon.cannon_length
		visible = true
		player_velocity = launch_angle * cannon.launch_power
		game_node.speed = player_velocity.x 
		game_node.launched = true  
