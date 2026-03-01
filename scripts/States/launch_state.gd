extends State

@export var hud_ui : CanvasLayer
@export var player : CharacterBody2D

var distance := 0

func Enter() -> void:
	hud_ui.visible = true
	player.set_distance_travelled(0.0)
	hud_ui.set_label("Distance: 0")
	
func Process(_delta) -> void:
	distance = player.get_distance_travelled()
	hud_ui.set_label("Distance: " + str(distance))
	
func Exit() -> void:
	hud_ui.visible = false
