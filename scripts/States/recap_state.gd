extends State

@export var recap_ui : CanvasLayer

var distance := 0

func Enter() -> void:
	recap_ui.visible = true
	
func Process(_delta) -> void:
	pass

func Exit() -> void:
	recap_ui.visible = false
