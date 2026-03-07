extends Control
class_name Shop
#https://www.youtube.com/watch?v=NxDAJuO1IzI
@export var sell_trap: PackedScene
@export var trap_container: VBoxContainer

func _ready() -> void:
 #Create 5 sell traps
	for i in range(4):
		var sell_trap_instance = sell_trap.instantiate()
		trap_container.add_child(sell_trap_instance)
