extends Node2D

var fall_speed = 400.0
@onready var sprite = $Sprite2D

func _ready() -> void:
	if randf() <= 0.02:  # 2 percent chance he big as hell boy
		sprite.scale *= 4.0 

func _process(delta):
	# Move down every frame
	position.y += fall_speed * delta
	
	# Delete itself when off-screen to save memory
	if position.y > 1000: 
		queue_free()
