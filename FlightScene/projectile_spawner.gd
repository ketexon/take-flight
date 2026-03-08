extends Node2D

#add new projectiles to this array
@export var projectiles: Array[PackedScene] = []
@onready var timer: Timer
@export var player: CharacterBody2D

	

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#spawn timer and start it. 
	timer = Timer.new()
	timer.wait_time = 4
	add_child(timer)
	timer.timeout.connect(_on_timer_timeout)
	timer.start()
 
func _on_timer_timeout():
	#pick a random projectile from the export array and spawn that bad boy
	var instance = projectiles.pick_random().instantiate()
	instance.target = player.global_position
	instance.player = player
	add_child(instance)
	if timer.wait_time > 0:
		timer.wait_time -= 0.01
