extends CharacterBody2D

@onready var cannon = get_node("../Cannon")
@onready var main_node = $".."

const GRAVITY := 300.0
const JUMP_VELOCITY := -1100.0
const STOPPING_SPEED := 0.001

var collision : KinematicCollision2D
var bounce_coefficient := .5
var distance_travelled := 0.0

signal in_air_signal
signal stopped_moving

func _process(_delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	# If we are in prelaunch state and launch action has been pressed

	if Input.is_action_just_pressed("launch_action") and (main_node.current_state == 0):
		velocity = cannon.launch_velocity
		visible = true
		position = cannon.launch_point
		in_air_signal.emit()
	
	if main_node.current_state == 1:
		velocity.y += GRAVITY * delta
		distance_travelled += velocity.x * delta
	
		collision = move_and_collide(velocity * delta)
		if collision:
			velocity = velocity.bounce(collision.get_normal()) * bounce_coefficient
		
		if velocity.x <= STOPPING_SPEED:
			print("stoppped moving - player")
			stopped_moving.emit()
		

func set_distance_travelled(new_val):
	distance_travelled = float(new_val)
	
func get_distance_travelled() -> int:
	return int(distance_travelled)
