extends CanvasLayer

@onready var parent_label := $PanelContainer/MarginContainer/VBoxContainer

var shop_hash := {
	"upgrades" : [
		{"name" : "Cannon Power v1", "cost" : 500},
		{"name" : "Cannon Power v2", "cost" : 1000},
		{"name" : "Cannon Power v3", "cost" : 1500}
	]
}
func create_entry(dict: Dictionary):
	var container = HBoxContainer.new()
	var name_label = Label.new()
	var purchase_button = Button.new()
	
	name_label.text = dict["name"]
	name_label.size_flags_horizontal = true
	
	purchase_button.text = str(dict["cost"])
	
	container.add_child(name_label)
	container.add_child(purchase_button)
	parent_label.add_child(container)
	

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for upgrade in shop_hash["upgrades"]:
		create_entry(upgrade)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
