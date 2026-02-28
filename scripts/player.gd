extends CharacterBody2D

@onready var cannon = get_node("../Cannon")
@onready var main_node = $".."

const GRAVITY := 300.0
const JUMP_VELOCITY = -1100.0
var collision : KinematicCollision2D
var bounce_coefficient := .5


signal in_air_signal
signal stopped_moving

func _process(_delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	# If we are in prelaunch state and launch action has been pressed
	if Input.is_action_just_pressed("launch_action") and (main_node.current_state == 0):
		velocity = cannon.launch_velocity
		visible = true
		in_air_signal.emit()
	
	if main_node.current_state == 1:
		velocity.y += GRAVITY * delta

		collision = move_and_collide(velocity * delta)
		if collision:
			velocity = velocity.bounce(collision.get_normal()) * bounce_coefficient
		
		if velocity == Vector2(0.0, 0.0):
			stopped_moving.emit()
	
