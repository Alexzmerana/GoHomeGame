extends CanvasLayer

@onready var game = $".."

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_restart_pressed() -> void:
	game.new_launch()
	game.post_launch = false
	game.pre_launch = true


func _on_shop_pressed() -> void:
	$".".visible = false
	var shop_menu := game.get_node("ShopMenu")
	shop_menu.visible = true
