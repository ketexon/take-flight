extends Node2D

@export var camera: Camera2D
@onready var left_wall = $LeftBound
@onready var right_wall = $RightBound
@onready var top_wall = $TopBound
@onready var bottom_wall = $BottomBound

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var center = camera.get_screen_center_position() 
	
	# 2. Get viewport size adjusted for camera zoom
	var v_size = camera.get_viewport_rect().size / camera.zoom
	var half_width = v_size.x / 2.0
	var half_height = v_size.y / 2.0
	
	left_wall.global_position = Vector2(center.x - half_width, center.y)
	right_wall.global_position = Vector2(center.x + half_width, center.y)
	top_wall.global_position = Vector2(center.x, center.y - half_height)
	bottom_wall.global_position = Vector2(center.x, center.y + half_height)
