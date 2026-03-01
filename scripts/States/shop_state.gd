extends State

@export var shop_ui : CanvasLayer


func Enter() -> void:
	shop_ui.visible = true
	
func Process(_delta) -> void:
	pass

func Exit() -> void:
	shop_ui.visible = false
