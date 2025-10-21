extends CharacterBody2D

@onready var game_node = $".."
@onready var camera: Camera2D = $Camera2D

const SPEED := 1 
const JUMP_VELOCITY := -400.0
const GRAVITY := 30.0
const MAX_Y_POSITION := 160.0
var launched := false
var launch_velocity := Vector2(100, -25)

func _physics_process(delta: float) -> void:
	position.y += velocity[1] * delta
	game_node.speed = velocity[0]
	velocity[1] += GRAVITY * delta
	if position.y > MAX_Y_POSITION: 
		position.y = MAX_Y_POSITION
		velocity *= 0.0
		game_node.speed = 0.0
	
func _input(event: InputEvent) -> void:
	if event.is_action("launch_action") and not launched:
		velocity += launch_velocity
		#launched = true
