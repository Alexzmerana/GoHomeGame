extends Node2D

@onready var ground := $Ground
@onready var player := $Player
@onready var camera := $Camera2D
@onready var cannon := $Cannon
@onready var restart_screen := $RestartScreen
@onready var distance_label := $HUD/DistanceLabel

const GROUND_PIXEL_WIDTH := 2304

const GROUND_START_POSITION = Vector2(1152.0, 40.0)

# The starting position of the sprite is at 1152. When the sprite is at postion 0 we are half way 
# through and it needs to be reset to maintain illusion of movement
const GROUND_RESET_POSITION_THRESHHOLD = 0

const CANNON_START_POSITION := Vector2(-22, 0)

const CAMERA_START_POSITION := Vector2(232, -112)

const PLAYER_START_POITION := Vector2(24, 0)
const MAX_SPEED := 2000
const MAX_ZOOM := Vector2(2.5, 2.5)
const MIN_ZOOM := Vector2(2.0, 2.0)

@export var speed : float = 0.0
@export var pre_launch := false
@export var in_flight := false
@export var post_launch := false

var distance_travelled := 0.0
var distance_income_scalar := .1
var income_added = false


func _ready() -> void:
	new_launch()
	
	
func new_launch() -> void:
	pre_launch = true
	in_flight = false
	post_launch = false
	player.visible = false
	income_added = false
	restart_screen.visible = false
	ground.position = GROUND_START_POSITION
	cannon.position = CANNON_START_POSITION
	player.position = PLAYER_START_POITION
	camera.position = CAMERA_START_POSITION
	distance_label.text = "Distance: 0"
	distance_travelled = 0.0

func post_launch_actions() -> void:
	restart_screen.visible = true
	var income = int(distance_travelled * distance_income_scalar)
	if not income_added:
		income_added = true
		player.account_balance += income
	var post_launch_distance = $RestartScreen/PanelContainer/MarginContainer/VBoxContainer/GridContainer/FinalDistanceLabel
	var post_launch_income = $RestartScreen/PanelContainer/MarginContainer/VBoxContainer/GridContainer/IncomeEarnedLabel
	post_launch_distance.text = "Distance: " + str(int(distance_travelled))
	post_launch_income.text = "Income: " + str(income)

func _process(delta: float) -> void:
	
	if in_flight:
		distance_travelled += speed * delta
		distance_label.text = "Distance: " + str(int(distance_travelled))
		ground.position.x -= speed * delta
		cannon.position.x -= speed * delta
		
		if ground.position.x < GROUND_RESET_POSITION_THRESHHOLD:
			ground.position = GROUND_START_POSITION
			
		#var zoom_amount := remap(speed, 0.0, MAX_SPEED, 0.0, 1.0)
		#var target_zoom := MAX_ZOOM.lerp(MIN_ZOOM, zoom_amount)
		#camera.zoom = camera.zoom.lerp(target_zoom, delta * 5.0)
		
	# Post launch actions
	if post_launch and not income_added:
		post_launch_actions()
