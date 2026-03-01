extends CanvasLayer

signal restart_signal
signal shop_signal



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_restart_pressed() -> void:
	restart_signal.emit()


func _on_shop_pressed() -> void:
	shop_signal.emit()
