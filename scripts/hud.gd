extends CanvasLayer

var distance_label : Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	distance_label = $DistanceLabel


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func set_label(input : String) -> void:
	distance_label.text = input
