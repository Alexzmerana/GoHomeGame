extends State
class_name hudState

@export var hud_element : CanvasLayer
@export var player : CharacterBody2D

var distance := 0

func Enter() -> void:
	hud_element.text = 0;
	
func Process(_delta) -> void:
	distance = int(player.position.x)
	hud_element.set_label("Distance: " + str(distance))
	
