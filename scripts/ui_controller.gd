extends Node

@onready var states : Dictionary[int, State] = {
	0 : $HUDState
}
var current_state : State

func _ready() -> void:
	current_state = states[0]

func _process(delta: float) -> void:
	current_state.Process(delta)

func transition(new_state_id) -> void:
	assert(states[new_state_id])
	current_state.Exit()
	current_state = states[new_state_id]
	current_state.Enter()
