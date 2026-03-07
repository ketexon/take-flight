extends Node2D

@export var item_to_spawn: PackedScene
@onready var timer: Timer
@export var labelNode: Control

	

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer = Timer.new()
	timer.wait_time = 3
	add_child(timer)
	timer.timeout.connect(_on_timer_timeout)
	timer.start()
 
func _on_timer_timeout():
	var instance = item_to_spawn.instantiate()
	add_child(instance)
	
	instance.pickup.connect(labelNode._on_resource_pickup)
