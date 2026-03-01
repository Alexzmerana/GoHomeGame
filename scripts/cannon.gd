extends Node2D
class_name Cannon

@onready var cannon_shaft = $CannonShaft
@onready var main_node = $".."
@onready var launch_point_node := $CannonShaft/LaunchPoint

# Cannon angles in radians
const MAX_CANNON_ANGLE := 0
const MIN_CANNON_ANGLE := -PI/2 + PI/8
var launch_point : Vector2


var launch_power := 1000.0:
	set(new_val):
		launch_power = 100.0
	get:
		return launch_power

@export var launch_velocity : Vector2:
	get:
		return launch_power * Vector2(cos(cannon_angle), sin(cannon_angle))

var cannon_angle := 0.0:
	set(new_angle):
		cannon_angle = clamp(new_angle, MIN_CANNON_ANGLE, MAX_CANNON_ANGLE)
		cannon_shaft.rotation = cannon_angle
	get:
		return cannon_angle

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	cannon_angle = -PI/4
	launch_point = launch_point_node.global_position
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	#If in pre_launch game state
	if(main_node.current_state == 0): 
		cannon_angle = position.angle_to_point(get_global_mouse_position())
		launch_point = launch_point_node.global_position
