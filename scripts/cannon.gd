extends Node2D


@onready var cannon_shaft = $cannon_shaft
@onready var game_node = $".."
# Cannon angles in radians
const MAX_CANNON_ANGLE := 0
const MIN_CANNON_ANGLE := -PI/2 

@export var cannon_length := 87.0:
	set(new_val):
		cannon_length = 87.0
	get:
		return cannon_length

@export var launch_power := 100.0:
	set(new_val):
		launch_power = 100.0
	get:
		return launch_power

var cannon_angle := 0.0:
	set(new_angle):
		cannon_angle = clamp(new_angle, MIN_CANNON_ANGLE, MAX_CANNON_ANGLE)
		cannon_shaft.rotation = cannon_angle
	get:
		return cannon_angle

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	cannon_angle = -PI/4
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if game_node.pre_launch:
		cannon_angle = cannon_shaft.position.angle_to_point(get_global_mouse_position())
	
