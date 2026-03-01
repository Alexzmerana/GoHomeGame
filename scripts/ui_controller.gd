extends Node

@onready var states : Dictionary[int, State] = {
	0 : $LaunchState,
	2 : $RecapState,
	3 : $ShopState
}
var current_state : State

func _ready() -> void:
	current_state = states[0]
	current_state.Enter()

func _process(delta: float) -> void:
	current_state.Process(delta)

func transition_state(new_state_id) -> void:
	print("transitioning states current state: ", current_state.name, " to state id: ", new_state_id)
	assert(states[new_state_id])
	current_state.Exit()
	current_state = states[new_state_id]
	current_state.Enter()
