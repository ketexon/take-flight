class_name TrapSpawner
extends Node2D


@export var _spawned_object: PackedScene


func spawn() -> void:
	var instance := _spawned_object.instantiate()
	add_child(instance)
